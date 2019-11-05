# MoveMapFactories (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

The packer can be controlled using TaskOperations, the equivalent for the minimizer is the MoveMapFactory. A MoveMapFactory will create a MoveMap tailored for an input Pose; you can say "I want to allow the sidechains to move from Chain B that are within 10 A of residues on chain A" using ResidueSelectors. The biggest difference between MoveMapFactories (which you construct explicitly) and TaskFactories (which are constructed behind the scenes from a list of TaskOperations) is that the order in which MoveMap operations take place matters. If you say in your first operation "turn on all sidechain DOFs" and you say in your second operation "disable sidechain DOFs for residues 10-20", you will have a MoveMap that allows all sidechain DOFs except for residues 10-20; if on the other hand you reverse the order of those two operations, you will have a MoveMap that allows all sidechain DOFs: the "enable everything" command will overwrite the specific prior instructions for residues 10-20. When you construct a MoveMapFactory in RosettaScripts, you list a series of operations for various DOFs. The operations will be performed in the order you list them.

### [[_TOC_]]


### Example
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

### Attributes for MoveMapFactory
The MoveMap created by a MoveMapFactory starts off with no DOFs enabled. If you want to enable all DOFs of a particular type, that can be done with the following attributes. These attributes are processed before the operations in the subtags.

-   bb (bool) Enable or disable movement for all backbone torsions
-   chi (bool) "Enable or disable movement for all chi torsions
-   nu (bool) "Enable or disable movement for all nu torsions
-   branches (bool) "Enable or disable movement for all branch torsions
-   jumps (bool) "Enable or disable movement for all jump DOFs
-   cartesian (bool) Set the MoveMapFactor for specific cartesian overrides.  Currently only used for glycans in order to maintain IUPAC nomenclature during moves


### Operations

Operations are performed after the attributes in the MoveMapFactory tag are processed. Operations are performed in the order they are listed. The different kinds of operations may be listed in any order (presumably, in the order that you want them to be performed). Furthermore, each kind of operation may be listed multiple times.

#### Backbone
    <Backbone enable=(&bool true) residue_selector=(&string) bb_tor_index=(&int)/>

Enable (or optionally disable) the backbone torsions for the residues identified by a given residue selector. If bb_tor_index is provided, then only a particular torsion for the selected residues are enabled. E.g., for amino acid residues, phi is 1, psi is 2, and omega is 3.

#### Chi

    <Chi enable=(&bool true) residue_selector=(&string)/>

Enable (or optionally disable) the side-chain torsions for the residues identified by a given residue selector.

#### Nu

    <Nu enable=(&bool true) residue_selector=(&string)/>

Enable (or optionally disable) the "nu" torsions for the carbohydrate residues identified by a given residue selector.


#### Branches

    <Branches enable=(&bool true) residue_selector=(&string)/>

Enable (or optionally disable) the "branch" torsions for the carbohydrate residues identified by a given residue selector.


#### Jumps

    <Jumps enable=(&bool true) jump_selector=(&string)/>

Enable (or optionally disable) the Jumps identified by a given jump selector.


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