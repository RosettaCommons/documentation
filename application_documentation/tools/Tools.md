#Tools

## General Rosetta Tools

This page is a list of accessory scripts which are helpful in working with Rosetta input/output and job running.

Many of these scripts have further help options. 
Try running them without any arguments or with the '-h' flag to get further information.

### Input Preparation


#### Ligands

main/source/src/python/apps/public/molfile_to_params.py  
 -- #8195; Make Rosetta *.params files. 

main/source/src/python/apps/public/rename_params.py  
 -- #8195; Rename params files so that none conflict with each other.

main/source/src/python/apps/public/batch_molfile_to_params.py  
 -- #8195; Make Rosetta *.params files for a large number of inputs.

main/source/src/apps/public/ligand_docking/[[assign_charges.py|ligand-dock]]  
 -- #8195; Assign AM1-BCC charges to ligands.


#### Symmetry

main/source/src/apps/public/symmetry/[[make_symmdef_file_denovo.py|make-symmdef-file-denovo]]  
 -- #8195; Make a symmetry file. 

main/source/src/apps/public/symmetry/[[make_symmdef_file.pl|make-symmdef-file]]  
 -- #8195; Make a symmetry file for an existing PDB.


#### Membrane

main/source/src/apps/public/membrane_abinitio/octopus2span.pl  
 -- #8195; Convert an Octopus topology file to a Rosetta span file.

main/source/src/apps/public/membrane_abinitio/run_lips.pl  
 -- #8195; Run lipophilicity predictions.

main/source/src/apps/public/membrane_abinitio/alignblast.pl  
 -- #8195; Extract a multiple alignment of hits from Blast or PsiBlast output.


#### Electron Density

main/source/src/apps/public/electron_density/prepare_template_for_MR.pl  
 -- #8195; 


### Job Runing

main/source/src/python/apps/public/parallel.py  
 -- #8195; Utility for running a large number of command lines in parallel.


### Output Manipulation


#### Silent files

main/source/src/python/apps/public/pymol_silent.py  
 -- #8195; A pymol plugin to read silent files.


#### Score files

main/source/src/python/apps/public/column.sh  
 -- #8195; Select only certain columns from a file.

main/source/src/python/apps/public/sd.py  
 -- #8195; Extract data from silent files.

main/source/src/python/apps/public/rmsd_score_pymol_plotter/rmsd_score_pymol_plotter.py  
 -- #8195; Create score vs. rmsd (funnel) plots.

main/source/src/python/apps/public/rmsd_score_pymol_plotter/rmsd_score_pymol_plotter_generator.pl  
 -- #8195; Create score vs. rmsd (funnel) plots.

main/source/tools/scorefile.py  
 -- #8195; Parse and extract data from score files in JSON format. 

main/source/src/apps/public/enzdes/[[DesignSelect.pl|enzyme-design]]  
 -- #8195; Select only those rows of a tabular format which have columns matching requirements.


### PDBs

main/source/src/python/apps/public/pdb2fasta.py  
 -- #8195; Extract a FASTA formatted sequence from a PDB.



### Unclassified

main/source/src/python/apps/public/color_pdb.py  
 -- #8195; 

main/source/src/python/apps/public/color_pdb_byatom.py  
 -- #8195; 

main/source/src/python/apps/public/get_pdb.py  
 -- #8195;  

main/source/src/utility/make_static_database.py  
 -- #8195; 


## Application Specific Scripts


### Ligand Docking

main/source/src/apps/public/ligand_docking/[[arls.py|ligand-dock]]  
 -- #8195; Automatic RosettaLigand setup.

main/source/src/apps/public/ligand_docking/best_ifaceE.py  
 -- #8195; Prints the tags of the 'best' structures from a ligand docking run.

main/source/src/apps/public/ligand_docking/pdb_to_molfile.py  
 -- #8195; Extracts coordinates from PDB file to regenerate mol/sdf/mol2 files.

main/source/src/apps/public/ligand_docking/prune_atdiff_top5pct.py  
 -- #8195; Extract the top 5% by total score from an AtomTreeDiff file.

main/source/src/apps/public/ligand_docking/get_scores.py  
 -- #8195; Extract the SCORES line of an AtomTreeDiff file into tabular format.

main/source/src/apps/public/ligand_docking/plot_funnels.R --


### Constrained Relax

main/source/src/apps/public/relax_w_allatom_cst/clean_pdb_keep_ligand.py  
 -- #8195; Clean the PDB, keeping the ligand

main/source/src/apps/public/relax_w_allatom_cst/sidechain_cst_3.py  
 -- #8195; Create a constraint file for the sidechain heavy atoms.

main/source/src/apps/public/relax_w_allatom_cst/amino_acids.py  
 -- #8195; Utility data script.


### ddG monomer

main/source/src/apps/public/ddg/convert_to_cst_file.sh  
 -- #8195; Convert ddG logfile to a constraint file.


### Unclassified

main/source/external/R/BranchAngleOptimizer.R  
 -- #8195; 


## Build scripts

main/source/scons.py  
 -- #8195; Main script for Rosetta compilation.

main/source/ninja_build.py  
 -- #8195; Script for the alternative CMake+ninja build system.


## Test scripts

main/source/test/run.py  
 -- #8195; Run the unit tests.

main/tests/integration/integration.py  
 -- #8195; Run the integration tests.

main/tests/benchmark/benchmark.py  
 -- #8195; Run the benchmark server tests locally.

main/tests/sfxn_fingerprint/sfxn_fingerprint.py  
 -- #8195; Run the scorefunction fingerprint test.

main/tests/profile/profile.py  
 -- #8195; Run the profile tests.

main/tests/profile/compare_results.py  
 -- #8195; Compare the results of the profile tests.

main/tests/FeatureExtraction/features.py  
 -- #8195; 


## Coding Tools

main/source/make_ctags.sh  
 -- #8195; Make a ctag file for code editors.

main/source/src/utility/tools/make_templates.py  
 -- #8195; 


## Scripting Utilities

main/source/src/python/apps/public/amino_acids.py  
 -- #8195; Data about amino acids and their properties

main/source/src/python/apps/public/param_utils.py  
 -- #8195; Functions for manipulating params files.

main/source/src/python/rosetta_py/io/pdb.py  
 -- #8195; Utilities for reading PDB files.

main/source/src/python/rosetta_py/io/mdl_molfile.py  
 -- #8195; Utilities for reading sdf/mol/mol2 files.

main/source/src/python/rosetta_py/utility/rankorder.py  
 -- #8195; Functions for sorting data.

main/source/src/python/rosetta_py/utility/ForkManager.py  
 -- #8195; Utilities for handling multiprocessing

main/source/src/python/rosetta_py/utility/r3.py  
 -- #8195; A 3D vector class for python.


## Unclassified

main/source/GUIs/rosetta_flag_file_builder/  
 -- #8195; 

main/source/src/python/packaged_bindings/ --

main/source/src/python/bindings/  
 -- #8195; 

