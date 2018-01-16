#Step 2: Creating the Job DAG

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

##Plan

I tried to contrive a queen that would require a non-linear [[job dag|JD3]].
There are several ways to create a dag that would fit our needs, let's go with something like this:

DAG Node 1: Designs a negativly-charged residue on chain 1's side of the interface

DAG Node 2: Designs a posativly-charged residue on chain 2's side of the interface

DAG Node 3: Relax the interface

```
1  2
| /
|/
|
3
```
##Code

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms