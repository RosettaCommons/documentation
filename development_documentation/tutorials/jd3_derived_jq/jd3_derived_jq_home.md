#Walkthrough: Writing a Derived Job Queen for JD3

Author: Jack Maguire

##Overview
The goal of this tutorial is to help developers get experience with writing their own JD3 protocol.
This tutorial assumes the reader has some knowledge of [[JD3|JD3]] in general.

The (very contrived) design case that we will be working with is as follows:
We want to stabilize a protein-protein interface but only allow one of the two sides to design (change sequence).
We do not care which side is designed, but it can only be one.
Again, this is very contrived.

In general, the code generated in this example is NOT written with effeciency, performance, or even our own coding conventions in mind.
The main goal is clarity and simplicity/readability.

All feedback is welcome! Please send thoughts/questions to jack@med.unc.edu

##Contents

[[Step 1: Skeletons for creating the file|skeletons]]

[[Step 2: Creating the Job DAG|creating_the_job_dag]]

[[Step 3: Node Managers|node_managers]] (optional)

[[Step 4: Creating Larval Jobs|larval_jobs]]

##Bonus Contents
[[Appendix A: Let the user define their own score function|TODO]]

[[Appendix B: The Job Genealogist]]

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms