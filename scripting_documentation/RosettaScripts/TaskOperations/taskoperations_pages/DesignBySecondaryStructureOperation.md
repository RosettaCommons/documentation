# DesignBySecondaryStructure
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DesignBySecondaryStructure

DesignBySecondaryStructureOperation is a developmental task operation, and is not available in the public release of Rosetta.

<!--- BEGIN_INTERNAL -->

Selects residues for design based on agreement with psipred secondary structure prediction. Residues which disagree with the secondary structure prediction are selected for design. This mover is stochastic in that residues which disagree in secondary structure prediction are selected randomly every time the task operation is called.

    <DesignBySecondaryStructure name="(&string)" region_shell="(8.0 &real)" regions_to_design="(1 &int)" repack_non_selected="(0 &bool)" blueprint="('' &string)" cmd="(&string)" />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.
-   blueprint: a blueprint file which specifies the secondary structure at each position.
-   cmd: **Required** Path to the runpsipred executable.

**Example** The following example redesigns a sphere of 8 A radius centered at a residue with secondary structure prediction that disagrees with actual secondary structure. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <DesignBySecondaryStructure name="des_by_sspred" region_shell="8.0" regions_to_design="1" repack_non_selected="0" cmd="/path/to/runpsipred_single" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_by_sspred" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="design" />
    </PROTOCOLS>

<!--- END_INTERNAL -->

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