# RestrictToInterfaceVector
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictToInterfaceVector

Restricts the task to residues defined as interface by core/pack/task/operation/util/interface\_vector\_calculate.cc Calculates the residues at an interface between two protein chains or jump. The calculation is done in the following manner. First the point graph is used to find all residues within some big cutoff(CB\_dist\_cutoff) of residues on the other chain. For these residues near the interface, two metrics are used to decide if they are actually possible interface residues. The first metric is to itterate through all the side chain atoms in the residue of interest and check to see if their distance is less than the nearby atom cutoff (nearby\_atom\_cutoff), if so then they are an interface residue. If a residue does not pass that check, then two vectors are drawn, a CA-CB vector and a vector from CB to a CB atom on the neighboring chain. The dot product between these two vectors is then found and if the angle between them (vector\_angle\_cutoff) is less than some cutoff then they are classified as interface. The vector cannot be longer than some other distance (vector\_dist\_cutoff).

There are two ways of using this task, first way is to use jumps:

```xml
  <RestrictToInterfaceVector name="(& string)" jump="(1 & int,int,int... )" CB_dist_cutoff="(10.0 & Real)" nearby_atom_cutoff="(5.5 & Real)" vector_angle_cutoff="(75.0 & Real)" vector_dist_cutoff="(9.0 & Real)"/>
```

-   jump - takes a comma separated list of jumps to find the interface between, will find the interface across all jumps defined

OR you can use chains instead

```xml
  <RestrictToInterfaceVector name="(& string)" chain1_num="(1 & int)" chain2_num="(2 & int)" CB_dist_cutoff="(10.0 & Real)" nearby_atom_cutoff="(5.5 & Real)" vector_angle_cutoff="(75.0 & Real)" vector_dist_cutoff="(9.0 & Real)"/>
```

-   chain1\_num - chain number of the chain on one side of the interface. Optionally accepts a comma separated list of chain numbers.
-   chain2\_num - chain on the other side of the interface from chain1. Optionally accepts a comma separated list of chain numbers.

Common tags, see descriptions above:

-   CB\_dist\_cutoff - distance, should keep between 8.0 and 15.0
-   nearby\_atom\_cutoff - distance, should be between 4.0 and 8.0
-   vector\_angle\_cutoff - angle in degrees, should be between 60 and 90
-   vector\_dist\_cutoff - distance, should be between 7.0 and 12.0

Note that if you specify a list of chain numbers for the chain1\_num and chain2\_num options, the interface will be calculated between the two sets. In other words, if chain1\_num=1,2 and chain2\_num=3,4 the interface will be calculated between chains 1 and 3, 1 and 4, 2 and 3, and 2 and 4. The interface between chains 1 and 2 and between 3 and 4 will not be calculated.

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta