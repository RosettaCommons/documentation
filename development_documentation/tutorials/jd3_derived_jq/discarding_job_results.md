#Step 9: Discarding Job Results

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 8: Completed Job Summary|completed_job_summary]]

[[Step 10: Outputting Results|outputting_results]]

[[_TOC_]]

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
                        core::Size const local_job_id = discarded_result.first - node_managers_[ dag_node ]->job_offset();
                        job_genealogist_->discard_job_result( dag_node, local_job_id, discarded_result.second );
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

###TutorialQueen.cc


##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms