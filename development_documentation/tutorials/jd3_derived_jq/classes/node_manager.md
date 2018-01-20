#Node Manager

Author: Jack Maguire

[[_TOC_]]

The node manager is a class that is designed to help derived job queens with their boring book-keeping.
This classes is designed such that you have one of these per every node in your job digraph.
Under the hood, the node manager is has the following elements:

##Results to keep

There is a 2-dimensional sorted vector of results.
Each row of the array is called a partition.
The user (job queen developer) specifies how many job results they want for each parition.

When reporting a result, the user declares which partition the result should go in.
Once the result is sorted into its correct partition, the last (worst) element of
that parition will be removed if there are more elements than the user specified.

The user can access these results either using `results_to_keep()`,
which creates a 1-dimensional representation of the 2D vector,
or `get_nth_job_result_id()`, which returns the ResultID for the nth element.
`get_nth_job_result_id()` is prefered over `results_to_keep()`
because the former allows the node manager to keep accepting new results
while the latter freezes the result vector to prevent iterator invalidation.

##Results to discard

When a job result is removed from the 2-dimensional vector of results to keep,
it is added to a `std::list` of job results to discard.
The derived queen can access this list using `append_job_results_that_should_be_discarded()`.

##Counters for various job submission states

The node manager keeps track of:

- The number of jobs that have been submitted for this node.

- The next local job id to be submitted

- The number of results received.*


*There is also built-in functionality to stop submitting jobs for a DAG node early once enough results come in.
This is handled by the "result_threshold" arguments in the constructor.

#Derived classes

Two derived classes have been created to make the interface simpler:

##SimpleNodeManager

This class only creates 1 parition,
so the 2-dimensional vector is basically a 1-dimensional vector.
The interface to this class is designed such that you never need to specify
a partition argument.

##EvenlyPartitionedNodeManager

This class allows for multiple partitions,
but it requires that the paritions have symmetric requirements.
The number of results to keep is divided enevly among the paritions.
Same is true for the result threshold.
This allows for a modestly more user-friendly constructor,
but none of the other methods are changed.

##See Also

* [[Using a Node Manager in Practice|node_managers]]
* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms