#Tools


This page is a list of accessory scripts which are helpful in working with Rosetta input/output and job running.

Many of these scripts have further help options. 
Try running them without any arguments or with the '-h' flag to get further information.
<!--- BEGIN_INTERNAL -->

**NOTE TO DEVELOPERS:**
The `tools` repository is intended to be used for general-purpose scripts for development purposes (generating/processing input files, etc.). Python scripts for scientific purposes should be placed in the `main` repository so that they remain in sync with the Rosetta code base. Scientific python scripts for public use should be placed in `main/source/scripts/python/public/` and should have accompanying integration tests. Private scripts should be placed in `main/source/scripts/python/pilot/<user_name>`.  

Scripts in all of these categories should be listed and briefly described on this page. Public scientific scripts intended to be used as standalone applications should also have a separate application documentation page (see the [[How to write documentation]] page for notes on formatting application documentation).

<!--- END_INTERNAL -->
[[_TOC_]]

## General Rosetta Tools

### Input Preparation

#### PDB

* See also [[preparing structures]].

tools/protein_tools/scripts/clean_pdb.py    
&#8195; - Prepare PDBs for Rosetta by cleaning and renumbering residues. 

tools/renumber_pdb.py    
&#8195; - Renumber PDB such that PDB numbering matches pose numbering. 

tools/protein_tools/scripts/pdb_renumber.py    
&#8195; - Renumber PDB such that PDB numbering matches pose numbering.

tools/convert_hatm_names.py    
&#8195; - Convert the hydrogen naming convention of all PDBs in a directory to Rosetta conventions. 

tools/protein_tools/scripts/remove_loop_coords.py    
&#8195; - Zero out coordinates of atoms marked as loop in a loop file. 

#### Ligands

* See also [[preparing ligands]].

main/source/scripts/python/public/molfile_to_params.py    
&#8195; - Make Rosetta *.params files. 

main/source/scripts/python/public/rename_params.py    
&#8195; - Rename params files so that none conflict with each other.

main/source/scripts/python/public/batch_molfile_to_params.py    
&#8195; - Make Rosetta *.params files for a large number of inputs.

main/source/src/apps/public/ligand_docking/[[assign_charges.py|ligand-dock]]    
&#8195; - Assign AM1-BCC charges to ligands.

tools/protein_tools/scripts/calculate_ligand_rmsd.py
&#8195; - Pymol based script for calculating small molecule RMSDs

tools/protein_tools/scripts/visualize_ligand.py
&#8195; - Generate Pymol session for visualizing ligand binding pocket

#### Symmetry

* See [[Symmetry]] for more information.

main/source/src/apps/public/symmetry/[[make_symmdef_file_denovo.py|make-symmdef-file-denovo]]    
&#8195; - Make a symmetry file. 

main/source/src/apps/public/symmetry/[[make_symmdef_file.pl|make-symmdef-file]]    
&#8195; - Make a symmetry file for an existing PDB.


#### Membrane

* Examples of script usage are given at the [[membrane abinitio]] page.

main/source/src/apps/public/membrane_abinitio/[[octopus2span.pl|spanfile]]    
&#8195; - Convert an Octopus topology file to a Rosetta span file.

main/source/src/apps/public/membrane_abinitio/[[run_lips.pl|lipsfile]]    
&#8195; - Run lipophilicity predictions.

main/source/src/apps/public/membrane_abinitio/alignblast.pl    
&#8195; - Extract a multiple alignment of hits from Blast or PsiBlast output.


#### RosettaMembrane Framework

* See [[RosettaMembrane Framework Overview]] for overview, and
[[RosettaMembrane:-Scripts-and-Tools]] for more details about the scripts.

tools/membrane_tools/prep_mpdb.py    
&#8195; - Prep all required datafiles for the RosettaMembrane Framework.

tools/membrane_tools/[[octopus2span.pl|spanfile]]    
&#8195; - Convert an Octopus topology file to a Rosetta span file.

tools/membrane_tools/[[run_lips.pl|lipsfile]]    
&#8195; - Generate a lipid accessibility file.

tools/membrane_tools/alignblast.pl    
&#8195; - Generate multiple alignent file from Blast output - dependancy of run_lips.pl.

tools/membrane_tools/write_mp_xml.py    
&#8195; - Write a resource definition file template for membrane framework protocols. 

tools/membrane_tools/mptest_ut.py    
&#8195; - Run unit test for RosettaMembrane Framework code.

tools/membrane_tools/check_spanfile_in_pymol.pl    
&#8195; - Color PDB model by residue range regions as defined in membrane spanfile.


#### Electron Density

* See [[density map scoring]] for more information.

main/source/src/apps/public/electron_density/[[prepare_template_for_MR.pl|prepare-template-for-mr]]   
&#8195; - 


#### Contact Maps

tools/analysis/contactMapTools.py    
&#8195; - 


#### Fragments

* For more information see [[app-fragment-picker]] and [[Fragment file]].

tools/fragment_tools/make_fragments.pl    
&#8195; - Generate fragments from a fasta file.

tools/fragment_tools/install_dependencies.pl    
&#8195; - Install dependancies for fragment picking.

tools/fragment_tools/ss_pred_converter.py    
&#8195; - Convert secondary structure predictions to PsiPred-SS2 format.

tools/fragment_tools/update_revdat.pl    
&#8195; - Update revdat file for benchmarking cutoffs. 

#### Constraint files

tools/protein_tools/scripts/generate_atom_pair_constraint_file.py
&#8195; - Generate a Rosetta constraint file to restrain atom pair distances based on a PDB file.

### Job Running

main/source/scripts/python/public/parallel.py    
&#8195; - Utility for running a large number of command lines in parallel.


### Output Manipulation


#### Silent files

* See [[silent file]] for more information.

main/source/scripts/python/public/pymol_silent.py    
&#8195; - A pymol plugin to read silent files.

tools/analysis/extract_pdbs_from_pdbsilent_by_tags.py    
&#8195; - Extract particular structures from a silent file by their tags. 


#### Score files

* See [[score file]] for more information.

main/source/scripts/python/public/column.sh    
&#8195; - Select only certain columns from a file.

main/source/scripts/python/public/sd.py    
&#8195; - Extract data from silent files.

main/source/tools/scorefile.py    
&#8195; - Parse and extract data from score files in JSON format. 

main/source/src/apps/public/enzdes/[[DesignSelect.pl|enzyme-design]]    
&#8195; - Select only those rows of a tabular format which have columns matching requirements.


#### PDBs

main/source/scripts/python/public/pdb2fasta.py    
&#8195; - Extract a FASTA formatted sequence from a PDB.

tools/protein_tools/scripts/get_fasta_from_pdb.py    
&#8195; - Extract a FASTA formatted sequence from a PDB. 


#### Analysis of Multiple Structures 

tools/protein_tools/scripts/SequenceProfile.py    
&#8195; - Create a sequence profile from a list of PDBs. 


#### Plotting Utilities

main/source/scripts/python/public/rmsd_score_pymol_plotter/rmsd_score_pymol_plotter.py    
&#8195; - Create score vs. rmsd (funnel) plots.

main/source/scripts/python/public/rmsd_score_pymol_plotter/rmsd_score_pymol_plotter_generator.pl    
&#8195; - Create score vs. rmsd (funnel) plots.

tools/protein_tools/scripts/score_vs_rmsd_full.py    
&#8195; - Create score vs. rmsd (funnel) plots. 

tools/protein_tools/scripts/score_vs_rmsd.py    
&#8195; - Create score vs. rmsd (funnel) plots.

tools/protein_tools/scripts/score_scatter_plot.py    
&#8195; - Create score term vs. score term scatter plots.

tools/analysis/numeric/MultiDimensionalHistogram.R    
&#8195; - 

tools/analysis/protocols/moves/DOFHistogramRecorder.R    
&#8195; - 

tools/analysis/constraints/score_vs_atom_pair_constraint.R    
&#8195; - Make a total score vs. atom_pair_constraint scatter plot.

#### Clustering Utilities

* See also [[cluster]].

tools/protein_tools/scripts/clustering.py    
&#8195; - Run and parse the Rosetta clustering. 


#### Unclassified

main/source/scripts/python/public/color_pdb.py    
&#8195; - 

main/source/scripts/python/public/color_pdb_byatom.py    
&#8195; - 

main/source/scripts/python/public/get_pdb.py    
&#8195; -  

main/source/src/utility/make_static_database.py    
&#8195; - 

tools/protein_tools/scripts/best_models.py    
&#8195; - 

tools/protein_tools/scripts/sequence_recovery.py    
&#8195; - 

tools/protein_tools/scripts/small_molecule_rmsd_table.py    
&#8195; - 

tools/protein_tools/scripts/tabbed_to_bcl.py    
&#8195; - 

tools/protein_tools/scripts/thread_pdb_from_alignment.py    
&#8195; - 

tools/protein_tools/scripts/top_n_percent.py    
&#8195; - 

tools/protein_tools/setup.py    
&#8195; - 

tools/perl_tools/addChain.pl    
&#8195; - 

tools/perl_tools/cleanPdbCA.pl    
&#8195; - 

tools/perl_tools/createTemplate.pl    
&#8195; - 

tools/perl_tools/getCAcoords.pl    
&#8195; - 

tools/perl_tools/getFastaFromCoords.pl    
&#8195; - 

tools/perl_tools/getFirstChain.pl    
&#8195; - 

tools/perl_tools/getPdb.pl    
&#8195; - 

tools/perl_tools/removeChain.pl    
&#8195; - 

tools/perl_tools/removeExtendedChain.pl    
&#8195; - 

tools/perl_tools/removeTERs.pl    
&#8195; - 

tools/python_pdb_structure/compare_sequences.py    
&#8195; - 

tools/python_pdb_structure/create_matcher_gridlig.py    
&#8195; - 

tools/python_pdb_structure/find_neighbors.py    
&#8195; - 

tools/python_pdb_structure/hist.py    
&#8195; - 

tools/python_pdb_structure/intdef_basics.py    
&#8195; - 

tools/python_pdb_structure/pdb_structure.py    
&#8195; - 

tools/python_pdb_structure/sequence_profile.py    
&#8195; - 

tools/python_pdb_structure/test_compare_sequences.py    
&#8195; - 

tools/python_pdb_structure/test_sequence_profile.py    
&#8195; - 

tools/python_pdb_structure/vector3d.py    
&#8195; - 


## Application Specific Scripts


### Ligand Docking

* See [[Ligand dock]] for an overview.

main/source/src/apps/public/ligand_docking/[[arls.py|ligand-dock]]    
&#8195; - Automatic RosettaLigand setup.

main/source/src/apps/public/ligand_docking/[[best_ifaceE.py|extract-atomtree-diffs]]    
&#8195; - Prints the tags of the 'best' structures from a ligand docking run.

main/source/src/apps/public/ligand_docking/pdb_to_molfile.py    
&#8195; - Extracts coordinates from PDB file to regenerate mol/sdf/mol2 files.

main/source/src/apps/public/ligand_docking/prune_atdiff_top5pct.py    
&#8195; - Extract the top 5% by total score from an AtomTreeDiff file.

main/source/src/apps/public/ligand_docking/[[get_scores.py|extract-atomtree-diffs]]    
&#8195; - Extract the SCORES line of an AtomTreeDiff file into tabular format.

main/source/src/apps/public/ligand_docking/plot_funnels.R    
&#8195; - 


### Antibody

* See [[Antibody Protocol]] for more information.

tools/antibody/[[antibody.py|antibody-python-script]]    
&#8195; - Pre-processing script for antibody protocol.

tools/antibody/antibody_repertoire.py    
&#8195; - Processes a fasta file of an antibody repertoire to create a dB of structures.

tools/antibody/convert_pdb_to_antibody_numbering_scheme.py    
&#8195; - Script to change a PDB sequence into a cannonical antibody numbering scheme. 

tools/antibody/chothia_mapping_v2.pl    
&#8195; - Script to map the given PDB sequence to the Chothia numbering. 

tools/antibody/chothia_renumber_v2.pl    
&#8195; - Script to re-number PDB files according to the Chothia scheme.

tools/antibody/classification_H3.pl    
&#8195; - 

tools/antibody/colorcdr.pml    
&#8195; - 

tools/antibody/kink_constraints.py    
&#8195; - Output kink constraint files for a set of antibodies. 

tools/antibody/kink_geom.py    
&#8195; - Calculate kink geometry for a set of antibodies. 

tools/antibody/kink_plots.R    
&#8195; - Plot geometry of the H3 kink.

tools/antibody/make_angle_distances.py    
&#8195; - Calculates orientational distance between all antibodies in database. 

tools/antibody/superimpose_interface.py    
&#8195; - 


### Constrained Relax

main/source/src/apps/public/relax_w_allatom_cst/clean_pdb_keep_ligand.py    
&#8195; - Clean the PDB, keeping the ligand

main/source/src/apps/public/relax_w_allatom_cst/sidechain_cst_3.py    
&#8195; - Create a constraint file for the sidechain heavy atoms.

main/source/src/apps/public/relax_w_allatom_cst/amino_acids.py    
&#8195; - Utility data script.


### RosettaCM

tools/protein_tools/scripts/setup_RosettaCM.py    
&#8195; - 


### RNA

* See [[RNA tools]] for more information.

tools/rna_tools/bin/amino_acids.py    
&#8195; - 

tools/rna_tools/bin/biox3_jobsub.py    
&#8195; - 

tools/rna_tools/bin/cat_outfiles.py    
&#8195; - 

tools/rna_tools/bin/check_cutpoints.py    
&#8195; - 

tools/rna_tools/bin/cluster_info.py    
&#8195; - 

tools/rna_tools/bin/easy_cat.py    
&#8195; - 

tools/rna_tools/bin/extract_chain.py    
&#8195; - 

tools/rna_tools/bin/extract_lowscore_decoys_outfile.py    
&#8195; - 

tools/rna_tools/bin/extract_lowscore_decoys.py    
&#8195; - 

tools/rna_tools/bin/fetch_pdb.py    
&#8195; - 

tools/rna_tools/bin/fields.py    
&#8195; - 

tools/rna_tools/bin/fix_chainbreaks_with_erraser.py    
&#8195; - 

tools/rna_tools/bin/get_res_num.py    
&#8195; - 

tools/rna_tools/bin/get_sequence.py    
&#8195; - 

tools/rna_tools/bin/get_surrounding_res.py    
&#8195; - 

tools/rna_tools/bin/helix_preassemble_setup.py    
&#8195; - 

tools/rna_tools/bin/make_rna_rosetta_ready.py    
&#8195; - [[rna-denovo]]

tools/rna_tools/bin/make_tag.py    
&#8195; - 

tools/rna_tools/bin/mpi4py_jobsub.py    
&#8195; - 

tools/rna_tools/bin/parallel_min_setup.py    
&#8195; - 

tools/rna_tools/bin/parse_options.py    
&#8195; - 

tools/rna_tools/bin/parse_tag.py    
&#8195; - 

tools/rna_tools/bin/pdb2fasta.py    
&#8195; - 

tools/rna_tools/bin/pdbslice.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/bin/pdbsubset.py    
&#8195; - 

tools/rna_tools/bin/pp_jobsub.py    
&#8195; - 

tools/rna_tools/bin/pp_util.py    
&#8195; - 

tools/rna_tools/bin/prepare_rna_puzzle_submissions.py    
&#8195; - 

tools/rna_tools/bin/qsub_torque.py    
&#8195; - 

tools/rna_tools/bin/read_pdb.py    
&#8195; - 

tools/rna_tools/bin/renumber_pdb_in_place.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/bin/reorder_pdb.py    
&#8195; - 

tools/rna_tools/bin/reorder_to_standard_pdb.py    
&#8195; - 

tools/rna_tools/bin/replace_chain_inplace.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/bin/replace_chain.py    
&#8195; - 

tools/rna_tools/bin/rna_denovo_jobscript.py    
&#8195; - 

tools/rna_tools/bin/rna_denovo_setup.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/bin/rna_helix.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/bin/rna_server_conversions.py    
&#8195; - 

tools/rna_tools/bin/rosetta_exe.py    
&#8195; - 

tools/rna_tools/bin/rosetta_submit.py    
&#8195; - 

tools/rna_tools/bin/rsync_from_cluster.py    
&#8195; - 

tools/rna_tools/bin/rsync_to_cluster.py    
&#8195; - 

tools/rna_tools/bin/silent_file_sort_and_select.py    
&#8195; - 

tools/rna_tools/cluster_setup/biox3_jobsub.py    
&#8195; - 

tools/rna_tools/cluster_setup/cluster_info.py    
&#8195; - 

tools/rna_tools/cluster_setup/easy_cat.py    
&#8195; - 

tools/rna_tools/cluster_setup/mpi4py_jobsub.py    
&#8195; - 

tools/rna_tools/cluster_setup/pp_jobsub.py    
&#8195; - 

tools/rna_tools/cluster_setup/pp_util.py    
&#8195; - 

tools/rna_tools/cluster_setup/qsub_torque.py    
&#8195; - 

tools/rna_tools/cluster_setup/rosetta_submit.py    
&#8195; - 

tools/rna_tools/cluster_setup/rsync_from_cluster.py    
&#8195; - 

tools/rna_tools/cluster_setup/rsync_to_cluster.py    
&#8195; - 

tools/rna_tools/job_setup/helix_preassemble_setup.py    
&#8195; - 

tools/rna_tools/job_setup/make_tag.py    
&#8195; - 

tools/rna_tools/job_setup/parallel_min_setup.py    
&#8195; - 

tools/rna_tools/job_setup/parse_options.py    
&#8195; - 

tools/rna_tools/job_setup/parse_tag.py    
&#8195; - 

tools/rna_tools/job_setup/rna_denovo_jobscript.py    
&#8195; - 

tools/rna_tools/job_setup/rna_denovo_setup.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/job_setup/rna_server_conversions.py    
&#8195; - 

tools/rna_tools/job_setup/rosetta_exe.py    
&#8195; - 

tools/rna_tools/pdb_util/amino_acids.py    
&#8195; - 

tools/rna_tools/pdb_util/check_cutpoints.py    
&#8195; - 

tools/rna_tools/pdb_util/extract_chain.py    
&#8195; - 

tools/rna_tools/pdb_util/fetch_pdb.py    
&#8195; - 

tools/rna_tools/pdb_util/fix_chainbreaks_with_erraser.py    
&#8195; - 

tools/rna_tools/pdb_util/get_res_num.py    
&#8195; - 

tools/rna_tools/pdb_util/get_sequence.py    
&#8195; - 

tools/rna_tools/pdb_util/get_surrounding_res.py    
&#8195; - 

tools/rna_tools/pdb_util/make_rna_rosetta_ready.py    
&#8195; - 

tools/rna_tools/pdb_util/pdb2fasta.py    
&#8195; - 

tools/rna_tools/pdb_util/pdbslice.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/pdb_util/pdbsubset.py    
&#8195; - 

tools/rna_tools/pdb_util/plot_contour.py    
&#8195; - [[Sample-around-nucleobase]]

tools/rna_tools/pdb_util/prepare_rna_puzzle_submissions.py    
&#8195; - 

tools/rna_tools/pdb_util/read_pdb.py    
&#8195; - 

tools/rna_tools/pdb_util/renumber_pdb_in_place.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/pdb_util/reorder_pdb.py    
&#8195; - 

tools/rna_tools/pdb_util/reorder_to_standard_pdb.py    
&#8195; - 

tools/rna_tools/pdb_util/replace_chain_inplace.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/pdb_util/replace_chain.py    
&#8195; - 

tools/rna_tools/pdb_util/rna_helix.py    
&#8195; - [[rna-denovo-setup]]

tools/rna_tools/silent_util/cat_outfiles.py    
&#8195; - 

tools/rna_tools/silent_util/extract_lowscore_decoys_outfile.py    
&#8195; - 

tools/rna_tools/silent_util/extract_lowscore_decoys.py    
&#8195; - 

tools/rna_tools/silent_util/fields.py    
&#8195; - 

tools/rna_tools/silent_util/silent_file_sort_and_select.py    
&#8195; - 

tools/rna_tools/sym_link.py    
&#8195; - 

### Stepwise assembly

tools/SWA_protein_python/generate_dag/generate_CA_constraints.py    
&#8195; - [[swa-protein-main]] [[swa-protein-long-loop]]

tools/SWA_protein_python/generate_dag/generate_constraints.py    
&#8195; - 

tools/SWA_protein_python/generate_dag/generate_swa_protein_dag.py    
&#8195; - [[swa-protein-long-loop]]

tools/SWA_protein_python/generate_dag/get_sequence.py    
&#8195; - 

tools/SWA_protein_python/generate_dag/make_tag.py    
&#8195; - 

tools/SWA_protein_python/generate_dag/parse_options.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/extract_lowscore_decoys_outfile.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/parse_options.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/stepwise_post_process_cluster.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/stepwise_post_process_combine_and_filter_outfiles.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/stepwise_pre_process_setup_dirs.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_condor_test.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_dagman_LSF_continuous.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_dagman_slave.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_kick_off_slave_jobs.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_parse_options.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_pseudo_dagman_continuous.py    
&#8195; - [[swa-protein-long-loop]]

tools/SWA_protein_python/run_dag_on_cluster/SWA_sampling_post_process.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_sampling_pre_process.py    
&#8195; - 

tools/SWA_protein_python/run_dag_on_cluster/SWA_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/benchmark_command.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/benchmark_command_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/DAG_continuous.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/DAG_continuous_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/DAG_general_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/DAG_generic_silent_file_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/DAG_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/DAG_slave.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/generic_empty_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/dagman/submit_DAG_job.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/database/SWA_amino_acids.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/FARFAR_dag_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/FARFAR_easy_cat.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/FARFAR_filterer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/FARFAR_final_filter_dag.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/FARFAR_pre_process.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/FARFAR_rna_build_dagman.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/FARFAR_rna_build_dagman_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/setup_FARFAR_job_files_parse_options.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/setup_FARFAR_job_files.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/FARFAR_DAG/setup_FARFAR_job_files_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/calculate_pairwise_RMSD.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/calculate_RMSD.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/check_mapper_files_exist.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/cluster_rotamers.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/combine_pdb.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/count_molprobity_clash_atoms.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_benchmark_job_files.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_benchmark_table.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_benchmark_table_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_gnuplot_script.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_idealize_helix_general.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_idealize_helix.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_local_dag.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_RNA_primer_simple.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_score_vs_rmsd_plot.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_torsion_database_check_length.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/create_torsion_database.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/ensure_rna_rosetta_ready.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/extend_silent_struct_with_idealized_helix.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/extract_C1_P_atom_from_PDB.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/extract_FR3D_data.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/extract_hbond_stat.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/extract_MC_annotate_data.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/extract_torsions_from_pdb.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/fields.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/find_sequence.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/fix_pymol_output_pdb.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/get_OLLM_chain_closure_only_regions.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/invert_chain_sequence.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/line_counts.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/lower_sequence.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/minimize_pdb.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/path_check_gnuplot.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/pdb2seqlist.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/pdb_to_silent_file.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/remove_columns.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/remove_duplicate_sequence_line_in_silent_file.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/remove_hydrogen_from_pdb.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/renumber_pdb_in_place.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/replace_chain_inplace.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/replace_silent_scoreline.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/Reposition_pdb_atom_name.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/reweight_chem_shift_score.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/reweight_silent_file_SCORE.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/Rosetta_all_atom_derivative_check.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/Rosetta_import_and_dump_pdb.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/Rosetta_to_standard_PDB.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/select_models_silentfile.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/slice_pdb_list.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/slice_sample_res_and_surrounding.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_add_hydrogen.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_align_pdb.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_all_rna_rosetta_ready.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_cat_outfiles.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_cat_outfiles_wrapper.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_cluster.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_copy_non_full_length_regions.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_extract_pdb.py    
&#8195; - [[swa-rna-loop]]

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_filter_outfile_wrapper.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_filter_silent_file.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_make_rna_rosetta_ready.py    
&#8195; - [[swa-rna-loop]]

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_mutate_residues.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_pdb2fasta.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_pdbslice.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_pdb_slice_wrapper.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_plot_region_FINALs.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_SS_LOOP_create_benchmark_table.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_SS_LOOP_create_benchmark_table_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_trace_pathway.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_trace_pathway_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/benchmark_command.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/benchmark_command_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_continuous_MPI_wrapper.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_continuous.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_continuous_qsub.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_continuous_qsub_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_continuous_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_generic_silent_file_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/DAG_slave.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/generic_empty_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/old_dagman_works_with_condor/submit_DAG_job.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/parser/SWA_parse_benchmark.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/parser/SWA_parse_internal_arguments.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/parser/SWA_parse_options.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/parser/SWA_parse_rosetta_options.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/infinite_loop.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/kill_all_slave_jobs.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/LSF_scheduler.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/MPI_helloword.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/MPI_PBS_scheduler.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/MPI_SGE_scheduler.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/PBS_scheduler.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/print_queued_jobs.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/scheduler_build_test.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/scheduler_common.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/scheduler_queue_job.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/scheduler_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/scheduler/simple_test_script.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/create_dag_job_files.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/DAG_rebuild_bulge_pre_process.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/DAG_rebuild_bulge.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/DAG_rebuild_bulge_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/DAG_rebuild_bulge_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/setup_SWA_RNA_dag_job_files.py    
&#8195; - [[swa-rna-loop]]

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/submit_SWA_rna_minimize_benchmark.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_DAG_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_rna_build_dagman.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_rna_build_dagman_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_rna_minimize.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_rna_minimize_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_sample_virt_ribose_reducer.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_sampling_combine_long_loop_pre_process.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_sampling_post_process.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_sampling_post_process_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/SWA_sampling_pre_process.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/swa_revival/plot_silent_file_scores.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/swa_revival/SWA_rna_build_commands_from_dagman.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/swa_revival/SWA_rna_build_dag_parse.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/swa_revival/SWA_rna_serial_hack.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/swa_revival/SWA_rna_setup_inputs.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/swa_revival/SWA_setup_benchmark.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/swa_revival/SWA_setup_benchmark_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/chemical_shift_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/DAGMAN_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/error_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/extract_FR3D_data_functions.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/extract_MC_annotate_data_functions.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/list_operations.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/master_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/PATHS.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/PDB_operations.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/RNA_BP_and_BS_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/RNA_sequence.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/Rosetta_to_standard_PDB_functions.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/silent_file_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/SWA_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/torsion_database_util.py    
&#8195; - 

tools/SWA_RNA_python/SWA_dagman_python/utility/USER_PATHS.py    
&#8195; - 


### RECCES

* See [[RECCES]] for more information.

tools/recces/data.py    
&#8195; - 

tools/recces/min_func.py    
&#8195; - 

tools/recces/util.py    
&#8195; - 


### Remodel

See also the [[Remodel]] and [[RosettaRemodel]] documentation.

tools/remodel/getBluePrintFromCoords.pl    
&#8195; - 


### ddG monomer

* See [[ddg-monomer]] for more information.

main/source/src/apps/public/ddg/[[convert_to_cst_file.sh|ddg-monomer]]    
&#8195; - Convert ddG logfile to a constraint file.


### Pepspec

* See [[Pepspec]] for more info.

tools/analysis/apps/gen_pepspec_pwm.py    
&#8195; - Generate a position weight matrix from PepSpec output. 


### Beta peptides

tools/beta-peptide/create_beta_peptide_params.py    
&#8195; -  

tools/beta-peptide/make_beta_peptide_bbdep.py    
&#8195; - 


### High Throughput Docking

tools/hts_tools/add_activity_tags_to_database.py    
&#8195; - 

tools/hts_tools/add_hydrogens.py    
&#8195; - 

tools/hts_tools/add_ligands_to_job_file.py    
&#8195; - 

tools/hts_tools/clean_pdb.py    
&#8195; - 

tools/hts_tools/compress_ligands.py    
&#8195; - 

tools/hts_tools/get_descriptor_data.py    
&#8195; - 

tools/hts_tools/hts_util.py    
&#8195; - 

tools/hts_tools/ligand_database.py    
&#8195; - 

tools/hts_tools/make_evenly_grouped_jobs.py    
&#8195; - 

tools/hts_tools/make_ligand_centroid_pdb.py    
&#8195; - 

tools/hts_tools/make_params.py    
&#8195; - 

tools/hts_tools/make_startfom_files.py    
&#8195; - 

tools/hts_tools/prepare_sdfs_for_bcl.py    
&#8195; - 

tools/hts_tools/sdf_parser/MolFile.py    
&#8195; - 

tools/hts_tools/sdf_parser/MolFileTests.py    
&#8195; - 

tools/hts_tools/sdf_parser/SdfFile.py    
&#8195; - 

tools/hts_tools/sdf_parser/SdfTest.py    
&#8195; - 

tools/hts_tools/sdf_split_organize.py    
&#8195; - 

tools/hts_tools/setup_screening_project.py    
&#8195; - 


### Fiber Difraction

tools/fragment_tools/pdb2vall/pdb2vall.py    
&#8195; - 

tools/fiber_diffraction/layer_line_pruner.py    
&#8195; - Remove neighboring points from free or working sets. 

tools/fiber_diffraction/make_helix_denovo_cnsm.py    
&#8195; - Helix denovo symmetry definition file generator.

tools/fiber_diffraction/make_helix_denovo.py    
&#8195; - Helix denovo symmetry definition file generator.


### Vall generation

tools/fragment_tools/pdb2vall/amino_acids.py    
&#8195; - 

tools/fragment_tools/pdb2vall/database/rcsb_data/get_ss_dis.sh    
&#8195; - 

tools/fragment_tools/pdb2vall/database/rcsb_data/rsyncPDB.sh    
&#8195; - 

tools/fragment_tools/pdb2vall/database/rcsb_data/update_rcsb_data.pl    
&#8195; - 

tools/fragment_tools/pdb2vall/get_missing_den_from_disss.py    
&#8195; - 

tools/fragment_tools/pdb2vall/jump_over_missing_density.py    
&#8195; - 

tools/fragment_tools/pdb2vall/numbering_back_to_pdbseqres.py    
&#8195; - 

tools/fragment_tools/pdb2vall/parse_dssp_results.py    
&#8195; - 

tools/fragment_tools/pdb2vall/pdb_scripts/amino_acids.py    
&#8195; - 

tools/fragment_tools/pdb2vall/pdb_scripts/clean_pdb.py    
&#8195; - 

tools/fragment_tools/pdb2vall/pdb_scripts/fetch_raw_pdb.py    
&#8195; - 

tools/fragment_tools/pdb2vall/pdb_scripts/get_pdb_new.py    
&#8195; - 

tools/fragment_tools/pdb2vall/pdb_scripts/maxsprout/test/runmaxsprout.pl    
&#8195; - 

tools/fragment_tools/pdb2vall/pdb_scripts/pdb2fasta.py    
&#8195; - 

tools/fragment_tools/pdb2vall/pdb_scripts/rebuild_pdb_from_CA.sh    
&#8195; - 

tools/fragment_tools/pdb2vall/renumber_structure_profile_checkpoint_back_to_seqres.py    
&#8195; - 

tools/fragment_tools/pdb2vall/sequence_profile_scripts/run_psiblast_filtnr_tight.pl    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/create_checkpoint_from_fasta_alignment.pl    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/DEPTH-CLONE-2.8.7/doc/example.sh    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/DEPTH-CLONE-2.8.7/par/background-map.py    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/DEPTH-CLONE-2.8.7/src/pdb_T_modifier.py    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/dssp2threestateSS.pl    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/generate_struct_profile.rb    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/get_structure_profile_checkpoint.py    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/make_alignment_from_fragfile.pl    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/make_alignment_from_fragfile_rmsCutoff.pl    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/make_depthfile.py    
&#8195; - 

tools/fragment_tools/pdb2vall/structure_profile_scripts/make_sequence_fragments.pl    
&#8195; - 


### Design Analysis Tools 

tools/protein_tools/scripts/design_analysis/analysis_tools.py    
&#8195; - 

tools/protein_tools/scripts/design_analysis/argument_parsing.py    
&#8195; - 

tools/protein_tools/scripts/design_analysis/design_analysis.py    
&#8195; - 

tools/protein_tools/scripts/design_analysis/scoretable.py    
&#8195; - 

tools/protein_tools/scripts/design_analysis/sequence_analysis.py    
&#8195; - 



### Small Molecule Artificial Neural Networks

tools/ann_tools/cat_sdfs.py    
&#8195; - 

tools/ann_tools/compute_csv_tables.py    
&#8195; - 

tools/ann_tools/make_bcl_inputs_for_plotting.py    
&#8195; - 

tools/ann_tools/make_bcl_roc_plots.py    
&#8195; - 

tools/ann_tools/make_datasets.py    
&#8195; - 

tools/ann_tools/score_sdf.py    
&#8195; - 

tools/ann_tools/sort_sdfs.py    
&#8195; - 


### Unclassified

main/source/external/R/BranchAngleOptimizer.R    
&#8195; - 

main/source/scripts/python/public/orbitals_pretty.pml    
&#8195; 

main/tests/integration/tests/inv_kin_lig_loop_design/showme.pml    
&#8195; 

tools/analysis/apps/sequence_tolerance.R    
&#8195; - 


## Build scripts

* See [[Build Documentation]] for more information.

main/source/[[scons.py|Build Documentation]]    
&#8195; - Main script for Rosetta compilation.

main/source/ninja_build.py    
&#8195; - Script for the alternative CMake+ninja build system.


## Test scripts

main/source/test/[[run.py|run-unit-test]]    
&#8195; - Run the unit tests.

main/tests/integration/[[integration.py|integration-tests]]    
&#8195; - Run the integration tests.

main/tests/benchmark/[[benchmark.py|testing-server]]    
&#8195; - Run the benchmark server tests locally.

main/tests/sfxn_fingerprint/sfxn_fingerprint.py    
&#8195; - Run the scorefunction fingerprint test.

main/tests/profile/profile.py    
&#8195; - Run the profile tests.

main/tests/profile/compare_results.py    
&#8195; - Compare the results of the profile tests.

main/tests/FeatureExtraction/features.py    
&#8195; - 


## Scripting Utilities

main/source/scripts/python/public/amino_acids.py    
&#8195; - Data about amino acids and their properties.

tools/protein_tools/scripts/amino_acids.py    
&#8195; - Data about amino acids and their properties. 

tools/python_pdb_structure/amino_acids.py    
&#8195; - Data about amino acids and their properties. 

main/source/scripts/python/public/param_utils.py    
&#8195; - Functions for manipulating params files.

main/source/scripts/python/public/rosetta_py/io/pdb.py    
&#8195; - Utilities for reading PDB files.

main/source/scripts/python/public/rosetta_py/io/mdl_molfile.py    
&#8195; - Utilities for reading sdf/mol/mol2 files.

main/source/scripts/python/public/rosetta_py/utility/rankorder.py    
&#8195; - Functions for sorting data.

main/source/scripts/python/public/rosetta_py/utility/ForkManager.py    
&#8195; - Utilities for handling multiprocessing.

main/source/scripts/python/public/rosetta_py/utility/r3.py    
&#8195; - A 3D vector class for python.

tools/protein_tools/rosettautil/bcl/file_formats.py    
&#8195; - 

tools/protein_tools/rosettautil/graphics/plotting.py    
&#8195; - 

tools/protein_tools/rosettautil/protein/alignment.py    
&#8195; - 

tools/protein_tools/rosettautil/protein/naccess.py    
&#8195; - 

tools/protein_tools/rosettautil/protein/pdbStat.py    
&#8195; - 

tools/protein_tools/rosettautil/protein/PSSM.py    
&#8195; - 

tools/protein_tools/rosettautil/protein/util.py    
&#8195; - 

tools/protein_tools/rosettautil/rosetta/loops.py    
&#8195; - 

tools/protein_tools/rosettautil/rosetta/map_pdb_residues.py    
&#8195; - 

tools/protein_tools/rosettautil/rosetta/params.py    
&#8195; - 

tools/protein_tools/rosettautil/rosetta/resfile.py    
&#8195; - 

tools/protein_tools/rosettautil/rosetta/rosettaScore_beta.py    
&#8195; - 

tools/protein_tools/rosettautil/rosetta/rosettaScore.py    
&#8195; - 

tools/protein_tools/rosettautil/rosetta/weights.py    
&#8195; - 

tools/protein_tools/rosettautil/util/fileutil.py    
&#8195; - 


## Coding Tools

main/source/make_ctags.sh    
&#8195; - Make a ctag file for code editors.

tools/Check_header_guards_and_copyright.py    
&#8195; - Check that the copyright header on each Rosetta file is correct. 

tools/coding_util/remove_dead_code.py    
&#8195; - Remove files which are not needed for the compile. 

tools/code_coverage.py    
&#8195; - Calculate code coverage over integration and unit test. 

tools/git_revision_parser.py    
&#8195; - Attempt to find relevant revision designations from a git commit. 

tools/coding_util/generate_warnings_list.py    
&#8195; - Find compiler warnings in Rosetta code. 

main/source/src/utility/tools/make_templates.py    
&#8195; - 

tools/perl_util/compiler.pl    
&#8195; - 

tools/perl_util/diff_int.pl    
&#8195; - 

tools/perl_util/find_includes.pl    
&#8195; - 

tools/perl_util/grep_source.pl    
&#8195; - 

tools/perl_util/hack_replace.pl    
&#8195; - 

tools/perl_util/include_guard.pl    
&#8195; - 

tools/perl_util/promote_lib.pl    
&#8195; - 

tools/perl_util/ralph-build.pl    
&#8195; - 

tools/perl_util/remove_trailing_whitespace.pl    
&#8195; - 

tools/perl_util/scons_to_makefile.pl    
&#8195; - 

tools/perl_util/spaces2tabs.pl    
&#8195; - 

tools/perl_util/suggest_compilation_fixes.pl    
&#8195; - 

tools/coding_util/artistic_spacing.py    
&#8195; - 

tools/coding_util/create_rosetta_class.py    
&#8195; - 

tools/coding_util/create_rosetta_mover.py    
&#8195; - 

tools/coding_util/create_variables_for_class.py    
&#8195; - 

tools/coding_util/fix_AUTO_REMOVE.py    
&#8195; - 

tools/coding_util/fixes/DNA_RNA_atom_rename.sh    
&#8195; - 

tools/coding_util/fixes/DNA_RNA_residue_rename_pdb.py    
&#8195; - 

tools/coding_util/fixes/DNA_RNA_residue_rename.sh    
&#8195; - 

tools/coding_util/fixes/fix_general_to_align.py    
&#8195; - 

tools/coding_util/fixes/fix_namespace_scopes.py    
&#8195; - 

tools/coding_util/fixes/fix_swa_rna_Output.py    
&#8195; - 

tools/coding_util/fixes/fix_tracer_names.py    
&#8195; - 

tools/coding_util/fixes/func_fixup.sh    
&#8195; - 

tools/coding_util/fixes/remove_Contain_seq_num.py    
&#8195; - 

tools/coding_util/fixes/remove_VIRT.py    
&#8195; - 

tools/coding_util/fixes/rename_rU.sh    
&#8195; - 

tools/coding_util/fixes/swa_rna_add_tracer_to_output.py    
&#8195; - 

tools/coding_util/fixes/swa_rna_fix_underscores.sh    
&#8195; - 

tools/coding_util/fixes/switch_DNA_hydrogens.sh    
&#8195; - 

tools/coding_util/fixes/switch_OP1_OP2.sh    
&#8195; - 

tools/coding_util/fixes/switch_RNA_hydrogens_H2.sh    
&#8195; - 

tools/coding_util/fixes/switch_RNA_hydrogens_H4.sh    
&#8195; - 

tools/coding_util/fixes/switch_RNA_hydrogens.sh    
&#8195; - 

tools/coding_util/fixes/update_swm_options2.sh    
&#8195; - 

tools/coding_util/fixes/update_swm_options.sh    
&#8195; - 


## Unclassified

main/source/GUIs/rosetta_flag_file_builder/*    
&#8195; - 

main/source/src/python/packaged_bindings/*    
&#8195; - 

main/source/src/python/bindings/*    
&#8195; - 

tools/clang/clang.py    
&#8195; - 

tools/clang_ast_transform/*    
&#8195; - 

tools/PyRosetta.develop/DeployPyRosetta.py    
&#8195; - 

tools/python_cc_reader/*    
&#8195; -

tools/willclang/*    


##See Also

* [[Utilities Applications]]
* [[Analysis Applications]]
* [[Application Documentation]]: Home page for applications
* [[Instructions for setting up R|FeaturesTutorialRBasics]]
* [[PyMOL]]