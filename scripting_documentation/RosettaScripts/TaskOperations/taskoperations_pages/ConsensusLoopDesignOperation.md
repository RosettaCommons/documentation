# ConsensusLoopDesign
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ConsensusLoopDesign

ConsensusLoopDesign restricts amino acid identities in loops based on the ABEGO torsion bins of the loop residues and the common sequence profiles from natives for loops with the same ABEGO bins. 

For each loop in the pose, a database is queried using the loop's torsion space (in ABEGO bins) and the secondary structure elements being joined. For each specific loop (e.g. loop ABEGO type "GG", joining two strands), the database contains the native frequencies for all 20 canonical amino acids at each position in the loop. These frequencies are converted into enrichment values via Enrichment(SS, ABEGO, X) = log(Freq_thisloop(SS, ABEGO, X))/log(Freq_allloops(X)), where Freq_thisloop is the frequency of the amino acid occurring at position, Freq_allloops is the frequency of the amino acid occurring in all loops, X is the loop residue number, SS is the secondary structure of the two elements being joined by the loop, and ABEGO is the torsion space of the loop.  Therefore, higher enrichment indicates a torsion-space bias for a particular amino acid. Enrichment <0 indicates that a particular amino acid is less commonly found in this loop than others.  The task operation works by disallowing all amino acids with enrichment below a certain threshold (i.e. those amino acids that is some native bias against).

    <ConsensusLoopDesign name="disallow_nonnative_loop_sequences"
                         residue_selector="(&string, '')"
                         include_adjacent_residues="(&bool, false)"
                         enrichment_threshold="(&real, 0.0)"
                         secstruct="(&string, '')"
                         blueprint="(&string, '')"
                         use_dssp="(&bool, true)" />

**residue_selector** - By default, ConsensusLoopDesign works on all residues deemed "loops" by DSSP in the pose. If set, a residue selector is used to select regions of the protein in which to disallow residues. The selector can be used to choose one or two loops in the pose rather than all of them. Note that the residues flanking loop regions are also restricted according to the sequence profiles. By default, this task operation works on all loops in the pose.

**include_adjacent_residues** - If true, amino acids allowed at the non-loop positions joined by each loop will also be restricted via their frequencies in native structures.  For example, some loops which follow helices strongly prefer proline as the last position in the helix.

**threshold** - If the enrichment value of an amino acid at a particular position is below this number, it will be disallowed. 0.5 is more stringent than 0.0.

**secstruct** - Allows the user to force a particular secondary structure onto the pose. If set, use_dssp will be ignored. The length of the secondary structure must match the length of the pose.

**use_dssp** - If true, DSSP will be used to determine which residues are loops.  If false, the secondary structure stored in the pose will be used to determine loops.  Has no effect if the "secstruct" option is set.

**blueprint** - If a blueprint filename is given, the blueprint will be read and its secondary structure will be used to set the "secstruct" option.


**Example**  This example runs fast design with consensus loop sequences for one loop (residues 7-9).

```xml
    <RESIDUE_SELECTORS>
        <Index name="loop1" resnums="7-9" />
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
        <ConsensusLoopDesign name="disallow_nonnative_loop_sequences" residue_selector="loop1" />
    </TASKOPERATIONS>
    <MOVERS>
        <FastDesign name="design" task_operations="disallow_nonnative_loop_sequences" />
    </MOVERS>
```

## Caveats

Note that this TaskOperation is intended for canonical design only.  It will not properly disallow noncanonicals (if they have been turned on with other task operations); nor will DSSP work properly with noncanonical secondary structure types (_e.g._ the left-handed helices formed by  D-amino acids).

##See Also

* [[Loop modeling|loopmodel]]: An application for modeling loops
* [[LoopModelerMover]]: A loop modeling mover
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
