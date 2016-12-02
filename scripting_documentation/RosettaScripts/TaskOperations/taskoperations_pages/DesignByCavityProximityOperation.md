# DesignByCavityProximity
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DesignByCavityProximity

This task operations scans the protein to identify intra-protein voids, and selects residues for design based on their proximity to the voids. Residues are scored by the metric (distance\_to\_cavity\_center)/(volume\_of\_cavity) and the lowest scoring residues are selected for design.

    <DesignByCavityProximity name="(&string)" region_shell="(8.0 &real)" regions_to_design="(1 &int)" repack_non_selected="(0 &bool)" />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.

**Example** The following example redesigns a sphere of 8 A radius centered at a residue near an intra-protein cavity. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <DesignByCavityProximity name="des_cavity" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_cavity" />
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