# ConsensusLoopDesign
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ConsensusLoopDesign

ConsensusLoopDesign restricts amino acid identities in loops based on the ABEGO torsion bins of the loop residues and the common sequence profiles from natives for loops with the same ABEGO bins. 

Briefly, a residue type is disallowed if its normalized frequence is < 0.5, where normalized frequency is defined as f_aa/f_highest, where f_aa is the number of occurrences of the given residue type in natives and f_highest if the number of occurrences of the most commonly found amino acid at the specific position in question. 

    <ConsensusLoopDesign name="disallow_nonnative_loop_sequences" residue_selector=(& string, "") />

**residue_selector** - By default, ConsensusLoopDesign works on all residues deemed "loops" by DSSP in the pose. If set, a residue selector is used to select regions of the protein in which to disallow residues. The selector can be used to choose one or two loops in the pose rather than all of them. Note that the residues flanking loop regions are also restricted according to the sequence profiles. By default, this task operation works on all loops in the pose.

**threshold** - If the enrichment value of an amino acid at a particular position is below this number, it will be disallowed. 0.5 is more stringent than 0.0.

**Example**  This example runs fast design with consensus loop sequences for one loop (residues 7-9).

    <RESIDUE_SELECTORS>
        <Index name="loop1" resnums="7-9" />
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
        <ConsensusLoopDesign name="disallow_nonnative_loop_sequences" residue_selector="loop1" />
    </TASKOPERATIONS>
    <MOVERS>
        <FastDesign name="design" task_operations="disallow_nonnative_loop_sequences" />
    </MOVERS>


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
