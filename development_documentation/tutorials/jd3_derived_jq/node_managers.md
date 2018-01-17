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

###init_node_managers()


###count_num_jobs_for_node1()


##Up-to-date Code


##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms