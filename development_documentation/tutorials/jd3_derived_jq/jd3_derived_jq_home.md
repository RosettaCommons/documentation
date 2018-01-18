#Walkthrough: Writing a Derived Job Queen for JD3

Author: Jack Maguire

##Overview
The goal of this tutorial is to help developers get experience with writing their own JD3 protocol.
This tutorial assumes the reader has some knowledge of [[JD3|JD3]] in general.

In general, the code generated in this example is NOT written with effeciency, performance, or even our own coding conventions in mind.
The main goal is clarity and simplicity/readability.
All feedback is welcome! Please send thoughts/questions to jack@med.unc.edu

##Contents

Beside each link is a list of the virtual function overrides that we introduce in that section.

###Setup

[[Step 1: Skeletons for creating the file|skeletons]]

[[Step 2: Creating the Job DAG|creating_the_job_dag]]
`initial_job_dag()`
`parse_job_definition_tags()`

[[Step 3: Node Managers|node_managers]] (optional)

###Spawning Jobs

[[Step 4: Creating Larval Jobs|larval_jobs]]
`complete_larval_job_maturation()`

[[Step 5: Writing a Job Class|tutorial_job]]

[[Step 6: Maturing Larval Jobs|maturing_larval_jobs]]

###Processing Results

[[Step 7: Note Job Completed|note_job_completed]]

[[Step 8: Completed Job Summary|completed_job_summary]]

[[Step 9: Discarding Job Results|discarding_job_results]]

[[Step 10: Outputting Results|outputting_results]]

##Bonus Content
[[Appendix A: Let the user define their own score function in &lt;Common>|TODO]]

[[Appendix B: Let the user define individual score functions in &lt;Job>|TODO]]

[[Appendix C: Changing the Job DAG|TODO]]

- [ ] test

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms