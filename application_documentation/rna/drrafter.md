#DRRAFTER: De novo RNP modeling in Real-space through Assembly of Fragments Together with Experimental density in Rosetta

**This documentation has been verified to be compatible with Rosetta weekly releases: 2018.12, 2018.17, 2018.19, 2018.21, and 2018.26.**

##Metadata

Author: Kalli Kappel (kappel at stanford dot edu)  
Last updated: July 2018

##Application purpose

DRRAFTER is used to build RNA coordinates into cryoEM maps of ribonucleoprotein complexes.

##Code and demo
DRRAFTER code is available in the Rosetta weekly releases starting with 2018.12. **DRRAFTER is NOT available in Rosetta 3.9**.  
 
DRRAFTER.py, the python script for setting up DRRAFTER runs is located in `ROSETTA_HOME/main/src/apps/public/DRRAFTER/`. This sets up a command line for the rna_denovo application. DRRAFTER.py can also be used to estimate the accuracy of DRRAFTER models. This mode relies on the drrafter_error_estimation application, which is also located in `ROSETTA_HOME/main/src/apps/public/DRRAFTER/`.  

A demo of DRRAFTER is available in `ROSETTA_HOME/demos/public/drrafter/`. Instructions for the demo are available [here](https://www.rosettacommons.org/demos/latest/public/drrafter/README).

## Installing DRRAFTER
1. Download Rosetta [here](https://www.rosettacommons.org/software/license-and-download). You will need to get a license before downloading Rosetta (free for academic users). DRRAFTER is available in the Rosetta weekly releases starting with 2018.12. **DRRAFTER is NOT available in Rosetta 3.9.** 
2. If you're not using the precompiled binaries (these are available for Mac and Linux and you can access them by downloading source+binaries in Step 1), install Rosetta following the instructions available [here](https://www.rosettacommons.org/docs/latest/build_documentation/Build-Documentation). 
3. Make sure that you have python (v2.7) installed.
4. Install Rosetta RNA tools. See instructions and documentation [here] (https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools).
5. Check that the ROSETTA environmental variable is set (you should have set this up during RNA tools installation). Type `echo $ROSETTA`. This should return the path to your Rosetta directory. If it does not return anything, go back to step 4 and make sure that you follow the steps for RNA tools setup.  
6. Set up the executables for DRRAFTER. Type:
```
ln -s $(ls $ROSETTA/main/source/bin/rna_denovo* | head -1 ) $ROSETTA/main/source/bin/rna_denovo
```
Then type: 
```
ln -s $(ls $ROSETTA/main/source/bin/drrafter_error_estimation* | head -1 ) $ROSETTA/main/source/bin/drrafter_error_estimation
``` 
Finally, type:
```
ln -s $(ls $ROSETTA/main/source/bin/extract_pdbs* | head -1 ) $ROSETTA/main/source/bin/extract_pdbs
```
7. Add the path to the DRRAFTER script to your $PATH (alternatively, you can type the full path to the DRRAFTER.py script each time that you use it). It is found in `main/source/src/apps/public/DRRAFTER/` in your Rosetta directory. For example, add the following line to your `.bashrc`:
```
export PATH=$PATH:$ROSETTA/main/source/src/apps/public/DRRAFTER/
```

##The DRRAFTER workflow
The general DRRAFTER workflow is described below:

**Step 1**: Fit known protein structures into the density map. Typically, this involves collecting previously solved crystal structures of protein subcomponents and then fitting these into the density in e.g. Chimera.  

**Step 2**: Fit ideal RNA helices into the density map. RNA helices can be generated in Rosetta with the `rna_helix.py` script (see RNA tools documentation: [RNA tools](https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools)). Example command (after setting up RNA tools): 
```
rna_helix.py -seq ggcg cgcc -o RNA_helix.pdb -resnum E:1-4 E:20-23 -extension static.linuxgccrelease
```
(*Note* that you may need to change the extension, see [RNA tools documentation](https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools#some-useful-tools_rna-modeling-utilities) for details.)    

**Step 3**: Identify regions where RNA coordinates are missing.  

**Step 4**: Use DRRAFTER to build the missing RNA coordinates and assess the accuracy of the models. The sections below describe how to perform this step.  

**Step 5**: Visually inspect at least the top 10 scoring DRRAFTER models. Be on the lookout for models that do not fit well in the density, RNA models that are built into protein density, or "distorted" models. This step is essential!   

##How to use DRRAFTER to build missing RNA coordinates
All DRRAFTER runs are set up with DRRAFTER.py. An example command line is provided below:
```
DRRAFTER.py -fasta fasta.txt -secstruct secstruct.txt -start_struct protein_and_RNA_helix_fit_into_density.pdb -map_file my_map.mrc -map_reso 7.0 -residues_to_model E:1-23 -include_as_rigid_body_structures protein_fit_into_density.pdb RNA_helix.pdb -absolute_coordinates_rigid_body_structure protein_fit_into_density.pdb -job_name my_run -dock_into_density
```
This will create a file called DRRAFTER_command, which contains the Rosetta command line to run DRRAFTER. This can be run by typing:
```
source ./DRRAFTER_command
```

For the best results, at least 2000-3000 models should be generated. Some tools for setting up jobs on a cluster are available as part of [RNA tools](https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools).  
   
The ten best scoring models can be extracted into PDB format from the compressed output file with the following command:
```
extract_lowscore_decoys.py my_run.out 10
```
**These models should be visually inspected.** See the troubleshooting section below for possible solutions to problems.  
  
The accuracy of these models can then be estimated with the following command:
```
DRRAFTER.py -final_structures my_run.out.1.pdb my_run.out.2.pdb my_run.out.3.pdb my_run.out.4.pdb my_run.out.5.pdb my_run.out.6.pdb my_run.out.7.pdb my_run.out.8.pdb my_run.out.9.pdb my_run.out.10.pdb -estimate_error
```
This will print information about the error estimation to the screen. The mean pairwise RMSD describes the “convergence” of the run, i.e. how similar the final structures are to each other. The estimated RMSD (root mean square deviation) values to the “true” coordinates are based on this convergence value. The estimated minimum RMSD predicts the best accuracy of the final structures. The estimated mean RMSD predicts the average RMSD accuracy of the final structures. The median structure is determined to be the final structure with the lowest average pairwise RMSD to the other final structures. The accuracy estimate of this model is also printed to the screen. All numbers have units of Å.  

**Also, open these structures in PyMOL or Chimera, to visually assess the modeling convergence.**

##DRRAFTER inputs and options

####`-h`

This prints a help message listing all of the options for `DRRAFTER.py`. These options are also described below.

####`-fasta`

Required for DRRAFTER run setup. This is a FASTA format file for your system. It must include all protein and RNA residues. Protein residues are specified by uppercase one-letter codes. RNA residues are specified with lowercase one-letter codes (‘a’, ‘u’, ‘g’, and ‘c’). **Proteins must be listed before RNA!**  
  
*Example:*  
```
>DRRAFTER_demo_1wsu  A:136-258 E:1-23
SETQKKLLKDLEDKYRVSRWQPPSFKEVAGSFNLDPSELEELLHYLVREGVLVKINDEFYWHRQALGEAREVIKNLASTGPFGLAEARDALGSSRKYVLPLLEYLDQVKFTRRVGDKRVVVGN
ggcguugccggucuggcaacgcc
```

####`-secstruct` 

Required for DRRAFTER run setup. A file containing the secondary structure of the complex in dot-bracket notation. Secondary structure for the protein should be specified by dots. The secondary structure should be the same length as the sequence found in the fasta file. For RNA residues, this secondary structure will be enforced during the DRRAFTER run. RNA secondary structures can be predicted computationally with packages such as [ViennaRNA](https://www.tbi.univie.ac.at/RNA/). If the secondary structure is not known, it may be necessary to test several different secondary structures in separate DRRAFTER jobs (or ideally the secondary structure would be determined through biochemical experiments).
  
*Example:*  
```
...........................................................................................................................(((((((((.....)))))))))
```
####`-rosetta_directory`
The path to the Rosetta executables. This is not necessary if the location of the Rosetta executables is in your PATH.
  
*Example:*  
/home/src/Rosetta/main/source/bin/  

####`-start_struct`
This is a single PDB file containing all of the protein and RNA structures that have been fit into the density map (steps 1-2 in the DRRAFTER workflow, above). For the best results, this should contain all of the protein structures that you want to model. This structure provides the starting coordinates for the DRRAFTER run.

####`-residues_to_model`
The RNA residues that should be modeled in the DRRAFTER run. This should include any RNA helices that you fit into the density and want to be allowed to move during the run.  

*Example:*  
A:1-10  
This would mean that residues 1-10 in chain A will be built.

####`-map_file`
Required for DRRAFTER run setup. The density map file in mrc or ccp4 format.

####`-map_reso`
Required for DRRAFTER run setup. The resolution of the map.  

####`-include_as_rigid_body_structures`
This option takes a list of PDB files that should be treated as rigid bodies during the DRRAFTER run. Each of the RNA helices that were fit into the density and are in the region being built should be provided as separate files. Protein structures that should be allowed to dock during the run should also be provided here, again as separate files. Each of these structures should also be present within the `-start_struct` file.  

####`-absolute_coordinates_rigid_body_structure`
This optional argument takes a single PDB file as an argument. This should be one of the structures that is provided to the `-include_as_rigid_body_structures` option. It will set the absolute coordinate frame for the system. If `-dock_into_density` is not specified, this structure will not move from its starting position. This structure must be fit into the density map! If no structures are provided as `-include_as_rigid_body_structures`, then this option can be omitted.

####`-constrain_rigid_bodies_only`
For coordinate constraints, only constrain residues in the `-include_as_rigid_body_structures`. By default, coordinate restraints penalizing deviations of more than 10 Å will be placed on all residues in the `-start_struct`. This distance tolerance can be controlled with `-cst_dist`. The constraints can be turned off with `-no_csts`.

####`-no_csts`
Turns off coordinate constraints for the run.

####`-cst_dist`
The distance tolerance for coordinate constraints. Deviations greater than this distance will be penalized. Default: 10 Å.

####`-ref_pdb_for_coord_csts`
An optional reference structure for the coordinate constraints. If this is not provided, the coordinate constraints will be based on the `-start_struct`.

####`-dock_into_density`
This flag turns on docking moves for all of the `-include_as_rigid_body_structures`, including the absolute_coordinates_rigid_body_structure. This option should not be turned on if `-absolute_coordinates_rigid_body_structure` is not specified.

####`-no_dock_each_rigid_body_separately`
This option changes the way that the kinematics is set up for the run. Without this option, each of the structures provided as -include_as_rigid_body_structures (possibly with the exception of the `-absolute_coordinates_rigid_body_structure` if `-dock_into_density` is not specified) will be allowed to move as a rigid body during the run. With this option, the structures passed to `-include_as_rigid_body_structures` within the same chain will not be subjected to docking moves. If this option is not specified, all `-include_as_rigid_body_structures` (including all RNA helices) need to be present in `-start_struct`.

####`-no_initial_structures`
Do not start the run from the structure provided in `-start_struct`.

####`-cycles`
The number of Monte Carlo cycles that will be run. If a value is not specified, the number of cycles will be determined based on the number of RNA residues that are being modeled.

####`-docking_move_size`
A number between 0.0 and 1.0 controlling the magnitude of the docking moves during the DRRAFTER run. 0.0 corresponds to the least aggressive docking moves and 1.0 corresponds to the most aggressive docking moves.

####`-include_residues_around`
Residues (e.g. A:1-5 B:2) that should be included in the DRRAFTER run, these do not need to be residues in the `-residues_to_model`. Other residues within the `-dist_cutoff` of these residues will also be included.

####`-dist_cutoff`
Default: 20 Å. Residues in the starting structure within this distance cutoff of the residues in `-include_as_rigid_body_structures` or the residues listed for `-include_residues_around` will be included in the DRRAFTER run.

####`-extra_flags`
Extra flags to be applied during the DRRAFTER run. Any of the options available for `rna_denovo` (see documentation [here](https://www.rosettacommons.org/docs/latest/application_documentation/rna/rna-denovo#options)) can be supplied.  
This flag can be used in conjunction with `'nstruct'` to set the number of structures that are built per DRRAFTER job (default=500 for regular jobs, default=10 when the `-demo_setting` flag is supplied). For example, the following sets the number of structures built per DRRAFTER job to 2000: `-extra_flags 'nstruct 2000'`.

####`-job_name`
The name for your job. This determines the names of the output files.

####`-demo_setting`
Turns on settings to make the demo run quickly. This option should NOT be used for actual runs.

####`-estimate_error`
Runs an error estimation calculation. If this option is specified, `-final_structures` should also be provided.

####`-final_structures`
This should be a list of (ideally ten) final DRRAFTER models in PDB format for error estimation. Typically, this should be the best ten scoring DRRAFTER models.

##Troubleshooting

**Problem:** RNA coordinates are being built into density that I think belongs to a protein (but I don’t have a structure of that protein!).  
**Solution:** Segment your density map – remove density for regions that you do not want to build RNA coordinates into. This can be done in Chimera.
  
**Problem:** RNA coordinates are being built into density that I know belongs to a protein (I even fit a protein structure into the density map!).   
**Solution:** To minimize computational expense, protein residues that are not near the region where missing RNA coordinates are being built are removed. If RNA coordinates end up being built into the density for these removed protein residues, there are several possible solutions:
* Change the -dist_cutoff value. By default it is 20 Å, meaning that residues more than 20 Å away from RNA residues being modeled (that are supplied in -start_struct) or the residues listed in -include_residues_around will be removed. This does not apply to residues in -include_as_rigid_body_structures.
* Include the full protein structure in -include_as_rigid_body_structures. This will ensure that no residues will be removed from the protein. 
* Try specifying more residues for -include_residues_around. Residues within the -dist_cutoff of the specified residues will be kept during the DRRAFTER run.  
  
**Problem:** I'm getting an error when running `DRRAFTER.py` that my sequence and secondary structure aren't the same length.  
**Solution:** `DRRAFTER.py` is reading all `(`,`)`,`[`,`]`,`{`, and `}` characters from your secondary structure file (unlike `rna_denovo` which only reads the first line of the file). Check your secondary structure file to make sure that it ONLY contains the exact secondary structure for your complex. Also remember that you need to specify "secondary structure" for the protein residues (just use dots).  
