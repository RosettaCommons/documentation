#Walkthrough: Writing a Derived Job Queen for JD3

Author: Jack Maguire,
Created January 2018

[[_TOC_]]

##[[Checklist of StandardJobQueen virtual functions that you generally want to override|checklist]]

##[[FAQ|jd3_derived_jq_FAQ]]

##Overview
The goal of this tutorial is to help developers get experience with writing their own JD3 protocol.
You can use [[this page|https://wiki.rosettacommons.org/index.php/JD3FAQ]]
for reference to JD3 concepts throughout the walkthrough.
I will link to specific sections of that page when they become relevant,
so there is no need to read the whole thing now.
That said, reading [[this section|https://wiki.rosettacommons.org/index.php/JD3FAQ#Bare-bones_description_of_how_to_create_a_JD3_application]]
would be a good place to start.

For the sake of having an example to work on,
let's pretend that we want to have a protocol where mover A and
mover B are both run on the input structure and the results are merged and run through mover C.
[[See step 2 if it is not clear what I mean|creating_the_job_dag]]

In general, the code generated in this example is NOT written with effeciency, performance, or even our own coding conventions in mind.
The main goal is clarity and simplicity/readability.
All feedback is welcome! Please send thoughts/questions to jackmaguire1444@gmail.com

##Changes in the code since this tutorial was written

###JobGenealogist no longer takes local_job_id

While I was writing this tutorial, I was frustrated by how the JobGenealogist
would sometimes take the global_job_id and other times the local_job_id.
It is very easy to pass the wrong element and not notice.
So I changed the JobGenealogist such that it only ever interacts with the global_job_id.
I tried to go through the tutorial and find all the things that needed to be updated,
but it is very possible I missed a few.
Please keep this change in mind if you see code that does not quite make sense.

-Jack

##Contents

Beside each link is a list of the virtual function overrides that we introduce in that section.

###Setup

[[Step 1: Skeletons for creating the file|skeletons]]

[[Step 2: Creating the Job DAG|creating_the_job_dag]]
`initial_job_dag()`
`parse_job_definition_tags()`

[[Step 3: Node Managers|node_managers]]

###Spawning Jobs

[[Step 4: Creating Larval Jobs|larval_jobs]]
`determine_job_list()`

[[Step 5: Writing a Job Class|tutorial_job]]

[[Step 6: Maturing Larval Jobs|maturing_larval_jobs]]
`complete_larval_job_maturation()`

###Processing Results

[[Step 7: Note Job Completed|note_job_completed]]
`note_job_completed()`

[[Step 8: Completed Job Summary|completed_job_summary]]
`completed_job_summary()`

[[Step 9: Discarding Job Results|discarding_job_results]]
`job_results_that_should_be_discarded()`

[[Step 10: Outputting Results|outputting_results]]
`jobs_that_should_be_output()`

##Bonus Content

[[FAQ|jd3_derived_jq_FAQ]]

[[Appendix A: Let the user define their own score function in &lt;Common>|appendixA]]
`append_common_tag_subelements()`

[[Appendix B: Let the user define individual score functions in &lt;Job>|appendixB]]
`append_job_tag_subelements()`

##Helpful Classes

[[Node Manager|node_manager]]

[[Job Genealogist|job_genealogist]]

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms
