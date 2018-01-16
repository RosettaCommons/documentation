#Walkthrough: Writing a Derived Job Queen for JD3

Author: Jack Maguire

##Overview
The goal of this tutorial is to help developers get experience with writing their own JD3 protocol.
This tutorial assumes the reader has some knowledge of [[JD3|JD3]] in general.

For the sake of example, we will write a (very contrived) 3-step job queen that takes a protein-protein interface and:

1. Designs a negativly-charged residue on chain 1's side of the interface

2. Designs a posativly-charged residue on chain 2's side of the interface

3. Relax the interface


##Contents

[[Step 1: Creating the Job DAG | creating_the_job_dag]]

##Bonus Contents
[[Appendix A: Let the user define their own score function|TODO]]

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms