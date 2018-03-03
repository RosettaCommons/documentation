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
`DRRAFTER.py -fasta fasta.txt -secstruct secstruct.txt -start_struct protein_and_RNA_helix_fit_into_density.pdb -map_file my_map.mrc -map_reso 7.0 -residues_to_model E:1-23 -include_as_rigid_body_structures protein_fit_into_density.pdb RNA_helix.pdb -absolute_coordinates_rigid_body_structure protein_fit_into_density.pdb -job_name my_run -dock_into_density`

