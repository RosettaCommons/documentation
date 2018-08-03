# RestrictRegion
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RestrictRegion

Makes a mutation to a pose, and creates a resfile task which repacks (no design) the mutated residue, and designs the region around the mutation. Residues far from the mutated residue are fixed. The residue to be mutated can be selected by several different metrics (see below). Useful for altering small regions of the pose during optimization without making large sequence changes.

```xml
<RestrictRegion name="(&string)" type="(&string)" resfile="('' &string)" psipred_cmd="(&string)" blueprint="(&string)" task_operations="(task,task,task)" num_regions="(&int)" scorefxn="()" />
```

-   type: Defines the method by which residues from the designable residues in the fast factory are selected for mutation. Possible types are:
    -   random\_mutation: Choose a residue at random.
    -   psipred: Choose residues with secondary structure that disagrees with psipred calculations.
    -   packstat: Choose residues with poor packstat scores.
    -   score: Choose residues with poor per-residue energy.
    -   random: Randomly choose from one of the above.
-   num\_regions: Number of mutations and regions to design
-   resfile: RestrictRegion creates a resfile with the proper information. This resfile should be read by any mover or filter which needs to use the RestrictRegion functionality. The resfile created will include restrictions from the task factory that is passed to RestrictRegion.
-   psipred\_cmd: Path to psipred executable. Required if the type is "psipred"
-   scorefxn: Scorefunction to use for determining poorly scoring regions. Only used if the type is "score"
-   task\_operations: Task factory which defines the possible mutations to the pose.
-   blueprint: Path to blueprint file which contains secondary structure information. Used if the type is "psipred"

**Example**

```xml
<SCOREFXNS>
    <ScoreFunction name="SFXN" weights="ref2015.wts" />
</SCOREFXNS>
<TASKOPERATIONS>
    <ReadResfile name="restrict_resfile" filename="restrict.resfile" />
</TASKOPERATIONS>
<MOVERS>
    <RestrictRegion name="restrict" resfile="restrict.resfile" type="random_mutation" num_regions="1" scorefxn="SFXN" />
    <PackRotamersMover name="design_region" task_operations="restrict_resfile" scorefxn="SFXN" />
</MOVERS>
<PROTOCOLS>
    <Add mover_name="restrict" />
    <Add mover_name="design_region" />
</PROTOCOLS>
```


##See Also

* [[RandomMutationMover]]
* [[PackRotamersMover]]
* [[RotamerTrialsMover]]
* [[MinPackMover]]
* [[RepackMinimizeMover]]
* [[I want to do x]]: Guide to choosing a mover
