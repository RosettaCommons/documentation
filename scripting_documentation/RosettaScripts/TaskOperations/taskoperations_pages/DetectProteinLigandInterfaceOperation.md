# DetectProteinLigandInterface
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DetectProteinLigandInterface

Setup packer task based on the detect design interface settings from enzyme design.

    <DetectProteinLigandInterface name="(&string)" cut1="(6.0 &Real)" cut2="(8.0 &Real)" cut3="(10.0 &Real)" cut4="(12.0 &Real)" 
    design="(1 &bool)" resfile="('' &string)" design_to_cys="(0 &bool)" catres_interface="(0 &bool)" catres_only_interface="(0 &bool)" 
    arg_sweep_interface="(0 &bool)" target_cstids="('' &string)"/>

The task will set to design all residues with a Calpha within cut1 of the ligand (specifically the last ligand), or within cut2 of the ligand, where the Calpha-Cbeta vector points toward the ligand. Those residues within cut3 or within cut4 pointing toward the ligand will be set to repack. All others will be set to be fixed. Setting design to false will turn off design at all positions.

If resfile is specified, the listed resfile will be read in the settings therein applied to the task. Any positions set to "AUTO" (and only those set to AUTO) will be subjected the detect design interface procedure as described above. Note that design=0 will turn off design even for positions where it is permitted in the resfile (use "cut1=0.0 cut2=0.0 design=1" to allow design at resfile-permitted positions while disabling design at all AUTO positions).

By default, the DetectProteinLigandInterface will turns off design at disulfide cysteines, and will not permit designing to cysteine. (Positions which start off as cysteine can remain as cysteine if use input sidechains is turned on, or if design is turned off at that position, for example for enzdes catalytic residues). If you wish to allow design to cysteine at designable positions, set design\_to\_cys=1.

catres\_interface: consider catalytic residues (if present) to determine interface (i.e. residues less than cut1 to these residues will be made designable etc.)

catres\_only\_interface: consider only neighbors of catalytic residues (not ligand) for defining interface

arg\_sweep\_interface: use arginine-reachability to interface as the criterion for defining designable positions instead of distance

target\_cstids: comma-separated list of particular constrained residues to be considered as exclusive targets for interface detection (e.g. 1B,2B,3B)

##See Also

* [[Preparing ligands|preparing-ligands]] for use in Rosetta
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta