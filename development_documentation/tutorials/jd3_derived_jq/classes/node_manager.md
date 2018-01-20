#Node Manager

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[_TOC_]]

The node manager is a class that is designed to help derived job queens with their boring bookkeeping.
Under the hood, the node manager is has the following elements:

##Results to keep

There is a 2-dimensional sorted vector of results.
Each row of the array is called a partition.
The user (job queen developer) specifies how many job results they want for each parition.

When reporting a result, the user declares which partition the result should go in.



##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms