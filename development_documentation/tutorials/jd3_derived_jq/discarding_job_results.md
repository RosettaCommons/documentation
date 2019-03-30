#Step 9: Discarding Job Results

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 8: Completed Job Summary|completed_job_summary]]

[[Step 10: Outputting Results|outputting_results]]

[[_TOC_]]

##Reading

[[jobs_that_should_be_discarded()|https://wiki.rosettacommons.org/index.php/JD3FAQ#JobQueen::jobs_that_should_be_discarded]]

##Plan

Job results are not always cheap to store.
You can save memory if you have disk space by using the `-archive_on_disk` option,
but even then it is beneficial to delete job results that you have no use for anymore.
The job distributor will delete job results for you using the interface of `job_results_that_should_be_discarded()`.

For every Job DAG node in our example,
we can start deleting results as soon as we have more results than we want to keep.
This is all taken care of for us under the hood of the `NodeManager` class.
We just have to take care to let the `JobGenealogist` know what jobs we want to delete.

The `JobGenealogist` can also help us find job results to delete.
Consider the Job DAG: `1->2->3` and suppose that we keep 1000 results from node 1 and 250 results from node 2.
Once node 2 is complete and node 3 has started, there will be 750 job results from node 1 that have no surviving offspring.
We can now call `JobGenealogist::garbage_collection( 1, true, ... )` on node 1 to find job results with no children.
We will not do that for this tutorial simply because our Job DAG is not complicated enough to benefit from this.
I probably should have thought further ahead when writing the early steps of this.

##Code Additions

###Additions to Header File

We need to add this declaration to the `public` section of the .hh file
```c++
std::list< jd3::JobResultID >
job_results_that_should_be_discarded() override;
```

###job_results_that_should_be_discarded()
For each node, we want to get a list of results that can be discarded.
We need to make sure to tell the `JobGenealogist` which ones are being deleted.
```c++
std::list< jd3::JobResultID >
TutorialQueen::job_results_that_should_be_discarded(){
        std::list< jd3::JobResultID > list_of_all_job_results_to_be_discarded;

        for ( core::Size dag_node = 1; dag_node <= 3; ++dag_node ) {
                std::list< jd3::JobResultID > job_results_to_be_discarded_for_node;
                node_managers_[ dag_node ]->append_job_results_that_should_be_discarded( job_results_to_be_discarded_for_node );

                for ( jd3::JobResultID const & discarded_result : job_results_to_be_discarded_for_node ) {
                        job_genealogist_->discard_job_result( dag_node, discarded_result );
                }

                list_of_all_job_results_to_be_discarded.splice(
                        list_of_all_job_results_to_be_discarded.end(),
                        job_results_to_be_discarded_for_node );
        }

        return list_of_all_job_results_to_be_discarded;
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
#include <protocols/jd3/dag_node_managers/SimpleNodeManager.fwd.hh>
#include <protocols/jd3/LarvalJob.hh>
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

        void note_job_completed(
                core::Size,
                jd3::JobStatus,
                core::Size
        ) override {
                runtime_assert( false );
        }

        void note_job_completed(
                jd3::LarvalJobCOP job,
                jd3::JobStatus status,
                core::Size nresults
        ) override;

        void completed_job_summary(
                core::Size job_id,
                core::Size result_index,
                jd3::JobSummaryOP summary
        ) override;

        void completed_job_summary(
                jd3::LarvalJobCOP job,
                core::Size result_index,
                jd3::JobSummaryOP summary
        ) override {
                completed_job_summary( job->job_index(), result_index, summary );
        }

        std::list< jd3::JobResultID >
        job_results_that_should_be_discarded() override;


protected:
        void init_node_managers();

        void count_num_jobs_for_nodes_1_and_2 (
                core::Size & num_jobs_for_node_1,
                core::Size & num_jobs_for_node_2
        );

        jd3::LarvalJobOP get_next_larva        l_job_for_node_1_or_2( core::Size node );

        jd3::LarvalJobOP get_next_larval_job_for_node_3();

        jd3::JobOP
        complete_larval_job_maturation(
                jd3::LarvalJobCOP larval_job,
                utility::options::OptionCollectionCOP job_options,
                utility::vector1< jd3::JobResultCOP > const & input_job_results
        ) override ;

private:
        core::Size num_input_structs_;

        utility::vector1< jd3::dag_node_managers::SimpleNodeManagerOP > node_managers_;
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
#include <protocols/tutorial/TutorialJob.hh>

#include <protocols/jd3/JobDigraph.hh>
#include <protocols/jd3/dag_node_managers/NodeManager.hh>
#include <protocols/jd3/dag_node_managers/SimpleNodeManager.hh>
#include <protocols/jd3/LarvalJob.hh>
#include <protocols/jd3/JobGenealogist.hh>
#include <protocols/jd3/standard/StandardInnerLarvalJob.hh>
#include <protocols/jd3/standard/MoverAndPoseJob.hh>

#include <protocols/moves/Mover.hh>
#include <protocols/relax/FastRelax.hh>
#include <protocols/minimization_packing/MinPackMover.hh>
#include <protocols/minimization_packing/MinMover.hh>

#include <utility/pointer/memory.hh>

#include <basic/Tracer.hh>

#include <core/pose/Pose.hh>
#include <core/scoring/ScoreFunction.fwd.hh>
#include <core/scoring/ScoreFunctionFactory.hh>


static basic::Tracer TR( "protocols.tutorial.TutorialQueen" );

using namespace protocols::jd3;
using namespace protocols::jd3::standard;

namespace protocols {
namespace tutorial {

//Constructor
TutorialQueen::TutorialQueen() :
        StandardJobQueen(),
        num_input_structs_( 0 ),
        node_managers_( 0 ),
        job_genealogist_( 0 )
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

JobOP
TutorialQueen::complete_larval_job_maturation(
        LarvalJobCOP job,
        utility::options::OptionCollectionCOP,
        utility::vector1< JobResultCOP > const & input_job_results
) {
        if ( num_input_structs_ == 0 ) {
                initial_job_dag();
        }

        standard::StandardInnerLarvalJobCOP standard_inner_larval_job
                = utility::pointer::static_pointer_cast< const standard::StandardInnerLarvalJob >( job->inner_job() );

        core::Size const global_job_id = job->job_index();

        moves::MoverOP mover = 0;
        core::scoring::ScoreFunctionOP sfxn = core::scoring::ScoreFunctionFactory::create_score_function( "ref2015.wts" );
        core::pose::PoseOP pose = 0;

        if( global_job_id <= node_managers_[ 1 ]->num_jobs() ){
                //This job belongs to node 1
                //local_job_id = global_job_id;
                mover = utility::pointer::make_shared< relax::FastRelax >();
                pose = pose_for_inner_job( standard_inner_larval_job );
        } else if( global_job_id <= node_managers_[ 1 ]->num_jobs() + node_managers_[ 2 ]->num_jobs() ) {
                //alternatively you could have used:
                //else if( global_job_id <= node_managers_[ 3 ]->job_offset() )

                //This job belongs to node 2
                //local_job_id = global_job_id - node_managers_[ 2 ]->job_offset();
                mover = utility::pointer::make_shared< minimization_packing::MinPackMover >();
                pose = pose_for_inner_job( standard_inner_larval_job );
        } else {
                //This job belongs to node 3
                //local_job_id = global_job_id - node_managers_[ 3 ]->job_offset();
                mover = utility::pointer::make_shared< minimization_packing::MinMover >();

                //We created this larval job and pose result so we know that there should be exactly 1 result and that result is a standard::PoseJobResult
                runtime_assert( input_job_results.size() == 1 );
                standard::PoseJobResult const & result1 = static_cast< standard::PoseJobResult const & >( * input_job_results[ 1 ] );
                pose = result1.pose()->clone();
                runtime_assert( pose );
        }

        TutorialJobOP tjob = utility::pointer::make_shared< TutorialJob >();
        tjob->set_pose( pose );
        tjob->set_sfxn( sfxn );
        tjob->set_mover( mover );

        return tjob;
}

void TutorialQueen::note_job_completed(
        jd3::LarvalJobCOP job,
        jd3::JobStatus status,
        core::Size nresults
) {
        core::Size const global_job_id = job->job_index();
        core::Size dag_node = 0;

        if( global_job_id <= node_managers_[ 1 ]->num_jobs() ) {
                dag_node = 1;
        } else if ( global_job_id > node_managers_[ 3 ]->job_offset() ) {
                dag_node = 3;
        } else {
                dag_node = 2;
        }

        if ( status != jd3_job_status_success ) {
                node_managers_[ dag_node ]->note_job_completed( global_job_id, 0 );
                job_genealogist_->note_job_completed( dag_node, global_job_id, 0 );
        } else {
                node_managers_[ dag_node ]->note_job_completed( global_job_id, nresults );
                job_genealogist_->note_job_completed( dag_node, global_job_id, nresults );
        }

}

void TutorialQueen::completed_job_summary(
        core::Size global_job_id,
        core::Size result_index,
        jd3::JobSummaryOP summary
) {

        core::Size dag_node = 0;
        if( global_job_id <= node_managers_[ 1 ]->num_jobs() ) {
                dag_node = 1;
        } else if ( global_job_id > node_managers_[ 3 ]->job_offset() ) {
                dag_node = 3;
        } else {
                dag_node = 2;
        }

        standard::EnergyJobSummary const & energy_summary =
                static_cast< standard::EnergyJobSummary const & >( * summary );

        node_managers_[ dag_node ]->register_result(
                global_job_id,
                result_index,
                energy_summary.energy()
        );

}

std::list< jd3::JobResultID >
TutorialQueen::job_results_that_should_be_discarded(){
        std::list< jd3::JobResultID > list_of_all_job_results_to_be_discarded;

        for ( core::Size dag_node = 1; dag_node <= 3; ++dag_node ) {
                std::list< jd3::JobResultID > job_results_to_be_discarded_for_node;
                node_managers_[ dag_node ]->append_job_results_that_should_be_discarded( job_results_to_be_discarded_for_node );

                for ( jd3::JobResultID const & discarded_result : job_results_to_be_discarded_for_node ) {
                        job_genealogist_->discard_job_result( dag_node, discarded_result );
                }

                list_of_all_job_results_to_be_discarded.splice(
                        list_of_all_job_results_to_be_discarded.end(),
                        job_results_to_be_discarded_for_node );
        }

        return list_of_all_job_results_to_be_discarded;
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
