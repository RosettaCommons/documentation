#Step 5: Creating Larval Jobs

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 3: Node Managers|node_managers]]

[[Step 5: TODO|TODO]]

[[_TOC_]]

##Plan

After the job distributor calls `initial_job_dag()`, it is going to start asking for jobs to submit.
This is done through the method `determine_job_list()`, which expects you to populate a list of [[larval jobs|JD3]].

We are going to create helper methods that each focus on larval job creation for one node, as shown below.

##Code Additions

###Additions to Header File

We need to add a new public method:
```
        jd3::JobOP
        complete_larval_job_maturation(
                jd3::LarvalJobCOP larval_job,
                utility::options::OptionCollectionCOP job_options,
                utility::vector1< jd3::JobResultCOP > const & input_job_results
        ) override ;
```

And a few protected methods:
```

```

###determine_job_list()

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