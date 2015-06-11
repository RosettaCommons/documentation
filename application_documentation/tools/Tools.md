#Tools

## General Rosetta Tools

This page is a list of accessory scripts which are helpful in working with Rosetta input/output and job running.

Many of these scripts have further help options. 
Try running them without any arguments or with the '-h' flag to get further information.

### Input Preparation


#### Ligands

main/source/src/python/apps/public/molfile_to_params.py -- Make Rosetta *.params files. 

main/source/src/python/apps/public/rename_params.py -- Rename params files so that none conflict with each other.

main/source/src/python/apps/public/batch_molfile_to_params.py -- Make Rosetta *.params files for a large number of inputs.

main/source/src/apps/public/ligand_docking/[[assign_charges.py|ligand-dock]] -- Assign AM1-BCC charges to ligands.


#### Symmetry

main/source/src/apps/public/symmetry/[[make_symmdef_file_denovo.py|make-symmdef-file-denovo]] -- Make a symmetry file. 

main/source/src/apps/public/symmetry/[[make_symmdef_file.pl|make-symmdef-file]] -- Make a symmetry file for an existing PDB.


#### Membrane

main/source/src/apps/public/membrane_abinitio/octopus2span.pl -- Convert an Octopus topology file to a Rosetta span file.

main/source/src/apps/public/membrane_abinitio/run_lips.pl -- Run lipophilicity predictions.

main/source/src/apps/public/membrane_abinitio/alignblast.pl -- Extract a multiple alignment of hits from Blast or PsiBlast output.


#### Electron Density

main/source/src/apps/public/electron_density/prepare_template_for_MR.pl -- 


### Job Runing

main/source/src/python/apps/public/parallel.py -- Utility for running a large number of command lines in parallel.


### Output Manipulation


#### Silent files

main/source/src/python/apps/public/pymol_silent.py -- A pymol plugin to read silent files.


#### Score files

main/source/src/python/apps/public/column.sh -- Select only certain columns from a file.

main/source/src/python/apps/public/sd.py -- Extract data from silent files.

main/source/src/python/apps/public/rmsd_score_pymol_plotter/rmsd_score_pymol_plotter.py -- Create score vs. rmsd (funnel) plots.

main/source/src/python/apps/public/rmsd_score_pymol_plotter/rmsd_score_pymol_plotter_generator.pl -- Create score vs. rmsd (funnel) plots.

main/source/tools/scorefile.py -- Parse and extract data from score files in JSON format. 

main/source/src/apps/public/enzdes/[[DesignSelect.pl|enzyme-design]] -- Select only those rows of a tabular format which have columns matching requirements.


### PDBs

main/source/src/python/apps/public/pdb2fasta.py -- Extract a FASTA formatted sequence from a PDB.



### Unclassified

main/source/src/python/apps/public/color_pdb.py -- 

main/source/src/python/apps/public/color_pdb_byatom.py -- 

main/source/src/python/apps/public/get_pdb.py --  

main/source/src/utility/make_static_database.py -- 


## Application Specific Scripts


### Ligand Docking

main/source/src/apps/public/ligand_docking/[[arls.py|ligand-dock]] -- Automatic RosettaLigand setup.

main/source/src/apps/public/ligand_docking/best_ifaceE.py -- Prints the tags of the 'best' structures from a ligand docking run.

main/source/src/apps/public/ligand_docking/pdb_to_molfile.py -- Extracts coordinates from PDB file to regenerate mol/sdf/mol2 files.

main/source/src/apps/public/ligand_docking/prune_atdiff_top5pct.py -- Extract the top 5% by total score from an AtomTreeDiff file.

main/source/src/apps/public/ligand_docking/get_scores.py -- Extract the SCORES line of an AtomTreeDiff file into tabular format.

main/source/src/apps/public/ligand_docking/plot_funnels.R --


### Constrained Relax

main/source/src/apps/public/relax_w_allatom_cst/clean_pdb_keep_ligand.py -- Clean the PDB, keeping the ligand

main/source/src/apps/public/relax_w_allatom_cst/sidechain_cst_3.py -- Create a constraint file for the sidechain heavy atoms.

main/source/src/apps/public/relax_w_allatom_cst/amino_acids.py -- Utility data script.


### ddG monomer

main/source/src/apps/public/ddg/convert_to_cst_file.sh -- Convert ddG logfile to a constraint file.


### Unclassified

main/source/external/R/BranchAngleOptimizer.R -- 


## Build scripts

main/source/scons.py -- Main script for Rosetta compilation.

main/source/ninja_build.py -- Script for the alternative CMake+ninja build system.


## Test scripts

main/source/test/run.py -- Run the unit tests.

main/tests/integration/integration.py -- Run the integration tests.

main/tests/benchmark/benchmark.py -- Run the benchmark server tests locally.

main/tests/sfxn_fingerprint/sfxn_fingerprint.py -- Run the scorefunction fingerprint test.

main/tests/profile/profile.py -- Run the profile tests.

main/tests/profile/compare_results.py -- Compare the results of the profile tests.

main/tests/FeatureExtraction/features.py -- 


## Coding Tools

main/source/make_ctags.sh -- Make a ctag file for code editors.

main/source/src/utility/tools/make_templates.py -- 


## Scripting Utilities

main/source/src/python/apps/public/amino_acids.py -- Data about amino acids and their properties

main/source/src/python/apps/public/param_utils.py -- Functions for manipulating params files.

main/source/src/python/rosetta_py/io/pdb.py -- Utilities for reading PDB files.

main/source/src/python/rosetta_py/io/mdl_molfile.py -- Utilities for reading sdf/mol/mol2 files.

main/source/src/python/rosetta_py/utility/rankorder.py -- Functions for sorting data.

main/source/src/python/rosetta_py/utility/ForkManager.py -- Utilities for handling multiprocessing

main/source/src/python/rosetta_py/utility/r3.py -- A 3D vector class for python.


## Unclassified

main/source/GUIs/rosetta_flag_file_builder/ -- 

main/source/src/python/packaged_bindings/ --

main/source/src/python/bindings/ -- 

