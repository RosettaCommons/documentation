#Step 3: Node Managers

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 2: Creating the Job DAG|creating_the_job_dag]]

[[Step 4: Creating Larval Jobs|larval_jobs]]

[[_TOC_]]

##Reading

[[Node Manager|node_manager]]

##Plan

There are classes in `protocols/jd3/dag_node_managers` that help us keep track of jobs that have been submitted and sort results.
There are a few different flavors of the [[NodeManager|node_manager]], but let's just use the most vanilla: the `SimpleNodeManager`.

We have the opportunity to make decisions at this point about how many results we want to keep from DAG nodes 1 and 2.
Let's arbitrarily say we want to keep the best half of the results from node 1 and best third of the results from node 2.

##Code Additions

###Additions to Header File
First off, we need to include the NodeManager forward header:
```c++
#include <protocols/jd3/dag_node_managers/NodeManager.fwd.hh>
```

We also have two new methods we need to declare:
```c++
protected:
        void init_node_managers();

        void count_num_jobs_for_nodes_1_and_2 (
                core::Size & num_jobs_for_node_1,
                core::Size & num_jobs_for_node_2
        );
```

And one new data member:
```c++
private:
        utility::vector1< jd3::dag_node_managers::NodeManagerOP > node_managers_;
```

###init_node_managers() definition
```c++
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
```

###count_num_jobs_for_nodes_1_and_2() definition
```c++
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
                core::pose::PoseOP pose = pose_for_inner_job( pl_job->inner_job );
                num_jobs_for_node_1 += pose->chain_sequence( 1 ).length();
                num_jobs_for_node_2 += pose->chain_sequence( 2 ).length();
        }
}
```

###Putting it all together
Let's add our call to `init_node_managers()` in	`initial_job_dag()`.
Take care to add this call AFTER `determine_preliminary_job_list()` has already been called.

We also need a few more `#include`'s in the .cc file:
```c++
#include <protocols/jd3/dag_node_managers/NodeManager.hh>
#include <protocols/jd3/dag_node_managers/SimpleNodeManager.hh>
#include <core/pose/Pose.hh>
```

##Up-to-date Code

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

protected:
        void init_node_managers();

        void count_num_jobs_for_nodes_1_and_2 (
                core::Size & num_jobs_for_node_1,
                core::Size & num_jobs_for_node_2
        );

private:
        core::Size num_input_structs_;

        utility::vector1< jd3::dag_node_managers::NodeManagerOP > node_managers_;

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

#include <utility/pointer/memory.hh>
#include <core/pose/Pose.hh>
#include <basic/Tracer.hh>

static basic::Tracer TR( "protocols.tutorial.TutorialQueen" );

using namespace protocols::jd3;

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

        JobDigraphOP dag = utility::pointer::make_shared< JobDigraph >( 3 );
        dag->add_edge( 1, 3 );
        dag->add_edge( 2, 3 );
        return dag;
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
