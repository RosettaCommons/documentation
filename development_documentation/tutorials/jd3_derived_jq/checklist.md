#Checklist Of StandardJobQueen Virtual Functions That You Generally Want To Override

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 1: Skeletons for creating the file|skeletons]]

The Standard Job Queen has many virtual functions and
it is not always obvious to the developer which functions
need to be overriden by the derived job queen.
The goal of this page (and this tutorial in general) is to
help developers figure out whether or not the Standard Job Queen
expects the derived job queen to override a given virtual function.

#Checklist:

- `initial_job_dag()`

- `parse_job_definition_tags()`

- `determine_job_list()`

- `complete_larval_job_maturation()`

- `note_job_completed()` x 2

- `completed_job_summary()` x 2

- `job_results_that_should_be_discarded()`

- `jobs_that_should_be_output()`

#Optional:

- `parse_job_definition_tags()`

- `append_common_tag_subelements()`

- `append_job_tag_subelements()`

- `assign_output_index()`

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms