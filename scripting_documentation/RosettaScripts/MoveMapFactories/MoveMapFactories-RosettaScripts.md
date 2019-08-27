#MoveMapFactories (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

The packer can be controlled using TaskOperations, the equivalent for the minimizer is the MoveMapFactory. A MoveMapFactory will create a MoveMap tailored for an input Pose; you can say "I want to allow the sidechains to move from Chain B that are within 10 A of residues on chain A" using ResidueSelectors. The biggest difference between MoveMapFactories (which you construct explicitly) and TaskFactories (which are constructed behind the scenes from a list of TaskOperations) is that the order in which MoveMap operations take place matters. If you say in your first operation "turn on all sidechain DOFs" and you say in your second operation "disable sidechain DOFs for residues 10-20", you will have a MoveMap that allows all sidechain DOFs except for residues 10-20; if on the other hand you reverse the order of those two operations, you will have a MoveMap that allows all sidechain DOFs: the "enable everything" command will overwrite the specific prior instructions for residues 10-20. When you construct a MoveMapFactory in RosettaScripts, you list a series of operations for various DOFs. The operations will be performed in the order you list them.

[[_TOC_]]

Example
=======
    ...
    <RESIDUE_SELECTORS>
        <CDR name="L1" cdrs="L1"/>
    </RESIDUE_SELECTORS>
    <MOVE_MAP_FACTORIES>
        <MoveMapFactory name="movemap_L1" bb="0" chi="0">
            <Backbone residue_selector="L1" />
            <Chi residue_selector="L1" />
        </MoveMapFactory>
    </MOVE_MAP_FACTORIES>

    ...
    <MOVERS>
      <FastRelaxMover name=relax_l1 movemap_factory=movemap_L1 task_operations=.../>
    </MOVERS>
    ...

Operations
========

Backbone
Chi
Nu
Branches
Jumps


See Also
========

* [[RosettaScripts]]: The RosettaScripts home page
* [[Recommended TaskOperations for design|Recommended_Design_TaskOperations]]
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[RosettaScripts Movers|Movers-RosettaScripts]]
* [[RosettaScripts Filters|Filters-RosettaScripts]]
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Getting Started]]: A page for people new to Rosetta
* [[Glossary]]
* [[RosettaEncyclopedia]]