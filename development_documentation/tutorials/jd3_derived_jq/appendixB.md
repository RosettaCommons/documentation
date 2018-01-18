#Appendix B: Let the user define individual score functions in &lt;Job>

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Appendix A: Let the user define their own score function in &lt;Common>|appendixA]]

[[Appendix C: Changing the Job DAG|TODO]]

[[_TOC_]]

##Plan

In [[Appendix A|appendixA]], we added a way for the user to define a
score function using the &lt;Common> block of the job definition file.
You may want to allow options to be unique for each job.
To do this, you can have the user supply information in the individual &lt;Job> blocks.

Let's keep the code we added in [[Appendix A|appendixA]] and allow the user to optionally
supply a different scorefunction for a given job as shown below.
Now, jobs 1 and 2 use ref2015 and job 3 uses ref2015_cart.

```xml
<JobDefinitionFile>
  <Common>
    <MyScoreFunction weights_file_name="ref2015.wts"/>
  </Common>

  <Job>
    <Input>
      ...
    </Input>
  </Job>

  <Job>
    <Input>
      ...
    </Input>
  </Job>

  <Job>
    <Input>
      ...
    </Input>

    <MyUniqueScoreFunction weights_file_name="ref2015_cart.wts"/>
  </Job>
</JobDefinitionFile>
```


##Code Additions

###Additions to Header File

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