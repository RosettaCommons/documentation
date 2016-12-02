# DesignCatalyticResidues
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DesignCatalyticResidues

Sets catalytic residues to designable. Prior to being called, this task operation REQUIRES that enzdes constraints be added to the pose. This can be accomplished using the \<AddOrRemoveMatchCsts /\> mover as shown in the example. This could be combined with the \<SetCatalyticResPackBehavior /\> task operation to set the catalytic residues to repack and design the spheres around them.

    <DesignCatalyticResidues name="(&string)" region_shell="(&real)" regions_to_design="(&int)" repack_non_selected="(&bool)" />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.

**Example** The following example redesigns a sphere of 8 A radius centered at catalytic residues. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <SetCatalyticResPackBehavior name="repack_cat" fix_catalytic_aa="0" />
        <DesignCatalyticResidues name="des_catalytic" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <AddOrRemoveMatchCsts name="add_csts" cstfile="my_csts.cst" cst_instruction="add_new" />
        <PackRotamersMover name="design" task_operations="des_catalytic,repack_cat" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="add_csts" />
        <Add mover_name="design" />
    </PROTOCOLS>

##See Also

* Discussion of [[enzyme design|enzyme-design]] logic
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta