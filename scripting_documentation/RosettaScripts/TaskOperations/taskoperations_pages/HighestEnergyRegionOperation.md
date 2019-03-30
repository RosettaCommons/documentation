# HighestEnergyRegion
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## HighestEnergyRegion

Selects residues that have the highest per-residue energy. This task operation is stochastic to allow for variation in design regions. Residues are selected by this task operation as follows. First, all residues are ranked in order of total score of a region which consists of a sphere around the residue. Next, the first residue is selected based on a random number generator. The first residue in the list (the one with highest (worst) score) has a 50% probability of being selected, the second residue has 25% probability, and so on. If regions\_to\_design is \> 1, additional residues are selected using the same process, except with previously chosen residues removed from consideration.

    <HighestEnergyRegion name="(&string)" region_shell="(&real)" regions_to_design="(&int)" repack_non_selected="(&bool)" scorefxn="(&string)" />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.
-   scorefxn: Scorefunction to be used to determine scores of regions.

**Example** The following example redesigns a sphere of 8 A radius centered in a poorly scoring region of the pose. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <HighestEnergyRegion name="des_high_energy" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_high_energy" />
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