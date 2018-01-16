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
1--\
    --> 3
2--/
```

This is admittedly a silly way to do things because the negativly-charged residues found in node 1 are not present when sampling posativly-charged residues in node 2.
In practice, you might do something like this instead:

```
1 -> 2 -> 3
```

But can we just play along with the first DAG?
My creativity is not what it used to be.
##Code

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms