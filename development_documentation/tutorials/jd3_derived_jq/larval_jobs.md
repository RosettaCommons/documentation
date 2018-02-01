#Step 4: Creating Larval Jobs

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 3: Node Managers|node_managers]]

[[Step 5: Writing a Job Class|tutorial_job]]

[[_TOC_]]

##Reading

[[JobQueen::determine_job_list|https://wiki.rosettacommons.org/index.php/JD3FAQ#JobQueen::determine_job_list]]

[[LarvalJob_vs_InnerLarvalJob|https://wiki.rosettacommons.org/index.php/JD3FAQ#LarvalJob_vs_InnerLarvalJob]]

[[Job Genealogist|job_genealogist]]

##Plan

Okay now steps are starting to get a little longer and messier.
We are now making decisions that are unique to the protocol in mind,
so there will be code that we are adding that will look very different when you write your own job queen.
In practice, you may choose to work on Steps 4, 5, and 6 simultaneously as they are closely related.

After the job distributor calls `initial_job_dag()`, it is going to start asking for jobs to submit.
This is done through the method `determine_job_list()`, which expects you to populate a list of [[larval jobs|https://wiki.rosettacommons.org/index.php/JD3FAQ#JobQueen::determine_job_list]].
In general, larval jobs need to hold all of the information required for the [[worker job queen|https://wiki.rosettacommons.org/index.php/JD3FAQ#LarvalJob_vs_InnerLarvalJob]] to be able to construct a job.
You may find that you need to create your own class that derives from `LarvalJob` because there is certain information you need to include that the base class does not provide a method for.

We are going to create helper methods that each focus on larval job creation for one node, as shown below.
We will also utilize the [[Job Genealogist|job_genealogist]] to help us keep track of the input sources for jobs.

##Code Additions

###Additions to Header File

New `#include`'s for the .hh file:
```c++
#include <protocols/jd3/LarvalJob.fwd.hh> 
#include <protocols/jd3/JobGenealogist.fwd.hh> 
```

We need to add a new public method:
```c++
std::list< jd3::LarvalJobOP >
determine_job_list (
        core::Size job_dag_node_index,
        core::Size max_njobs
)
```

And a few protected methods:
```c++
jd3::LarvalJobOP get_next_larval_job_for_node_1_or_2( core::Size node );

jd3::LarvalJobOP get_next_larval_job_for_node_3();
```

And a private member:
```c++
jd3::JobGenealogistOP job_genealogist_;
```

###Small Additions to the .cc file:

New includes:
```c++
#include <protocols/jd3/LarvalJob.hh>
#include <protocols/jd3/JobGenealogist.hh>
#include <protocols/jd3/standard/StandardInnerLarvalJob.hh>
```

We also need to initialize the Job Genealogist in `initial_job_dag()`
```c++
JobDigraphOP
TutorialQueen::initial_job_dag() {
        //you need to call this for the standard job queen to initialize
        determine_preliminary_job_list();
        init_node_managers();

        //NEW LINE://///////////////
        job_genealogist_ = utility::pointer::make_shared< JobGenealogist >( 3, num_input_structs_ );
        ////////////////////////////

        JobDigraphOP dag = utility::pointer::make_shared< JobDigraph >( 3 );
        dag->add_edge( 1, 3 );
        dag->add_edge( 2, 3 );
        return dag;
}
```

###determine_job_list()
In order to keep things clean, let's offload the work to these two other methods.
```c++
std::list< jd3::LarvalJobOP >
TutorialQueen::determine_job_list (
        core::Size job_dag_node_index,
        core::Size max_njobs
) {
        std::list< jd3::LarvalJobOP > job_list;

        for( core::Size ii = 1; ii <= max_njobs; ++ii ){
                jd3::LarvalJobOP next_job;
                if( job_dag_node_index == 3 ){
                        next_job = get_next_larval_job_for_node_3();
                } else {
                        next_job = get_next_larval_job_for_node_1_or_2( job_dag_node_index );
                }

                if( next_job == 0 ) {
                        return job_list;
                } else {
                        job_list.push_back( next_job );
                }
        }

        return job_list;
}
```

###get_next_larval_job_for_node_3()
This case is a little shorter than the other one, so let's look at it first.
The complicated part about this method is that we need to 
```c++
jd3::LarvalJobOP
TutorialQueen::get_next_larval_job_for_node_3(){

        using namespace protocols::jd3;

        if( node_managers_[ 3 ]->done_submitting() ) {
                return 0;
        }

        core::Size const local_job_id = node_managers_[ 3 ]->get_next_local_jobid();
        core::Size const global_job_id = node_managers_[ 3 ]->job_offset() + local_job_id;

        core::Size const num_results_for_node1 = node_managers_[ 1 ]->results_to_keep().size();
        core::Size const node_of_parent = ( local_job_id > num_results_for_node1 ? 2 : 1 );

        jd3::JobResultID parent_result;
        if( node_of_parent == 1 ){
                parent_result = node_managers_[ 1 ]->get_nth_job_result_id( local_job_id );
        } else {
                core::Size const num_results_for_node2 = node_managers_[ 2 ]->results_to_keep().size();
                core::Size const result_index = local_job_id - num_results_for_node1;
                if( result_index > num_results_for_node2 ){
                        return 0;
                }

                parent_result = node_managers_[ 2 ]->get_nth_job_result_id( result_index );
        }

        job_genealogist_->register_new_job(
                3,
                global_job_id,
                node_of_parent,
                parent_result
        );

        core::Size const pose_input_source_id = job_genealogist_->input_source_for_job( 3, global_job_id );

        jd3::standard::StandardInnerLarvalJobOP inner_ljob =
                create_and_init_inner_larval_job( 1, pose_input_source_id );

        LarvalJobOP ljob = utility::pointer::make_shared< LarvalJob >(
                inner_ljob,        1, global_job_id );

        return ljob;
}
```


###get_next_larval_job_for_node_1_or_2()

DAG Nodes 1 and 2 are very similar.
So similar, that you would probably implement them as just one node in practice.
Due to their similarities, we can combine a lot of this logic together and make them share this method.

```c++
jd3::LarvalJobOP
TutorialQueen::get_next_larval_job_for_node_1_or_2( core::Size node ) {
        //This is written very ineffeciently, but it will do for the scope of the tutorial
        runtime_assert( node == 1 || node == 2 );

        if( node_managers_[ node ]->done_submitting() ) {
                return 0;
        }

        //each job has 2 indices:
        //a local one, which tracks its index within its dag node
        //a global one, which is unique accross the entire program
        core::Size const local_job_id = node_managers_[ node ]->get_next_local_jobid();
        core::Size const global_job_id = node_managers_[ node ]->job_offset() + local_job_id;
        core::Size counter = local_job_id;

        utility::vector1< standard::PreliminaryLarvalJob > const & all_preliminary_larval_jobs = preliminary_larval_jobs();
        core::Size pose_input_source_id = 0;

        //This part is not directly JD3-related, it's just a matter of finding the pose that we need for this specific job
        for( standard::PreliminaryLarvalJob const & pl_job : all_preliminary_larval_jobs ){
                core::pose::PoseOP pose = pose_for_inner_job( pl_job.inner_job );
                ++pose_input_source_id;

                core::Size const nres_in_chain = pose->chain_sequence( node ).length();
                if( nres_in_chain > counter ){
                        counter -= nres_in_chain;
                } else {
                        break;
                }
        }
        debug_assert( pose_input_source_id <= all_preliminary_larval_jobs.size() );

        //These can be recycled between larval jobs
        //So in reality, you will probably choose to store this somewhere and use it again the next time this method is called
        //(you will have to change the arguments accordingly)
        //jd3::InnerLarvalJobOP inner_ljob =
        jd3::standard::StandardInnerLarvalJobOP inner_ljob =
                create_and_init_inner_larval_job( 1, pose_input_source_id );

        LarvalJobOP ljob = utility::pointer::make_shared< LarvalJob >(
                inner_ljob, 1, global_job_id );

        job_genealogist_->register_new_job (
                node,
                global_job_id,
                pose_input_source_id
        );

        return ljob;
}
```

##Up-To-Date Code

###TutorialQueen.hh
```c++
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialQueen.hh
/// @author Jack Maguire, jackmaguire1444@gmail.com


#ifndef INCLUDED_protocols_tutorial_TutorialQueen_HH
#define INCLUDED_protocols_tutorial_TutorialQueen_HH

#include <protocols/tutorial/TutorialQueen.fwd.hh>
#include <protocols/jd3/standard/StandardJobQueen.hh>
#include <protocols/jd3/JobDigraph.fwd.hh>
#include <protocols/jd3/dag_node_managers/NodeManager.fwd.hh>
#include <protocols/jd3/LarvalJob.fwd.hh>
#include <protocols/jd3/JobGenealogist.fwd.hh>

#include <utility/tag/Tag.fwd.hh>

namespace protocols {
namespace tutorial {

class TutorialQueen: public jd3::standard::StandardJobQueen {

public:

        //constructor
        TutorialQueen();

        //destructor
        ~TutorialQueen() override;

        jd3::JobDigraphOP
        initial_job_dag()
        override;

        void
        parse_job_definition_tags(
                utility::tag::TagCOP common_block_tags,
                utility::vector1< jd3::standard::PreliminaryLarvalJob > const &
        ) override;

        std::list< jd3::LarvalJobOP > determine_job_list(
                Size job_dag_node_index,
                Size max_njobs
        ) override;

protected:
        void init_node_managers();

        void count_num_jobs_for_nodes_1_and_2 (
                core::Size & num_jobs_for_node_1,
                core::Size & num_jobs_for_node_2
        );

        jd3::LarvalJobOP get_next_larval_job_for_node_1_or_2( core::Size node );

        jd3::LarvalJobOP get_next_larval_job_for_node_3();

private:
        core::Size num_input_structs_;

        utility::vector1< jd3::dag_node_managers::NodeManagerOP > node_managers_;
        jd3::JobGenealogistOP job_genealogist_;
};

} //tutorial
} //protocols

#endif        
```


###TutorialQueen.cc
```c++
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialQueen.cc
/// @author Jack Maguire, jackmaguire1444@gmail.com

#include <protocols/tutorial/TutorialQueen.hh>

#include <protocols/jd3/JobDigraph.hh>
#include <protocols/jd3/dag_node_managers/NodeManager.hh>
#include <protocols/jd3/dag_node_managers/SimpleNodeManager.hh>
#include <protocols/jd3/LarvalJob.hh>
#include <protocols/jd3/JobGenealogist.hh>
#include <protocols/jd3/standard/StandardInnerLarvalJob.hh>

#include <utility/pointer/memory.hh>
#include <core/pose/Pose.hh>
#include <basic/Tracer.hh>

static basic::Tracer TR( "protocols.tutorial.TutorialQueen" );

using namespace protocols::jd3;
using namespace protocols::jd3::standard;

namespace protocols {
namespace tutorial {

//Constructor
TutorialQueen::TutorialQueen() :
        StandardJobQueen()
{}

//Destructor
TutorialQueen::~TutorialQueen()
{}

JobDigraphOP
TutorialQueen::initial_job_dag() {
        //you need to call this for the standard job queen to initialize
        determine_preliminary_job_list();
        init_node_managers();

        job_genealogist_ = utility::pointer::make_shared< JobGenealogist >( 3, num_input_structs_ );

        JobDigraphOP dag = utility::pointer::make_shared< JobDigraph >( 3 );
        dag->add_edge( 1, 3 );
        dag->add_edge( 2, 3 );
        return dag;
}

std::list< jd3::LarvalJobOP >
TutorialQueen::determine_job_list (
        core::Size job_dag_node_index,
        core::Size max_njobs
) {
        std::list< jd3::LarvalJobOP > job_list;

        for( core::Size ii = 1; ii <= max_njobs; ++ii ){
                jd3::LarvalJobOP next_job;
                if( job_dag_node_index == 3 ){
                        next_job = get_next_larval_job_for_node_3();
                } else {
                        next_job = get_next_larval_job_for_node_1_or_2( job_dag_node_index );
                }
                if( next_job == 0 ) {
                        return job_list;
                } else {
                        job_list.push_back( next_job );
                }
        }

        return job_list;
}


void
TutorialQueen::parse_job_definition_tags(
        utility::tag::TagCOP common_block_tags,
        utility::vector1< standard::PreliminaryLarvalJob > const & prelim_larval_jobs
){
        num_input_structs_ = prelim_larval_jobs.size();
}

void
TutorialQueen::init_node_managers(){
        using namespace jd3::dag_node_managers;

        core::Size num_jobs_for_node1( 0 ), num_jobs_for_node2( 0 );
        count_num_jobs_for_nodes_1_and_2( num_jobs_for_node1, num_jobs_for_node2 );

        core::Size const num_results_to_keep_for_node1 = num_jobs_for_node1 / 2; //Let's keep half of the results
        SimpleNodeManagerOP node1 = utility::pointer::make_shared< SimpleNodeManager >(
                0, //Job offset
                num_jobs_for_node1,
                num_results_to_keep_for_node1
        );

        core::Size const num_results_to_keep_for_node2 = num_jobs_for_node2 / 3; //Let's keep half of the results
        SimpleNodeManagerOP node2 = utility::pointer::make_shared< SimpleNodeManager >(
                num_jobs_for_node1, //Job offset
                num_jobs_for_node2,
                num_results_to_keep_for_node2
        );

        core::Size const num_jobs_for_node3 = num_results_to_keep_for_node1 + num_results_to_keep_for_node2;
        core::Size const num_results_to_keep_for_node3 = num_jobs_for_node3; //Let's keep/dump all of the results
        SimpleNodeManagerOP node3 = utility::pointer::make_shared< SimpleNodeManager >(
                num_jobs_for_node1 + num_jobs_for_node2, //Job offset
                num_jobs_for_node3,
                num_results_to_keep_for_node3
        );

        node_managers_.reserve( 3 );
        node_managers_.push_back( node1 );
        node_managers_.push_back( node2 );
        node_managers_.push_back( node3 );
}

void
TutorialQueen::count_num_jobs_for_nodes_1_and_2(
        core::Size & num_jobs_for_node_1,
        core::Size & num_jobs_for_node_2
) {
        num_jobs_for_node_1 = 0;
        num_jobs_for_node_2 = 0;

        //vector has 1 element for each <Job> tag
        utility::vector1< standard::PreliminaryLarvalJob > const & all_preliminary_larval_jobs = preliminary_larval_jobs();

        for( standard::PreliminaryLarvalJob const & pl_job : all_preliminary_larval_jobs ){
                core::pose::PoseOP pose = pose_for_inner_job( pl_job.inner_job );
                num_jobs_for_node_1 += pose->chain_sequence( 1 ).length();
                num_jobs_for_node_2 += pose->chain_sequence( 2 ).length();
        }
}

jd3::LarvalJobOP
TutorialQueen::get_next_larval_job_for_node_1_or_2( core::Size node ) {
        //This is written very ineffeciently, but it will do for the scope of the tutorial
        runtime_assert( node == 1 || node == 2 );

        if( node_managers_[ node ]->done_submitting() ) {
                return 0;
        }

        //each job has 2 indices:
        //a local one, which tracks its index within its dag node
        //a global one, which is unique accross the entire program
        core::Size const local_job_id = node_managers_[ node ]->get_next_local_jobid();
        core::Size const global_job_id = node_managers_[ node ]->job_offset() + local_job_id;
        core::Size counter = local_job_id;

        utility::vector1< standard::PreliminaryLarvalJob > const & all_preliminary_larval_jobs = preliminary_larval_jobs();
        core::Size pose_input_source_id = 0;

        //This part is not directly JD3-related, it's just a matter of finding the pose that we need for this specific job
        for( standard::PreliminaryLarvalJob const & pl_job : all_preliminary_larval_jobs ){
                core::pose::PoseOP pose = pose_for_inner_job( pl_job.inner_job );
                ++pose_input_source_id;

                core::Size const nres_in_chain = pose->chain_sequence( node ).length();
                if( nres_in_chain > counter ){
                        counter -= nres_in_chain;
                } else {
                        break;
                }
        }
        debug_assert( pose_input_source_id <= all_preliminary_larval_jobs.size() );

        //These can be recycled between larval jobs
        //So in reality, you will probably choose to store this somewhere and use it again the next time this method is called
        //(you will have to change the arguments accordingly)
        //jd3::InnerLarvalJobOP inner_ljob =
        jd3::standard::StandardInnerLarvalJobOP inner_ljob =
                create_and_init_inner_larval_job( 1, pose_input_source_id );

        LarvalJobOP ljob = utility::pointer::make_shared< LarvalJob >(
                inner_ljob, 1, global_job_id );

        job_genealogist_->register_new_job (
                node,
                global_job_id,
                pose_input_source_id
        );

        return ljob;
}

jd3::LarvalJobOP
TutorialQueen::get_next_larval_job_for_node_3(){

        using namespace protocols::jd3;

        if( node_managers_[ 3 ]->done_submitting() ) {
                return 0;
        }

        core::Size const local_job_id = node_managers_[ 3 ]->get_next_local_jobid();
        core::Size const global_job_id = node_managers_[ 3 ]->job_offset() + local_job_id;

        core::Size const num_results_for_node1 = node_managers_[ 1 ]->results_to_keep().size();
        core::Size const node_of_parent = ( local_job_id > num_results_for_node1 ? 2 : 1 );

        jd3::JobResultID parent_result;
        if( node_of_parent == 1 ){
                parent_result = node_managers_[ 1 ]->get_nth_job_result_id( local_job_id );
        } else {
                core::Size const num_results_for_node2 = node_managers_[ 2 ]->results_to_keep().size();
                core::Size const result_index = local_job_id - num_results_for_node1;
                if( result_index > num_results_for_node2 ){
                        return 0;
                }

                parent_result = node_managers_[ 2 ]->get_nth_job_result_id( result_index );
        }

        job_genealogist_->register_new_job(
                3,
                global_job_id,
                node_of_parent,
                parent_result
        );

        core::Size const pose_input_source_id = job_genealogist_->input_source_for_job( 3, global_job_id );

        jd3::standard::StandardInnerLarvalJobOP inner_ljob =
                create_and_init_inner_larval_job( 1, pose_input_source_id );

        LarvalJobOP ljob = utility::pointer::make_shared< LarvalJob >(
                inner_ljob,        1, global_job_id );

        return ljob;
}


} //tutorial
} //protocols        
```

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms
