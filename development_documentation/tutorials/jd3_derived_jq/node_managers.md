#Step 3: Node Managers

THESE CLASSES ARE NOT YET IN MASTER, CURRENTLY IN: JackMaguire/MultistageRosettaScripts

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 2: Creating the Job DAG|creating_the_job_dag]]

[[Step 4: TODO|TODO]]

[[_TOC_]]

##Plan

There are classes in `protocols/jd3/dag_node_managers` that help us keep track of jobs that have been submitted and sort results.
There are a few different flavors of the [[NodeManager|TODO]], but let's just use the most vanilla: the `SimpleNodeManager`.

We have the opportunity to make decisions at this point about how many results we want to keep from DAG nodes 1 and 2.
Let's arbitrarily say we want to keep the best half of the results from node 1 and best third of the results from node 2.

First, we need to determine the number of jobs each node will need to run.
See `init_node_managers()` and `count_num_jobs_for_node1()` and its partners below.

##Code Additions

###Additions to Header File
First off, we need to include the NodeManager forward header:
```
#include <protocols/jd3/dag_node_managers/NodeManager.fwd.hh>
```

We also have two new methods we need to declare:
```
protected:
        void init_node_managers();

        void count_num_jobs_for_nodes_1_and_2 (
                core::Size & num_jobs_for_node_1,
                core::Size & num_jobs_for_node_2
        );
```

And one new data member:
```
private:
        utility::vector1< jd3::dag_node_managers::NodeManagerOP > node_managers_;
```

###init_node_managers() definition
```
void
MRSJobQueen::init_node_managers(){
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

###count_num_jobs_for_nodes_1_and_2() deinition
```
void
MRSJobQueen::count_num_jobs_for_nodes_1_and_2(
        core::Size & num_jobs_for_node_1,
        core::Size & num_jobs_for_node_2
) {
        num_jobs_for_node_1 = 0;
        num_jobs_for_node_2 = 0;

        //vector has 1 element for each <Job> tag
        utility::vector1< standard::PreliminaryLarvalJob > const & all_preliminary_larval_jobs = preliminary_larval_jobs();

        for( standard::PreliminaryLarvalJob & pl_job : all_preliminary_larval_jobs ){
                core::pose::PoseOP pose = pose_for_inner_job( pl_job->inner_job );
                num_jobs_for_node_1 += pose->chain_sequence( 1 ).length();
                num_jobs_for_node_2 += pose->chain_sequence( 2 ).length();
        }
}
```

###Putting it all together
Let's add our call to `init_node_managers()` in	`initial_job_dag()`.
Take care to add this call AFTER `determine_preliminary_job_list()` has already been called.

##Up-to-date Code

###

###

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms