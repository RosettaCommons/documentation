#Appendix A: Let the user define their own score function in &lt;Common>

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 10: Outputting Results|outputting_results]]

[[Appendix B: Let the user define individual score functions in &lt;Job>|appendixB]]

[[_TOC_]]

##Plan

Perhaps we want the user to be able to define the name of the weights file
we use for our score function in the &lt;Common> block of the job definition file:

```xml
<JobDefinitionFile>
  <Common>
    <ScoreFunction weights_file_name="ref2015.wts"/>
  </Common>

  <Job>
    ...
  </Job>
</JobDefinitionFile>
```

To do this, we need to 

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