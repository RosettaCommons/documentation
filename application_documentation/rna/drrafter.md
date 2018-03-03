#DRRAFTER: De novo RNP modeling in Real-space through Assembly of Fragments Together with Electron density in Rosetta

##Metadata

Author: Kalli Kappel (kappel at stanford dot edu)  
Last updated: March 2018

##Application purpose

DRRAFTER is used to build RNA coordinates into cryoEM maps of ribonucleoprotein complexes.

##Code and demo
DRRAFTER.py, the python script for setting up DRRAFTER runs is located in `src/apps/public/DRRAFTER/`. This sets up a command line for the rna_denovo application. DRRAFTER.py can also be used to estimate the accuracy of DRRAFTER models. This mode relies on the drrafter_error_estimation application, which is also located in `src/apps/public/DRRAFTER/`.
A demo of DRRAFTER is available in `demos/public/DRRAFTER/`.

##The DRRAFTER workflow
The general DRRAFTER workflow is described below:

**Step 1**: Fit known protein structures into the density map. Typically, this involves collecting previously solved crystal structures of protein subcomponents and then fitting these into the density in e.g. Chimera.  

**Step 2**: Fit ideal RNA helices into the density map. RNA helices can be generated in Rosetta with the rna_helix.py script (see RNA tools documentation: [RNA tools](https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools)).   

**Step 3**: Identify regions where RNA coordinates are missing.  

**Step 4**: Use DRRAFTER to build the missing RNA coordinates. The sections below describe how to perform this step.  

##How to use DRRAFTER to build missing RNA coordinates
###Setup
1. Make sure that you have python (v2.7) installed.
2. Install Rosetta RNA tools. See instructions and documentation [here] (https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools).
3. Add the path to the DRRAFTER script to your $PATH (alternatively, you can type the full path to the DRRAFTER.py script each time that you use it). An example for bash: `PATH=$PATH:YOUR_ROSETTA_PATH/main/source/src/apps/public/DRRAFTER/`

###Running DRRAFTER
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
These models should be carefully inspected. See the troubleshooting section below for possible solutions to problems.  
  
The accuracy of these models can then be estimated with the following command:
```
DRRAFTER.py -final_structures my_run.out.1.pdb my_run.out.2.pdb my_run.out.3.pdb my_run.out.4.pdb my_run.out.5.pdb my_run.out.6.pdb my_run.out.7.pdb my_run.out.8.pdb my_run.out.9.pdb my_run.out.10.pdb -estimate_error
```
This will print information about the error estimation to the screen. The mean pairwise RMSD describes the “convergence” of the run, i.e. how similar the final structures are to each other. The estimated RMSD (root mean square deviation) values to the “true” coordinates are based on this convergence value. The estimated minimum RMSD predicts the best accuracy of the final structures. The estimated mean RMSD predicts the average RMSD accuracy of the final structures. The median structure is determined to be the final structure with the lowest average pairwise RMSD to the other final structures. The accuracy estimate of this model is also printed to the screen. All numbers have units of Å.

##DRRAFTER inputs and options

####`-fasta`

Required for DRRAFTER run setup. This is a FASTA format file for your system. It must include all protein and RNA residues. Protein residues are specified by uppercase one-letter codes. RNA residues are specified with lowercase one-letter codes (‘a’, ‘u’, ‘g’, and ‘c’).  
  
*Example:*
```
>DRRAFTER_demo_1wsu  A:136-258 E:1-23
SETQKKLLKDLEDKYRVSRWQPPSFKEVAGSFNLDPSELEELLHYLVREGVLVKINDEFYWHRQALGEAREVIKNLASTGPFGLAEARDALGSSRKYVLPLLEYLDQVKFTRRVGDKRVVVGN
ggcguugccggucuggcaacgcc
```

####`-secstruct` 

Required for DRRAFTER run setup. A file containing the secondary structure of the complex in dot-bracket notation. Secondary structure for the protein should be specified by dots. The secondary structure should be the same length as the sequence found in the fasta file. For RNA residues, this secondary structure will be enforced during the DRRAFTER run.
  
*Example:*
```
...........................................................................................................................(((((((((.....)))))))))
```


