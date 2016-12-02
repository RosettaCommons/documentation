# DesignRandomRegion
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DesignRandomRegion

Simply chooses random residues from the pose. This task operation is stochastic to allow for variation in design regions. Each call to this operation results in a new randomly selected set of residues chosen for design.

    <DesignRandomRegion name="(&string)" region_shell="(&real)" regions_to_design="(&int)" repack_non_selected="(&bool)" />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.

**Example** The following example redesigns a sphere of 8 A radius centered at a randomly selected residue. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <DesignRandomRegion name="des_random" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_random" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="design" />
    </PROTOCOLS>

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