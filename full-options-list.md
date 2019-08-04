# List of Rosetta command line options.

_(This is an automatically generated file, do not edit!)_
Generated: 2019-08-04

_Note that some application specific options may not be present in this list._

[[_TOC_]]
+ <h2>-in</h2>
<dl>
<dt><b>-in</b> \<Boolean\></dt>
<dd>in option group<br/></dd>
<dt><b>-fconfig</b> \<FileVector\></dt>
<dd>A list of flag configurations to look for.  These can be in either your working directory or $HOME/.rosetta/flags directory.  Ex: -fconfig common design<br/>Default: ['"common"']<br/></dd>
<dt><b>-no_fconfig</b> \<Boolean\></dt>
<dd>Do not load the [common] config file if present. <br/>Default: false<br/></dd>
<dt><b>-skip_classic_cart_setup</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-skip_new_cart_setup</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-Ntermini</b> \<String\></dt>
<dd>Put full N termini on pose<br/>Default: "ALL"<br/></dd>
<dt><b>-Ctermini</b> \<String\></dt>
<dd>Put full C termini on pose<br/>Default: "ALL"<br/></dd>
<dt><b>-use_truncated_termini</b> \<Boolean\></dt>
<dd>Will not add extra OXT/Hs at termini if not in input structure<br/>Default: false<br/></dd>
<dt><b>-ignore_unrecognized_res</b> \<Boolean\></dt>
<dd>Do not abort if unknown residues are found in PDB file;  instead, ignore them. Note this implies -in:ignore_waters<br/>Default: false<br/></dd>
<dt><b>-ignore_waters</b> \<Boolean\></dt>
<dd>Ignore HOH residues found in PDB file. Note: HOH residues, and waters in general, are incompatible with the default solvation model (LK).<br/>Default: true<br/></dd>
<dt><b>-guarantee_no_DNA</b> \<Boolean\></dt>
<dd>Do not rename A/C/G to DA/DC/DG even if missing their 2' hydroxyl; expert knowledge says this structure has no DNA.<br/>Default: false<br/></dd>
<dt><b>-add_orbitals</b> \<Boolean\></dt>
<dd>Will add orbitals to residues only. Does not include orbitals to ligands. Done through params file reading.<br/>Default: false<br/></dd>
<dt><b>-show_all_fixes</b> \<Boolean\></dt>
<dd>Show all residue & atom name fixes<br/>Default: false<br/></dd>
<dt><b>-include_sugars</b> \<Boolean\></dt>
<dd>Sets whether or not carbohydrate residues will beloaded into Rosetta.  The default value is false.<br/>Default: false<br/></dd>
<dt><b>-include_lipids</b> \<Boolean\></dt>
<dd>Sets whether or not lipid residues will beloaded into Rosetta.  The default value is false.<br/>Default: false<br/></dd>
<dt><b>-include_surfaces</b> \<Boolean\></dt>
<dd>Sets whether or not mineral surface residues will beloaded into Rosetta.  The default value is false.<br/>Default: false<br/></dd>
<dt><b>-read_only_ATOM_entries</b> \<Boolean\></dt>
<dd>Sets whether to ignore everything except ATOM entries.<br/>Default: false<br/></dd>
<dt><b>-auto_detect_glycan_connections</b> \<Boolean\></dt>
<dd>Sets whether to search for non-protein connections using PDB coordinates and generate LINK records.<br/>Default: false<br/></dd>
<dt><b>-max_bond_length</b> \<Real\></dt>
<dd>Sets maximum O-C distance for glycan connection search. Default is 1.65 Angstroms.<br/>Default: 1.65<br/></dd>
<dt><b>-min_bond_length</b> \<Real\></dt>
<dd>Sets minimum O-C distance for glycan connection search. Default is 1.15 Angstroms.<br/>Default: 1.15<br/></dd>
<dt><b>-glycan_virtual_offset</b> \<Real\></dt>
<dd>Apply a very small offset to the glycan virtual positions to avoid collinearity in the angle minimization.<br/>Default: 0<br/></dd>
<dt><b>-membrane</b> \<Boolean\></dt>
<dd>Initialize pose as a membrane protein using specified membrane parameters. Default is false<br/>Default: false<br/></dd>
<dt><b>-remember_unrecognized_res</b> \<Boolean\></dt>
<dd>Ignore unrecognized residues, but remember them in PDBInfo.<br/>Default: false<br/></dd>
<dt><b>-remember_unrecognized_water</b> \<Boolean\></dt>
<dd>Remember waters along with other unrecognized residues.<br/>Default: false<br/></dd>
<dt><b>-preserve_crystinfo</b> \<Boolean\></dt>
<dd>Preserve information important for crystal refinement (B factors +CRYST1 line)<br/>Default: false<br/></dd>
<dt><b>-detect_oops</b> \<Boolean\></dt>
<dd>Detect oligooxopiperazines (oops) and add required constraints<br/>Default: false<br/></dd>
<dt><b>-detect_disulf</b> \<Boolean\></dt>
<dd>Forcably enable or disable disulfide detection. When unspecified, rosetta conservatively detects disulfides in full atom input based on SG distance, but will not form centroid disulfides.  Setting '-detect_disulf true' will force aggressive disulfide detection in centroid poses based on CB distance.  Setting '-detect_disulf false' disables all detection, even in full atom poses.  Note that disabling disulfides causes severe clashes for native disulfides.<br/></dd>
<dt><b>-detect_disulf_tolerance</b> \<Real\></dt>
<dd>disulf tolerance<br/>Default: 0.5<br/></dd>
<dt><b>-constraints_from_link_records</b> \<Boolean\></dt>
<dd>Turn link records into atom pair and angle constraints<br/>Default: false<br/></dd>
<dt><b>-auto_setup_metals</b> \<Boolean\></dt>
<dd>Automatically adds covalent linkages to bound metal ions, as well as atom pair constraints and angle constraints to hold ions in place, on PDB import.  Also, sets the atom_pair_constraint and angle_constraint weights in the default score function to 1.0.  False by default.<br/>Default: false<br/></dd>
<dt><b>-prevent_auto_setup_metal_bb_variants</b> \<Boolean\></dt>
<dd>When automatically setting up metals, in cases where there is a bond detected between a metal and a backbone heavyatom (e.g. a backbone carbonyl oxygen), by default Rosetta will set up bonded variant types for the current residue and for all orther residue types with an equivalent backbone heavyatom, to permit mutations.  Setting this flag to true prevents this.  False by default.<br/>Default: false<br/></dd>
<dt><b>-metals_detection_LJ_multiplier</b> \<Real\></dt>
<dd>When -auto_setup_metals is used, overlap between metal atoms and metal-binding atoms is used as the criterion by which covalent bonds are detected.  The Lennard-Jones radii of the atoms can be multiplied by a constant factor in order to detect longer bonds to metal ions.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-metals_distance_constraint_multiplier</b> \<Real\></dt>
<dd>Distances between metals and metal-binding atoms are constrained using harmonic potentials, scaled by this multiplier.  Default 1.0.  Set to 0.0 to skip adding distance constraints.<br/>Default: 1.0<br/></dd>
<dt><b>-metals_angle_constraint_multiplier</b> \<Real\></dt>
<dd>Angles between metals, metal-binding atoms, and metal-binding atom parents are constrained using circular harmonic potentials, scaled by this multiplier.  Default 1.0. Set to 0.0 to skip adding angle constraints.<br/>Default: 1.0<br/></dd>
<dt><b>-name3_property_codes</b> \<StringVector\></dt>
<dd>File that describes name3-property correspondence to fix up atom assignments<br/>Default: utility::vector1<std::string>(1,"code_properties.codes")<br/></dd>
<dt><b>-alternate_3_letter_codes</b> \<StringVector\></dt>
<dd>Specify the filename(s) of (a) *.codes files that includes a list of alternative 3-letter codes.  The default directory is database/input_output/3-letter_codes/ but any path can be provided.  Duplicate codes in successive files will overwrite previous ones.<br/>Default: utility::vector1<std::string>(1,"default.codes")<br/></dd>
<dt><b>-maintain_links</b> \<Boolean\></dt>
<dd>Maintains link records in the PDB when using auto_detect_glycans<br/>Default: false<br/></dd>
<dt><b>-fix_disulf</b> \<File\></dt>
<dd>Specify disulfide connectivity via a file.  Disulfides are specified as two whitespace-separated residue indices per line.  This option replaces the old '-run:fix_disulf' option.<br/></dd>
<dt><b>-missing_density_to_jump</b> \<Boolean\></dt>
<dd>If missing density is found in input pdbs, replace with a jump<br/>Default: false<br/></dd>
<dt><b>-target_residues</b> \<IntegerVector\></dt>
<dd>which residue numbers to pass for getDistConstraints<br/></dd>
<dt><b>-replonly_residues</b> \<IntegerVector\></dt>
<dd>residue numbers regarded as repulsive-only residues<br/></dd>
<dt><b>-replonly_loops</b> \<Boolean\></dt>
<dd>all loops will be regarded as repulsive-only<br/>Default: false<br/></dd>
<dt><b>-use_database</b> \<Boolean\></dt>
<dd>Read in structures from database.  Specify database via -inout:dbms:database_name and wanted structures with -in:file:tags or select_structures_from_database<br/></dd>
<dt><b>-select_structures_from_database</b> \<StringVector\></dt>
<dd>specify an SQL query to determine which structures get read in from a database specified with -inout:dbms:database_name.  SELECT query must return structures.tag<br/></dd>
</dl>
+ <h3>-in:dbms</h3>
<dl>
<dt><b>-dbms</b> \<Boolean\></dt>
<dd>dbms option group<br/></dd>
<dt><b>-struct_ids</b> \<StringVector\></dt>
<dd>List of struct_ids (hex representation) to be used by the database job inputter<br/></dd>
</dl>
+ <h3>-in:path</h3>
<dl>
<dt><b>-path</b> \<PathVector\></dt>
<dd>Paths to search for input files (checked after type-specific paths)<br/>Default: "."<br/></dd>
<dt><b>-fragments</b> \<PathVector\></dt>
<dd>Fragment file input search paths<br/></dd>
<dt><b>-pdb</b> \<PathVector\></dt>
<dd>PDB file input search paths<br/></dd>
<dt><b>-database</b> \<PathVector\></dt>
<dd>Database file input search paths.  If the database is not found the ROSETTA3_DB environment variable is tried.<br/></dd>
<dt><b>-database_cache_dir</b> \<Path\></dt>
<dd>Which directory to use when caching processed database files.<br/></dd>
</dl>
+ <h3>-in:file</h3>
<dl>
<dt><b>-file</b> \<Boolean\></dt>
<dd>Input file option group<br/></dd>
<dt><b>-s</b> \<FileVector\></dt>
<dd>Name(s) of single PDB file(s) to process<br/>Default: []<br/></dd>
<dt><b>-t</b> \<FileVector\></dt>
<dd>Name(s) of second PDB file(s) to process (pairs with -s)<br/></dd>
<dt><b>-l</b> \<FileVector\></dt>
<dd>File(s) containing list(s) of PDB files to process<br/></dd>
<dt><b>-job_definition_file</b> \<File\></dt>
<dd>File used by JD3 in which multiple jobs with different inputs can be specified<br/></dd>
<dt><b>-list</b> \<FileVector\></dt>
<dd>File(s) containing list(s) of PDB files.  PDBs on the same line become one pose<br/></dd>
<dt><b>-srlz</b> \<Boolean\></dt>
<dd>input serialized poses (as opposed to PDB files)<br/>Default: false<br/></dd>
<dt><b>-srlz_override</b> \<Boolean\></dt>
<dd>identical to in:file:srlz except this does not terminate if the input file was generated by a different version of Rosetta.<br/>Default: false<br/></dd>
<dt><b>-screening_list</b> \<FileVector\></dt>
<dd>Files containing lists of PDB files. all permutations of the files in the list become poses<br/></dd>
<dt><b>-screening_job_file</b> \<File\></dt>
<dd>A JSON file containing groups of ligands and proteins to screen<br/></dd>
<dt><b>-shuffle_screening_jobs</b> \<Boolean\></dt>
<dd>Randomize the order of jbos input through -in:file:screening_job_file<br/>Default: false<br/></dd>
<dt><b>-native</b> \<File\></dt>
<dd>Native PDB filename<br/></dd>
<dt><b>-torsion_bin_probs</b> \<File\></dt>
<dd>File describing probabilities over torsion bins A,B,E,G,O<br/>Default: "empty"<br/></dd>
<dt><b>-PCS_frag_cst</b> \<File\></dt>
<dd>File that containts PCS constraints for use in fragment picking<br/></dd>
<dt><b>-talos_phi_psi</b> \<File\></dt>
<dd>File that provides Phi-Psi angles in Talos+ format<br/></dd>
<dt><b>-talos_cs</b> \<File\></dt>
<dd>File that provides chemical shifts in Talos format<br/></dd>
<dt><b>-ambig_talos_cs_A</b> \<File\></dt>
<dd>File that provides 1st set of ambigious chemical shift options in Talos format<br/></dd>
<dt><b>-ambig_talos_cs_B</b> \<File\></dt>
<dd>File that provides 2nd set of ambigious chemical shift options in Talos format<br/></dd>
<dt><b>-native_exclude_res</b> \<IntegerVector\></dt>
<dd>Residue numbers to be excluded from RMS calculation<br/></dd>
<dt><b>-no_detect_pseudobonds</b> \<Boolean\></dt>
<dd>By default, Rosetta automatically detects pseudobonds on file import.  If this is set to true, this auto-detection is disabled.  False by default.<br/>Default: false<br/></dd>
<dt><b>-tags</b> \<StringVector\></dt>
<dd>Tag(s) of structures to be used from silent-file<br/></dd>
<dt><b>-user_tags</b> \<StringVector\></dt>
<dd>user_tag(s) of structures to be used from silent-file<br/></dd>
<dt><b>-tagfile</b> \<File\></dt>
<dd>File with list of tags tou be used from silent-file. (an -in:file:l for silent file tags.)<br/>Default: "TAGS"<br/></dd>
<dt><b>-frag_files</b> \<FileVector\></dt>
<dd>Fragment input file names<br/>Default: []<br/></dd>
<dt><b>-remap_pdb_atom_names_for</b> \<StringVector\></dt>
<dd>When reading PDBs, use geometry to rename atoms for the residues with the given three letter codes.<br/></dd>
<dt><b>-extra_res</b> \<FileVector\></dt>
<dd>.params file(s) for new residue types (e.g. ligands)<br/>Default: []<br/></dd>
<dt><b>-extra_res_fa</b> \<FileVector\></dt>
<dd>.params file(s) for new fullatom residue types (e.g. ligands)<br/>Default: []<br/></dd>
<dt><b>-extra_res_mol</b> \<FileVector\></dt>
<dd>.mol file(s) for new fullatom residue types (e.g. ligands)<br/>Default: []<br/></dd>
<dt><b>-extra_res_mmCIF</b> \<FileVector\></dt>
<dd>.mmCIF file(s) for component dictionary for residue types (e.g. ligands)<br/>Default: []<br/></dd>
<dt><b>-load_PDB_components</b> \<Boolean\></dt>
<dd>Use the PDB ligand definitions to load all standard residue descriptions.<br/>Default: true<br/></dd>
<dt><b>-PDB_components_directory</b> \<String\></dt>
<dd>The directory storing a collection of Chemical Components Dictionary mmCIF-formatted files, named as 'components.?.cif'<br/>Default: "chemical/pdb_components"<br/></dd>
<dt><b>-PDB_components_overrides</b> \<StringVector\></dt>
<dd>Any supplementary CIF file from which to load the PDB component definitions. These take first priority and can be used to correct the directory.<br/>Default: []<br/></dd>
<dt><b>-check_all_PDB_components</b> \<Boolean\></dt>
<dd>When set false, ignore PDB components with a name3 matching a Rosetta database type, even if they're chemically different.<br/>Default: true<br/></dd>
<dt><b>-extra_res_database</b> \<String\></dt>
<dd>the name of a database containing fullatom residue types (e.g. ligands)<br/></dd>
<dt><b>-extra_res_pq_schema</b> \<String\></dt>
<dd>the name of a postgreSQL schema in the database containing fullatom residue types (e.g. ligands)<br/>Default: ""<br/></dd>
<dt><b>-extra_res_database_mode</b> \<String\></dt>
<dd>The type of database driver to use for -in:file:extra_res_database.<br/>Default: "sqlite3"<br/></dd>
<dt><b>-extra_res_database_resname_list</b> \<File\></dt>
<dd>Path to a list of residue names to be read in from the residue database.  The list should have one residue name per line<br/></dd>
<dt><b>-extra_res_cen</b> \<FileVector\></dt>
<dd>.params file(s) for new centroid residue types (e.g. ligands)<br/>Default: []<br/></dd>
<dt><b>-extra_res_path</b> \<PathVector\></dt>
<dd>directories with .params files.  Only files containing 'param' will be chosen<br/>Default: []<br/></dd>
<dt><b>-extra_rot_lib_path</b> \<PathVector\></dt>
<dd>directories with NCAA rotamer files.<br/>Default: []<br/></dd>
<dt><b>-override_rot_lib_path</b> \<PathVector\></dt>
<dd>if rotamer libraries are found in this directory, prioritize them and not others<br/>Default: []<br/></dd>
<dt><b>-extra_res_batch_path</b> \<PathVector\></dt>
<dd>directories generated by src/python/apps/public/batch_molfile_to_params.py.  Only files containing 'param' will be chosen<br/>Default: []<br/></dd>
<dt><b>-extra_patch_fa</b> \<FileVector\></dt>
<dd>patch files for full atom variants not specified in the database<br/>Default: []<br/></dd>
<dt><b>-extra_patch_cen</b> \<FileVector\></dt>
<dd>patch files for centroid atom variants not specified in the database<br/>Default: []<br/></dd>
<dt><b>-frag3</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-frag9</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-fragA</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-fragB</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-surface_vectors</b> \<String\></dt>
<dd>Input file containing three sets of xyz coordinates which define the plane and periodicity of the solid surface<br/></dd>
<dt><b>-xyz</b> \<String\></dt>
<dd>Input coordinates in a raw XYZ format (three columns)<br/></dd>
<dt><b>-keep_input_scores</b> \<Boolean\></dt>
<dd>Keep/Don't keep scores from input file in Pose.<br/>Default: true<br/></dd>
<dt><b>-lazy_silent</b> \<Boolean\></dt>
<dd>Activate LazySilentFileJobInputter<br/>Default: false<br/></dd>
<dt><b>-silent</b> \<FileVector\></dt>
<dd>silent input filename(s)<br/>Default: []<br/></dd>
<dt><b>-force_silent_bitflip_on_read</b> \<Boolean\></dt>
<dd>Force bit-flipping when reading binary silent files.  This is useful if the files are produced on a little-endian system and read on a big-endian system.<br/>Default: false<br/></dd>
<dt><b>-atom_tree_diff</b> \<FileVector\></dt>
<dd>atom_tree_diff input filename(s)<br/></dd>
<dt><b>-zip</b> \<String\></dt>
<dd>zipped input file, used for BOINC database<br/></dd>
<dt><b>-boinc_wu_zip</b> \<FileVector\></dt>
<dd>zipped input file with files for a specific BOINC workunit<br/></dd>
<dt><b>-fullatom</b> \<Boolean\></dt>
<dd>Enable full-atom input of PDB or centroid structures<br/>Default: false<br/></dd>
<dt><b>-centroid_input</b> \<Boolean\></dt>
<dd>why input in the name twice ? in:file:centroid_input Enable centroid inputs of PDBs<br/>Default: false<br/></dd>
<dt><b>-centroid</b> \<Boolean\></dt>
<dd>Enable centroid inputs of PDBs<br/>Default: false<br/></dd>
<dt><b>-assign_gasteiger_atom_types</b> \<Boolean\></dt>
<dd>Automatically assign GasteigerAtomTypes to all residues in the ResidueTypeSet<br/>Default: false<br/></dd>
<dt><b>-treat_residues_in_these_chains_as_separate_chemical_entities</b> \<String\></dt>
<dd>Create a chemical jump for each residue in these chains (String of 1-letter chain IDs)<br/>Default: " "<br/></dd>
<dt><b>-residue_type_set</b> \<String\></dt>
<dd>ResidueTypeSet for input files<br/>Default: "fa_standard"<br/></dd>
<dt><b>-pca</b> \<File\></dt>
<dd>compute PCA projections<br/>Default: ""<br/></dd>
<dt><b>-silent_energy_cut</b> \<Real\></dt>
<dd>energy cut for silent-files<br/>Default: 1.0<br/></dd>
<dt><b>-silent_list</b> \<FileVector\></dt>
<dd>Silent input filename list(s) - like -l is to -s <br/></dd>
<dt><b>-silent_renumber</b> \<Boolean\></dt>
<dd>renumber decoys in not_universal_main or not<br/>Default: false<br/></dd>
<dt><b>-silent_struct_type</b> \<String\></dt>
<dd>Type of SilentStruct object to use in silent-file input<br/>Default: "protein"<br/></dd>
<dt><b>-silent_read_through_errors</b> \<Boolean\></dt>
<dd>will ignore decoys with errors and continue reading<br/>Default: false<br/></dd>
<dt><b>-silent_score_prefix</b> \<String\></dt>
<dd>Prefix that is appended to all scores read in from a silent-file<br/>Default: ""<br/></dd>
<dt><b>-silent_select_random</b> \<Integer\></dt>
<dd>Select a random subset of this number of decoys from every silent-file read<br/>Default: 0<br/></dd>
<dt><b>-silent_select_range_start</b> \<Integer\></dt>
<dd>Select a ranged subset of decoys from every silent-file read.  Start at this decoy.<br/>Default: -1<br/></dd>
<dt><b>-silent_select_range_mul</b> \<Integer\></dt>
<dd>Select a blocksize multiplier.  This param pasically multiplies -silent_select_range_start.  E.g. when set to, say, 5, -silent_select_range_start 0,1,2,3,4 will result in decoys being read starting from 0,5,10,15,20<br/>Default: 1<br/></dd>
<dt><b>-silent_select_range_len</b> \<Integer\></dt>
<dd>Select a ranged subset of decoys from every silent-file read.  Start at this decoy.<br/>Default: 1<br/></dd>
<dt><b>-skip_failed_simulations</b> \<Boolean\></dt>
<dd>Ignore failed simulations (prefixed by W_) during silent file input.  Existing behavior is preserved by default.<br/>Default: false<br/></dd>
<dt><b>-silent_scores_wanted</b> \<StringVector\></dt>
<dd>Only put these silent-scores into the Pose.<br/></dd>
<dt><b>-fasta</b> \<FileVector\></dt>
<dd>Fasta-formatted sequence file<br/>Default: []<br/></dd>
<dt><b>-pssm</b> \<FileVector\></dt>
<dd>NCBI BLAST formatted position-specific scoring matrix<br/></dd>
<dt><b>-seq</b> \<StringVector\></dt>
<dd>List of input files for constructing sequences<br/></dd>
<dt><b>-checkpoint</b> \<File\></dt>
<dd>Sequence profile (flat text file format) prepared by NCBI BLAST<br/></dd>
<dt><b>-binary_chk</b> \<File\></dt>
<dd>Sequence profile (binary file format) prepared by NCBI BLAST<br/></dd>
<dt><b>-alignment</b> \<FileVector\></dt>
<dd>Input file for sequence alignment<br/></dd>
<dt><b>-alignment2</b> \<FileVector\></dt>
<dd>Input file for second sequence alignment <br/></dd>
<dt><b>-rama2b_map</b> \<File\></dt>
<dd>Ramachandran file used by rama2b<br/>Default: "scoring/score_functions/rama/Rama08.dat"<br/></dd>
<dt><b>-psipred_ss2</b> \<File\></dt>
<dd>psipred_ss2 secondary structure definition file<br/>Default: "tt"<br/></dd>
<dt><b>-dssp</b> \<File\></dt>
<dd>dssp secondary structure definition file<br/>Default: "tt"<br/></dd>
<dt><b>-fail_on_bad_hbond</b> \<Boolean\></dt>
<dd>exit if a hydrogen bonding error is detected<br/>Default: true<br/></dd>
<dt><b>-movemap</b> \<File\></dt>
<dd>No description<br/>Default: "default.movemap"<br/></dd>
<dt><b>-repair_sidechains</b> \<Boolean\></dt>
<dd>Attempt a repack/minmize to repair sidechain problems, such as proline geometry and His tautomerization<br/>Default: false<br/></dd>
<dt><b>-no_binary_dunlib</b> \<Boolean\></dt>
<dd>Do not attempt to read from or write to a binary file for the Dunbrack library<br/></dd>
<dt><b>-extended_pose</b> \<Integer\></dt>
<dd>number of extended poses to process in not_universal_main<br/>Default: 1<br/></dd>
<dt><b>-template_pdb</b> \<FileVector\></dt>
<dd>Name of input template PDB files for comparative modeling<br/></dd>
<dt><b>-template_silent</b> \<File\></dt>
<dd>input templates for comparative modeling -- tag needs to fit alignment id<br/></dd>
<dt><b>-rdc</b> \<FileVector\></dt>
<dd>Experimental NMR Residual Dipolar Coupling File --- one file per alignment medium<br/></dd>
<dt><b>-csa</b> \<FileVector\></dt>
<dd>Experimental NMR Chemical Shift Anisotropy File<br/></dd>
<dt><b>-dc</b> \<FileVector\></dt>
<dd>Experimental NMR Dipolar Coupling File<br/></dd>
<dt><b>-burial</b> \<FileVector\></dt>
<dd>WESA-formatted burial prediction<br/></dd>
<dt><b>-hrf_ms_labeling</b> \<File\></dt>
<dd>Experimental Mass Spec HRF labeling data<br/></dd>
<dt><b>-vall</b> \<FileVector\></dt>
<dd>Fragment database file, e.g vall.dat.2006-05-05<br/>Default: "/sampling/filtered.vall.dat.2006-05-05"<br/></dd>
<dt><b>-rescore</b> \<Boolean\></dt>
<dd>Governs whether input poses are rescored or not in not_universal_main, defaults to false.<br/>Default: false<br/></dd>
<dt><b>-spanfile</b> \<String\></dt>
<dd>Membrane spanning file<br/></dd>
<dt><b>-lipofile</b> \<String\></dt>
<dd>Membrane exposure file<br/></dd>
<dt><b>-HDX</b> \<String\></dt>
<dd>HDX (Hydrogen exchange data file<br/></dd>
<dt><b>-d2h_sa_reweight</b> \<Real\></dt>
<dd>d2h_sa reweight<br/>Default: 1.00<br/></dd>
<dt><b>-sucker_params</b> \<File\></dt>
<dd>Parameter file containing SplineEnergy parameters<br/>Default: "scoring/spline_energy_functions/sucker.params"<br/></dd>
<dt><b>-fold_tree</b> \<File\></dt>
<dd>User defined fold tree to be imposed on the pose after reading from disk<br/></dd>
<dt><b>-obey_ENDMDL</b> \<Boolean\></dt>
<dd>Stop reading a PDB after ENDMDL card; effectively read only first model in multimodel NMR PDBs<br/>Default: false<br/></dd>
<dt><b>-new_chain_order</b> \<Boolean\></dt>
<dd>ensures chain from different MODEL records have differnet mini chains<br/>Default: false<br/></dd>
<dt><b>-ddg_predictions_file</b> \<File\></dt>
<dd>File that contains mutational ddG information. Used by ddG task operation/filter.<br/>Default: ""<br/></dd>
<dt><b>-input_res</b> \<ResidueChainVector\></dt>
<dd>Residues already present in starting file<br/>Default: []<br/></dd>
<dt><b>-minimize_res</b> \<IntegerVector\></dt>
<dd>Residues to minimize<br/>Default: []<br/></dd>
<dt><b>-md_schfile</b> \<String\></dt>
<dd>File name containing MD schedule<br/></dd>
<dt><b>-native_contacts</b> \<File\></dt>
<dd>native contacts pair list for fnat/fnon-nat calculation in Docking<br/></dd>
</dl>
+ <h3>-in:rdf</h3>
<dl>
<dt><b>-rdf</b> \<Boolean\></dt>
<dd>rdf option group<br/></dd>
<dt><b>-sep_bb_ss</b> \<Boolean\></dt>
<dd>separate RDFs by SS for backbone atypes <br/>Default: true<br/></dd>
</dl>
+ <h2>-inout</h2>
<dl>
<dt><b>-inout</b> \<Boolean\></dt>
<dd>Ouput option group<br/></dd>
<dt><b>-fold_tree_io</b> \<Boolean\></dt>
<dd>Ignore 'CHECKPOINT' file and the overwrite the PDB file(s)<br/></dd>
<dt><b>-skip_connect_info</b> \<Boolean\></dt>
<dd>If true, skips writing CONECT information in PDB files.  False by default (writes CONECT records).<br/>Default: false<br/></dd>
<dt><b>-write_all_connect_info</b> \<Boolean\></dt>
<dd>By default, CONECT information is written for all noncanonicals and HETATMs, except waters.  If this flag is set to true, it will be written for ALL residues, subject to the distance cutoff (-inout:connect_info_cufoff) and overridden by -inout:skip_connect_info.<br/>Default: false<br/></dd>
<dt><b>-connect_info_cutoff</b> \<Real\></dt>
<dd>The atom separation cutoff above which bonded atoms have explicit CONECT records written so that programs like PyMOL know the atomic connectivity.  Default 0.0 Angstroms (write all records).<br/>Default: 0.0<br/></dd>
<dt><b>-output_alternate_atomids</b> \<Boolean\></dt>
<dd>Use the alternate atom IDS as stored in the params files when available<br/>Default: false<br/></dd>
</dl>
+ <h3>-inout:dbms</h3>
<dl>
<dt><b>-dbms</b> \<Boolean\></dt>
<dd>database option group<br/></dd>
<dt><b>-mode</b> \<String\></dt>
<dd>Which backend to use by default for database access.  Note, usage of 'mysql' requires building with 'extras=mysql' and usage of 'postgres' requires building with 'extras=postgres'<br/>Default: "sqlite3"<br/></dd>
<dt><b>-database_name</b> \<String\></dt>
<dd>name of the database.  For sqlite3 databases this is a path in the file system usually with the '.db3' extension.<br/></dd>
<dt><b>-pq_schema</b> \<String\></dt>
<dd>For posgres databases, specify the default schema with the database.  For PostgreSQL database, schemas are like namespaces.<br/>Default: ""<br/></dd>
<dt><b>-host</b> \<String\></dt>
<dd>default hostname of database server<br/></dd>
<dt><b>-user</b> \<String\></dt>
<dd>default username for database server access<br/></dd>
<dt><b>-password</b> \<String\></dt>
<dd>default password for database server access<br/></dd>
<dt><b>-port</b> \<Integer\></dt>
<dd>default port for database server access<br/></dd>
<dt><b>-readonly</b> \<Boolean\></dt>
<dd>open sqlite3 database in read-only mode by default<br/>Default: false<br/></dd>
<dt><b>-separate_db_per_mpi_process</b> \<Boolean\></dt>
<dd>In MPI mode, open a separate sqlite3 database for each process with extension _<mpi_rank> and write partitioned schema to that database.<br/>Default: false<br/></dd>
<dt><b>-database_partition</b> \<Integer\></dt>
<dd>Open a sepearte sqlite3 database with the extension _<partition> and write a partitioned schema to that database.<br/>Default: -1<br/></dd>
<dt><b>-use_compact_residue_schema</b> \<Boolean\></dt>
<dd>Store all the atoms for a residue in a binary silent file style blob.  Sacrifices analyzability for scalability.  If you don't know if you want this you probably don't.<br/>Default: false<br/></dd>
<dt><b>-retry_failed_reads</b> \<Boolean\></dt>
<dd>If a database read fails for an unknown reason, try again several times before giving up<br/>Default: false<br/></dd>
<dt><b>-path</b> \<Path\></dt>
<dd>Directory the database should be read from or exported to.<br/>Default: "."<br/></dd>
</dl>
+ <h2>-out</h2>
<dl>
<dt><b>-out</b> \<Boolean\></dt>
<dd>Ouput option group<br/></dd>
<dt><b>-overwrite</b> \<Boolean\></dt>
<dd>Ignore 'CHECKPOINT' file and the overwrite PDB and silent file(s)<br/></dd>
<dt><b>-nstruct</b> \<Integer\></dt>
<dd>Number of times to process each input PDB<br/>Default: 1<br/></dd>
<dt><b>-shuffle_nstruct</b> \<Integer\></dt>
<dd>total number of decoys to produce<br/>Default: 1<br/></dd>
<dt><b>-prefix</b> \<String\></dt>
<dd>Prefix for output structure names, like old -series code<br/>Default: ""<br/></dd>
<dt><b>-suffix</b> \<String\></dt>
<dd>Suffix for output structure names<br/>Default: ""<br/></dd>
<dt><b>-mover_controlled_output_name</b> \<Boolean\></dt>
<dd>allows the mover to control the output name<br/>Default: false<br/></dd>
<dt><b>-no_nstruct_label</b> \<Boolean\></dt>
<dd>Do not tag the first output structure with _0001<br/>Default: false<br/></dd>
<dt><b>-pdb_gz</b> \<Boolean\></dt>
<dd>Compress (gzip) output pdbs<br/>Default: false<br/></dd>
<dt><b>-pdb</b> \<Boolean\></dt>
<dd>Output PDBs<br/>Default: false<br/></dd>
<dt><b>-silent_gz</b> \<Boolean\></dt>
<dd>Use gzipped compressed output (silent run level)<br/>Default: false<br/></dd>
<dt><b>-membrane_pdb</b> \<Boolean\></dt>
<dd>Write out the membrane in the PDB - on/off.<br/></dd>
<dt><b>-membrane_pdb_thickness</b> \<Real\></dt>
<dd>Thickness of the written membrane in the PDB file. Using this flag, turns on -out:membrane_pdb automatically. If flag is not given, it uses the default (30) or the one from the -mp:thickness flag.<br/></dd>
<dt><b>-mmCIF</b> \<Boolean\></dt>
<dd>output mmCIF files (broadly, as opposed to PDB files)<br/>Default: false<br/></dd>
<dt><b>-mmCIF_gz</b> \<Boolean\></dt>
<dd>if outputting mmCIF files, gzip them<br/>Default: false<br/></dd>
<dt><b>-mmtf</b> \<Boolean\></dt>
<dd>output mmtf files (broadly, as opposed to PDB files)<br/>Default: false<br/></dd>
<dt><b>-mmtf_gz</b> \<Boolean\></dt>
<dd>if outputting mmtf files, gzip them<br/>Default: false<br/></dd>
<dt><b>-use_database</b> \<Boolean\></dt>
<dd>Write out structures to database.  Specify database via -inout:dbms:database_name and wanted structures with -in:file:tags<br/></dd>
<dt><b>-database_protocol_id</b> \<Integer\></dt>
<dd>Manually specify a protocol ID for database output.  MPI-distributed jobs are the only time when you will want to use this.  It is a temporary workaround to a limitation of the MPI distributor<br/></dd>
<dt><b>-database_filter</b> \<StringVector\></dt>
<dd>Filter to use with database output.  Arguments for filter follow filter name<br/></dd>
<dt><b>-resume_batch</b> \<IntegerVector\></dt>
<dd>Specify 1 or more batch ids to finish an incomplete protocol.  Only works with the DatabaseJobOutputter.  The new jobs will be generated under a new protocol and batch ID<br/></dd>
<dt><b>-nooutput</b> \<Boolean\></dt>
<dd>Surpress outputfiles<br/>Default: false<br/></dd>
<dt><b>-output</b> \<Boolean\></dt>
<dd>Force outputfiles<br/>Default: false<br/></dd>
<dt><b>-scorecut</b> \<Real\></dt>
<dd>Only output lowest energy fraction of structures - default 1.0, i.e. output all <br/>Default: 1.0<br/></dd>
<dt><b>-show_accessed_options</b> \<Boolean\></dt>
<dd>In the end of the run show options that has been accessed.<br/>Default: false<br/></dd>
<dt><b>-show_unused_options</b> \<Boolean\></dt>
<dd>In the end of the run show options that were set by the user but never accessed. (Will automatically happen for JD2 protocols.)<br/>Default: false<br/></dd>
<dt><b>-sf</b> \<File\></dt>
<dd>filename for score output<br/>Default: "score.fsc"<br/></dd>
<dt><b>-mute</b> \<StringVector\></dt>
<dd>Mute specified Tracer channels; specify 'all' to mute all channels.<br/></dd>
<dt><b>-unmute</b> \<StringVector\></dt>
<dd>UnMute specified Tracer channels; specify 'all' to unmute all channels.<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>Level of Tracer output, any level above will be muted.  Availible levels: 0 - fatal, 100 - error, 200 - warning, 300 - info, 400 - debug, 500 - trace. For additional info please see: src/basic/Tracer.hh and doc page 'Tracer, tool for debug IO'. Default output level is 'info': 300<br/>Default: 300<br/></dd>
<dt><b>-levels</b> \<StringVector\></dt>
<dd>Specified hierarchical mute levels for individual channels in following format: -levels all:300 core.pose:500.  Numeric values could be substituted with mute level names like: debug, info, error etc.  Please note that all:<num> is synonymous to -level:<num><br/></dd>
<dt><b>-no_color</b> \<Boolean\></dt>
<dd>Suppress use of tracer color codes, which can appear as '^[[0m' in log files<br/>Default: false<br/></dd>
<dt><b>-chname</b> \<Boolean\></dt>
<dd>Add Tracer chanel names to output<br/>Default: true<br/></dd>
<dt><b>-chtimestamp</b> \<Boolean\></dt>
<dd>Add timestamp to tracer channel name<br/>Default: false<br/></dd>
<dt><b>-dry_run</b> \<Boolean\></dt>
<dd>If set ComparingTracer will not generate any asserts, and save all Tracer output to a file<br/>Default: false<br/></dd>
<dt><b>-mpi_tracer_to_file</b> \<String\></dt>
<dd>MPI ONLY: Redirect all tracer output to this file with '_<mpi_rank>' appened as a suffix<br/>Default: "tracer.out"<br/></dd>
<dt><b>-std_IO_exit_error_code</b> \<Integer\></dt>
<dd>Specify error code that will be used to exit if std::IO error detected.  This is useful if you want to detect situations like: Rosetta output was redirected to a file but the disk got full, etc.  Default value is 0 which means that error detection code is turned off.<br/>Default: 0<br/></dd>
<dt><b>-user_tag</b> \<String\></dt>
<dd>add this tag to structure tags: e.g., a process id<br/>Default: ""<br/></dd>
<dt><b>-output_tag</b> \<String\></dt>
<dd>Prefix output files with this tag, if code checks for it<br/>Default: ""<br/></dd>
<dt><b>-save_times</b> \<Boolean\></dt>
<dd>Save modeling time for each model in seconds<br/>Default: false<br/></dd>
</dl>
+ <h3>-out:file</h3>
<dl>
<dt><b>-file</b> \<Boolean\></dt>
<dd>Output file option group<br/></dd>
<dt><b>-o</b> \<String\></dt>
<dd>Name of output file<br/></dd>
<dt><b>-design_contrast</b> \<File\></dt>
<dd>output list comparing design sequence to native sequence<br/>Default: "redesign"<br/></dd>
<dt><b>-residue_type_set</b> \<String\></dt>
<dd>ResidueTypeSet for output files<br/>Default: "fa_standard"<br/></dd>
<dt><b>-srlz</b> \<Boolean\></dt>
<dd>output serialized poses (as opposed to PDB files)<br/>Default: false<br/></dd>
<dt><b>-atom_tree_diff</b> \<String\></dt>
<dd>Use atom_tree_diff file output, use filename after this flag<br/>Default: "default.out"<br/></dd>
<dt><b>-atom_tree_diff_bb</b> \<Integer\></dt>
<dd>For atom_tree_diff output, how many digits of precision to use for backbone dihedrals<br/>Default: 6<br/></dd>
<dt><b>-atom_tree_diff_sc</b> \<Integer\></dt>
<dd>For atom_tree_diff output, how many digits of precision to use for sidechain dihedrals<br/>Default: 4<br/></dd>
<dt><b>-atom_tree_diff_bl</b> \<Integer\></dt>
<dd>For atom_tree_diff output, how many digits of precision to use for bond lengths<br/>Default: 2<br/></dd>
<dt><b>-alignment</b> \<String\></dt>
<dd>Output file for sequence alignment<br/>Default: "out.align"<br/></dd>
<dt><b>-score_only</b> \<String\></dt>
<dd>Only output scores, no silent files or pdb files<br/>Default: "default.sc"<br/></dd>
<dt><b>-scorefile</b> \<String\></dt>
<dd>Write a scorefile to the provided filename<br/>Default: "default.sc"<br/></dd>
<dt><b>-scorefile_format</b> \<String\></dt>
<dd>Scorefile format: text, json<br/>Default: "text"<br/></dd>
<dt><b>-silent</b> \<String\></dt>
<dd>Use silent file output, use filename after this flag<br/>Default: "default.out"<br/></dd>
<dt><b>-silent_struct_type</b> \<String\></dt>
<dd>Type of SilentStruct object to use in silent-file output<br/>Default: "protein"<br/></dd>
<dt><b>-silent_print_all_score_headers</b> \<Boolean\></dt>
<dd>Print a SCORE header for every SilentStruct in a silent-file<br/>Default: false<br/></dd>
<dt><b>-raw</b> \<Boolean\></dt>
<dd>Use silent-type file output<br/>Default: false<br/></dd>
<dt><b>-weight_silent_scores</b> \<Boolean\></dt>
<dd>Weight scores in silent-file output.<br/>Default: true<br/></dd>
<dt><b>-silent_preserve_H</b> \<Boolean\></dt>
<dd>Preserve hydrogrens in PDB silent-file format.<br/>Default: false<br/></dd>
<dt><b>-fullatom</b> \<Boolean\></dt>
<dd>Enable full-atom output of PDB or centroid structures<br/>Default: false<br/></dd>
<dt><b>-suppress_zero_occ_pdb_output</b> \<Boolean\></dt>
<dd>Suppress output of atoms with zero (or negative) occupancy<br/>Default: false<br/></dd>
<dt><b>-output_ligands_as_separate_chains</b> \<Boolean\></dt>
<dd>Set whether or not ligands are output with unique chainIDs, even if they share a chainID with one of the peptide chains in the input structure.  The default value is false.<br/>Default: false<br/></dd>
<dt><b>-output_virtual</b> \<Boolean\></dt>
<dd>Output virtual atoms in output of PDB<br/>Default: false<br/></dd>
<dt><b>-output_virtual_zero_occ</b> \<Boolean\></dt>
<dd>Set occupancy to 0.0 for virtual atoms in output of PDB<br/>Default: false<br/></dd>
<dt><b>-no_chainend_ter</b> \<Boolean\></dt>
<dd>If true, TER records are not written at the ends of chains in PDB files -- only at the end of all of the ATOM records (the legacy Rosetta behaviour).  False by default (which results in TER records at the ends of every chain).<br/>Default: false<br/></dd>
<dt><b>-no_output_cen</b> \<Boolean\></dt>
<dd>Omit outputting centroids<br/>Default: false<br/></dd>
<dt><b>-output_orbitals</b> \<Boolean\></dt>
<dd>Output all orbitals into PDB.<br/>Default: false<br/></dd>
<dt><b>-renumber_pdb</b> \<Boolean\></dt>
<dd>Use Rosetta residue numbering and arbitrary chain labels in pdb output.<br/>Default: false<br/></dd>
<dt><b>-pdb_parents</b> \<Boolean\></dt>
<dd>If the pose contains a comment named template, print this as a REMARK in the pdb file<br/>Default: false<br/></dd>
<dt><b>-per_chain_renumbering</b> \<Boolean\></dt>
<dd>When used in conjunction with renumber_pdb, restarts residue numbering at each chain.<br/>Default: false<br/></dd>
<dt><b>-output_secondary_structure</b> \<Boolean\></dt>
<dd>output HELIX and SHEET records to StructFileRep / PDB<br/>Default: false<br/></dd>
<dt><b>-do_not_autoassign_SS</b> \<Boolean\></dt>
<dd>Depends on -out:file:output_secondary_structure.  If outputting SS, if this flag is true, it will NOT generate the secondary structure automatically; it will instead assume the secstruct string in the pose is correct<br/>Default: false<br/></dd>
<dt><b>-output_torsions</b> \<Boolean\></dt>
<dd>Output phi, psi, and omega torsions in the PDB output if the pose is ideal.<br/>Default: false<br/></dd>
<dt><b>-use_occurrence_data</b> \<Boolean\></dt>
<dd>if option is true reads probability matrix from pssm file.<br/>Default: false<br/></dd>
<dt><b>-pdb_comments</b> \<Boolean\></dt>
<dd>If the pose contains any comment print it as a COMMENT in the pdb file.<br/>Default: false<br/></dd>
<dt><b>-force_nonideal_structure</b> \<Boolean\></dt>
<dd>Force ResidueConformationFeatures to treat the structure as nonideal.  If you know all your structures are non-ideal this decreases pose output time<br/>Default: true<br/></dd>
<dt><b>-set_pdb_author</b> \<String\></dt>
<dd>Set the author name(s), if any, to output in the .pdb Title Section. List of names should be comma-delimited.<br/>Default: ""<br/></dd>
<dt><b>-write_pdb_title_section_records</b> \<Boolean\></dt>
<dd>Sets whether or not the title section records in PDB files are written.  The title section includes HEADER, EXPDTA, AUTHOR, and REMARK records.  The default value is true.<br/>Default: true<br/></dd>
<dt><b>-write_pdb_link_records</b> \<Boolean\></dt>
<dd>Sets whether or not the LINK records in PDB files are written.  The default value is true.<br/>Default: true<br/></dd>
<dt><b>-use_pdb_format_HETNAM_records</b> \<Boolean\></dt>
<dd>Sets whether or not the HETNAM records in PDB files are written in the standard PDB format with a single record per 3-letter code.  The default value is false, which means that the file will use the Rosetta format, which provides a unique HETNAM record for each residue.<br/>Default: false<br/></dd>
<dt><b>-write_pdb_parametric_info</b> \<Boolean\></dt>
<dd>If true, parametric poses have their parameter info included in the REMARK lines of the output PDB file.  True by default.<br/>Default: true<br/></dd>
<dt><b>-write_glycan_pdb_codes</b> \<Boolean\></dt>
<dd>If true glycans will be written based on the pdb codes rather than the rosetta names<br/>Default: false<br/></dd>
<dt><b>-write_seqres_records</b> \<Boolean\></dt>
<dd>Sets whether or not the SEQRES records in PDB files are written. The default value is false.<br/>Default: false<br/></dd>
<dt><b>-output_pose_energies_table</b> \<Boolean\></dt>
<dd>Output the pose energies table.  This can be overridden<br/>Default: true<br/></dd>
<dt><b>-output_pose_cache_data</b> \<Boolean\></dt>
<dd>Output the pose cache.<br/>Default: true<br/></dd>
<dt><b>-output_pose_fold_tree</b> \<Boolean\></dt>
<dd>Output the foldtree of the pose. Will go in rosetta_additional column for cif files.<br/>Default: false<br/></dd>
<dt><b>-output_only_asymmetric_unit</b> \<Boolean\></dt>
<dd>For symmetrical poses, de-symmetrize the pose before output in order to output only the master subunit.  Energies will still be output as symmetrical. Does not work with Silent files.<br/>Default: false<br/></dd>
<dt><b>-cif_extra_data_separate_file</b> \<Boolean\></dt>
<dd>When outputting mmCIF, write extra data and energies to separate files (JOBNAME.extradata and JOBNAME.eneriges)<br/>Default: false<br/></dd>
<dt><b>-dont_rewrite_dunbrack_database</b> \<Boolean\></dt>
<dd>Disables the default behavior of rewriting the Dunrack library in binary format if a binary version is not found<br/></dd>
<dt><b>-frag_prefix</b> \<String\></dt>
<dd>Prefix for fragment output<br/>Default: "default.frags"<br/></dd>
<dt><b>-no_extra_sdf_data</b> \<Boolean\></dt>
<dd>Do not add extra round-tripping data to SDF file output<br/>Default: false<br/></dd>
<dt><b>-no_scores_in_pdb</b> \<Boolean\></dt>
<dd>Deprated option.  See -output_pose_energies_table and -output_pose_cache_data<br/></dd>
</dl>
+ <h3>-out:path</h3>
<dl>
<dt><b>-all</b> \<Path\></dt>
<dd>Default file output path<br/>Default: "."<br/></dd>
<dt><b>-path</b> \<Path\></dt>
<dd>Default file output path<br/>Default: "."<br/></dd>
<dt><b>-pdb</b> \<Path\></dt>
<dd>PDB file output path<br/></dd>
<dt><b>-db</b> \<Path\></dt>
<dd>Database file output path if using FeatureReporters or database output<br/>Default: "."<br/></dd>
<dt><b>-score</b> \<Path\></dt>
<dd>Score file output path<br/></dd>
<dt><b>-scratch</b> \<Path\></dt>
<dd>use this path as scratch drive<br/>Default: ['"/scratch/USERS/"']<br/></dd>
<dt><b>-mpi_rank_dir</b> \<Boolean\></dt>
<dd>Put silent-output files in individual directory as determined by mpi-rank<br/>Default: false<br/></dd>
<dt><b>-mmCIF</b> \<Path\></dt>
<dd>if outputting mmCIF, mmCIF file output path<br/></dd>
<dt><b>-mmtf</b> \<Path\></dt>
<dd>mmtf file output path<br/></dd>
</dl>
+ <h2>-run</h2>
<dl>
<dt><b>-run</b> \<Boolean\></dt>
<dd>Run option group<br/></dd>
<dt><b>-batches</b> \<FileVector\></dt>
<dd>batch_flag_files<br/>Default: ""<br/></dd>
<dt><b>-no_prof_info_in_silentout</b> \<Boolean\></dt>
<dd>no time-columns appears in score/silent - files<br/>Default: false<br/></dd>
<dt><b>-archive</b> \<Boolean\></dt>
<dd>run MPIArchiveJobDistributor<br/>Default: false<br/></dd>
<dt><b>-n_replica</b> \<Integer\></dt>
<dd>run MPIMultiCommJobDistributor with n_replica processes per job<br/>Default: 1<br/></dd>
<dt><b>-shuffle</b> \<Boolean\></dt>
<dd>Shuffle job order<br/>Default: false<br/></dd>
<dt><b>-n_cycles</b> \<Integer\></dt>
<dd>Option to control miscellaneous cycles within protocols.  This has no core meaning - it is meant to reduce option-bloat by having every protocol define separate cycles options.  Check your protocol's documentation to see if it is used.<br/>Range: 1-<br/>Default: 1<br/></dd>
<dt><b>-repeat</b> \<Integer\></dt>
<dd>Repeat mover N times<br/>Range: 0-<br/>Default: 1<br/></dd>
<dt><b>-max_min_iter</b> \<Integer\></dt>
<dd>Maximum number of iterations of dfpmin<br/>Default: 200<br/></dd>
<dt><b>-maxruntime</b> \<Integer\></dt>
<dd>Maximum runtime in seconds. JobDistributor will signal end if time is exceeded no matter how many jobs were finished.<br/>Default: -1<br/></dd>
<dt><b>-maxruntime_bufferfactor</b> \<Real\></dt>
<dd>If set, the JobDistributor will attempt to stop if there doesn't appear to be enough time for `maxruntime_bufferfactor` jobs before maxruntime occurs.<br/>Default: 0<br/></dd>
<dt><b>-write_failures</b> \<Boolean\></dt>
<dd>write failed structures to output<br/>Default: false<br/></dd>
<dt><b>-benchmark</b> \<Boolean\></dt>
<dd>Run in benchmark mode<br/></dd>
<dt><b>-test_cycles</b> \<Boolean\></dt>
<dd>When running tests, use reduced cycles.  Cycles must be defined in the code itself<br/>Default: false<br/></dd>
<dt><b>-memory_test_cycles</b> \<Boolean\></dt>
<dd>use together with test_cycles to keep number of copies of anything as high as in production mode<br/>Default: false<br/></dd>
<dt><b>-dry_run</b> \<Boolean\></dt>
<dd>Run through structures/tasks/etc skipping the actual calculation step for testing of I/O and/or setup<br/>Default: false<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>Run in debug mode<br/></dd>
<dt><b>-profile</b> \<Boolean\></dt>
<dd>Run in profile mode<br/>Default: false<br/></dd>
<dt><b>-max_retry_job</b> \<Integer\></dt>
<dd>If a job fails with FAIL_RETRY retry this many times at most<br/>Default: 10<br/></dd>
<dt><b>-version</b> \<Boolean\></dt>
<dd>write out detailed version info, if it was available at compile time<br/>Default: false<br/></dd>
<dt><b>-nodelay</b> \<Boolean\></dt>
<dd>Do not delay launch of minirosetta<br/></dd>
<dt><b>-delay</b> \<Integer\></dt>
<dd>Wait N seconds before doing anything at all. Useful for cluster job staggering.<br/>Default: 0<br/></dd>
<dt><b>-random_delay</b> \<Integer\></dt>
<dd>Wait a random amount of 0..N seconds before doing anything at all. Useful for cluster job staggering.<br/>Default: 0<br/></dd>
<dt><b>-timer</b> \<Boolean\></dt>
<dd>write out time per decoy in minutes in scorefile<br/></dd>
<dt><b>-chain</b> \<String\></dt>
<dd>-chain <chain_id><br/>Default: "-"<br/></dd>
<dt><b>-score_only</b> \<Boolean\></dt>
<dd>calculate the score only and exit<br/>Default: false<br/></dd>
<dt><b>-decoystats</b> \<Boolean\></dt>
<dd>calculate values of a series of additional structural properties, including counting unsatisfied buried Hbond donors and acceptors, SASApack, etc. Additional output associated with this flag is written both to stdout and to output PDB files<br/></dd>
<dt><b>-output_hbond_info</b> \<Boolean\></dt>
<dd>print hydrogen bond info in the stats section of written out PDB files<br/></dd>
<dt><b>-wide_nblist_extension</b> \<Real\></dt>
<dd>Amount to extend the wide neighbor list<br/>Default: 2.0<br/></dd>
<dt><b>-constant_seed</b> \<Boolean\></dt>
<dd>Use a constant seed (1111111 unless specified)<br/></dd>
<dt><b>-jran</b> \<Integer\></dt>
<dd>Specify seed (requires -constant_seed)<br/>Default: 1111111<br/></dd>
<dt><b>-use_time_as_seed</b> \<Boolean\></dt>
<dd>Use time as random number seed instead of default rng seed device.<br/></dd>
<dt><b>-rng_seed_device</b> \<String\></dt>
<dd>Obtain random number seed from specified device.<br/>Default: "/dev/urandom"<br/></dd>
<dt><b>-seed_offset</b> \<Integer\></dt>
<dd>This value will be added to the random number seed. Useful when using time as seed 			and submitting many jobs to clusters.  Using the condor job id will force jobs that 			are started in the same second to still have different initial seeds<br/>Default: 0<br/></dd>
<dt><b>-rng</b> \<String\></dt>
<dd>Random number generation algorithm: Currently only mt19937 is a accepted here<br/>Default: "mt19937"<br/></dd>
<dt><b>-rebuild_disulf</b> \<Boolean\></dt>
<dd>Attempt to build correct disulfide geometry when converting from a centroid pose to a full atom pose. Disulfides must be previously annotated, either by enabling -detect_disulf or by specifying a file to -fix_disulf.<br/>Default: false<br/></dd>
<dt><b>-preserve_header</b> \<Boolean\></dt>
<dd>Maintain header info from input PDB when writing output PDBs<br/></dd>
<dt><b>-suppress_checkpoints</b> \<Boolean\></dt>
<dd>Override & switch off checkpoints.<br/></dd>
<dt><b>-checkpoint</b> \<Boolean\></dt>
<dd>Turn checkpointing on<br/></dd>
<dt><b>-delete_checkpoints</b> \<Boolean\></dt>
<dd>delete the checkpoints after use<br/>Default: true<br/></dd>
<dt><b>-checkpoint_interval</b> \<Integer\></dt>
<dd>Checkpoint time interval in seconds<br/>Range: 10-<br/>Default: 600<br/></dd>
<dt><b>-protocol</b> \<String\></dt>
<dd>Which protocol to run, for Rosetta@home wrapper<br/>Default: "abrelax"<br/></dd>
<dt><b>-remove_ss_length_screen</b> \<Boolean\></dt>
<dd>Sets the use_ss_length_screen flag in the Fragment Mover to false<br/></dd>
<dt><b>-min_type</b> \<String\></dt>
<dd>type of minimizer to use<br/>Default: "lbfgs_armijo_nonmonotone"<br/></dd>
<dt><b>-min_tolerance</b> \<Real\></dt>
<dd>minimizer tolerance<br/>Default: 0.000001<br/></dd>
<dt><b>-nblist_autoupdate</b> \<Boolean\></dt>
<dd>Turn on neighborlist auto-updates for all minimizations<br/>Default: false<br/></dd>
<dt><b>-nblist_autoupdate_narrow</b> \<Real\></dt>
<dd>With nblist autoupdate: the reach in Angstroms for the narrow neighbor list<br/>Default: 0.5<br/></dd>
<dt><b>-nblist_autoupdate_wide</b> \<Real\></dt>
<dd>With nblist autoupdate: the reach in Angstroms for the wide neighbor list<br/>Default: 2.0<br/></dd>
<dt><b>-skip_set_reasonable_fold_tree</b> \<Boolean\></dt>
<dd>Do not run set_reasonable_fold_tree when creating a pose from a pdb.  Useful for unreasonable PDBs where the user sets a fold tree explicitly.<br/>Default: false<br/></dd>
<dt><b>-randomize_missing_coords</b> \<Boolean\></dt>
<dd>Insert random coordinates for missing density atoms ( occupancy is zero ) and for any atoms with negative occupancy, randomizing coords is done by default<br/>Default: false<br/></dd>
<dt><b>-ignore_zero_occupancy</b> \<Boolean\></dt>
<dd>discard coords information for missing density atoms ( occupancy is zero ) defined in input structures.  Default is to keep those coordinates because this is a consistent problem for end users<br/>Default: true<br/></dd>
<dt><b>-cycles_outer</b> \<Integer\></dt>
<dd>number of outer cycles<br/>Range: 1-<br/>Default: 1<br/></dd>
<dt><b>-cycles_inner</b> \<Integer\></dt>
<dd>number of inner cycles<br/>Range: 1-<br/>Default: 1<br/></dd>
<dt><b>-repack_rate</b> \<Integer\></dt>
<dd>repack after every [value] cycles during certain protocols<br/>Range: 1-<br/>Default: 10<br/></dd>
<dt><b>-reinitialize_mover_for_each_job</b> \<Boolean\></dt>
<dd>job distributor will generate fresh copy of its mover before each apply (once per job)<br/>Default: false<br/></dd>
<dt><b>-reinitialize_mover_for_new_input</b> \<Boolean\></dt>
<dd>job distributor will generate fresh copy of its mover whenever the pose being passed to the mover is going to change (e.g., next PDB in -l)<br/>Default: false<br/></dd>
<dt><b>-multiple_processes_writing_to_one_directory</b> \<Boolean\></dt>
<dd>activates .in_progress files used to communicate between independent processes that a job is underway.  UNSAFE but may be convenient.<br/>Default: false<br/></dd>
<dt><b>-jobdist_miscfile_ext</b> \<String\></dt>
<dd>extension for JobOutputter file() function (miscellaneous file output).<br/>Default: ".data"<br/></dd>
<dt><b>-no_scorefile</b> \<Boolean\></dt>
<dd>do not output scorefiles<br/>Default: false<br/></dd>
<dt><b>-other_pose_to_scorefile</b> \<Boolean\></dt>
<dd>write other_pose (JobOutputter) to a scorefile; path by other_pose_scorefile; be warned you can get garbage if scorefunctions for poses do not match.  Overridden by no_scorefile<br/>Default: false<br/></dd>
<dt><b>-other_pose_scorefile</b> \<File\></dt>
<dd>Path to other_pose (JobOutputter) scorefiles.  Default is same scorefile as regular result poses.  The default will cause problems if your output poses were scored on different scorefunctions.<br/>Default: ""<br/></dd>
<dt><b>-intermediate_scorefiles</b> \<Boolean\></dt>
<dd>write intermediate evaluations to disk (depends on your protocol if and how often this happens<br/>Default: false<br/></dd>
<dt><b>-intermediate_structures</b> \<Boolean\></dt>
<dd>write structures together with intermediate evaluations<br/>Default: false<br/></dd>
<dt><b>-idealize_before_protocol</b> \<Boolean\></dt>
<dd>run idealize first, before running whatever.<br/></dd>
<dt><b>-interactive</b> \<Boolean\></dt>
<dd>Signal Rosetta is to be run as a library in an interactive application. In particular, favor throwing exceptions on bad inputs rather than exiting.<br/>Default: false<br/></dd>
<dt><b>-nosignal</b> \<Boolean\></dt>
<dd>Don't install the signal handler to catch segfaults, etc. in the crash reporter. Useful for running under a debugger.<br/>Default: false<br/></dd>
<dt><b>-condor</b> \<Boolean\></dt>
<dd>if condor say yes -- proc_id counting starts at 0<br/>Default: false<br/></dd>
<dt><b>-nproc</b> \<Integer\></dt>
<dd>number of process... needed if proc_id is specified<br/>Default: 0<br/></dd>
<dt><b>-proc_id</b> \<Integer\></dt>
<dd>give process number... Jobdistributor will only work on proc_id mod nproc part of work <br/>Default: 0<br/></dd>
<dt><b>-exit_if_missing_heavy_atoms</b> \<Boolean\></dt>
<dd>quit if heavy atoms missing in pdb<br/>Default: false<br/></dd>
<dt><b>-show_simulation_in_pymol</b> \<Real\></dt>
<dd>Attach PyMOL observer to pose at the beginning of the simulation. Waits until at least every [argument] seconds before sending pose if something has changed, default 5. A value of 0 indicates to not skip any packets from sending! Don't forget to run the PyMOLPyRosettaServer.py script within PyMOL!<br/>Default: 5.0<br/></dd>
<dt><b>-update_pymol_on_energy_changes_only</b> \<Boolean\></dt>
<dd>Only Update the simulation in on energy change.  Useful if pymol observer is segfaulting on length changes.<br/>Default: false<br/></dd>
<dt><b>-update_pymol_on_conformation_changes_only</b> \<Boolean\></dt>
<dd>Only update the simulation in pymol on conformation change.<br/>Default: false<br/></dd>
<dt><b>-keep_pymol_simulation_history</b> \<Boolean\></dt>
<dd>Keep history when using show_simulation_in_pymol flag?<br/>Default: false<br/></dd>
</dl>
+ <h3>-run:PyMOLMover</h3>
<dl>
<dt><b>-PyMOLMover</b> \<Boolean\></dt>
<dd>PyMOLMover option group<br/></dd>
<dt><b>-address</b> \<String\></dt>
<dd>TCP port address to use when initializing PyMOLMover<br/>Default: ""<br/></dd>
<dt><b>-port</b> \<Integer\></dt>
<dd>TCP port to use when initializing PyMOLMover<br/>Default: 0<br/></dd>
<dt><b>-max_packet_size</b> \<Integer\></dt>
<dd>Max size of packet to send to PyMOL. Default value is dependable from address: for 127.0.0.1 it will be set to 7678 and any other addresses to 1500.<br/>Default: 0<br/></dd>
</dl>
+ <h2>-parser</h2>
<dl>
<dt><b>-parser</b> \<Boolean\></dt>
<dd>parser option group<br/></dd>
<dt><b>-protocol</b> \<String\></dt>
<dd>The protocol you will be running. (Input XML File<br/></dd>
<dt><b>-script_vars</b> \<StringVector\></dt>
<dd>Variable substitutions for xml parser, in the form of name=value<br/></dd>
<dt><b>-view</b> \<Boolean\></dt>
<dd>Use the viewer?<br/></dd>
<dt><b>-info</b> \<StringVector\></dt>
<dd>Have the rosetta_scripts application print out the available XML-accessible options for a given mover, filter, task operation, or residue selector, and then exit.<br/></dd>
<dt><b>-output_schema</b> \<String\></dt>
<dd>Have the rosetta_scripts application write out its XML Schema to the given file and then exit.<br/></dd>
<dt><b>-validate_and_exit</b> \<Boolean\></dt>
<dd>After XML Schema validation completes, exit<br/></dd>
<dt><b>-patchdock</b> \<String\></dt>
<dd>Patchdock output file name.<br/></dd>
<dt><b>-patchdock_random_entry</b> \<IntegerVector\></dt>
<dd>Pick a random patchdock entry between two entry numbers. inclusive<br/></dd>
<dt><b>-inclusion_recursion_limit</b> \<Integer\></dt>
<dd>How many recursions to perform when parsing an XML file with inclusions<br/>Default: 8<br/></dd>
</dl>
+ <h2>-jd3</h2>
<dl>
<dt><b>-jd3</b> \<Boolean\></dt>
<dd>jd3 option group<br/></dd>
<dt><b>-mpi_work_partition_job_distributor</b> \<Boolean\></dt>
<dd>determine if we should use the WorkPartition job distributor<br/>Default: false<br/></dd>
<dt><b>-job_definition_schema</b> \<File\></dt>
<dd>If provided on the command line, the job distributor will write the XML Schema for the applciation's job definition file out to disk and then exit<br/></dd>
<dt><b>-mpi_fast_nonblocking_output</b> \<Boolean\></dt>
<dd>By default the master node blocks while a slave node outputs to avoid two slaves writing to a score file or silent file at the same time setting this to true disables that feature<br/>Default: false<br/></dd>
<dt><b>-n_archive_nodes</b> \<Integer\></dt>
<dd>The number of nodes that should perform archival roles only. This flag is only used by the MPIWorkPoolJobDistributor<br/>Default: 0<br/></dd>
<dt><b>-do_not_archive_on_node0</b> \<Boolean\></dt>
<dd>Should the master node in the MPIWorkPoolJobDistributor archive any JobResults on it? Only relevant for MPI builds when using -n_archive_nodes<br/>Default: false<br/></dd>
<dt><b>-mpi_fraction_outputters</b> \<Real\></dt>
<dd>Fraction of the MPI nodes that node0 is allowed to use to output job results; non-archive nodes that output will also perform regular work in addition to their output work. This flag should range from 0 to 1. Note that node0 never outputs, so even if this is set to 0, one node will be deputized as an output node.<br/>Default: 0.01<br/></dd>
<dt><b>-nthreads</b> \<Integer\></dt>
<dd>For the multithreaded job distributor, how many threads should be run at the same time<br/></dd>
<dt><b>-archive_on_disk</b> \<String\></dt>
<dd>Sometimes job results use a ton of memory. This option tells Rosetta to store job results on disk instead of in memory. The string you pass here should be the name of a (preferably empty) directoy where we can put all of our temporary files. You can delete this directory and everything in it when Rosetta is done running.<br/>Default: "null"<br/></dd>
<dt><b>-compress_job_results</b> \<Boolean\></dt>
<dd>Sometimes job results use a ton of memory. This option tells Rosetta to compress all job results so they use less memory.<br/>Default: true<br/></dd>
<dt><b>-resource_definition_files</b> \<FileVector\></dt>
<dd>Specify all the resources to available for the jobs running.<br/></dd>
<dt><b>-resource_definition_schema</b> \<File\></dt>
<dd>If provided on the command line, the job distributor will write the XML Schema for the applciation's resource definition file out to disk and then exit<br/></dd>
<dt><b>-load_input_poses_only_once</b> \<Boolean\></dt>
<dd>If the same Pose is used as input to multiple jobs (which can only happen when a job definition file is provided, but the input poses come from the command line), then preserve those input poses in memory until they will not be used in any future jobs. This necessarily comes with an increased memory footprint and is likely undesireable if the number of jobs is large!<br/></dd>
<dt><b>-checkpoint</b> \<Boolean\></dt>
<dd>Should we checkpoint job progress? Uses default values for checkpoint_period and checkpoint_directory<br/></dd>
<dt><b>-checkpoint_period</b> \<Integer\></dt>
<dd>The approximate number of minutes between checkpoints. If this flag is provided by the user, then checkpointing will occurr, even if the -checkpoint flag is not on the command line.<br/>Default: 30<br/></dd>
<dt><b>-checkpoint_directory</b> \<String\></dt>
<dd>What directory should checkpoints be written to? If this flag is provided by the user, then checkpointing will occurr, even if the -checkpoint flag is not on the command line.<br/>Default: "checkpoints"<br/></dd>
<dt><b>-restore_from_checkpoint</b> \<Boolean\></dt>
<dd>Should the contents of the checkpoint directory be used to restart a previously run job that was interrupted before it could be completed? If this flag is not present on the command line when trying to rerun a previously-run but interrupted job, then Rosetta will not attempt to restore the job from the checkpoint file. This is to safeguard against accidentally restoring from a checkpoint generated by some other execution of the code.<br/></dd>
<dt><b>-continue_past_failed_checkpoint_restoration</b> \<Boolean\></dt>
<dd>Should we keep going even if we could not restore from a checkpoint as requested? Use this if you are ok with possibly of starting over from the beginning, or if you expect to relaunch the job multiple times and want simply to use the same command line each time, including the first time you launch the job and there are no checkpoints yet to restore from.<br/></dd>
<dt><b>-keep_all_checkpoints</b> \<Boolean\></dt>
<dd>Allow old checkpoint files to build up on disk. Cannot be combined with -archive_on_disk. Using this flag could use up a lot of disk space unncessarily. If this flag is not present on the command line, then previously created checkpoints will be deleted when the next checkpoints are created. Note that job distributor will delete the previous checkpoint by default after the next checkpoint is written to disk.<br/></dd>
<dt><b>-keep_checkpoint</b> \<Integer\></dt>
<dd>Prevent the JobDistributor from deleting a particular checkpoint; perhaps useful if you are trying to debug an infrequent event and you want to restart from a particular checkpoint repeatedly without worrying that the JobDistributor will delete your starting point.<br/></dd>
</dl>
+ <h2>-jd2</h2>
<dl>
<dt><b>-jd2</b> \<Boolean\></dt>
<dd>jd2 option group<br/></dd>
<dt><b>-pose_input_stream</b> \<Boolean\></dt>
<dd>Use PoseInputStream classes for Pose input<br/>Default: false<br/></dd>
<dt><b>-lazy_silent_file_reader</b> \<Boolean\></dt>
<dd>use lazy silent file reader in job distributor, read in a structure only when you need to<br/>Default: false<br/></dd>
<dt><b>-mpi_nowait_for_remaining_jobs</b> \<Boolean\></dt>
<dd>exit immediately (not graceful -- not complete) if the last job has been sent out<br/>Default: false<br/></dd>
<dt><b>-mpi_timeout_factor</b> \<Real\></dt>
<dd>timeout is X times average job-completion time - set to 0 to switch off<br/>Default: 0<br/></dd>
<dt><b>-mpi_work_partition_job_distributor</b> \<Boolean\></dt>
<dd>determine if we should use the WorkPartition job distributor<br/>Default: false<br/></dd>
<dt><b>-mpi_file_buf_job_distributor</b> \<Boolean\></dt>
<dd>determine if we should use the MPIFileBufJobDistributor (warning: silent output only)<br/>Default: true<br/></dd>
<dt><b>-mpi_filebuf_jobdistributor</b> \<Boolean\></dt>
<dd>same as mpi_file_buf_job_distributor but with more intuitive spacing... determine if we should use the MPIFileBufJobDistributor (warning: silent output only)<br/>Default: true<br/></dd>
<dt><b>-mpi_fast_nonblocking_output</b> \<Boolean\></dt>
<dd>By default the master node blocks while a slave node outputs to avoid two slaves writing to a score file or silent file at the same time setting this to true disables that feature<br/>Default: false<br/></dd>
<dt><b>-dd_parser</b> \<Boolean\></dt>
<dd>determine whether to use the dock_design_parser<br/>Default: false<br/></dd>
<dt><b>-ntrials</b> \<Integer\></dt>
<dd>number of attempts at creating an output file for each nstruct. e.g., ntrials 3 and nstruct 10 would mean that each of 10 trajectories would attempt to write an output file 3 times and if unsuccessful would fail.<br/>Default: 1<br/></dd>
<dt><b>-generic_job_name</b> \<String\></dt>
<dd>job name when using GenericJobInputter (i.e. abinitio)<br/>Default: "S"<br/></dd>
<dt><b>-no_output</b> \<Boolean\></dt>
<dd>use NoOutputJobOutputter; do not store the pose after a run (no silent or scorefile)<br/>Default: false<br/></dd>
<dt><b>-enzdes_out</b> \<Boolean\></dt>
<dd>causes an enzdes-style scorefile (with information about catalytic res and some pose metric stuff ) to be written instead of the regular scorefile<br/>Default: false<br/></dd>
<dt><b>-buffer_silent_output</b> \<Integer\></dt>
<dd>write structures to silent-files in blocks of N structures to<br/>Default: 1<br/></dd>
<dt><b>-buffer_flush_frequency</b> \<Real\></dt>
<dd>when N structures (buffer_silent_output) are collected dump to file with probability X<br/>Default: 1.0<br/></dd>
<dt><b>-delete_old_poses</b> \<Boolean\></dt>
<dd>Delete poses after they have been processed.  For jobs that process a large number of structures, the memory consumed by old poses is wasteful.<br/>Default: false<br/></dd>
<dt><b>-checkpoint_file</b> \<File\></dt>
<dd>write/read nstruct-based checkpoint files to the desired filename.<br/></dd>
<dt><b>-failed_job_exception</b> \<Boolean\></dt>
<dd>If JD2 encounters an error during job execution, raise an exception at the end of the run<br/>Default: true<br/></dd>
<dt><b>-max_nstruct_in_memory</b> \<Integer\></dt>
<dd>If nstruct is set higher than this number, JD2 will keep only this many jobs in memory in the jobs list at any given time (to keep the jobs list from filling up memory).  As jobs complete, they will be deleted and the jobs list will be filled out with new jobs.  This option is intended for exteremly large runs on systems like the Blue Gene/Q supercomputer.  To disable this sort of memory management, set this option to 0.<br/>Default: 1000000<br/></dd>
<dt><b>-sequential_mpi_job_distribution</b> \<Boolean\></dt>
<dd>If specified, MPI versions of the JobDistributor send jobs to each slave in sequence (slave1, slave2, slave3 etc.).  False by default.  Note that this should NOT be used for production runs; it is intended only for regression tests in which non-sequential job distribution would result in stochastic variations.<br/>Default: false<br/></dd>
<dt><b>-grid_ensemble</b> \<Boolean\></dt>
<dd>Do an ensemble search where each input pdb is used for an ensemble based search.  Instead of each in file outputting nstruct, we use the input files to generate a total nstruct across the inputs<br/>Default: false<br/></dd>
<dt><b>-seed_ensemble</b> \<Boolean\></dt>
<dd>Do an ensemble search as in grid_search, but randomly choose the seeds over the inputs.  See seed_ensemble_weights to weight the inputs<br/>Default: false<br/></dd>
<dt><b>-seed_ensemble_weights</b> \<RealVector\></dt>
<dd>Specifiy weights for seeded ensemble.  Must match number of inputs.  See also: -seed_ensemble_weights_file<br/></dd>
<dt><b>-seed_ensemble_weights_file</b> \<File\></dt>
<dd>A file specifying weights to use for each input structure.  Two columns.  basename with extension (or relative path or full path), weight<br/></dd>
</dl>
+ <h2>-view</h2>
<dl>
<dt><b>-view</b> \<Boolean\></dt>
<dd>view option group<br/></dd>
<dt><b>-show_virtual_residues</b> \<Boolean\></dt>
<dd>Show virtual residues?<br/>Default: true<br/></dd>
<dt><b>-single_glycan_color</b> \<Boolean\></dt>
<dd>Show glycans as a single color instead of default<br/>Default: true<br/></dd>
</dl>
+ <h2>-score</h2>
<dl>
<dt><b>-score_pose_cutpoint_variants</b> \<Boolean\></dt>
<dd>Include cutpoint variants in the pose during linear chainbreak<br/>Default: false<br/></dd>
<dt><b>-score</b> \<Boolean\></dt>
<dd>scorefunction option group<br/></dd>
<dt><b>-weights</b> \<String\></dt>
<dd>Name of weights file (without extension .wts)<br/>Default: "ref2015"<br/></dd>
<dt><b>-set_weights</b> \<StringVector\></dt>
<dd>Modification to weights via the command line. Applied in ScoreFunctionFactory::create_score_function inside the function apply_user_defined_reweighting_. Format is a list of paired strings: -score::set_weights <score_type1> <setting1> <score_type2> <setting2> ...<br/></dd>
<dt><b>-pack_weights</b> \<String\></dt>
<dd>Name of packing weights file (without extension .wts)<br/>Default: "ref2015"<br/></dd>
<dt><b>-soft_wts</b> \<String\></dt>
<dd>Name of the 'soft' weights file, for protocols which use it.<br/>Default: "soft_rep"<br/></dd>
<dt><b>-docking_interface_score</b> \<Boolean\></dt>
<dd>the score is computed as difference between bound and unbound pose<br/>Default: false<br/></dd>
<dt><b>-min_score_score</b> \<Real\></dt>
<dd>do not consider scores lower than min-score in monte-carlo criterion<br/>Default: 0.0<br/></dd>
<dt><b>-custom_atom_pair</b> \<String\></dt>
<dd>filename for custom atom pair constraints<br/>Default: "empty"<br/></dd>
<dt><b>-patch</b> \<FileVector\></dt>
<dd>Name of patch file (without extension)<br/>Default: ""<br/></dd>
<dt><b>-empty</b> \<Boolean\></dt>
<dd>Make an empty score - i.e. NO scoring<br/></dd>
<dt><b>-fa_max_dis</b> \<Real\></dt>
<dd>How far does the FA pair potential go out to ?<br/>Default: 6.0<br/></dd>
<dt><b>-fa_Hatr</b> \<Boolean\></dt>
<dd>Turn on Lennard Jones attractive term for hydrogen atoms<br/>Default: true<br/></dd>
<dt><b>-no_smooth_etables</b> \<Boolean\></dt>
<dd>Revert to old style etables<br/></dd>
<dt><b>-count_pair_hybrid</b> \<Boolean\></dt>
<dd>Use standard count-pair for non-ligands and cp3 w/ full-weight 1-4 for ligands<br/>Default: false<br/></dd>
<dt><b>-count_pair_full</b> \<Boolean\></dt>
<dd>Use cp3 w/ full-weight 1-4 for everything<br/>Default: false<br/></dd>
<dt><b>-no_lk_polar_desolvation</b> \<Boolean\></dt>
<dd>Disable the polar-desolvation component of the LK solvation model; effectively set dGfree for polar atoms to 0<br/></dd>
<dt><b>-lk_polar_without_proline_N</b> \<Boolean\></dt>
<dd>Force class LK_PolarNonPolarEnergy to treat the N atom of proline as non-polar<br/>Default: false<br/></dd>
<dt><b>-input_etables</b> \<String\></dt>
<dd>Read etables from files with given prefix<br/></dd>
<dt><b>-output_etables</b> \<String\></dt>
<dd>Write out etables to files with given prefix<br/></dd>
<dt><b>-analytic_etable_evaluation</b> \<Boolean\></dt>
<dd>Instead of interpolating between bins, use an analytic evaluation of the lennard-jones and solvation energies<br/>Default: true<br/></dd>
<dt><b>-put_intra_into_total</b> \<Boolean\></dt>
<dd>Put intra-residue terms inside hbond, geom_sol_fast, fa_atr. (Contributions will not show up in hbond_intra, fa_atr_intra_xover4.) Off for proteins by default.<br/>Default: false<br/></dd>
<dt><b>-include_intra_res_protein</b> \<Boolean\></dt>
<dd>Include computation of intra-residue terms for proteins.<br/>Default: false<br/></dd>
<dt><b>-fa_stack_base_base_only</b> \<Boolean\></dt>
<dd>Only calculate fa_stack for RNA base/base.<br/>Default: true<br/></dd>
<dt><b>-fa_stack_include_rna_protein</b> \<Boolean\></dt>
<dd>Calculate fa_stack for RNA/protein<br/>Default: true<br/></dd>
<dt><b>-fa_stack_sol_prefactor</b> \<Real\></dt>
<dd>Strength of sol penalty in fa_stack_sol.<br/>Default: 0.1<br/></dd>
<dt><b>-fa_stack_sol_stack_cutoff</b> \<Real\></dt>
<dd>distances below this get full sol stack.<br/>Default: 5.5<br/></dd>
<dt><b>-fa_stack_sol_dist_cutoff</b> \<Real\></dt>
<dd>distances below this get some sol stack.<br/>Default: 6.5<br/></dd>
<dt><b>-fa_stack_lr_prefactor</b> \<Real\></dt>
<dd>Strength of lr penalty in fa_stack_lr.<br/>Default: -0.05<br/></dd>
<dt><b>-fa_stack_lr_stack_cutoff</b> \<Real\></dt>
<dd>distances below this get full lr stack.<br/>Default: 6.5<br/></dd>
<dt><b>-fa_stack_lr_dist_cutoff</b> \<Real\></dt>
<dd>distances below this get some lr stack.<br/>Default: 7.5<br/></dd>
<dt><b>-geom_sol_interres_path_distance_cutoff</b> \<Integer\></dt>
<dd>Minimum no. bonds between atoms in different residues to calculate geom_sol<br/>Default: 0<br/></dd>
<dt><b>-geom_sol_intrares_path_distance_cutoff</b> \<Integer\></dt>
<dd>Minimum no. bonds between atoms in same residues to calculate geom_sol<br/>Default: 6<br/></dd>
<dt><b>-rms_target</b> \<Real\></dt>
<dd>Target of RMS optimization for RMS_Energy EnergyMethod<br/>Default: 0.0<br/></dd>
<dt><b>-ramaneighbors</b> \<Boolean\></dt>
<dd>Uses neighbor-dependent ramachandran maps<br/>Default: false<br/></dd>
<dt><b>-optH_weights</b> \<String\></dt>
<dd>Name of weights file (without extension .wts) to use during optH<br/></dd>
<dt><b>-optH_patch</b> \<String\></dt>
<dd>Name of weights file (without extension .wts) to use during optH<br/></dd>
<dt><b>-hb_don_strength</b> \<StringVector\></dt>
<dd>Modification of hbond donor-atom strengths, over-rides any database file settings. Format is -hb_don_strength <atm1>:<wt1> <atm2>:<wt2> ...   For example -hb_don_strength hbdon_IND:1.5 hbdon_AHX:0.5<br/></dd>
<dt><b>-hb_acc_strength</b> \<StringVector\></dt>
<dd>Modification of hbond acceptor-atom strengths, over-rides any database file settings. Format is -hb_acc_strength <atm1>:<wt1> <atm2>:<wt2> ...   For example -hb_acc_strength hbacc_CXA:1.5 hbdon_HXL:0.5<br/></dd>
<dt><b>-hbe_for_dH2O_aGEN_SP3SC_ssother</b> \<String\></dt>
<dd>HBEvalType for HBEvalTuple(hbdon_H2O, hbacc_GENERIC_SP3SC, seq_sep_other)<br/>Default: "hbe_dH2OaHXL"<br/></dd>
<dt><b>-hbond_params</b> \<String\></dt>
<dd>Directory name in the database for which hydrogen bond parameters to use.<br/>Default: "ref2015_params"<br/></dd>
<dt><b>-hbond_bb_per_residue_energy</b> \<Boolean\></dt>
<dd>In score tables, separate out backbone hydrogens bond energies per residue. By default, bb hbonds are included in the total energy, but not per residue energies<br/>Default: false<br/></dd>
<dt><b>-hbond_disable_bbsc_exclusion_rule</b> \<Boolean\></dt>
<dd>Disable the rule that protein bb/sc hbonds are excluded if the backbone group is already forming a hydrogen bond to a backbone group; with this flag, no hbonds are excluded<br/>Default: false<br/></dd>
<dt><b>-use_hb_env_dep</b> \<Boolean\></dt>
<dd>Use hydrogen bond environment dependency. Smaller in the surface of the protein.<br/>Default: true<br/></dd>
<dt><b>-water_hybrid_sf</b> \<Boolean\></dt>
<dd>Use a hybrid scoring function, which includes energy terms hbond_wat and wat_entropy.<br/>Default: false<br/></dd>
<dt><b>-show_etable_contributions</b> \<Boolean\></dt>
<dd>Shows atom-atom and res-res contributions to Lennard-Jones and solvation energies when scoring.<br/>Default: false<br/></dd>
<dt><b>-symE_units</b> \<Integer\></dt>
<dd>Number of symmetric Units in design for use with symE scoring<br/>Default: -1<br/></dd>
<dt><b>-symE_bonus</b> \<Real\></dt>
<dd>Energy bonus per match for use with symE scoring<br/>Default: 0.0<br/></dd>
<dt><b>-symmetric_gly_tables</b> \<Boolean\></dt>
<dd>If true, the Ramachandran and P_AA_PP tables for glycine will be symmetrized on load.  If false (the default), then the statistical tables will be used, which are asymmetric due to the contribution of chiral amino acids.<br/>Default: false<br/></dd>
<dt><b>-NV_lbound</b> \<Real\></dt>
<dd>Lower Bound for neighbor Vector scoring<br/>Default: 3.3<br/></dd>
<dt><b>-NV_ubound</b> \<Real\></dt>
<dd>Upper Bound for neighbor Vector scoring<br/>Default: 11.1<br/></dd>
<dt><b>-NV_table</b> \<String\></dt>
<dd>Location of path to potential lookup table<br/>Default: "scoring/score_functions/NV/neighbor_vector_score.histogram"<br/></dd>
<dt><b>-find_neighbors_3dgrid</b> \<Boolean\></dt>
<dd>Use a 3D lookup table for doing neighbor calculations.  For spherical, well-distributed conformations, O(N) neighbor detection instead of general O(NlgN)<br/>Default: false<br/></dd>
<dt><b>-find_neighbors_stripehash</b> \<Boolean\></dt>
<dd>should be faster than 3dgrid and use 1/8th the memory<br/>Default: false<br/></dd>
<dt><b>-seqdep_refene_fname</b> \<String\></dt>
<dd>Filename for table containing sequence-dependent reference energies<br/></dd>
<dt><b>-secondary_seqdep_refene_fname</b> \<String\></dt>
<dd>Additional filename for table containing sequence-dependent reference energies<br/></dd>
<dt><b>-exact_occ_pairwise</b> \<Boolean\></dt>
<dd>When using occ_sol_exact, compute energies subject to pairwise additivity (not recommended - intended for parameterization / evaluation purposes)<br/>Default: false<br/></dd>
<dt><b>-exact_occ_skip_Hbonders</b> \<Boolean\></dt>
<dd>When using occ_sol_exact, do not count contributions from occluding groups which form Hbonds to the polar group of interest<br/>Default: true<br/></dd>
<dt><b>-exact_occ_pairwise_by_res</b> \<Boolean\></dt>
<dd>When using occ_sol_exact, compute energies subject to by-residue pairwise additivity (not recommended - intended for parameterization / evaluation purposes)<br/>Default: false<br/></dd>
<dt><b>-exact_occ_split_between_res</b> \<Boolean\></dt>
<dd>When using occ_sol_exact with the exact_occ_pairwise flag, split the energies between both contributing residues instead of assigning it just to the polar residue (not recommended - intended for parameterization / evaluation purposes)<br/>Default: false<br/></dd>
<dt><b>-exact_occ_self_res_no_occ</b> \<Boolean\></dt>
<dd>Setting this to false means that the self-residue CAN occlude when using the exact ODO model, leading to potential double-counting with the Dunbrack energy but better results in loop discrimination.<br/>Default: false<br/></dd>
<dt><b>-exact_occ_radius_scaling</b> \<Real\></dt>
<dd>When using occ_sol_exact, scale the radii of occluding atoms by this factor (intended for parameterization / evaluation purposes)<br/>Default: 1.0<br/></dd>
<dt><b>-ref_offsets</b> \<StringVector\></dt>
<dd>offset reference energies using 3 character residue types (example: TRP 0.9 HIS 0.3)<br/></dd>
<dt><b>-ref_offset</b> \<Real\></dt>
<dd>offset all reference energies by this amount<br/>Default: 0.0<br/></dd>
<dt><b>-output_residue_energies</b> \<Boolean\></dt>
<dd>Output the energy for each residue<br/>Default: false<br/></dd>
<dt><b>-fa_custom_pair_distance_file</b> \<String\></dt>
<dd>Name of custom pair distance energy file<br/>Default: ""<br/></dd>
<dt><b>-disulf_matching_probe</b> \<Real\></dt>
<dd>Size of probe to use in disulfide matching score<br/>Default: 2.5<br/></dd>
<dt><b>-bonded_params</b> \<RealVector\></dt>
<dd>Default spring constants for bonded parameters [length,angle,torsion,proton-torsion,improper-torsion]<br/></dd>
<dt><b>-bonded_params_dir</b> \<String\></dt>
<dd>Spring constants for bonded parameters [length,angle,torsion,proton-torsion,improper-torsion]<br/>Default: "scoring/score_functions/bondlength_bondangle"<br/></dd>
<dt><b>-gen_bonded_params_file</b> \<String\></dt>
<dd>Parameters for [length,angle,torsion,improper-torsion]<br/>Default: "scoring/score_functions/generic_potential/generic_bonded.round6p.txt"<br/></dd>
<dt><b>-gen_bonded_exclude_def_file</b> \<String\></dt>
<dd>Definitions for double-counting params with other energy terms<br/>Default: "scoring/score_functions/generic_potential/params_exclude.txt"<br/></dd>
<dt><b>-genbonded_score_canonical_aas</b> \<Boolean\></dt>
<dd>Turn on gen_bonded term for canonical amino acids<br/>Default: false<br/></dd>
<dt><b>-extra_improper_file</b> \<String\></dt>
<dd>Add extra parameters for improper torsions<br/></dd>
<dt><b>-pro_close_planar_constraint</b> \<Real\></dt>
<dd>stdev of CD,N,CA,prevC trigonal planar constraint in pro_close energy method<br/>Default: 0.1<br/></dd>
<dt><b>-no_pro_close_ring_closure</b> \<Boolean\></dt>
<dd>The pro_close term holds the proline ring closed, but also has some inter-residue energy associated with the psi value of the preceding residue.  If this flag is set to 'true', the term ONLY does the torsional stuff -- it doesn't hold the ring closed.  For use with cart_bonded or ring_close.  False by default.<br/>Default: false<br/></dd>
<dt><b>-ring_close_shadow_constraint</b> \<Real\></dt>
<dd>Standard deviation of the harmonic potential used to hold shadow atoms atop real atoms in order to hold rings closed with the ring_close scoring term.  Analogous to pro_close_planar_constraint option for the pro_close energy term.<br/>Default: 0.1<br/></dd>
<dt><b>-linear_bonded_potential</b> \<Boolean\></dt>
<dd>use linear (instead of quadratic) bonded potential<br/>Default: false<br/></dd>
<dt><b>-free_side_chain_bonus</b> \<Real\></dt>
<dd>Amount to reward virtualization of a protein side chain, per free chi<br/>Default: -0.5<br/></dd>
<dt><b>-compute_mg_sol_for_hydrogens</b> \<Boolean\></dt>
<dd>mg_sol includes penalties for hydrogens near Mg(2+)<br/>Default: false<br/></dd>
<dt><b>-rg_local_span</b> \<IntegerVector\></dt>
<dd>First,last res in rg_local. For example to calc rg_local from 1-20 would be 1,20<br/>Default: 0<br/></dd>
<dt><b>-unmodifypot</b> \<Boolean\></dt>
<dd>Do not call modify pot to add extra repulsive interactions between Obb/Obb atom types at distances beneath 3.6 Angstroms<br/>Default: true<br/></dd>
<dt><b>-conc</b> \<Real\></dt>
<dd>intermolecular concentration to use in intermol term (give in M)<br/>Default: 1.0<br/></dd>
<dt><b>-sidechain_buried</b> \<IntegerVector\></dt>
<dd>count buried residues (rvernon pilot app)<br/>Default: -1<br/></dd>
<dt><b>-sidechain_exposed</b> \<IntegerVector\></dt>
<dd>count exposed residues (rvernon pilot app)<br/>Default: -1<br/></dd>
<dt><b>-aa_composition_setup_file</b> \<StringVector\></dt>
<dd>The filename of one or more setup files for the aa_composition scoring term.  (Multiple such files can be listed, separated by a space.)  The default location for these files (which have a .comp extension) is /database/scoring/score_functions/aa_composition/.<br/></dd>
<dt><b>-aa_repeat_energy_penalty_file</b> \<String\></dt>
<dd>The filename of a penalty file for the aa_repeat_energy term.  The penalty file should be a series of numbers on a single line, representing the penalty for having a repeat of 1, 2, 3, etc. of the same residue.  Penalty files are stored in database/scoring/score_functions/aa_repeat_energy/ and should have the suffix .rpt_pen.  The default is default_repeat_penalty_table.rpt_pen.<br/>Default: "default_repeat_penalty_table.rpt_pen"<br/></dd>
<dt><b>-approximate_buried_unsat_penalty_hbond_energy_threshold</b> \<Real\></dt>
<dd>Energy threshold for a h-bond to be considered satisfying a buried polar. Should be a negative number. (Setting to -0.001 will be much faster than 0 at runtime)<br/>Default: -0.25<br/></dd>
<dt><b>-approximate_buried_unsat_penalty_burial_atomic_depth</b> \<Real\></dt>
<dd>The atomic depth cutoff to determine whether or not a polar atom is buried. Measured from the Sasa surface.<br/>Default: 4.5f<br/></dd>
<dt><b>-approximate_buried_unsat_penalty_burial_probe_radius</b> \<Real\></dt>
<dd>The probe radius for the atomic depth calculation.<br/>Default: 2.3f<br/></dd>
<dt><b>-approximate_buried_unsat_penalty_burial_resolution</b> \<Real\></dt>
<dd>The resolution for the atomic depth calculation.<br/>Default: 0.5f<br/></dd>
<dt><b>-approximate_buried_unsat_penalty_oversat_penalty</b> \<Real\></dt>
<dd>The penalty between atoms that both satisfy the same atom. If we let X = weight_of_approximate_buried_unsat_penalty. Then in general, a buried unsat is worth X, a satisfied unsat is worth 0, a doubly satisfied unsat is worth X * ( setting-1.0 ), a triply satisfied unsat is worth X * ( -2 + 3 * setting ), a N-ly satisfied unsat is worth X * ( 1 - N + 0.5 * N * (N - 1) ).<br/>Default: 1.0<br/></dd>
<dt><b>-approximate_buried_unsat_penalty_assume_const_backbone</b> \<Boolean\></dt>
<dd>Should we assume that the backbone atoms will not change during a packing trajectory? (i.e. no positions that include normal aa and proline or n-methyl) If set to false, this energy method takes longer to compute. (~ 2X as long)<br/>Default: true<br/></dd>
<dt><b>-aspartimide_penalty_value</b> \<Real\></dt>
<dd>The penalty for each aspartimide-forming two-residue sequence found, when the aspartimide_penalty score term weight is set to 1.0.  Default is 25.0.<br/>Default: 25.0<br/></dd>
<dt><b>-buried_unsatisfied_penalty_cone_angle_exponent</b> \<Real\></dt>
<dd>The angle exponent for calculating burial by the method of sidechain neighbor cones, used by the BuriedUnsatPenalty energy.<br/>Default: 2.0<br/></dd>
<dt><b>-buried_unsatisfied_penalty_cone_angle_shift_factor</b> \<Real\></dt>
<dd>The angle shift factor for calculating burial by the method of sidechain neighbor cones, used by the BuriedUnsatPenalty energy.<br/>Default: 0.25<br/></dd>
<dt><b>-buried_unsatisfied_penalty_cone_dist_exponent</b> \<Real\></dt>
<dd>The distance exponent for calculating burial by the method of sidechain neighbor cones, used by the BuriedUnsatPenalty energy.<br/>Default: 1.0<br/></dd>
<dt><b>-buried_unsatisfied_penalty_cone_dist_midpoint</b> \<Real\></dt>
<dd>The distance midpoint for calculating burial by the method of sidechain neighbor cones, used by the BuriedUnsatPenalty energy.<br/>Default: 9.0<br/></dd>
<dt><b>-buried_unsatisfied_penalty_burial_threshold</b> \<Real\></dt>
<dd>The number of cones in which a point must lie to be considered buried by the method of sidechain neighbor cones, used by the BuriedUnsatPenalty energy.<br/>Default: 5.0<br/></dd>
<dt><b>-buried_unsatisfied_penalty_hbond_energy_threshold</b> \<Real\></dt>
<dd>The energy threshold above which a hydrogen bond is not counted, used by the BuriedUnsatPenalty energy.<br/>Default: -0.25<br/></dd>
<dt><b>-covalent_labeling_input</b> \<File\></dt>
<dd>Input covalent labeling data in the form of neighbor counts<br/></dd>
<dt><b>-covalent_labeling_fa_input</b> \<File\></dt>
<dd>Input covalent labeling data in the form of neighbor counts for FA<br/></dd>
<dt><b>-elec_min_dis</b> \<Real\></dt>
<dd>changes the minimum distance cut-off for hack-elec energy<br/>Default: 1.6<br/></dd>
<dt><b>-elec_max_dis</b> \<Real\></dt>
<dd>changes the maximum distance cut-off for hack-elec energy<br/>Default: 5.5<br/></dd>
<dt><b>-elec_die</b> \<Real\></dt>
<dd>changes the dielectric constant for hack-elec energy<br/>Default: 10.0<br/></dd>
<dt><b>-elec_r_option</b> \<Boolean\></dt>
<dd>changes the dielectric from distance dependent to distance independent<br/>Default: false<br/></dd>
<dt><b>-elec_sigmoidal_die</b> \<Boolean\></dt>
<dd>changes the dielectric from distance dependent to sigmoidal<br/>Default: true<br/></dd>
<dt><b>-elec_sigmoidal_die_D</b> \<Real\></dt>
<dd>D parameter for sigmoidal dielectric<br/>Default: 80.0<br/></dd>
<dt><b>-elec_sigmoidal_die_D0</b> \<Real\></dt>
<dd>D0 parameter for sigmoidal dielectric<br/>Default: 6.0<br/></dd>
<dt><b>-elec_sigmoidal_die_S</b> \<Real\></dt>
<dd>S parameter for sigmoidal dielectric<br/>Default: 0.4<br/></dd>
<dt><b>-stack_elec_sigmoidal_die</b> \<Boolean\></dt>
<dd>override of -elec_sigmoidal_die for stack_elec<br/>Default: false<br/></dd>
<dt><b>-elec_representative_cp</b> \<Boolean\></dt>
<dd>Use representative atoms for countpair to avoid dipole splits<br/>Default: true<br/></dd>
<dt><b>-elec_representative_cp_flip</b> \<Boolean\></dt>
<dd>Enable elec_representative_cp, but FLIP the order in the table<br/>Default: true<br/></dd>
<dt><b>-eval_intrares_elec_ST_only</b> \<Boolean\></dt>
<dd>Intrares elec only for free DOF atoms in Ser/Thr<br/>Default: false<br/></dd>
<dt><b>-smooth_fa_elec</b> \<Boolean\></dt>
<dd>Smooth the discontinuities in the elec energy function using a sigmoidal term<br/>Default: true<br/></dd>
<dt><b>-grpelec_fade_type</b> \<String\></dt>
<dd>use standard way (shift/switch function) of Coulomb function for fa_grpelec<br/>Default: "false"<br/></dd>
<dt><b>-grpelec_fade_param1</b> \<Real\></dt>
<dd>fading distance for shift/switch<br/>Default: 1.0<br/></dd>
<dt><b>-grpelec_fade_param2</b> \<Real\></dt>
<dd>exponent for shift<br/>Default: 1.0<br/></dd>
<dt><b>-elec_group_file</b> \<String\></dt>
<dd>file where group information is stored<br/>Default: "/scoring/score_functions/elec_group_def.dat"<br/></dd>
<dt><b>-elec_group_extrafile</b> \<String\></dt>
<dd>file where group information for extra_res is stored<br/>Default: ""<br/></dd>
<dt><b>-grpelec_fade_hbond</b> \<Boolean\></dt>
<dd>fade grpelec for hbonding group<br/>Default: false<br/></dd>
<dt><b>-grpelec_max_qeps</b> \<RealVector\></dt>
<dd>Max abs charge for the group types, used when fading hbond [nonpolar/polar/charged]<br/>Default: ['0', '0.10', '0.25', '0.5']<br/></dd>
<dt><b>-grpelec_context_dependent</b> \<Boolean\></dt>
<dd>whether grpelec depends on context<br/>Default: false<br/></dd>
<dt><b>-grp_cpfxn</b> \<Boolean\></dt>
<dd>rule for trying cpfxn on group<br/>Default: true<br/></dd>
<dt><b>-grpelec_cpfxn_weight</b> \<RealVector\></dt>
<dd>cpfxn weight on group(1-4/1-5/>1-5)<br/>Default: ['0.0', '0.2', '1.0']<br/></dd>
<dt><b>-hbnet_bonus_function_ramping</b> \<String\></dt>
<dd>The hbnet score term's bonus function can scale in different ways as the size of a network grows.  The default is quadratic growth, though linear, logarithmic, and square root growth are all allowed.<br/>Default: "quadratic"<br/></dd>
<dt><b>-hbnet_max_network_size</b> \<Integer\></dt>
<dd>This is the maximum hydrogen bond network size, beyond which the hbnet score term will not give any more bonus.  Defaults to 0, which means no limit.<br/>Default: 0<br/></dd>
<dt><b>-elec_context_minstrength</b> \<Real\></dt>
<dd>strength at min burial <br/>Default: 0.2<br/></dd>
<dt><b>-elec_context_minburial</b> \<Real\></dt>
<dd>num. cb assigned as min burial <br/>Default: 7.0<br/></dd>
<dt><b>-elec_context_maxburial</b> \<Real\></dt>
<dd>num. cb assigned as max burial<br/>Default: 24.0<br/></dd>
<dt><b>-use_polarization</b> \<Boolean\></dt>
<dd>whether multipole electrostatics includes polarization (induced dipoles)<br/>Default: true<br/></dd>
<dt><b>-use_gen_kirkwood</b> \<Boolean\></dt>
<dd>whether multipole electrostatics includes treatment of reaction field<br/>Default: true<br/></dd>
<dt><b>-protein_dielectric</b> \<Real\></dt>
<dd>dielectric constant for protein in generalized Kirkwood treatment of reaction field<br/>Default: 1.0<br/></dd>
<dt><b>-water_dielectric</b> \<Real\></dt>
<dd>dielectric constant for water in generalized Kirkwood treatment of reaction field<br/>Default: 78.3<br/></dd>
<dt><b>-facts_GBpair_cut</b> \<Real\></dt>
<dd>GBpair interaction distance cutoff (same as elec_max_dis)<br/>Default: 10.0<br/></dd>
<dt><b>-facts_kappa</b> \<Real\></dt>
<dd>GBpair interaction screening factor<br/>Default: 12.0<br/></dd>
<dt><b>-facts_asp_patch</b> \<Integer\></dt>
<dd>AtomicSolvationParameter set for nonpolar interaction in FACTS<br/>Default: 3<br/></dd>
<dt><b>-facts_plane_to_self</b> \<Boolean\></dt>
<dd>Add atoms in same plane to self energy pairs<br/>Default: true<br/></dd>
<dt><b>-facts_saltbridge_correction</b> \<Real\></dt>
<dd>FACTS Self energy parameter scaling factor for polarH<br/>Default: 1.0<br/></dd>
<dt><b>-facts_dshift</b> \<RealVector\></dt>
<dd>FACTS pair term denominator distance shift[bb/bbsc/scsc/saltbridge]<br/>Default: ['0.0', '1.5', '1.5', '1.5']<br/></dd>
<dt><b>-facts_die</b> \<Real\></dt>
<dd>FACTS dielectric constant<br/>Default: 1.0<br/></dd>
<dt><b>-facts_binding_affinity</b> \<Boolean\></dt>
<dd>Activate FACTS options for binding affinity calculation<br/>Default: false<br/></dd>
<dt><b>-facts_intrascale_by_level</b> \<Boolean\></dt>
<dd>Apply internal scaling by path_dist to CA? (definition below becomes G/D/E/Z/>Z<br/>Default: false<br/></dd>
<dt><b>-facts_intbb_elec_scale</b> \<RealVector\></dt>
<dd>FACTS Coulomb scale for intrares bonded pairs: [1-4, 1-5, >1-5]<br/>Default: ['0.0', '0.2', '0.0']<br/></dd>
<dt><b>-facts_intbb_solv_scale</b> \<RealVector\></dt>
<dd>FACTS GB scale for intrares bb-bb bonded pairs: [1-4, 1-5, >1-5]<br/>Default: ['0.4', '0.4', '0.0']<br/></dd>
<dt><b>-facts_adjbb_elec_scale</b> \<RealVector\></dt>
<dd>FACTS Coulomb scale for adjacent bb-bb bonded pairs: [1-4, 1-5, 1-6, 2res-coupled, 1res-decoupled]<br/>Default: ['0.0', '0.2', '1.0', '0.5', '0.5']<br/></dd>
<dt><b>-facts_adjbb_solv_scale</b> \<RealVector\></dt>
<dd>FACTS GB scale for adjacent bb-bb bonded pairs: [1-4, 1-5, 1-6, 2res-coupled, 1res-decoupled]<br/>Default: ['0.0', '0.2', '1.0', '0.5', '0.5']<br/></dd>
<dt><b>-facts_intbs_elec_scale</b> \<RealVector\></dt>
<dd>FACTS Coulomb scale for intrares bb-sc bonded pairs: [1-4, 1-5, 1-6, >1-6, dumm]<br/>Default: ['0.2', '0.2', '0.2', '0.2', '0.0']<br/></dd>
<dt><b>-facts_intbs_solv_scale</b> \<RealVector\></dt>
<dd>FACTS GB scale for intrares bb-sc bonded pairs: [1-4, 1-5, 1-6, >1-6, dumm]<br/>Default: ['1.0', '0.6', '0.6', '0.6', '0.0']<br/></dd>
<dt><b>-facts_adjbs_elec_scale</b> \<RealVector\></dt>
<dd>FACTS Coulomb scale for adjacent bb-sc bonded pairs: [1-4, 1-5, 1-6, 1-7, >1-7]<br/>Default: ['0.0', '0.2', '0.2', '0.2', '0.2']<br/></dd>
<dt><b>-facts_adjbs_solv_scale</b> \<RealVector\></dt>
<dd>FACTS GB scale for adjacent bb-sc bonded pairs: [1-4, 1-5, 1-6, 1-7, >1-7]<br/>Default: ['1.0', '0.6', '0.6', '0.6', '0.6']<br/></dd>
<dt><b>-facts_intsc_elec_scale</b> \<RealVector\></dt>
<dd>FACTS Coulomb scale for intrares sc-sc pairs: [1-4, 1-5, >1-5]<br/>Default: ['0.0', '0.0', '0.0']<br/></dd>
<dt><b>-facts_intsc_solv_scale</b> \<RealVector\></dt>
<dd>FACTS GB scale for intrares sc-sc pairs: [1-4, 1-5, >1-5]<br/>Default: ['1.0', '0.0', '0.0']<br/></dd>
<dt><b>-facts_charge_dir</b> \<String\></dt>
<dd>directory where residue topology files for FACTS charge are stored<br/>Default: "scoring/score_functions/facts"<br/></dd>
<dt><b>-facts_eff_charge_dir</b> \<String\></dt>
<dd>directory where residue topology files for FACTS charge are stored<br/>Default: "scoring/score_functions/facts/eff"<br/></dd>
<dt><b>-facts_plane_aa</b> \<StringVector\></dt>
<dd>AAs to apply plane rule<br/></dd>
<dt><b>-facts_eq_type</b> \<String\></dt>
<dd>FACTS equation type<br/>Default: "exact"<br/></dd>
<dt><b>-ignore_terminal_ss_elements</b> \<Integer\></dt>
<dd>number of secondary structure elements to be ignored<br/>Default: 0<br/></dd>
<dt><b>-length_dep_srbb</b> \<Boolean\></dt>
<dd>Enable helix-length-dependent sr backbone hbonds<br/>Default: false<br/></dd>
<dt><b>-ldsrbb_low_scale</b> \<Real\></dt>
<dd>Helix-length-dependent scaling at minlength.<br/>Default: 0.5<br/></dd>
<dt><b>-ldsrbb_high_scale</b> \<Real\></dt>
<dd>Helix-length-dependent scaling at maxlength.<br/>Default: 2.0<br/></dd>
<dt><b>-ldsrbb_minlength</b> \<Integer\></dt>
<dd>Helix-length-dependent scaling minlength.<br/>Default: 4<br/></dd>
<dt><b>-ldsrbb_maxlength</b> \<Integer\></dt>
<dd>Helix-length-dependent scaling maxlength.<br/>Default: 17<br/></dd>
<dt><b>-max_motif_per_res</b> \<Real\></dt>
<dd>maximum value for motifs<br/>Default: 3.0<br/></dd>
<dt><b>-max_contacting_ss</b> \<Integer\></dt>
<dd>maximum number of interconnecting SS<br/>Default: 4<br/></dd>
<dt><b>-motif_ignore_symmmetry</b> \<Boolean\></dt>
<dd>only counts motifs inside monomer<br/>Default: true<br/></dd>
<dt><b>-motif_residues</b> \<IntegerVector\></dt>
<dd>which residue numbers to calculate motifs<br/></dd>
<dt><b>-netcharge_setup_file</b> \<StringVector\></dt>
<dd>The filename of one or more setup files for the netcharge scoring term.  (Multiple such files can be listed, separated by a space.)  The default location for these files (which have a .charge extension) is /database/scoring/score_functions/netcharge/.<br/></dd>
<dt><b>-mhc_epitope_setup_file</b> \<StringVector\></dt>
<dd>The filename of one or more setup files for the mhc_epitope scoring term.  (Multiple such files can be listed, separated by a space.)  The default location for these files (which have a .mhc extension) is /database/scoring/score_functions/mhc_epitope/.<br/></dd>
<dt><b>-ms_dist_midpoint</b> \<Real\></dt>
<dd>distance midpoint for distance factor for HRF_MSLabeling score term<br/>Default: 9.0<br/></dd>
<dt><b>-ms_dist_exponent</b> \<Real\></dt>
<dd>distance exponent for distance factor for HRF_MSLabeling score term<br/>Default: 0.1<br/></dd>
<dt><b>-ms_fit_slope</b> \<Real\></dt>
<dd>slope for burial measure calc from lnPF for HRF_MSlabeling score term<br/>Default: 3.827<br/></dd>
<dt><b>-ms_fit_intercept</b> \<Real\></dt>
<dd>intercept for burial measure calc from lnPF for HRF_MSlabeling score term<br/>Default: 36.202<br/></dd>
<dt><b>-ms_fade_outer</b> \<Real\></dt>
<dd>outer limit for FadeFunc in HRF_MSLabeling score term<br/>Default: 10.0<br/></dd>
<dt><b>-ms_fade_dist</b> \<Real\></dt>
<dd>fade distance for FadeFunc in HRF_MSLabeling score term<br/>Default: 5.0<br/></dd>
<dt><b>-nmer_ref_energies</b> \<String\></dt>
<dd>nmer ref energies database filename<br/></dd>
<dt><b>-nmer_ref_energies_list</b> \<String\></dt>
<dd>list of nmer ref energies database filenames<br/></dd>
<dt><b>-nmer_pssm</b> \<String\></dt>
<dd>nmer pssm database filename<br/></dd>
<dt><b>-nmer_pssm_list</b> \<String\></dt>
<dd>list of nmer pssm database filenames<br/></dd>
<dt><b>-nmer_pssm_scorecut</b> \<Real\></dt>
<dd>nmer pssm scorecut gate for ignoring lowscore nmers<br/>Default: 0.0<br/></dd>
<dt><b>-nmer_svm</b> \<String\></dt>
<dd>nmer svm filename (libsvm)<br/>Default: ""<br/></dd>
<dt><b>-nmer_svm_list</b> \<String\></dt>
<dd>list of nmer svm filenames (libsvm)<br/>Default: ""<br/></dd>
<dt><b>-nmer_svm_rank</b> \<String\></dt>
<dd>nmer svm rank scores filename (libsvm)<br/>Default: ""<br/></dd>
<dt><b>-nmer_svm_rank_list</b> \<String\></dt>
<dd>list of nmer svm rank scores filenames (libsvm)<br/>Default: ""<br/></dd>
<dt><b>-nmer_svm_scorecut</b> \<Real\></dt>
<dd>nmer svm scorecut gate for ignoring lowscore nmers<br/>Default: 0.0<br/></dd>
<dt><b>-nmer_svm_aa_matrix</b> \<String\></dt>
<dd>nmer svm sequence encoding matrix filename<br/></dd>
<dt><b>-nmer_svm_term_length</b> \<Integer\></dt>
<dd>how many up/dnstream res to avg and incl in svm sequence encoding<br/>Default: 3<br/></dd>
<dt><b>-nmer_svm_pssm_feat</b> \<Boolean\></dt>
<dd>add pssm features to svm encoding?<br/>Default: true<br/></dd>
<dt><b>-nmer_svm_avg_rank_as_energy</b> \<Boolean\></dt>
<dd>use average of svm score ranks as rsd energy for NmerSVM scoring method, good for normalizing across mhc/hla alleles<br/>Default: false<br/></dd>
<dt><b>-nmer_ref_seq_length</b> \<Integer\></dt>
<dd>length of nmers in nmer_ref score<br/>Default: 9<br/></dd>
<dt><b>-just_calc_rmsd</b> \<Boolean\></dt>
<dd>In rna_score, just calculate rmsd -- do not replace score.<br/>Default: false<br/></dd>
<dt><b>-envsmooth_zero_negatives</b> \<Boolean\></dt>
<dd>use alternative envsmooth table with a floor of 0.0 (envsmooth awards no energy bonus)<br/>Default: false<br/></dd>
<dt><b>-rama_power</b> \<Real\></dt>
<dd>If rama > 0.0, raise to the nth power.  This has been useful for Foldit design.  Note that this creates derivative discontinuities, so it should be used with caution!  If not specified, the default rama behaviour (no power function) is preserved.<br/>Default: 1.0<br/></dd>
<dt><b>-ideal_sugars</b> \<Boolean\></dt>
<dd>Triggers loading of only the ideal chair conformations of sugars with 6 member rings.<br/>Default: false<br/></dd>
<dt><b>-hbond_fade</b> \<Real\></dt>
<dd>fade_factor for hbond geometry softmax<br/>Default: 2.5<br/></dd>
<dt><b>-hbond_new_sp3_acc</b> \<Boolean\></dt>
<dd>fade_factor for hbond geometry softmax<br/>Default: false<br/></dd>
<dt><b>-alignment_sharpness</b> \<Real\></dt>
<dd>When computing a harmonic function of RMSD for the alignment score, what should the standard deviation be?<br/>Default: 1.0<br/></dd>
<dt><b>-rna_torsion_potential</b> \<String\></dt>
<dd>In RNA torsion calculation, directory containing 1D torsional potentials<br/>Default: "ps_04282011"<br/></dd>
<dt><b>-mc_optimize_dG</b> \<Boolean\></dt>
<dd>Optimize the dG during MonteCarlo.  It is not possible to do this within overall scoring, 			but where possible, do this during MC calls.  This option does not globally-use the MonteCarloInterface object, but is protocol-specific. 			This is due to needing to know the interface it will be used on. 			dG is measured by the InterfaceAnalyzerMover. 			Supported Code is currently RosettaAntibodyDesign and RosettaDock<br/>Default: false<br/></dd>
<dt><b>-mc_interface_weight</b> \<Real\></dt>
<dd>Weight of interface score if using MonteCarloInterface with a particular protocol.<br/>Default: 1.0<br/></dd>
<dt><b>-mc_total_weight</b> \<Real\></dt>
<dd>Weight of total score if using MonteCarloInterface with a particular protocol<br/>Default: 0.0<br/></dd>
<dt><b>-voids_penalty_energy_containing_cones_cutoff</b> \<Integer\></dt>
<dd>A parameter for the voids_penalty score term.  The minimum number of cones projecting from side-chains in which a voxel must lie in order for that voxel to be considerd to be buried.  Defaults to 6 cones.<br/>Default: 6<br/></dd>
<dt><b>-voids_penalty_energy_cone_dotproduct_cutoff</b> \<Real\></dt>
<dd>A parameter for the voids_penalty score term.  The cutoff value for the dot product of a cone vector and a cone base-test point vector below which we declare the test point not to be within the cone.  Effectively, this is the cone width.  Lower values make broader cones.  Default 0.1.  Can range from 1.0 (infinitely thin cone) to -1.0 (full spherical volume), with 0.0 represeting all points on one side of the plane perpendicular to the cone vector.<br/>Default: 0.1<br/></dd>
<dt><b>-voids_penalty_energy_cone_distance_cutoff</b> \<Real\></dt>
<dd>A parameter for the voids_penalty score term.  The cutoff value for the distance from the cone base at which we are considered no longer to be within the cone.  Defaults to 8.0 Angstroms.<br/>Default: 8.0<br/></dd>
<dt><b>-voids_penalty_energy_disabled_except_during_packing</b> \<Boolean\></dt>
<dd>If true, then the voids_penalty term is only evaluated during packing (and not scoring or minimizing).  If false, then it is evaluated during packing and scoring (but not minimizing).  True by default.  Can be overridden for a particular ScoreFunction on a per-instance basis.<br/>Default: true<br/></dd>
<dt><b>-voids_penalty_energy_voxel_size</b> \<Real\></dt>
<dd>The size, in Angstroms, of the voxels used in the voxel grid for the voids_penalty energy.  Defaults to 0.5 A (a cube with a side of 0.5 Angstroms).<br/>Default: 0.5<br/></dd>
<dt><b>-voids_penalty_energy_voxel_grid_padding</b> \<Real\></dt>
<dd>A parameter for the voids_penalty energy.  This is the enlargement (on all sides) of the bounding box for the pose when setting up the voxel grid.  Defaults to 1.0 A padding on all sides.<br/>Default: 1.0<br/></dd>
</dl>
+ <h3>-score:rna</h3>
<dl>
<dt><b>-rna</b> \<Boolean\></dt>
<dd>rna option group<br/></dd>
<dt><b>-rna_base_pair_xy_filename</b> \<String\></dt>
<dd>File name where the RNA pase pair XY potential is defined<br/>Default: "scoring/rna/rna_base_pair_xy.dat"<br/></dd>
<dt><b>-disable_orientation_dependent_rna_ch_o_bonds</b> \<Boolean\></dt>
<dd>Do not use orientation-dependent potential for RNA carbon hydrogen bonds<br/>Default: false<br/></dd>
<dt><b>-rna_suite_potential</b> \<String\></dt>
<dd>In RNA calculation, directory containing suite potentials<br/>Default: "Richardson"<br/></dd>
<dt><b>-suiteness_bonus</b> \<String\></dt>
<dd>In RNA calculation, directory containing suiteness bonus definition<br/>Default: "Richardson"<br/></dd>
<dt><b>-rna_torsion_skip_chainbreak</b> \<Boolean\></dt>
<dd>Don't score RNA torsions located at the chain_breaks (aside from the ones that will be closed)<br/>Default: true<br/></dd>
<dt><b>-rna_chemical_shift_verbose</b> \<Boolean\></dt>
<dd>print out chemical shifts; useful for debug<br/>Default: false<br/></dd>
<dt><b>-rna_chemical_shift_larmord</b> \<Boolean\></dt>
<dd>Use LARMORD to calculate 1H chemical shifts<br/>Default: false<br/></dd>
<dt><b>-rna_chemical_shift_exp_data</b> \<String\></dt>
<dd>rna_chemical_shift_exp_data<br/>Default: ""<br/></dd>
<dt><b>-rna_chemical_shift_larmord_par</b> \<String\></dt>
<dd>larmord parameters file<br/>Default: "larmord_1.0_nocut_parameters.dat"<br/></dd>
<dt><b>-rna_chemical_shift_larmord_wt</b> \<String\></dt>
<dd>larmord expected accuracy file<br/>Default: "larmord_noweights.txt"<br/></dd>
<dt><b>-rna_chemical_shift_larmord_ref</b> \<String\></dt>
<dd>larmord reference  chemical shift file<br/>Default: "larmord_1.0_reference_shifts.dat"<br/></dd>
<dt><b>-rna_chemical_shift_larmord_nei</b> \<String\></dt>
<dd>larmord neighbor atom shift file<br/>Default: "larmord_1.0_neighbor_atoms.dat"<br/></dd>
<dt><b>-rna_chemical_shift_larmord_cut</b> \<Real\></dt>
<dd>larmord distance cutoff<br/>Default: 9999.9<br/></dd>
<dt><b>-rna_chemical_shift_larmord_beta</b> \<Real\></dt>
<dd>larmord beta value (the exponent)<br/>Default: -3.0<br/></dd>
<dt><b>-rna_chemical_shift_H5_prime_mode</b> \<String\></dt>
<dd>rna_chemical_shift_H5_prime_mode<br/>Default: ""<br/></dd>
<dt><b>-rna_chemical_shift_include_res</b> \<IntegerVector\></dt>
<dd>rna_chemical_shift_include_res<br/></dd>
<dt><b>-DMS_separate_features</b> \<Boolean\></dt>
<dd>in RNA DMS scoring, calculate N1-bonded, occupancy, and binding-energy-based scores as if they were uncorrelated     features and sum scores. <br/>Default: false<br/></dd>
<dt><b>-DMS_careful_base_pair_classifier</b> \<Boolean\></dt>
<dd>in RNA lo-res DMS scoring, use detailed base pair classification to assess lores score <br/>Default: false<br/></dd>
<dt><b>-rna_chem_map_lores_weight</b> \<Real\></dt>
<dd>In RNA lo-res chemical mapping scoring, final strength of rna_chem_map_lores term when -data_file is specified.<br/>Default: 0.0<br/></dd>
<dt><b>-use_2prime_OH_potential</b> \<Boolean\></dt>
<dd>Use torsional potential for RNA 2prime OH.<br/>Default: true<br/></dd>
<dt><b>-use_rna_chi_potential</b> \<Boolean\></dt>
<dd>Use chi potential for RNA glyocosidic torsion.<br/>Default: true<br/></dd>
<dt><b>-include_neighbor_base_stacks</b> \<Boolean\></dt>
<dd>In RNA score calculation, include stacks between i,i+1<br/>Default: false<br/></dd>
<dt><b>-FA_low_res_rnp_scoring</b> \<Boolean\></dt>
<dd>RNA/protein low-res scoring using full atom protein residues<br/>Default: false<br/></dd>
<dt><b>-free_suite_bonus</b> \<Real\></dt>
<dd>Amount to reward virtualization of a nucleotide suite<br/>Default: -1.0<br/></dd>
<dt><b>-free_sugar_bonus</b> \<Real\></dt>
<dd>Amount to reward virtualization of a sugar/ribose<br/>Default: -1.0<br/></dd>
<dt><b>-free_2HOprime_bonus</b> \<Real\></dt>
<dd>Amount to reward virtualization of a 2'-OH<br/>Default: -0.5<br/></dd>
<dt><b>-syn_G_potential_bonus</b> \<Real\></dt>
<dd>Amount to reward syn chi conformation of guanosine<br/>Default: 0.0<br/></dd>
<dt><b>-rna_bulge_bonus_once_per_loop</b> \<Boolean\></dt>
<dd>For legacy stepwise term rna_bulge in SWM runs, compute bulge bonus on a per-loop basis, rather than a bonus for each virtual residue.<br/>Default: true<br/></dd>
<dt><b>-pack_phosphate_penalty</b> \<Real\></dt>
<dd>Amount to penalize instantiation of a 5' or 3' phosphate<br/>Default: 0.25<br/></dd>
</dl>
+ <h3>-score:saxs</h3>
<dl>
<dt><b>-saxs</b> \<Boolean\></dt>
<dd>saxs option group<br/></dd>
<dt><b>-min_score</b> \<Real\></dt>
<dd>minimum value of saxs score; the parameter is used to flatten the energy funnel around its minimum<br/>Default: -5<br/></dd>
<dt><b>-custom_ff</b> \<String\></dt>
<dd>Name of config file providing extra from factors<br/>Default: ""<br/></dd>
<dt><b>-print_i_calc</b> \<String\></dt>
<dd>File to optionally write scaled computed spectra<br/>Default: ""<br/></dd>
<dt><b>-ref_fa_spectrum</b> \<File\></dt>
<dd>reads reference full-atom spectrum from a file<br/></dd>
<dt><b>-ref_cen_spectrum</b> \<File\></dt>
<dd>reads reference centroid spectrum from a file<br/></dd>
<dt><b>-ref_spectrum</b> \<File\></dt>
<dd>reads reference spectrum from a file<br/></dd>
<dt><b>-ref_pddf</b> \<File\></dt>
<dd>reads reference pairwise distance distribution function<br/></dd>
<dt><b>-d_min</b> \<Real\></dt>
<dd>minimum value of distance used in PDDF score evaluation (in [A])<br/>Default: 5.0<br/></dd>
<dt><b>-d_max</b> \<Real\></dt>
<dd>maximum value of distance used in PDDF score evaluation (in [A])<br/>Default: 100.0<br/></dd>
<dt><b>-d_step</b> \<Real\></dt>
<dd>step of distance used in PDDF score evaluation (in [A])<br/>Default: 0.1<br/></dd>
<dt><b>-q_min</b> \<Real\></dt>
<dd>minimum value of q used in spectra calculations (in [A^-1])<br/>Default: 0.01<br/></dd>
<dt><b>-q_max</b> \<Real\></dt>
<dd>maximum value of q used in spectra calculations (in [A^-1])<br/>Default: 0.25<br/></dd>
<dt><b>-q_step</b> \<Real\></dt>
<dd>step of q used in spectra calculations (in [A^-1])<br/>Default: 0.01<br/></dd>
<dt><b>-fit_pddf_area</b> \<Boolean\></dt>
<dd>PDDF curve for a scored pose will be normalized to match the area under the reference PDDF curve<br/>Default: false<br/></dd>
</dl>
+ <h3>-score:fiber_diffraction</h3>
<dl>
<dt><b>-fiber_diffraction</b> \<Boolean\></dt>
<dd>fiber_diffraction option group<br/></dd>
<dt><b>-layer_lines</b> \<File\></dt>
<dd>reads layer_lines from a file<br/></dd>
<dt><b>-a</b> \<Real\></dt>
<dd>number of subunits per repeat<br/>Default: 0<br/></dd>
<dt><b>-b</b> \<Real\></dt>
<dd>number of turns per repeat<br/>Default: 0<br/></dd>
<dt><b>-p</b> \<Real\></dt>
<dd>subunit rise<br/>Default: 0<br/></dd>
<dt><b>-radius</b> \<Real\></dt>
<dd>helical radius<br/>Default: 0<br/></dd>
<dt><b>-resolution_cutoff_low</b> \<Real\></dt>
<dd>ignore intensity data below this point<br/>Default: 0.05<br/></dd>
<dt><b>-resolution_cutoff_high</b> \<Real\></dt>
<dd>ignore intensity data above this point<br/>Default: 0.5<br/></dd>
<dt><b>-max_bessel_order</b> \<Integer\></dt>
<dd>maximum number of bessel orders used in simulations<br/>Default: 50<br/></dd>
<dt><b>-cn_symmetry</b> \<Integer\></dt>
<dd>cn symmetry at one z level (along fibrilar axis)<br/>Default: 0<br/></dd>
<dt><b>-b_factor</b> \<Real\></dt>
<dd>b_factor value<br/>Default: 20<br/></dd>
<dt><b>-b_factor_solv</b> \<Real\></dt>
<dd>b_factor_solv value<br/>Default: 400<br/></dd>
<dt><b>-b_factor_solv_K</b> \<Real\></dt>
<dd>b_factor_solv_K value<br/>Default: 0.4<br/></dd>
<dt><b>-grid_reso</b> \<Real\></dt>
<dd>resolution for density sampling on the grid<br/>Default: 0.5<br/></dd>
<dt><b>-grid_r</b> \<Integer\></dt>
<dd>number of grid points along r<br/>Default: 256<br/></dd>
<dt><b>-grid_phi</b> \<Integer\></dt>
<dd>number of grid points along phi<br/>Default: 128<br/></dd>
<dt><b>-grid_z</b> \<Integer\></dt>
<dd>number of grid points along z<br/>Default: 256<br/></dd>
<dt><b>-qfht_K1</b> \<Real\></dt>
<dd>value of K1 for Hankel sampling<br/>Default: 2.0<br/></dd>
<dt><b>-qfht_K2</b> \<Real\></dt>
<dd>value of K2 for Hankel sampling<br/>Default: 2.2<br/></dd>
<dt><b>-chi_iterations</b> \<Integer\></dt>
<dd>number of iterations to calculate chi e.g. number of layer lines<br/>Default: 0<br/></dd>
<dt><b>-rfactor_refinement</b> \<Boolean\></dt>
<dd>R-factor refinement<br/>Default: false<br/></dd>
<dt><b>-output_fiber_spectra</b> \<Boolean\></dt>
<dd>Output intensity, reciprocal R, layer line<br/>Default: false<br/></dd>
<dt><b>-gpu_processor</b> \<Integer\></dt>
<dd>GPU processor number - for systems with more than 1<br/>Default: 0<br/></dd>
<dt><b>-centroid_density_mass</b> \<Real\></dt>
<dd>density mass of centroid<br/>Default: 0.0<br/></dd>
</dl>
+ <h3>-score:occ_sol_fitted</h3>
<dl>
<dt><b>-occ_sol_fitted</b> \<Boolean\></dt>
<dd>occ_sol_fitted option group<br/></dd>
<dt><b>-Ntrp_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Ntrp atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-NH2O_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for NH2O atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Nlys_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Nlys atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Narg_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Narg atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Nbb_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Nbb atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Nhis_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Nhis atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-OH_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for OH atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-ONH2_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for ONH2 atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-OOC_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for OOC atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Oaro_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Oaro atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Oet2_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Oet2 atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Oet3_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Oet3 atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-OCbb_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for OCbb atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-HOH_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for HOH atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-OPha_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for OPha atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-OHha_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for OHha atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-OC3_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for OC3 atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-OSi_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for OSi atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
<dt><b>-Oice_amp_scaling</b> \<Real\></dt>
<dd>scaling factor for Oice atoms's amplitude of the gaussian<br/>Default: 1.0<br/></dd>
</dl>
+ <h3>-score:loop_close</h3>
<dl>
<dt><b>-loop_close</b> \<Boolean\></dt>
<dd>loop_close option group<br/></dd>
<dt><b>-loop_fixed_cost</b> \<Real\></dt>
<dd>For loop_close term, a fixed cost of instantiating an end of a Gaussian chain; calibrated based on RNA bulge/loop data<br/>Default: -0.29<br/></dd>
<dt><b>-allow_complex_loop_graph</b> \<Boolean\></dt>
<dd>LoopGraph hack - allow sharing of loops between cycles<br/>Default: true<br/></dd>
<dt><b>-use_6D_potential</b> \<Boolean\></dt>
<dd>for implicit modeling of RNA loops, use 6D potentials instead of simple 1D Gaussian chain model<br/>Default: false<br/></dd>
<dt><b>-force_6D_potential_file</b> \<String\></dt>
<dd>use this 6D potential for all loop_close instead of database files (for testing only!)<br/>Default: ""<br/></dd>
<dt><b>-use_cubic_interp</b> \<Boolean\></dt>
<dd>cubic interpolation for 6D potential, instead of polylinear<br/>Default: true<br/></dd>
</dl>
+ <h2>-multithreading</h2>
<dl>
<dt><b>-multithreading</b> \<Boolean\></dt>
<dd>multithreading option group<br/></dd>
<dt><b>-total_threads</b> \<Integer\></dt>
<dd>The number of threads to launch in the global thread pool.  All thread-parallelized work will be distributed over these threads.<br/>Default: 1<br/></dd>
</dl>
+ <h2>-recon</h2>
<dl>
<dt><b>-recon</b> \<Boolean\></dt>
<dd>recon option group<br/></dd>
<dt><b>-randomize</b> \<Boolean\></dt>
<dd>Randomize order of input poses for RECON MSD<br/>Default: false<br/></dd>
</dl>
+ <h2>-packing</h2>
<dl>
<dt><b>-packing</b> \<Boolean\></dt>
<dd>Packing option group<br/></dd>
<dt><b>-repack_only</b> \<Boolean\></dt>
<dd>Disable design at all positions<br/>Default: false<br/></dd>
<dt><b>-prevent_repacking</b> \<Boolean\></dt>
<dd>Disable repacking (or design) at all positions<br/>Default: false<br/></dd>
<dt><b>-cenrot_cutoff</b> \<Real\></dt>
<dd>Cutoff to generate centroid rotamers<br/>Default: 0.16<br/></dd>
<dt><b>-ignore_ligand_chi</b> \<Boolean\></dt>
<dd>Disable param file chi-angle based rotamer generation in SingleLigandRotamerLibrary<br/>Default: false<br/></dd>
<dt><b>-quasisymmetry</b> \<Boolean\></dt>
<dd>Turn on quasisymmetric packing using when using RotamerLinks<br/>Default: false<br/></dd>
<dt><b>-ndruns</b> \<Integer\></dt>
<dd>Number of fixbb packing iterations.  Each time packing occurs, it will pack this many times and return only the best result.  Implemented at level of PackRotamersMover.<br/>Range: 1-<br/>Default: 1<br/></dd>
<dt><b>-soft_rep_design</b> \<Boolean\></dt>
<dd>Use larger LJ radii for softer potential<br/></dd>
<dt><b>-mainchain_h_rebuild_threshold</b> \<Real\></dt>
<dd>Cutoff for rebuilding mainchain hydrogens during rotamer generation during packing.  If the position of the hydrogen is less than the threshold from its ideal position, it is not rebuilt.  Default 0.75 A.<br/>Default: 0.75<br/></dd>
<dt><b>-use_electrostatic_repulsion</b> \<Boolean\></dt>
<dd>Use electrostatic repulsion<br/></dd>
<dt><b>-dump_rotamer_sets</b> \<Boolean\></dt>
<dd>Output NMR-style PDB's with the rotamer sets used during packing<br/>Default: false<br/></dd>
<dt><b>-dunbrack_prob_buried</b> \<Real\></dt>
<dd>fraction of possible dunbrack rotamers to include in each single residue rotamer set, for 'buried' residues<br/>Range: 0-1<br/>Default: 0.98<br/></dd>
<dt><b>-dunbrack_prob_nonburied</b> \<Real\></dt>
<dd>fraction of possible dunbrack rotamers to include in each single residue rotamer set, for 'nonburied' residues<br/>Range: 0-1<br/>Default: 0.95<br/></dd>
<dt><b>-no_optH</b> \<Boolean\></dt>
<dd>Do not optimize hydrogen placement at the time of a PDB load<br/>Default: true<br/></dd>
<dt><b>-optH_MCA</b> \<Boolean\></dt>
<dd>If running optH, use the Multi-Cool Annealer (more consistent, but slower)<br/>Default: false<br/></dd>
<dt><b>-pack_missing_sidechains</b> \<Boolean\></dt>
<dd>Run packer to fix residues with missing sidechain density at PDB load<br/>Default: true<br/></dd>
<dt><b>-preserve_c_beta</b> \<Boolean\></dt>
<dd>Preserve c-beta positions during rotamer construction<br/></dd>
<dt><b>-flip_HNQ</b> \<Boolean\></dt>
<dd>Consider flipping HIS, ASN, and GLN during hydrogen placement optimization (must turn off -no_optimizeH)<br/></dd>
<dt><b>-fix_his_tautomer</b> \<IntegerVector\></dt>
<dd>seqpos numbers of his residus whose tautomer should be fixed during repacking<br/>Default: []<br/></dd>
<dt><b>-print_pymol_selection</b> \<Boolean\></dt>
<dd>include pymol-style selections when printing a PackerTask<br/>Default: false<br/></dd>
<dt><b>-extrachi_cutoff</b> \<Integer\></dt>
<dd>number of neighbors a residue must have before extra rotamers are used. default: 18<br/>Default: 18<br/></dd>
<dt><b>-resfile</b> \<FileVector\></dt>
<dd>resfile filename(s).  Most protocols use only the first and will ignore the rest; it does not track against -s or -l automatically.<br/>Default: ['"resfile"']<br/></dd>
<dt><b>-sc_branch_rotamers</b> \<Boolean\></dt>
<dd>construct rotamers for conjugated side chains. Warning: results in deformation of the conjugation bond length and angles, so should be followed by some correction<br/>Default: ['false']<br/></dd>
<dt><b>-outeriterations_scaling</b> \<Real\></dt>
<dd>Multiplier for number of outer iterations<br/>Default: 1.0<br/></dd>
<dt><b>-inneriterations_scaling</b> \<Real\></dt>
<dd>Multiplier for number of inner iterations<br/>Default: 1.0<br/></dd>
<dt><b>-adducts</b> \<StringVector\></dt>
<dd>Gives list of adduct names to generate for residue 			definitions.  Each adduct name may be followed by an 			optional integer, which gives a maximum number of adducts 			of that type which will be generated.<br/></dd>
<dt><b>-use_input_sc</b> \<Boolean\></dt>
<dd>Use rotamers from input structure in packing 			By default, input sidechain coords are NOT 			included in rotamer set but are discarded 			before the initial pack; with this flag, the 			the input rotamers will NOT be discarded. 			Note that once the starting rotamers are 			replaced by any mechanism, they are no longer 			included in the rotamer set 			(rotamers included by coordinates)<br/></dd>
<dt><b>-unboundrot</b> \<FileVector\></dt>
<dd>Read 'native' rotamers from supplied PDB(s).  			Unlike -use_input_sc, these rotamers will not be lost during repacks.  			This option requires specific support from the protocol;  			it is NOT built in to PackerTask.initialize_from_command_line()<br/></dd>
<dt><b>-max_rotbump_energy</b> \<Real\></dt>
<dd>discard rotamers with poor interactions with the background using  				the specified cutoff.  Values must be in the range of 0 to 5.0.<br/>Default: 5.0<br/></dd>
<dt><b>-lazy_ig</b> \<Boolean\></dt>
<dd>Force the packer to always allocate pair energy storage but procrastinate 				energy caclulation until each RPE is needed; each RPE is 				computed at most once. Memory use is quadratic in rotamers per residue. 				The InteractionGraphFactory will prefer the linear-memory interaction graph 				to the Lazy Interaction graph, so specifying both linmem_ig and lazy_ig results 				in the use of the linear-memory interaction graph.  The Surface-series IGs 				(surface weight in scorefunction is nonzero) also overrides this IG.<br/>Default: false<br/></dd>
<dt><b>-double_lazy_ig</b> \<Boolean\></dt>
<dd>Force the packer to always procrastinate allocation AND energy caclulation 				until each RPE is needed; each RPE is computed at most once. 				The InteractionGraphFactory will prefer the linear-memory interaction graph 				to the DoubleLazy Interaction graph, so specifying both linmem_ig and lazy_ig results 				in the use of the linear-memory interaction graph.  The Surface-series IGs (surface 				weight in scorefunction is nonzero) also overrides this IG.<br/>Default: false<br/></dd>
<dt><b>-linmem_ig</b> \<Integer\></dt>
<dd>Force the packer to use the linear memory interaction graph; each 				RPE may be computed more than once, but recently-computed RPEs 				are reused.  The integer parameter specifies the number 				of recent rotamers to store RPEs for.  10 is the recommended size. 				Memory use scales linearly with the number of 				rotamers at about 200 bytes per rotamer per recent rotamers to 				store RPEs for (~4 KB per rotamer by default)<br/>Default: 10<br/></dd>
<dt><b>-multi_cool_annealer</b> \<Integer\></dt>
<dd>Alternate annealer for packing.  Runs multiple quence cycles in a first cooling stage, and tracks 			the N best network states it observes.  It then runs low-temperature rotamer substitutions with repeated 			quenching starting from each of these N best network states.  10 is recommended.<br/></dd>
<dt><b>-minpack_temp_schedule</b> \<RealVector\></dt>
<dd>Alternate annealing schedule for min_pack.<br/></dd>
<dt><b>-minpack_inner_iteration_scale</b> \<Integer\></dt>
<dd>The number of inner iterations per rotamer to run at each temperature in min pack.<br/></dd>
<dt><b>-minpack_disable_bumpcheck</b> \<Boolean\></dt>
<dd>Disable bump check in min pack (i.e. include rotamers that collide with the background.<br/></dd>
</dl>
+ <h3>-packing:ex1</h3>
<dl>
<dt><b>-ex1</b> \<Boolean\></dt>
<dd>use extra chi1 sub-rotamers for all residues that pass the extrachi_cutoff<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi1 sub-rotamers for all residues that pass the extrachi_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
<dt><b>-operate</b> \<Boolean\></dt>
<dd>apply special operations (see RotamerOperation class) on ex1 rotamers<br/></dd>
</dl>
+ <h3>-packing:ex2</h3>
<dl>
<dt><b>-ex2</b> \<Boolean\></dt>
<dd>use extra chi2 sub-rotamers for all residues that pass the extrachi_cutoff<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi2 sub-rotamers for all residues that pass the extrachi_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
<dt><b>-operate</b> \<Boolean\></dt>
<dd>apply special operations (see RotamerOperation class) on ex2 rotamers<br/></dd>
</dl>
+ <h3>-packing:ex3</h3>
<dl>
<dt><b>-ex3</b> \<Boolean\></dt>
<dd>use extra chi1 sub-rotamers for all residues that pass the extrachi_cutoff<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi3 sub-rotamers for all residues that pass the extrachi_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
<dt><b>-operate</b> \<Boolean\></dt>
<dd>apply special operations (see RotamerOperation class) on ex3 rotamers<br/></dd>
</dl>
+ <h3>-packing:ex4</h3>
<dl>
<dt><b>-ex4</b> \<Boolean\></dt>
<dd>use extra chi1 sub-rotamers for all residues that pass the extrachi_cutoff<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi4 sub-rotamers for all residues that pass the extrachi_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
<dt><b>-operate</b> \<Boolean\></dt>
<dd>apply special operations (see RotamerOperation class) on ex4 rotamers<br/></dd>
</dl>
+ <h3>-packing:ex1aro</h3>
<dl>
<dt><b>-ex1aro</b> \<Boolean\></dt>
<dd>use extra chi1 sub-rotamers for aromatic residues that pass the extrachi_cutoff<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi1 sub-rotamers for all residues that pass the extrachi_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
</dl>
+ <h3>-packing:ex2aro</h3>
<dl>
<dt><b>-ex2aro</b> \<Boolean\></dt>
<dd>use extra chi1 sub-rotamers for aromatic residues that pass the extrachi_cutoff<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi2 sub-rotamers for all residues that pass the extrachi_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
</dl>
+ <h3>-packing:ex1aro_exposed</h3>
<dl>
<dt><b>-ex1aro_exposed</b> \<Boolean\></dt>
<dd>use extra chi1 sub-rotamers for all aromatic residues<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi1 sub-rotamers for all aromatic residues The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
</dl>
+ <h3>-packing:ex2aro_exposed</h3>
<dl>
<dt><b>-ex2aro_exposed</b> \<Boolean\></dt>
<dd>use extra chi2 sub-rotamers for all aromatic residues<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>use extra chi2 sub-rotamers for all aromatic residues The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO_EXTRA_CHI_SAMPLES          0          original dihedral only; same as using no flag at all EX_ONE_STDDEV                 1 Default  +/- one standard deviation (sd); 3 samples EX_ONE_HALF_STEP_STDDEV       2          +/- 0.5 sd; 3 samples EX_TWO_FULL_STEP_STDDEVS      3          +/- 1 & 2 sd; 5 samples EX_TWO_HALF_STEP_STDDEVS      4          +/- 0.5 & 1 sd; 5 samples EX_FOUR_HALF_STEP_STDDEVS     5          +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX_THREE_THIRD_STEP_STDDEVS   6          +/- 0.33, 0.67, 1 sd; 7 samples EX_SIX_QUARTER_STEP_STDDEVS   7          +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples<br/>Default: 1<br/></dd>
</dl>
+ <h3>-packing:exdna</h3>
<dl>
<dt><b>-exdna</b> \<Boolean\></dt>
<dd>use extra dna rotamers<br/></dd>
<dt><b>-level</b> \<Integer\></dt>
<dd>extra dna rotamer sample level -- rotbuilder converts from 0-7 to number<br/>Default: 1<br/></dd>
</dl>
+ <h3>-packing:packer_palette</h3>
<dl>
<dt><b>-packer_palette</b> \<Boolean\></dt>
<dd>packer_palette option group<br/></dd>
<dt><b>-extra_base_type_file</b> \<File\></dt>
<dd>PackerPalettes define the set of residue types with which one is designing, and TaskOperations allow types to be turned off at specific positinos.  The default PackerPalette includes the twenty canonical amino acids.  If this option is used to provide a file containing a whitespace-separated list of residue type names, the default PackerPalette will include these additional residue types.<br/></dd>
<dt><b>-NCAA_expanded</b> \<Boolean\></dt>
<dd>Design positions like beta-AAs, oligoureas, and polyaramids with a default set of options<br/></dd>
</dl>
+ <h2>-archive</h2>
<dl>
<dt><b>-archive</b> \<Boolean\></dt>
<dd>archive option group<br/></dd>
<dt><b>-reread_all_structures</b> \<Boolean\></dt>
<dd>ignore pool file... reread from batches<br/>Default: false<br/></dd>
<dt><b>-completion_notify_frequency</b> \<Integer\></dt>
<dd>tell Archive every X completed decoys<br/>Default: 100<br/></dd>
</dl>
+ <h2>-carbohydrates</h2>
<dl>
<dt><b>-carbohydrates</b> \<Boolean\></dt>
<dd>carbohydrates option group<br/></dd>
<dt><b>-glycam_pdb_format</b> \<Boolean\></dt>
<dd>Indicates that the input PDB files were generated by GLYCAM and thus join any HO- or RO- \"residues\" to the following one since Rosetta is smart enough to patch reducing ends.  The default value is false.<br/>Default: false<br/></dd>
<dt><b>-linkage_conformer_data_file</b> \<String\></dt>
<dd>Specify the file where glycosidic linkage conformer torsion angle statistical data is stored.  The default directory is database/chemical/carbohydrates/linkage_conformers/but any path can be provided.  The default filename is default.table<br/>Default: "default.table"<br/></dd>
</dl>
+ <h3>-carbohydrates:glycan_sampler</h3>
<dl>
<dt><b>-glycan_sampler</b> \<Boolean\></dt>
<dd>glycan_sampler option group<br/></dd>
<dt><b>-glycan_sampler_test</b> \<Boolean\></dt>
<dd>Indicates to go into testing mode for Glycan Relax.  Will try all torsions in a given PDB in a linear fashion<br/>Default: false<br/></dd>
<dt><b>-glycan_sampler_rounds</b> \<Integer\></dt>
<dd>Number of rounds to use for Glycan Relax. Total rounds is this # times number of glycan residues in movemap<br/>Default: 25<br/></dd>
<dt><b>-min_rings</b> \<Boolean\></dt>
<dd>Minimize Carbohydrate Rings during minimization?  Otherwise, we keep them at their input values (which is recommended).<br/>Default: false<br/></dd>
<dt><b>-pack_glycans</b> \<Boolean\></dt>
<dd>Pack Glycan OH groups during Glycan Relax. Currently time consuming<br/>Default: false<br/></dd>
<dt><b>-final_min_glycans</b> \<Boolean\></dt>
<dd>Do a final minimization of glycans after glycan relax protocol?<br/>Default: true<br/></dd>
<dt><b>-glycan_sampler_movie</b> \<Boolean\></dt>
<dd>Make a movie of accepts and trials (send to pymol)<br/>Default: false<br/></dd>
<dt><b>-glycan_sampler_kt</b> \<Real\></dt>
<dd>KT for GlycanRelaxMover<br/>Default: 2.0<br/></dd>
<dt><b>-glycan_sampler_refine</b> \<Boolean\></dt>
<dd>Set the protocol to not start from a random conformation, and instead refine the structure.<br/>Default: false<br/></dd>
<dt><b>-cartmin</b> \<Boolean\></dt>
<dd>Use Cartesian-space minimization instead of dihedral<br/>Default: false<br/></dd>
<dt><b>-tree_based_min_pack</b> \<Boolean\></dt>
<dd>Use a random-tree based method to minimize and pack instead of minimizing and packing all of them during the randommover selection. This makes the speed of the algorithm mostly-linear with the addition of more glycans, and wastes less time packing and minimizing<br/>Default: true<br/></dd>
<dt><b>-population_based_conformer_sampling</b> \<Boolean\></dt>
<dd>Use the populations of the conformers as probabilities during our linkage conformer sampling.  This makes it harder to overcome energy barriers with more-rare conformers<br/>Default: false<br/></dd>
<dt><b>-use_gaussian_sampling</b> \<Boolean\></dt>
<dd>Set whether to build conformer torsions using a gaussian of the angle or through uniform sampling up to 1 SD (default)<br/>Default: false<br/></dd>
</dl>
+ <h3>-carbohydrates:clash_check</h3>
<dl>
<dt><b>-clash_check</b> \<Boolean\></dt>
<dd>clash_check option group<br/></dd>
<dt><b>-glycan_branches</b> \<StringVector\></dt>
<dd>Required. Vector of glycan branches.  Rosetta Residue numbering or PDB like RosettaScripts<br/></dd>
<dt><b>-check_chains</b> \<StringVector\></dt>
<dd>Required. A list of chains to compute chain-based clashes.  If not given, will only compute glycan-glycan clashes!<br/></dd>
<dt><b>-soft_clash</b> \<Real\></dt>
<dd>When we calculate atom-atom distances using VDW, clash if distance < (atomI_vdw + atomJ_vdw)*(1 - soft_clash)<br/>Default: 0.33<br/></dd>
<dt><b>-cb_clash_distance</b> \<Real\></dt>
<dd>NOT CURRENTLY USED. Distance for CB distance clash check. Residue is clashing if at least 1 atom is less than this distance<br/></dd>
<dt><b>-ignore_hydrogens</b> \<Boolean\></dt>
<dd>Should we calculate only heavy-heavy atom clashes?<br/>Default: false<br/></dd>
<dt><b>-ignore_full_res_output</b> \<Boolean\></dt>
<dd>Should we output each glycan residue clash information in scorefile?  Ignoring will make scorefile a bit smaller.<br/>Default: false<br/></dd>
<dt><b>-output_per_glycan_data</b> \<Boolean\></dt>
<dd>Should we output per glycan branch data?  Easy to compute later on if full res output is on. <br/>Default: false<br/></dd>
</dl>
+ <h2>-rings</h2>
<dl>
<dt><b>-rings</b> \<Boolean\></dt>
<dd>rings option group<br/></dd>
<dt><b>-ring_conformer_dbpath</b> \<File\></dt>
<dd>Path to ring conformers in the Rosetta DB<br/>Default: "chemical/ring_conformer_sets"<br/></dd>
<dt><b>-lock_rings</b> \<Boolean\></dt>
<dd>Sets whether or not alternative ring conformations will be sampled by the protocol, (e.g, ring flips or puckering).  Only low-energy conformers will be sampled, if known.  Otherwise, all ideal ring conformers will be sampled.  The default value is false.<br/>Default: false<br/></dd>
<dt><b>-idealize_rings</b> \<Boolean\></dt>
<dd>Sets whether or not the ring conformations of input poses are idealized (set to the lowest-energy ring conformer, according to the toplogy file for that residue).  The default is false: the input ring conformations will be used.<br/>Default: false<br/></dd>
<dt><b>-sample_high_energy_conformers</b> \<Boolean\></dt>
<dd>Sets whether or not even ring conformations that are energy energy maxima will be sampled by the protocol.  The default value is false; however, if the low energy ring conformers are not listed in the topology files, all ideal ring conformers will be sampled anyway.<br/>Default: false<br/></dd>
</dl>
+ <h2>-chemical</h2>
<dl>
<dt><b>-chemical</b> \<Boolean\></dt>
<dd>chemical option group<br/></dd>
<dt><b>-exclude_patches</b> \<StringVector\></dt>
<dd>Names of the residue-type-set patches which should not be applied; if you know which patches you do not need for a particular run, this flag can reduce your memory use<br/></dd>
<dt><b>-include_patches</b> \<StringVector\></dt>
<dd>Names of the residue-type-set patches which should be applied even if excluded/commented out in patches.txt; useful for testing non-default patches<br/></dd>
<dt><b>-add_atom_type_set_parameters</b> \<StringVector\></dt>
<dd>Additional AtomTypeSet extra-parameter files that should be read; format is a sequence of paired strings: <atom-type-set-tag1> <filename1> <atom-type-set-tag2> <filename2> ...<br/></dd>
<dt><b>-set_atom_properties</b> \<StringVector\></dt>
<dd>Modify atom properties (the ones in <atom-set>/atom_properties.txt) from the command line. Happens at time of AtomTypeSet creation inside ChemicalManager.cc. Format is: -chemical:set_atom_properties <atom-set1>:<atom_name1>:<param1>:<setting1> <atom-set2>:<atom2>:<param2>:<setting2> ... For example: '-chemical:set_atom_properties fa_standard:OOC:LK_DGFREE:-5 fa_standard:ONH2:LJ_RADIUS:0.5' <br/></dd>
<dt><b>-patch_selectors</b> \<StringVector\></dt>
<dd>allow patch files that have CMDLINE_SELECTOR tags can be switched on with this option<br/>Default: []<br/></dd>
<dt><b>-override_rsd_type_limit</b> \<Boolean\></dt>
<dd>over-ride cap on number of residue types.<br/>Default: false<br/></dd>
<dt><b>-clone_atom_types</b> \<StringVector\></dt>
<dd>Optionally clone atom types; copies all properties, which can then be diverged via -set_atom_properties. -clone_atom_types format should be:: -clone_atom_types <set1>:<atomname1>:<cloned-atomname1> <set2>:<atomname2>:<cloned-atomname2> ...; for example: '-chemical:clone_atom_types fa_standard:OOC:OOC2' <br/></dd>
<dt><b>-reassign_atom_types</b> \<StringVector\></dt>
<dd>Switch the atomtype assignments for atoms in specified residue types. Useful along with -clone_atom_types. -reassign_atom_types format should be:: -reassign_atom_types <rsd-type-set1-name>:<rsd-type1-name>:<atom-type1-name>:<new-atom-type1-name>   <rsd-type-set2-name>:<rsd-type2-name>:<atom-type2-name>:<new-atom-type2-name> ...; for example: '-chemical:reassign_atom_types fa_standard:ARG:NE:NtpR' <br/></dd>
<dt><b>-reassign_icoor</b> \<StringVector\></dt>
<dd>Update icoor parameters for specified atom types. -reassign_icoor format should be:: -reassign_icoor <rsd-type-set1-name>:<rsd-type1-name>:<atom1-name>:<the-six-icoor-params-as-a-comma-separated-list>   <rsd-type-set2-name>:<rsd-type2-name>:<atom2-name>:<icoorparams2> ...; for example: -chemical:reassign_icoor fa_standard:ADE:UPPER:-180,60,1.6,O3',C3',C4' <br/></dd>
<dt><b>-set_atomic_charge</b> \<StringVector\></dt>
<dd>Modify atomic charge from the command line. Happens at time of params file reading, so changes will propagate to patched versions of the residue type. Format is: -chemical:set_atomic_charge <rsd-type-set1-name>:<rsd-type1-name>:<atom1-name>:<new-charge> <rsd-type-set2-name>:<rsd-type2-name>:<atom2-name>:<new-charge>  ... For example: '-chemical:set_atomic_charge fa_standard:ARG:NE:-1' <br/></dd>
<dt><b>-set_patch_atomic_charge</b> \<StringVector\></dt>
<dd>Modify patch atomic charge from the command line. Happens at time of patch file reading, so changes will propagate to patched versions of the residue type.  Uses a simplified version of the residue selector so will probably not work for patches with complex selector logic.   format should be::  -chemical:set_patch_atomic_charge <rsd-type-set1-name>:<rsd-type1-name>:<patch-name>:<atom1-name>:<new-charge> ... For example: '-chemical:set_atomic_charge fa_standard:PRO:NtermProteinFull:1H:-1' <br/></dd>
<dt><b>-enlarge_H_lj</b> \<Boolean\></dt>
<dd>Use larger LJ_WDEPTH for Hs to avoid RNA clashes<br/>Default: false<br/></dd>
<dt><b>-no_hbonds_to_ether_oxygens</b> \<Boolean\></dt>
<dd>no H-bonds to nucleic acid ether oxygens O3', O4', O5' -- deprecated<br/>Default: false<br/></dd>
<dt><b>-unset_acceptor_ether_oxygens</b> \<Boolean\></dt>
<dd>nucleic acid ether oxygens O3', O4', O5' are not counted as acceptors<br/>Default: false<br/></dd>
</dl>
+ <h2>-constraints</h2>
<dl>
<dt><b>-constraints</b> \<Boolean\></dt>
<dd>constraints option group<br/></dd>
<dt><b>-exit_on_bad_read</b> \<Boolean\></dt>
<dd>exit if error is encountered reading constraints<br/>Default: true<br/></dd>
<dt><b>-cst_file</b> \<StringVector\></dt>
<dd>constraints filename(s) (for proteins, applied in centroid mode; when multiple files are given a *random* one will be picked).<br/></dd>
<dt><b>-cst_weight</b> \<Real\></dt>
<dd>No description<br/>Default: 1.0<br/></dd>
<dt><b>-max_cst_dist</b> \<Real\></dt>
<dd>No description<br/>Default: 12.0<br/></dd>
<dt><b>-cst_fa_file</b> \<StringVector\></dt>
<dd>constraints filename(s) for fullatom. When multiple files are given a *random* one will be picked.<br/></dd>
<dt><b>-cst_fa_weight</b> \<Real\></dt>
<dd>No description<br/>Default: 1.0<br/></dd>
<dt><b>-normalize_mixture_func</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-penalize_mixture_func</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-forest_file</b> \<File\></dt>
<dd>file with constraintforest<br/>Default: ""<br/></dd>
<dt><b>-compute_total_dist_cst</b> \<Boolean\></dt>
<dd>only relevant for debug: atom_pair_constraints during abinito depends on seq_sep, this computes also the score without regarding seq_sep<br/>Default: false<br/></dd>
<dt><b>-cull_with_native</b> \<Integer\></dt>
<dd>if option is set all constraints that violate the native structure with more than X are thrown out! <br/>Default: 1<br/></dd>
<dt><b>-dump_cst_set</b> \<File\></dt>
<dd>dump the cstset_ to file <br/>Default: ""<br/></dd>
<dt><b>-evaluate_max_seq_sep</b> \<IntegerVector\></dt>
<dd>evaluate constraints to this seq-sep [vector]<br/>Default: 0<br/></dd>
<dt><b>-named</b> \<Boolean\></dt>
<dd>enable named constraints to avoid problems with changing residue-types e.g., cutpoint-variants<br/>Default: false<br/></dd>
<dt><b>-no_cst_in_relax</b> \<Boolean\></dt>
<dd>remove constraints for relax<br/>Default: false<br/></dd>
<dt><b>-no_linearize_bounded</b> \<Boolean\></dt>
<dd>dont switch to linearized in BOUNDED func<br/>Default: false<br/></dd>
<dt><b>-pocket_constraint_weight</b> \<Real\></dt>
<dd>Weight of the Pocket Constraint<br/>Default: 0<br/></dd>
<dt><b>-pocket_zero_derivatives</b> \<Boolean\></dt>
<dd>Return zero for PocketConstaint derivatives<br/>Default: false<br/></dd>
<dt><b>-viol</b> \<Boolean\></dt>
<dd>show violations<br/>Default: false<br/></dd>
<dt><b>-viol_level</b> \<Integer\></dt>
<dd>how much detail for violation output<br/>Default: 1<br/></dd>
<dt><b>-viol_type</b> \<String\></dt>
<dd>work only on these types of constraints<br/>Default: ""<br/></dd>
<dt><b>-sog_cst_param</b> \<Real\></dt>
<dd>weight parameter for SOGFunc constraints<br/>Default: 0.0<br/></dd>
<dt><b>-sog_upper_bound</b> \<Real\></dt>
<dd>Upper cutoff for SOGFunc constraints<br/>Default: 10.0<br/></dd>
<dt><b>-epr_distance</b> \<Boolean\></dt>
<dd>use epr distance potential<br/>Default: false<br/></dd>
<dt><b>-combine</b> \<Integer\></dt>
<dd>combine constraints randomly into OR connected groups (Ambiguous). N->1<br/>Default: 1<br/></dd>
<dt><b>-combine_exclude_region</b> \<File\></dt>
<dd>core-defintion file do not combine constraints that are core-core<br/></dd>
<dt><b>-skip_redundant</b> \<Boolean\></dt>
<dd>skip redundant constraints<br/>Default: false<br/></dd>
<dt><b>-skip_redundant_width</b> \<Integer\></dt>
<dd>radius of influence for redundant constraints<br/>Default: 2<br/></dd>
<dt><b>-force_pdb_info_mapping</b> \<BooleanVector\></dt>
<dd>force PDB info mapping for residues in cst file, using " " as default chain.<br/>Default: []<br/></dd>
</dl>
+ <h2>-corrections</h2>
<dl>
<dt><b>-corrections</b> \<Boolean\></dt>
<dd>corrections option group<br/></dd>
<dt><b>-beta</b> \<Boolean\></dt>
<dd>Use the most-recent (curr Apr 2018) beta score function<br/>Default: false<br/></dd>
<dt><b>-beta_cart</b> \<Boolean\></dt>
<dd>Use the most-recent (curr Apr 2018) beta score function for nonideal optimization<br/>Default: false<br/></dd>
<dt><b>-beta_nov16</b> \<Boolean\></dt>
<dd>Use the November 2015 beta score function<br/>Default: false<br/></dd>
<dt><b>-beta_nov16_cart</b> \<Boolean\></dt>
<dd>Use the November 2015 beta score function for nonideal optimization<br/>Default: false<br/></dd>
<dt><b>-beta_july15</b> \<Boolean\></dt>
<dd>Use the July 2015 beta  score function<br/>Default: false<br/></dd>
<dt><b>-beta_july15_cart</b> \<Boolean\></dt>
<dd>Use the July 2015 beta score function for nonideal optimization<br/>Default: false<br/></dd>
<dt><b>-gen_potential</b> \<Boolean\></dt>
<dd>Use the April 2018 genralized potential<br/>Default: false<br/></dd>
<dt><b>-newdna</b> \<Boolean\></dt>
<dd>Apply some dna-specific mods to chemical/scoring (for testing)<br/>Default: false<br/></dd>
<dt><b>-restore_talaris_behavior</b> \<Boolean\></dt>
<dd>Use talaris score function and residue_type_set<br/>Default: false<br/></dd>
<dt><b>-correct</b> \<Boolean\></dt>
<dd>turn on default corrections:See src/core/init/score_function_corrections.cc.  Note that this is a flag for the older score12 scorefunction, which should NOT be used with talaris2013, talaris2014, ref2015, or the beta scorefunctions.<br/>Default: false<br/></dd>
<dt><b>-hbond_sp2_correction</b> \<Boolean\></dt>
<dd>turn on the hbond Sp2 correction with a single flag use with sp2_correction.wts. Note, these weight sets are chosen automatically by default. -score::hb_sp2_chipen -hb_sp2_BAH180_rise 0.75 -hb_sp2_outer_width 0.357 -hb_fade_energy -hbond_measure_sp3acc_BAH_from_hvy -lj_hbond_hdis 1.75 -lj_hbond_OH_donor_dis 2.6 -hbond_params sp2_elec_params -expand_st_chi2sampling -smooth_fa_elec -elec_min_dis 1.6 -elec_r_option false -chemical::set_atom_properties fa_standard:ONH2:LK_DGFREE:-5.85 fa_standard:NH2O:LK_DGFREE:-7.8 fa_standard:Narg:LK_DGFREE:-10.0 fa_standard:OH:LK_DGFREE:-6.70<br/></dd>
<dt><b>-facts_default</b> \<Boolean\></dt>
<dd>turn on default options for FACTS use with scorefacts.wts. Incompatible with hbond_sp2_correction option. -correct -lj_hbond_hdis 2.3 -lj_hbond_OH_donor_dis 3.4 -use_bicubic_interpolation  -hbond_params sp2_elec_params -hb_sp2_chipen  -hbond_measure_sp3acc_BAH_from_hby -facts_GBpair_cut 10.0 -facts_min_dis 1.5 -facts_dshift 1.4 -facts_die 1.0 -facts_kappa 12.0 -facts_asp_patch 3 -facts_intrares_scale 0.4 -facts_elec_sh_exponent 1.8<br/>Default: false<br/></dd>
</dl>
+ <h3>-corrections:score</h3>
<dl>
<dt><b>-score</b> \<Boolean\></dt>
<dd>score option group<br/></dd>
<dt><b>-bbdep_omega</b> \<Boolean\></dt>
<dd>Enable phi-psi dependent omega<br/>Default: true<br/></dd>
<dt><b>-bbdep_bond_params</b> \<Boolean\></dt>
<dd>Enable phi-psi dependent bondlengths and bondangles<br/></dd>
<dt><b>-bbdep_bond_devs</b> \<Boolean\></dt>
<dd>Enable phi-psi dependent deviations for bondlengths and bondangles<br/></dd>
<dt><b>-fa_dun_canonicals_use_voronoi</b> \<Boolean\></dt>
<dd>If true, then canonical amino acids use Voronoi-style detection of neareset rotamer wells during fa_dun scoring instead of hard-coded rotamer well definitions.  False by default (i.e. hard-coded definitions are used by defaults).<br/>Default: false<br/></dd>
<dt><b>-fa_dun_noncanonicals_use_voronoi</b> \<Boolean\></dt>
<dd>If true, then noncanonical amino acids and other polymer building blocks use Voronoi-style detection of neareset rotamer wells during fa_dun scoring instead of hard-coded rotamer well definitions.  True by default (i.e. Voronoi-style detection is used by default).  Setting this to false creates problems with many noncanonicals that have rotamer wells that aren't simple gauche+/gauche-/anti wells.<br/>Default: true<br/></dd>
<dt><b>-fa_dun_correct_rotamer_well_order</b> \<Boolean\></dt>
<dd>If true, the rotamer well order for rotamer files is corrected automatically to the Rosetta convention of lowest to highest in the range [0,360).  False by default.<br/>Default: false<br/></dd>
<dt><b>-fa_dun_correct_achiral_peptoid_libraries</b> \<Boolean\></dt>
<dd>If true, the rotamer libraries for peptoids with achiral side-chains are symmetrized (so that mirror-image conformatoins score identically).  Rotamer library generation can produce slight asymmetries, so this is an easy way around that problem.  True by default.<br/>Default: true<br/></dd>
<dt><b>-no_his_his_pairE</b> \<Boolean\></dt>
<dd>Set pair term for His-His to zero<br/></dd>
<dt><b>-no_his_DE_pairE</b> \<Boolean\></dt>
<dd>Set pair term for His-Glu and His-Asp to zero<br/></dd>
<dt><b>-p_aa_pp</b> \<String\></dt>
<dd>Name of scoring/score_functions/P_AA_pp/P_AA_PP potential file (search in the local directory first, then look in the database)<br/>Default: "scoring/score_functions/P_AA_pp/P_AA_pp"<br/></dd>
<dt><b>-p_aa_pp_nogridshift</b> \<Boolean\></dt>
<dd>the format of p_aa_pp changed from using i*10+5 (5, 15, etc) to i*10 (0,10,etc.) as grid points<br/></dd>
<dt><b>-rama_not_squared</b> \<Boolean\></dt>
<dd>Rama potential calculated as input for both rama and rama2b. By default, the potential is square for (ram a+entropy) > 1.0<br/></dd>
<dt><b>-rama_map</b> \<File\></dt>
<dd>Ramachandran file used by rama<br/>Default: "scoring/score_functions/rama/Rama_smooth_dyn.dat_ss_6.4"<br/></dd>
<dt><b>-rama_pp_map</b> \<File\></dt>
<dd>Ramachandran dir used by rama_prepro<br/>Default: "scoring/score_functions/rama/fd"<br/></dd>
<dt><b>-rama_map_average_L_flat</b> \<File\></dt>
<dd>Ramachandran map that's the average of all canonical L amino acids, flattened to give equal probability to the allowed region.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/avg_L_rama.dat"<br/></dd>
<dt><b>-rama_map_sym_average_L_flat</b> \<File\></dt>
<dd>Ramachandran map that's the average of all canonical L amino acids, flattened to give equal probability to the allowed region, and symmetrized.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/sym_all_rama.dat"<br/></dd>
<dt><b>-rama_map_sym_gly_flat</b> \<File\></dt>
<dd>Ramachandran map for glycine, flattened to give equal probability to the allowed region and symmetrized.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/sym_G_rama.dat"<br/></dd>
<dt><b>-rama_map_sym_pro_flat</b> \<File\></dt>
<dd>Ramachandran map for proline, flattened to give equal probability to the allowed region and symmetrized.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/sym_P_rama.dat"<br/></dd>
<dt><b>-rama_map_average_L_flat_stringent</b> \<File\></dt>
<dd>Ramachandran map that's the average of all canonical L amino acids, flattened to give equal probability to the allowed region, with the allowed region selected with high stringency.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/avg_L_rama_str.dat"<br/></dd>
<dt><b>-rama_map_sym_average_L_flat_stringent</b> \<File\></dt>
<dd>Ramachandran map that's the average of all canonical L amino acids, flattened to give equal probability to the allowed region, with the allowed region selected with high stringency, and symmetrized.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/sym_all_rama_str.dat"<br/></dd>
<dt><b>-rama_map_sym_gly_flat_stringent</b> \<File\></dt>
<dd>Ramachandran map for glycine, flattened to give equal probability to the allowed region, with the allowed region selected with high stringency, and symmetrized.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/sym_G_rama_str.dat"<br/></dd>
<dt><b>-rama_map_sym_pro_flat_stringent</b> \<File\></dt>
<dd>Ramachandran map for proline, flattened to give equal probability to the allowed region, with the allowed region selected with high stringency, and symmetrized.  Lazily loaded; for sampling only.<br/>Default: "scoring/score_functions/rama/flat/sym_P_rama_str.dat"<br/></dd>
<dt><b>-rama_prepro_steep</b> \<Boolean\></dt>
<dd>Use steep rama_prepro library<br/>Default: false<br/></dd>
<dt><b>-rama_prepro_nobidentate</b> \<Boolean\></dt>
<dd>Use rama_prepro library derived by excluding bidentate Hbonding loop residues<br/>Default: false<br/></dd>
<dt><b>-cenrot</b> \<Boolean\></dt>
<dd>Use the Centroid Rotamer Model.<br/>Default: false<br/></dd>
<dt><b>-dun10</b> \<Boolean\></dt>
<dd>Use the 2010 Dunbrack library instead of either the the 2002 library.<br/>Default: true<br/></dd>
<dt><b>-dun10_dir</b> \<String\></dt>
<dd>Name of dun10 dir<br/>Default: "rotamer/ExtendedOpt1-5"<br/></dd>
<dt><b>-dun02_file</b> \<String\></dt>
<dd>Name of dun02 input file<br/>Default: "rotamer/bbdep02.May.sortlib"<br/></dd>
<dt><b>-ch_o_bond_potential</b> \<String\></dt>
<dd>Name of ch_o_bond potential file (search in the local directory first, then look in the database)<br/>Default: "scoring/score_functions/carbon_hbond/ch_o_bond_potential.dat"<br/></dd>
<dt><b>-lj_hbond_hdis</b> \<Real\></dt>
<dd>Lennard Jones sigma value for hatms, classically it's been at 1.95 but the average A-H distance for hydrogen bonding is 1.75 from crystal structures. (momeara)<br/>Default: 1.75<br/></dd>
<dt><b>-lj_hbond_OH_donor_dis</b> \<Real\></dt>
<dd>Lennard Jones sigma value for O in OH donor groups.  Classically it has been 3.0 but the average distances from crystal structurs is 2.6 (momeara)<br/>Default: 2.6<br/></dd>
<dt><b>-score12prime</b> \<Boolean\></dt>
<dd>Restore to score funciton parameters to score12 parameters and have getScoreFuntion return with score12prime.wts. The score12prime.wts differs from standard.wts + score12.wts_patch, in that the reference energies have been optimized with optE for sequence profile recovery<br/>Default: false<br/></dd>
<dt><b>-hbond_energy_shift</b> \<Real\></dt>
<dd>The shift upwards (through addition) of the well depth for the hydrogen bond polynomials; this shift is applied before the weights are applied.<br/>Default: 0.0<br/></dd>
<dt><b>-hb_sp2_BAH180_rise</b> \<Real\></dt>
<dd>The rise from -0.5 for the BAH=180 value for the additive chi/BAH sp2 potential<br/>Default: 0.75<br/></dd>
<dt><b>-hb_sp2_outer_width</b> \<Real\></dt>
<dd>The width between the peak when CHI=0 and BAH=120 to when the BAH is at a maximum (Units: pi * radians. E.g. 1/3 means the turn off hbonding when BAH < 60, larger values mean a wider potential). Use 0.357 in conjunction with the hb_energy_fade flag.<br/>Default: 0.357<br/></dd>
<dt><b>-hb_sp2_chipen</b> \<Boolean\></dt>
<dd>Experimental term for hydrogen bonds to sp2 acceptors: penalizes out-of-plane geometry by 67%<br/>Default: true<br/></dd>
<dt><b>-hbond_measure_sp3acc_BAH_from_hvy</b> \<Boolean\></dt>
<dd>If true, then the BAH angle for sp3 (aka hydroxyl) acceptors is measured donor-hydrogen--acceptor-heavyatom--heavyatom-base instead of donor-hydrogen--accptor-heavyatom--hydroxyl-hydrogen<br/>Default: true<br/></dd>
<dt><b>-hb_fade_energy</b> \<Boolean\></dt>
<dd>Rather than having a strict cutoff of hbond definition at 0, fade the energy smoothly in the range [-0.1, 0.1]. This is necessary to prevent a discontinuity in the derivative when E=0 that arise because of the additive form of the hbond function.<br/>Default: true<br/></dd>
<dt><b>-hb_exclude_ether_oxygens</b> \<Boolean\></dt>
<dd>no H-bonds to nucleic acid ether oxygens O3', O4', O5'<br/>Default: false<br/></dd>
<dt><b>-hb_cen_soft</b> \<Boolean\></dt>
<dd>Use softer version of cen_hb term<br/>Default: false<br/></dd>
<dt><b>-use_bicubic_interpolation</b> \<Boolean\></dt>
<dd>Instead of using bilinear interpolation to evaluate the Ramachandran, P_AA_pp and Dunbrack potentials, use bicubic interpolation.  Avoids pile-ups at the grid boundaries where discontinuities in the derivatives frustrate the minimizer<br/>Default: true<br/></dd>
<dt><b>-dun_normsd</b> \<Boolean\></dt>
<dd>Use height-normalized guassian distributions to model p(chi|phi,psi) instead of height-unnormalized gaussians<br/>Default: false<br/></dd>
<dt><b>-dun_entropy_correction</b> \<Boolean\></dt>
<dd>Add Shannon entropy correction to rotamer energy: E = -logP + S<br/>Default: false<br/></dd>
<dt><b>-no_autogen_cart_improper</b> \<Boolean\></dt>
<dd>Ignore the auto parameter generation of improper torsions (undefined torsions) in CartesianBondedEnergy, generate_impropers_map_res.<br/></dd>
</dl>
+ <h3>-corrections:chemical</h3>
<dl>
<dt><b>-chemical</b> \<Boolean\></dt>
<dd>chemical option group<br/></dd>
<dt><b>-icoor_05_2009</b> \<Boolean\></dt>
<dd>New set of idealized coordinates for full atom, 05-2009<br/></dd>
<dt><b>-parse_charge</b> \<Boolean\></dt>
<dd>Use PARSE charge set.<br/></dd>
<dt><b>-expand_st_chi2sampling</b> \<Boolean\></dt>
<dd>Ugly temporary hack.  Expand the chi2 sampling for serine and threonine in the fa_standard residue type set so that samples are taken every 20 degrees (instead of every 60 degrees.  This will soon be changed in the SER and THR params files themselves.  This flag can be used with any residue type set (including the pre-s fa_standard version, and with the fa_standard_05.2009_icoor version) but is unncessary for the talaris2013 version (currently named fa_standard) as the expanded SER and THR sampling is already encoded in .params files for these two residues<br/>Default: false<br/></dd>
<dt><b>-alternate_fullatom_ats</b> \<String\></dt>
<dd>Specify an alternate directory for the fullatom atom type set<br/></dd>
</dl>
+ <h3>-corrections:genpotential</h3>
<dl>
<dt><b>-genpotential</b> \<Boolean\></dt>
<dd>genpotential option group<br/></dd>
<dt><b>-set_torsion_params</b> \<StringVector\></dt>
<dd>Modify generic_bonded_potential torsion parameters (the ones in generic_bonded.round6p.txt) from the command line. Format is: -corrections:genpotential:set_torsion_params <atom-set1>:<atom_name1>:<atom_name2>:<atom_name3>:<atom_name4><param1>:<setting1>:<param2>:<setting2> ... For example: '-corrections:genpotential:set_torsion_params fa_standard:C*:CS:CS:C*:k1:0.0:k2:0.0:k3:0.077 fa_standard:CD:CS:CS:CD:k1:0.435:k2:0.039:k3:0.070' <br/></dd>
<dt><b>-set_special_torsion_params</b> \<StringVector\></dt>
<dd>Modify generic_bonded_potential special torsion parameters (the ones in generic_bonded.round6p.txt) from the command line. Format is: -corrections:genpotential:set_special_torsion_params <atom-set1>:<atom_name1>:<atom_name2>:<atom_name3>:<atom_name4><param1>:<setting1>:<param2>:<setting2> ... For example: '-corrections:genpotential:set_special_torsion_params fa_standard:X:CRb:CRb:X:k1:0.000:k2:-0.226:k3:0.000:k4:0.093:k8:0.000 ' <br/></dd>
</dl>
+ <h2>-corrections</h2>
<dl>
<dt><b>-shapovalov_lib_fixes_enable</b> \<Boolean\></dt>
<dd>Apply new code by Maxim Shapovalov from Dunbrack Lab such as for reading/using dun, rama, prop libraries in new format and options for applying different bug fixes. False value will employ old libraries and old code.<br/>Default: true<br/></dd>
</dl>
+ <h3>-corrections:shapovalov_lib</h3>
<dl>
<dt><b>-shapovalov_lib</b> \<Boolean\></dt>
<dd>shapovalov_lib option group<br/></dd>
<dt><b>-shap_dun10_enable</b> \<Boolean\></dt>
<dd>Enable new Shapovalov's dun10 fix if the umbrella option is on, shapovalov_lib_fixes<br/>Default: true<br/></dd>
<dt><b>-shap_dun10_smooth_level</b> \<String\></dt>
<dd>Smoothing level either numeric or word keyword, possible values are 1 or lowest_smooth, 2 or lower_smooth, 3 or low_smooth, 4 or average_smooth, 5 or higher_smooth, 6 or highest_smooth.<br/>Default: "1"<br/></dd>
<dt><b>-shap_dun10_dir</b> \<String\></dt>
<dd>Name of the new format dun10 dir<br/>Default: "rotamer/shapovalov/StpDwn_5-5-5"<br/></dd>
<dt><b>-shap_dun10_use_minus_log_P_ignore_P</b> \<Boolean\></dt>
<dd>Use minus log P from text libraries only and ignore any P.<br/>Default: false<br/></dd>
<dt><b>-shap_rama_enable</b> \<Boolean\></dt>
<dd>Enable new Shapovalov's Rama fix if the umbrella option is on, shapovalov_lib_fixes<br/>Default: true<br/></dd>
<dt><b>-shap_rama_smooth_level</b> \<String\></dt>
<dd>Smoothing level either numeric or word keyword, possible values are 1 or lowest_smooth, 2 or lower_smooth, 3 or higher_smooth, 4 or highest_smooth.<br/>Default: "4"<br/></dd>
<dt><b>-shap_rama_map</b> \<File\></dt>
<dd>New Ramachandran file in the new format used by rama<br/>Default: "scoring/score_functions/rama/shapovalov/kappa25/all.ramaProb"<br/></dd>
<dt><b>-shap_rama_nogridshift</b> \<Boolean\></dt>
<dd>With correct flag there is a bug. Rama09_noEH_kernel25_it08.dat is used where prob values are reported exactly at the 10-deg grid while Rama_smooth_dyn.dat_ss_6.4 has values reported in the middle of bins. There is no need for 5-deg shift for newer Rama maps with values reported at the grid.<br/>Default: true<br/></dd>
<dt><b>-shap_p_aa_pp_enable</b> \<Boolean\></dt>
<dd>Enable new Shapovalov's propensity map fix if the umbrella option is on, shapovalov_lib_fixes<br/>Default: true<br/></dd>
<dt><b>-shap_p_aa_pp_smooth_level</b> \<String\></dt>
<dd>Smoothing level either numeric or word keyword, possible values are 1 or low_smooth, 2 or high_smooth.<br/>Default: "1"<br/></dd>
<dt><b>-shap_p_aa_pp</b> \<String\></dt>
<dd>Name of the new Shapovalov's P_AA_PP potential file (search in the local directory first, then look in the database)<br/>Default: "scoring/score_functions/P_AA_pp/shapovalov/10deg/kappa50/a20.prop"<br/></dd>
</dl>
+ <h3>-corrections:water</h3>
<dl>
<dt><b>-water</b> \<Boolean\></dt>
<dd>water option group<br/></dd>
<dt><b>-water_bump_check</b> \<Boolean\></dt>
<dd>exclude water rotamers that dont pass energy bump check<br/>Default: false<br/></dd>
<dt><b>-lkb_overlap_distance</b> \<Real\></dt>
<dd>intersection distance when solvating with lkball sites<br/>Default: 0.750<br/></dd>
<dt><b>-lkb_cluster_radius</b> \<Real\></dt>
<dd>radius for clustering overlapping lkball sites<br/>Default: 1.000<br/></dd>
<dt><b>-lkb_rotset_radius</b> \<Real\></dt>
<dd>radius for grouping clustered water sites into rotamer sets<br/>Default: 3.000<br/></dd>
<dt><b>-wat_rot_params</b> \<String\></dt>
<dd>for statistical-based placement of potential water positions<br/>Default: "sampling/waterrots/water.rots"<br/></dd>
<dt><b>-dwell_cutoff</b> \<Real\></dt>
<dd>dwell time cutoff value for PWAT rotamers kept after normalizing by number of MC steps<br/>Default: 0.02<br/></dd>
<dt><b>-cluster_radius</b> \<Real\></dt>
<dd>radius from dwell-weighted centroid for growing PWAT rotamer clusters<br/>Default: 1.52<br/></dd>
<dt><b>-cluster_cutoff</b> \<Real\></dt>
<dd>remove cluster if cumulative dwell time is not met<br/>Default: 0.179<br/></dd>
<dt><b>-watlim_scale</b> \<Real\></dt>
<dd>scale factor for waters kept if using limit_water: scale factor * # molten residues<br/>Default: 0.0<br/></dd>
<dt><b>-pointwater_params</b> \<String\></dt>
<dd>PWAT: directory name for pointwater potential databases<br/>Default: "norm_trunc6"<br/></dd>
<dt><b>-ordered_pt_wat_penalty</b> \<Real\></dt>
<dd>PWAT: Penalty for adding an ordered point water.  Implemented through pointwater scoreterm.<br/>Default: 2.709<br/></dd>
<dt><b>-pointwat_wat_bonus</b> \<Real\></dt>
<dd>PWAT: water-water bonus for nearby PWAT residues<br/>Default: 0.52<br/></dd>
<dt><b>-pointwat_wat_bonus_width</b> \<Real\></dt>
<dd>PWAT: factor determining width of water-water bonus exponential function<br/>Default: 17.1<br/></dd>
<dt><b>-ordered_wat_penalty</b> \<Real\></dt>
<dd>HOH: Penalty for adding an ordered water; implemented through ref scoreterm<br/>Default: 1.221<br/></dd>
<dt><b>-wat_rot_sampling</b> \<Real\></dt>
<dd>Stepsize (in degrees) of rotatable waters<br/>Default: 30.0<br/></dd>
<dt><b>-wat_axis_sampling</b> \<Boolean\></dt>
<dd>align O-H1 vector with nearby backbone O and sample about O-O axes<br/>Default: true<br/></dd>
<dt><b>-axis_rot_sampling</b> \<Real\></dt>
<dd>Stepsize (in degrees) of rotatable waters when wat_axis_sampling is used<br/>Default: 15.0<br/></dd>
<dt><b>-include_vrt</b> \<Boolean\></dt>
<dd>allow for water virtualization<br/>Default: true<br/></dd>
</dl>
+ <h2>-enzymes</h2>
<dl>
<dt><b>-enzymes</b> \<Boolean\></dt>
<dd>enzymes option group<br/></dd>
<dt><b>-species</b> \<String\></dt>
<dd>Setting the species name limits the behavior of the simulated enzyme(s) used in this protocol to reactions known to occur in the given species.  A species name must be in the format \"e_coli\" or \"h_sapiens\", (note the underscores,) which must also correspond to a directory in the Rosetta database, e.g., \"database/virtual_enzymes/<enzyme_family>/h_sapiens/\".<br/>Default: "h_sapiens"<br/></dd>
<dt><b>-enzyme</b> \<String\></dt>
<dd>If set, the simulated enzyme used in this protocol will use specific enzymatic details for this reaction from the database.  If the species name has not been set, a \"generic\" enzyme from general family used in this protocol is assumed.  An enzyme name must be as listed in an appropriate enzyme file in \"database/virtual_enzymes/<enzyme_family>/<species_name_>/\".<br/>Default: "generic"<br/></dd>
<dt><b>-efficiency</b> \<Real\></dt>
<dd>If set, the simulated enzyme used in this protocol will have the efficiency indicated, where 1.00 is 100%.  A virtual enzyme with an efficiency of 0.50 will perform its reaction  any given site 50% of the time.  If not set, the value given in the database for this enzyme will be used.  Enzyme efficiency data are found in \"database/virtual_enzymes/<enzyme_family>/<species_name_>/\".<br/></dd>
</dl>
+ <h2>-evaluation</h2>
<dl>
<dt><b>-evaluation</b> \<Boolean\></dt>
<dd>evaluation option group<br/></dd>
<dt><b>-rmsd_target</b> \<FileVector\></dt>
<dd>[vector] determine rmsd against this/these structure(s)<br/></dd>
<dt><b>-rmsd_column</b> \<StringVector\></dt>
<dd>[vector] use xxx as column name: rms_xxx<br/></dd>
<dt><b>-rmsd_select</b> \<FileVector\></dt>
<dd>[vector] a bunch of loop files which makes rmsds with tags: rms_XXX, where XXX is basename of file<br/></dd>
<dt><b>-align_rmsd_target</b> \<FileVector\></dt>
<dd>[vector] determine rmsd against this/these structure(s) using simple sequence alignment<br/></dd>
<dt><b>-structural_similarity</b> \<FileVector\></dt>
<dd>[vector] measure average similarity against these structures (option specifies a silent-file)<br/></dd>
<dt><b>-contact_map</b> \<Boolean\></dt>
<dd>Calculate contact map similarity using the given native<br/></dd>
<dt><b>-jscore_evaluator</b> \<StringVector\></dt>
<dd>Calculate scores using the given score function weights files and, residue type set names (e.g score12 fa_standard score3 centroid)<br/></dd>
<dt><b>-align_rmsd_column</b> \<StringVector\></dt>
<dd>[vector] use xxx as column name for align_rmsd_target: rms_xxx<br/></dd>
<dt><b>-align_rmsd_fns</b> \<FileVector\></dt>
<dd>[vector] of sequence alignments used for align_rmsd files<br/></dd>
<dt><b>-align_rmsd_format</b> \<String\></dt>
<dd>format for sequence alignment between structures used in evaluation<br/>Default: "grishin"<br/></dd>
<dt><b>-rms_type</b> \<String\></dt>
<dd>RNP if you want both protein and RNA RMSD, blank for protein<br/>Default: ""<br/></dd>
<dt><b>-predicted_burial_fn</b> \<String\></dt>
<dd>file for burial predictions<br/>Default: ""<br/></dd>
<dt><b>-pool</b> \<File\></dt>
<dd>find closest matching structure in this pool and report tag and rmsd<br/></dd>
<dt><b>-rmsd</b> \<FileVector\></dt>
<dd>[vector/pairs] tripletts: rmsd_target (or NATIVE / IRMS) col_name selection_file (or FULL)<br/></dd>
<dt><b>-chirmsd</b> \<FileVector\></dt>
<dd>[vector/tripletts]: rmsd_target (or NATIVE / IRMS ) col_name selection_file ( or FULL) <br/></dd>
<dt><b>-gdtmm</b> \<Boolean\></dt>
<dd>for each rmsd evaluator also a gdtmm evaluator is created<br/>Default: false<br/></dd>
<dt><b>-gdttm</b> \<Boolean\></dt>
<dd>for each rmsd evaluator also a gdttm evaluator is created<br/>Default: false<br/></dd>
<dt><b>-score_with_rmsd</b> \<Boolean\></dt>
<dd>score the pose on the same subset of atoms as in the rmsd poses<br/></dd>
<dt><b>-constraints</b> \<FileVector\></dt>
<dd>[vector] evaluate against these constraint sets<br/></dd>
<dt><b>-constraints_column</b> \<FileVector\></dt>
<dd>[vector] use xxx as column name: cst_xxx<br/></dd>
<dt><b>-combined_constraints</b> \<FileVector\></dt>
<dd>[vector] use xxx as cst-file but combine constraints before applying<br/></dd>
<dt><b>-combined_constraints_column</b> \<FileVector\></dt>
<dd>[vector] use xxx as cst-file but combine constraints before applying<br/></dd>
<dt><b>-combine_statistics</b> \<Integer\></dt>
<dd>repeat constraint evaluation X times to get statistics of constraint combination<br/>Default: 10<br/></dd>
<dt><b>-chemical_shifts</b> \<StringVector\></dt>
<dd>compute chemical shift score with SPARTA+ use tuples: talos_file [cs]_column_name  (ATTENTION uses filesystem)<br/></dd>
<dt><b>-sparta_dir</b> \<String\></dt>
<dd>[optional] point to an external resource for the sparta directory (instead of minirosetta_database)<br/>Default: "SPARTA+"<br/></dd>
<dt><b>-cam_shifts</b> \<StringVector\></dt>
<dd>compute chemical shift score with Camshift talos_file [cs]_column_name  (ATTENTION uses filesystem)<br/></dd>
<dt><b>-pales</b> \<StringVector\></dt>
<dd>compute Residual Dipolar Couplings using the PALES program (ATTENTION uses filesystem)<br/></dd>
<dt><b>-extra_score</b> \<FileVector\></dt>
<dd>[vector] provide .wts files to generate extra columns<br/></dd>
<dt><b>-extra_score_patch</b> \<FileVector\></dt>
<dd>[vector] provide .patch files, set NOPATCH for columns that are not patched<br/></dd>
<dt><b>-extra_score_column</b> \<StringVector\></dt>
<dd>[vector] use xxx as column name: score_xxx<br/></dd>
<dt><b>-extra_score_select</b> \<FileVector\></dt>
<dd>[vector] /rigid/ files for selection, use SELECT_ALL as placeholder<br/></dd>
<dt><b>-rdc_target</b> \<FileVector\></dt>
<dd>[vector] as rmsd_target/column provide PDB wih missing density to compute RDC score on selected residues<br/></dd>
<dt><b>-symmetric_rmsd</b> \<Boolean\></dt>
<dd>calculate the rmsd symmetrically by checking all chain orderings<br/></dd>
<dt><b>-rdc_column</b> \<StringVector\></dt>
<dd>[vector] column names for rdc_select<br/></dd>
<dt><b>-rdc</b> \<StringVector\></dt>
<dd>[vector] rdc-files and column names for RDC calculation<br/></dd>
<dt><b>-built_in_rdc</b> \<String\></dt>
<dd>evaluate rdc from -in:file:rdc with standard score function and store under column xxx<br/></dd>
<dt><b>-jump_nr</b> \<Boolean\></dt>
<dd>adds the JumpNrEvaluator for the nrjumps column<br/>Default: false<br/></dd>
<dt><b>-score_exclude_res</b> \<IntegerVector\></dt>
<dd>Calculates a select_score column based on all residues not excluded by the command line vector<br/></dd>
<dt><b>-score_sscore_short_helix</b> \<Integer\></dt>
<dd>defines the maximum length of a helix that is not scored if it terminates a loop<br/>Default: 5<br/></dd>
<dt><b>-score_sscore_maxloop</b> \<Integer\></dt>
<dd>defines the maximum length of a loop that is still considered for the sscore - score<br/>Default: 3<br/></dd>
<dt><b>-window_size</b> \<Integer\></dt>
<dd>Window size for local RMSD calculations in windowed_rmsd app<br/>Default: 5<br/></dd>
<dt><b>-I_sc</b> \<String\></dt>
<dd>score function name used to calculate I_sc<br/>Default: "score12"<br/></dd>
<dt><b>-Irms</b> \<Boolean\></dt>
<dd>will compute the docking interface rmsd<br/>Default: false<br/></dd>
<dt><b>-Ca_Irms</b> \<Boolean\></dt>
<dd>will compute the docking Ca-atom interface rmsd<br/>Default: false<br/></dd>
<dt><b>-Fnat</b> \<Boolean\></dt>
<dd>will compute the docking recovered fraction of native contacts<br/>Default: false<br/></dd>
<dt><b>-Lrmsd</b> \<Boolean\></dt>
<dd>will compute the docking ligand rmsd<br/>Default: false<br/></dd>
<dt><b>-Fnonnat</b> \<Boolean\></dt>
<dd>will compute the fraction of non-native contacts for docking<br/>Default: false<br/></dd>
<dt><b>-DockMetrics</b> \<Boolean\></dt>
<dd>will compute all docking metrics (I_sc/Irms/Fnat/Lrmsd for now) for replica docking<br/>Default: false<br/></dd>
</dl>
+ <h2>-filters</h2>
<dl>
<dt><b>-filters</b> \<Boolean\></dt>
<dd>filters option group<br/></dd>
<dt><b>-disable_all_filters</b> \<Boolean\></dt>
<dd>turn off all centroid filters: RG, CO, and Sheet<br/>Default: false<br/></dd>
<dt><b>-disable_rg_filter</b> \<Boolean\></dt>
<dd>turn off RG filter<br/>Default: false<br/></dd>
<dt><b>-disable_co_filter</b> \<Boolean\></dt>
<dd>turn off contact order filter<br/>Default: false<br/></dd>
<dt><b>-disable_sheet_filter</b> \<Boolean\></dt>
<dd>turn off sheet filter<br/>Default: false<br/></dd>
<dt><b>-set_pddf_filter</b> \<Real\></dt>
<dd>Turns on PDDF filter with a given score cutoff<br/>Default: 5.0<br/></dd>
<dt><b>-set_saxs_filter</b> \<Real\></dt>
<dd>Turns on SAXS energy filter with a given score cutoff<br/>Default: -3<br/></dd>
</dl>
+ <h2>-gpu</h2>
<dl>
<dt><b>-gpu</b> \<Boolean\></dt>
<dd>Enable/Disable GPU support<br/>Default: true<br/></dd>
<dt><b>-device</b> \<Integer\></dt>
<dd>GPU device to use<br/>Default: 1<br/></dd>
<dt><b>-threads</b> \<Integer\></dt>
<dd>Max GPU threads to use<br/>Default: 2048<br/></dd>
</dl>
+ <h2>-jumps</h2>
<dl>
<dt><b>-jumps</b> \<Boolean\></dt>
<dd>jumps option group<br/></dd>
<dt><b>-evaluate</b> \<Boolean\></dt>
<dd>evaluate N-CA-C gemoetry for all jumps in the fold-tree<br/>Default: false<br/></dd>
<dt><b>-extra_frags_for_ss</b> \<File\></dt>
<dd>use ss-def from this fragset<br/>Default: ""<br/></dd>
<dt><b>-fix_chainbreak</b> \<Boolean\></dt>
<dd>minimize to fix ccd in re-runs<br/>Default: false<br/></dd>
<dt><b>-fix_jumps</b> \<File\></dt>
<dd>read jump_file<br/>Default: ""<br/></dd>
<dt><b>-jump_lib</b> \<File\></dt>
<dd>read jump_library_file for automatic jumps<br/>Default: ""<br/></dd>
<dt><b>-loop_definition_from_file</b> \<File\></dt>
<dd>use ss-def from this file<br/>Default: ""<br/></dd>
<dt><b>-no_chainbreak_in_relax</b> \<Boolean\></dt>
<dd>dont penalize chainbreak in relax<br/>Default: false<br/></dd>
<dt><b>-pairing_file</b> \<File\></dt>
<dd>file with pairings<br/>Default: ""<br/></dd>
<dt><b>-random_sheets</b> \<IntegerVector\></dt>
<dd>random sheet topology--> replaces -sheet1 -sheet2 ... select randomly up to N sheets with up to -sheet_i pairgins for sheet i<br/>Default: 1<br/></dd>
<dt><b>-residue_pair_jump_file</b> \<File\></dt>
<dd>a file to define residue pair jump<br/>Default: ""<br/></dd>
<dt><b>-sheets</b> \<IntegerVector\></dt>
<dd>sheet topology--> replaces -sheet1 -sheet2 ... -sheetN<br/>Default: 1<br/></dd>
<dt><b>-topology_file</b> \<File\></dt>
<dd>read a file with topology info ( PairingStats )<br/>Default: ""<br/></dd>
<dt><b>-bb_moves</b> \<Boolean\></dt>
<dd>Apply bb_moves ( wobble, small, shear) during stage3 and stage 4.<br/>Default: false<br/></dd>
<dt><b>-no_wobble</b> \<Boolean\></dt>
<dd>Don t apply the useless wobble during stage3 and stage 4.<br/>Default: false<br/></dd>
<dt><b>-no_shear</b> \<Boolean\></dt>
<dd>Don t apply the useless shear during stage3 and stage 4.<br/>Default: false<br/></dd>
<dt><b>-no_sample_ss_jumps</b> \<Boolean\></dt>
<dd>sample jump-frags during folding<br/>Default: false<br/></dd>
<dt><b>-invrate_jump_move</b> \<Integer\></dt>
<dd>give 5 here to have 5 torsion moves for each jump move<br/>Default: 10<br/></dd>
<dt><b>-chainbreak_weight_stage1</b> \<Real\></dt>
<dd>the weight on chainbreaks<br/>Default: 1.0<br/></dd>
<dt><b>-chainbreak_weight_stage2</b> \<Real\></dt>
<dd>the weight on chainbreaks<br/>Default: 1.0<br/></dd>
<dt><b>-chainbreak_weight_stage3</b> \<Real\></dt>
<dd>the weight on chainbreaks<br/>Default: 1.0<br/></dd>
<dt><b>-chainbreak_weight_stage4</b> \<Real\></dt>
<dd>the weight on chainbreaks<br/>Default: 1.0<br/></dd>
<dt><b>-ramp_chainbreaks</b> \<Boolean\></dt>
<dd>ramp up the chainbreak weight stage1-0, stage2 0.25, stage3 alternating 0.5..2.5, stage4 2.5..4<br/>Default: true<br/></dd>
<dt><b>-increase_chainbreak</b> \<Real\></dt>
<dd>multiply ramped chainbreak weight by this amount<br/>Default: 1.0<br/></dd>
<dt><b>-overlap_chainbreak</b> \<Boolean\></dt>
<dd>use the overlap chainbrak term in stage4<br/>Default: false<br/></dd>
<dt><b>-sep_switch_accelerate</b> \<Real\></dt>
<dd>constraints and chainbreak depend on in-chain-separation. Accelerate their enforcement 1+num_cuts()*<this_factor><br/>Default: 0.4<br/></dd>
<dt><b>-dump_frags</b> \<Boolean\></dt>
<dd>dump jump_fragments <br/>Default: false<br/></dd>
<dt><b>-njumps</b> \<Integer\></dt>
<dd>number_of_jumps to select from library for each trajectory (membrane mode)<br/>Default: 1<br/></dd>
<dt><b>-max_strand_gap_allowed</b> \<Integer\></dt>
<dd>merge strands if they less than X residues but same register<br/>Default: 2<br/></dd>
<dt><b>-contact_score</b> \<Real\></dt>
<dd>the strand-weight will have a weight * contact_order component<br/>Default: 0.0<br/></dd>
<dt><b>-filter_templates</b> \<Boolean\></dt>
<dd>filter hybridization protocol templates<br/>Default: false<br/></dd>
</dl>
+ <h2>-loops</h2>
<dl>
<dt><b>-loops</b> \<Boolean\></dt>
<dd>loop modeling option group<br/>Default: true<br/></dd>
<dt><b>-cen_weights</b> \<String\></dt>
<dd>ScoreFunction weights file for centroid phase of loop-modeling<br/>Default: "cen_std"<br/></dd>
<dt><b>-cen_patch</b> \<String\></dt>
<dd>ScoreFunction patch for for centroid phase of loop-modeling<br/>Default: "score4L"<br/></dd>
<dt><b>-input_pdb</b> \<File\></dt>
<dd>template pdb file<br/>Default: "input_pdb"<br/></dd>
<dt><b>-loop_file</b> \<StringVector\></dt>
<dd>Loop definition file(s). When multiple files are given a *random* one will be picked each time when this parameter is requested.<br/></dd>
<dt><b>-extended_loop_file</b> \<File\></dt>
<dd>loop definition file for loops to be extended (used in abrelax)<br/>Default: "loop_file"<br/></dd>
<dt><b>-mm_loop_file</b> \<File\></dt>
<dd>loop definition file<br/>Default: "loop_file"<br/></dd>
<dt><b>-fix_natsc</b> \<Boolean\></dt>
<dd>fix sidechains in template region in loop modeling<br/>Default: false<br/></dd>
<dt><b>-refine_only</b> \<Boolean\></dt>
<dd>perform full atom refinement only on loops<br/>Default: false<br/></dd>
<dt><b>-fast</b> \<Boolean\></dt>
<dd>reduce number of simulation cycles in loop modeling<br/>Default: false<br/></dd>
<dt><b>-vall_file</b> \<File\></dt>
<dd>vall database file<br/>Default: "vall_file"<br/></dd>
<dt><b>-frag_sizes</b> \<IntegerVector\></dt>
<dd>lengths of fragments to be used in loop modeling<br/>Default: ['9', '3', '1']<br/></dd>
<dt><b>-frag_files</b> \<FileVector\></dt>
<dd>fragment libraries files<br/>Default: ['"frag9"', '"frag3"', '"frag1"']<br/></dd>
<dt><b>-output_pdb</b> \<File\></dt>
<dd>output model pdb file<br/>Default: "output.pdb"<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-build_initial</b> \<Boolean\></dt>
<dd>Precede loop-modeling with an initial round of just removing the missing densities and building simple loops<br/>Default: false<br/></dd>
<dt><b>-extended</b> \<Boolean\></dt>
<dd>Force extended on loops, independent of loop input file<br/>Default: false<br/></dd>
<dt><b>-remove_extended_loops</b> \<Boolean\></dt>
<dd>Before building any loops, remove all loops marked as extended<br/>Default: false<br/></dd>
<dt><b>-idealize_after_loop_close</b> \<Boolean\></dt>
<dd>Run structure through idealizer after loop_closing<br/>Default: true<br/></dd>
<dt><b>-idealize_before_loop_close</b> \<Boolean\></dt>
<dd>Run structure through idealizer before loop_closing<br/>Default: true<br/></dd>
<dt><b>-select_best_loop_from</b> \<Integer\></dt>
<dd>Keep building loops until N and choose best (by score)<br/>Default: 1<br/></dd>
<dt><b>-build_attempts</b> \<Integer\></dt>
<dd>Build attempts per growth attempt<br/>Default: 3<br/></dd>
<dt><b>-grow_attempts</b> \<Integer\></dt>
<dd>Total loop growth attempts<br/>Default: 7<br/></dd>
<dt><b>-random_grow_loops_by</b> \<Real\></dt>
<dd>Randomly grow loops by up to this number of residues on either side.<br/>Default: 0.0<br/></dd>
<dt><b>-accept_aborted_loops</b> \<Boolean\></dt>
<dd>accept aborted loops      <br/>Default: false<br/></dd>
<dt><b>-strict_loops</b> \<Boolean\></dt>
<dd>Do not allow growing of loops<br/>Default: false<br/></dd>
<dt><b>-superimpose_native</b> \<Boolean\></dt>
<dd>Superimpose the native over the core before calculating looprms<br/>Default: false<br/></dd>
<dt><b>-build_specific_loops</b> \<IntegerVector\></dt>
<dd>Numbers of the loops to be built<br/></dd>
<dt><b>-random_order</b> \<Boolean\></dt>
<dd>build in random order     <br/>Default: true<br/></dd>
<dt><b>-build_all_loops</b> \<Boolean\></dt>
<dd>build all loops(no skip)  <br/>Default: false<br/></dd>
<dt><b>-fa_closure_protocol</b> \<Boolean\></dt>
<dd>Abrelax uses FASlidingWindowLoopClosure... <br/>Default: false<br/></dd>
<dt><b>-combine_rate</b> \<Real\></dt>
<dd>Combine successive loops at this rate<br/>Default: 0.0<br/></dd>
<dt><b>-skip_initial_loop_build</b> \<Boolean\></dt>
<dd>Skip the initial loop build step where existing loop torsions are discarded and the loop is built from scratch. <br/>Default: false<br/></dd>
<dt><b>-remodel</b> \<String\></dt>
<dd><br/>Default: "no"<br/></dd>
<dt><b>-intermedrelax</b> \<String\></dt>
<dd><br/>Default: "no"<br/></dd>
<dt><b>-refine</b> \<String\></dt>
<dd>method for performing full-atom refinement on loops<br/>Default: "no"<br/></dd>
<dt><b>-relax</b> \<String\></dt>
<dd><br/>Default: "no"<br/></dd>
<dt><b>-final_clean_fastrelax</b> \<Boolean\></dt>
<dd>Add a final fastrelax without constraints<br/>Default: false<br/></dd>
<dt><b>-relax_with_foldtree</b> \<Boolean\></dt>
<dd>keep foldtree during relax<br/>Default: false<br/></dd>
<dt><b>-constrain_rigid_segments</b> \<Real\></dt>
<dd>Use Coordinate constraints on the non-loop regions<br/>Default: 0.0<br/></dd>
<dt><b>-loopscores</b> \<String\></dt>
<dd>Calculate loopscores individually for these loops (path to loopsfile)<br/></dd>
<dt><b>-timer</b> \<Boolean\></dt>
<dd>Output time spent in seconds for each loop modeling job<br/>Default: false<br/></dd>
<dt><b>-vicinity_sampling</b> \<Boolean\></dt>
<dd>only sample within a certain region of the current torsion values<br/>Default: false<br/></dd>
<dt><b>-vicinity_degree</b> \<Real\></dt>
<dd>number of degrees to sample within current torsion values for vicinity sampling<br/>Default: 1.0<br/></dd>
<dt><b>-neighbor_dist</b> \<Real\></dt>
<dd>CB distance cutoff for repacking, rotamer trails, and side-chain minimization during loop modeling. NOTE: values over 10.0 are effectively reduced to 10.0<br/>Default: 10.0<br/></dd>
<dt><b>-kic_max_seglen</b> \<Integer\></dt>
<dd>maximum size of residue segments used in kinematic closure calculations<br/>Default: 12<br/></dd>
<dt><b>-kic_recover_last</b> \<Boolean\></dt>
<dd>If true, do not recover lowest scoring pose after each outer cycle and at end of protocol in kic remodel and refine<br/>Default: false<br/></dd>
<dt><b>-kic_min_after_repack</b> \<Boolean\></dt>
<dd>Should the kinematic closure refine protocol minimize after repacking steps<br/>Default: true<br/></dd>
<dt><b>-optimize_only_kic_region_sidechains_after_move</b> \<Boolean\></dt>
<dd>Should we perform rotamer trials and minimization after every KIC move but only within the loops:neighbor_dist of the residues in the moved KIC segment. Useful to speed up when using very large loop definitions (like when whole chains are used for ensemble generation).<br/>Default: false<br/></dd>
<dt><b>-max_kic_build_attempts</b> \<Integer\></dt>
<dd>Number of attempts at initial kinematic closure loop building<br/>Default: 10000<br/></dd>
<dt><b>-remodel_kic_attempts</b> \<Integer\></dt>
<dd>Number of kic attempts per inner cycle during perturb_kic protocol<br/>Default: 300<br/></dd>
<dt><b>-max_kic_perturber_samples</b> \<Integer\></dt>
<dd>Maximum number of kinematic perturber samples<br/>Default: 2000<br/></dd>
<dt><b>-nonpivot_torsion_sampling</b> \<Boolean\></dt>
<dd>enables sampling of non-pivot residue torsions when the kinematic loop closure segment length is > 3<br/>Default: true<br/></dd>
<dt><b>-fix_ca_bond_angles</b> \<Boolean\></dt>
<dd>Freezes N-CA-C bond angles in KIC loop sampling<br/>Default: false<br/></dd>
<dt><b>-kic_use_linear_chainbreak</b> \<Boolean\></dt>
<dd>Use linear_chainbreak instead of (harmonic) chainbreak in KIC loop sampling<br/>Default: false<br/></dd>
<dt><b>-sample_omega_at_pre_prolines</b> \<Boolean\></dt>
<dd>Sample omega in KIC loop sampling<br/>Default: false<br/></dd>
<dt><b>-allow_omega_move</b> \<Boolean\></dt>
<dd>Allow loop omega to minimize during loop modeling<br/>Default: false<br/></dd>
<dt><b>-kic_with_cartmin</b> \<Boolean\></dt>
<dd>Use cartesian minimization in KIC loop modeling<br/>Default: false<br/></dd>
<dt><b>-allow_takeoff_torsion_move</b> \<Boolean\></dt>
<dd>Allow takeoff phi/psi to move during loop modeling<br/>Default: false<br/></dd>
<dt><b>-extend_length</b> \<Integer\></dt>
<dd>Number of alanine residues to append after cutpoint in loopextend app<br/>Range: 0-<br/>Default: 0<br/></dd>
<dt><b>-perturb_outer_cycles</b> \<Integer\></dt>
<dd>number of outer cycles in the perturbation (centroid) stage<br/>Range: 1-<br/>Default: 5<br/></dd>
<dt><b>-refine_outer_cycles</b> \<Integer\></dt>
<dd>number of outer cycles in the fullatom refinement stage<br/>Range: 1-<br/>Default: 5<br/></dd>
<dt><b>-max_inner_cycles</b> \<Integer\></dt>
<dd>maxium number of inner cycles in fullatom loop refinement<br/>Range: 1-<br/>Default: 1<br/></dd>
<dt><b>-repack_period</b> \<Integer\></dt>
<dd>repack period during fullatom loop refinement<br/>Range: 1-<br/>Default: 20<br/></dd>
<dt><b>-remodel_init_temp</b> \<Real\></dt>
<dd>Initial temperature for loop rebuiding. Currently only supported in kinematic (KIC) mode<br/>Default: 2.0<br/></dd>
<dt><b>-remodel_final_temp</b> \<Real\></dt>
<dd>Final temperature for loop rebuilding. Currently only supported in kinematic (KIC) mode<br/>Default: 1.0<br/></dd>
<dt><b>-refine_init_temp</b> \<Real\></dt>
<dd>Initial temperature for loop refinement. Currently only supported in kinematic (KIC) mode<br/>Default: 1.5<br/></dd>
<dt><b>-refine_final_temp</b> \<Real\></dt>
<dd>Final temperature for loop refinement. Currently only supported in kinematic (KIC) mode<br/>Default: 0.5<br/></dd>
<dt><b>-gapspan</b> \<Integer\></dt>
<dd>when automatically identifying loop regions, this is the maximum gap length for a single loop<br/>Range: 1-<br/>Default: 6<br/></dd>
<dt><b>-spread</b> \<Integer\></dt>
<dd>when automatically identifying loop regions, this is the number of neighboring residues by which to extend out loop regions<br/>Range: 1-<br/>Default: 2<br/></dd>
<dt><b>-kinematic_wrapper_cycles</b> \<Integer\></dt>
<dd>maximum number of KinematicMover apply() tries per KinematicWrapper apply()<br/>Default: 20<br/></dd>
<dt><b>-kic_num_rotamer_trials</b> \<Integer\></dt>
<dd>number of RotamerTrial iterations in each KIC cycle -- default is 1<br/>Default: 1<br/></dd>
<dt><b>-kic_omega_sampling</b> \<Boolean\></dt>
<dd>Perform sampling of omega angles around 179.6 for trans, and including 0 for pre-prolines -- default false, for legacy reasons<br/>Default: false<br/></dd>
<dt><b>-kic_bump_overlap_factor</b> \<Real\></dt>
<dd>allow some atomic overlap in initial loop closures (should be remediated in subsequent repacking and minimization)<br/>Default: 0.36<br/></dd>
<dt><b>-minimize_max_iter</b> \<Integer\></dt>
<dd>Max iteration of minimization during MC<br/>Default: 200<br/></dd>
<dt><b>-restrict_kic_sampling_to_torsion_string</b> \<String\></dt>
<dd>restrict kinematic loop closure sampling to the phi/psi angles specified in the torsion string<br/>Default: ""<br/></dd>
<dt><b>-derive_torsion_string_from_native_pose</b> \<Boolean\></dt>
<dd>apply torsion-restricted sampling, and derive the torsion string from the native [or, if not provided, starting] structure<br/>Default: false<br/></dd>
<dt><b>-always_remodel_full_loop</b> \<Boolean\></dt>
<dd>always remodel the full loop segment (i.e. the outer pivots are always loop start & end) -- currently this only applies to the perturb stage -- EXPERIMENTAL<br/>Default: false<br/></dd>
<dt><b>-taboo_sampling</b> \<Boolean\></dt>
<dd>enhance diversity in KIC sampling by pre-generating different torsion bins and sampling within those -- this flag activates Taboo sampling in the perturb stage<br/>Default: false<br/></dd>
<dt><b>-taboo_in_fa</b> \<Boolean\></dt>
<dd>enhance diversity in KIC sampling by pre-generating different torsion bins and sampling within those -- this flag activates Taboo sampling in the first half of the full-atom stage; use in combination with -loops:taboo_sampling or -kic_leave_centroid_after_initial_closure<br/>Default: false<br/></dd>
<dt><b>-ramp_fa_rep</b> \<Boolean\></dt>
<dd>ramp the weight of fa_rep over outer cycles in refinement<br/>Default: false<br/></dd>
<dt><b>-ramp_rama</b> \<Boolean\></dt>
<dd>ramp the weight of rama over outer cycles in refinement<br/>Default: false<br/></dd>
<dt><b>-kic_rama2b</b> \<Boolean\></dt>
<dd>use neighbor-dependent Ramachandran distributions in random torsion angle sampling<br/>Default: false<br/></dd>
<dt><b>-kic_leave_centroid_after_initial_closure</b> \<Boolean\></dt>
<dd>only use centroid mode for initial loop closure -- all further loop closures will be performed in full-atom<br/>Default: false<br/></dd>
<dt><b>-legacy_kic</b> \<Boolean\></dt>
<dd>always select the start pivot first and then the end pivot -- biases towards sampling the C-terminal part of the loop more (false by default)<br/>Default: false<br/></dd>
<dt><b>-alternative_closure_protocol</b> \<Boolean\></dt>
<dd>use WidthFirstSliding...<br/>Default: false<br/></dd>
<dt><b>-chainbreak_max_accept</b> \<Real\></dt>
<dd>accept all loops that have a lower cumulative chainbreak score (linear,quadratic(if present), and overlap)<br/>Default: 2.0<br/></dd>
<dt><b>-debug_loop_closure</b> \<Boolean\></dt>
<dd>dump structures before and after loop closing<br/>Default: false<br/></dd>
<dt><b>-non_ideal_loop_closing</b> \<Boolean\></dt>
<dd>allow small non-idealities at the chainbreak residue after loop-closing -- requires binary silent out<br/>Default: false<br/></dd>
<dt><b>-scored_frag_cycles</b> \<Real\></dt>
<dd>cycle-ratio for scored_frag_cycles ( loop_size<10 ) after jumping-abinitio<br/>Default: 1.0<br/></dd>
<dt><b>-short_frag_cycles</b> \<Real\></dt>
<dd>cycle-ratio for short_frag_cycles ( loop_size<10 ) after jumping-abinitio<br/>Default: 1.0<br/></dd>
<dt><b>-rmsd_tol</b> \<Real\></dt>
<dd>rmsd tolerance to deviate from original pose<br/>Default: 10000.0<br/></dd>
<dt><b>-chain_break_tol</b> \<Real\></dt>
<dd>acceptable tolerance for chain break score<br/>Default: 0.2<br/></dd>
<dt><b>-random_loop</b> \<Boolean\></dt>
<dd>randomize loop stub positions<br/>Default: false<br/></dd>
<dt><b>-stealfrags</b> \<FileVector\></dt>
<dd>StealFragPDBS<br/></dd>
<dt><b>-stealfrags_times</b> \<Integer\></dt>
<dd>StealFragPDBS how many times ?<br/>Default: 1<br/></dd>
<dt><b>-coord_cst</b> \<Real\></dt>
<dd>restraintweight<br/>Default: 0.0<br/></dd>
<dt><b>-skip_1mers</b> \<Real\></dt>
<dd>rate at which you should skip a 1 mer insertion<br/>Default: 0.0<br/></dd>
<dt><b>-skip_3mers</b> \<Real\></dt>
<dd>rate at which you should skip a 3 mer insertion<br/>Default: 0.0<br/></dd>
<dt><b>-skip_9mers</b> \<Real\></dt>
<dd>rate at which you should skip a 9 mer insertion<br/>Default: 0.0<br/></dd>
<dt><b>-loop_model</b> \<Boolean\></dt>
<dd>loop modeling option<br/>Default: false<br/></dd>
<dt><b>-score_filter_cutoff</b> \<Real\></dt>
<dd>value for score filter<br/>Default: 1.0<br/></dd>
<dt><b>-ccd_closure</b> \<Boolean\></dt>
<dd>apply ccd closure<br/>Default: false<br/></dd>
<dt><b>-skip_ccd_moves</b> \<Boolean\></dt>
<dd>when running in ccd_moves mode, dont actually do ccd_moves.. just do fragment insertions<br/>Default: false<br/></dd>
<dt><b>-no_randomize_loop</b> \<Boolean\></dt>
<dd>Leave loop as it is<br/>Default: false<br/></dd>
<dt><b>-loops_subset</b> \<Boolean\></dt>
<dd>pick subset of desired loops<br/>Default: false<br/></dd>
<dt><b>-num_desired_loops</b> \<Integer\></dt>
<dd>number of desired loops<br/>Default: 1<br/></dd>
<dt><b>-loop_combine_rate</b> \<Real\></dt>
<dd>skip rate for not combining a chosen loop<br/>Default: 0.0<br/></dd>
<dt><b>-final_score_filter</b> \<Real\></dt>
<dd>Only output structures that score bette rthan that<br/>Default: 1000000.0<br/></dd>
<dt><b>-no_combine_if_fail</b> \<Boolean\></dt>
<dd>combine loops if loop modeling fails<br/>Default: true<br/></dd>
<dt><b>-shorten_long_terminal_loop</b> \<Boolean\></dt>
<dd>shorten long loops<br/>Default: false<br/></dd>
<dt><b>-backrub_trials</b> \<Integer\></dt>
<dd>number of backrub steps to do in loop relax<br/>Default: 10<br/></dd>
<dt><b>-looprlx_cycle_ratio</b> \<Real\></dt>
<dd>fraction of the total looprlx cycles<br/>Default: 1.0<br/></dd>
<dt><b>-extended_beta</b> \<Real\></dt>
<dd>Extended tempfactor: stochastic extendedness: p_ext = exp( - beta * length ) <br/>Default: -1.0<br/></dd>
<dt><b>-no_looprebuild</b> \<Boolean\></dt>
<dd>do not rebuild loops<br/>Default: false<br/></dd>
<dt><b>-allow_lig_move</b> \<Boolean\></dt>
<dd>allow ligands to move during loop modeling<br/>Default: false<br/></dd>
<dt><b>-keep_natro</b> \<File\></dt>
<dd>list of residues where the rotamers are kept fixed<br/>Default: "keep_natro"<br/></dd>
<dt><b>-refine_design_iterations</b> \<Integer\></dt>
<dd>iterations of refine and design<br/>Default: 1<br/></dd>
</dl>
+ <h3>-loops:ccd</h3>
<dl>
<dt><b>-ccd</b> \<Boolean\></dt>
<dd>ccd option group<br/></dd>
<dt><b>-max_rama_score_increase</b> \<Real\></dt>
<dd>Maximum increase in Ramachandran score that will be tolerated.<br/>Default: 2.0<br/></dd>
<dt><b>-max_torsion_delta_per_move</b> \<RealVector\></dt>
<dd>Maxmimum absolute torsion deviation for a single residue in a given move. Different deviations for residues in helical, extended or coil conformations must be supplied (in that order).<br/>Default: ['1.0', '5.0', '10.0']<br/></dd>
<dt><b>-max_torsion_delta</b> \<RealVector\></dt>
<dd>Maxmimum absolute torsion deviation for a single residue over the entire CCD closure. Different deviations for residues in helical, extended or coil conformations must be supplied (in that order).<br/>Default: ['10.0', '50.0', '75.0']<br/></dd>
<dt><b>-tolerance</b> \<Real\></dt>
<dd>Maximum RMSD (in Angstroms) of the duplicated atoms across the cutpoint that will be considered a successful closure.<br/>Default: 0.08<br/></dd>
<dt><b>-max_cycles</b> \<Integer\></dt>
<dd>Maximum number of CCD iterations to attempt. CCD will stop if the loop is closed in fewer cycles than the maximum.<br/>Default: 100<br/></dd>
<dt><b>-check_rama_scores</b> \<Boolean\></dt>
<dd>Bias toward moves that improve the moving resiude's Ramachandran score.<br/>Default: true<br/></dd>
<dt><b>-rama_2b</b> \<Boolean\></dt>
<dd>Use two-body (neighbor-dependent) Ramachandran score.<br/>Default: false<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>Temperature (roughly in units of kT) to use when accepting a move that does not improve the Ramachandran score.<br/>Default: 0.25<br/></dd>
</dl>
+ <h2>-intf</h2>
<dl>
<dt><b>-intf</b> \<Boolean\></dt>
<dd>intf option group<br/></dd>
<dt><b>-chains</b> \<String\></dt>
<dd>Chains over which the statistics are taken, can be multiple. Example: 'AEF'. If not given, takes statistics over unique chains in the PDB.<br/></dd>
</dl>
+ <h2>-mp</h2>
<dl>
<dt><b>-mp</b> \<Boolean\></dt>
<dd>mp option group<br/></dd>
<dt><b>-restore_lazaridis_imm_behavior</b> \<Boolean\></dt>
<dd>Restore energy function behavior to Lazaridis IMM1<br/>Default: false<br/></dd>
<dt><b>-thickness</b> \<Real\></dt>
<dd>Thickness of the membrane used by the high resolution scoring function. Overwrites default thickness of 30A.<br/></dd>
<dt><b>-membrane_core</b> \<Real\></dt>
<dd>set membrane core thickness for Lazaridis-Karplus. default is 10A, i.e (-10, 10)<br/></dd>
<dt><b>-steepness</b> \<Real\></dt>
<dd>Control transition region between polar and nonpoar phases for the membrane model used by the high resolution energy function. Default = 10 gives a 6A transition region.<br/></dd>
<dt><b>-center_start</b> \<RealVector\></dt>
<dd>Starting point for center search. Example: 3 2 4.<br/></dd>
<dt><b>-center_delta</b> \<Real\></dt>
<dd>Perturbation of center in Angstrom.<br/></dd>
<dt><b>-center_search_cycles</b> \<Real\></dt>
<dd>Iterations for center search.<br/></dd>
<dt><b>-normal_start</b> \<RealVector\></dt>
<dd>Base vector for normal search. Angles go off that vector.<br/></dd>
<dt><b>-normal_angle_start</b> \<Real\></dt>
<dd>Starting angle from base vector for normal search. Degrees.<br/></dd>
<dt><b>-normal_angle_delta</b> \<Real\></dt>
<dd>Perturbation of normal angle in degrees.<br/></dd>
<dt><b>-normal_search_cycles</b> \<Real\></dt>
<dd>Number of iterations for normal search.<br/></dd>
<dt><b>-chain_normal_angle_max</b> \<Real\></dt>
<dd>Maximum of normal angle wrt normal_start for chain embedding. Degrees.<br/></dd>
<dt><b>-pose_normal_angle_max</b> \<Real\></dt>
<dd>Maximum of normal angle wrt normal_start for pose embedding. Degrees.<br/></dd>
<dt><b>-no_interpolate_Mpair</b> \<Boolean\></dt>
<dd>from old code.<br/></dd>
<dt><b>-Hbond_depth_correction</b> \<Boolean\></dt>
<dd>from old code.<br/></dd>
<dt><b>-TMprojection</b> \<Boolean\></dt>
<dd>Penalty for hydrophobic mismatch on/off.<br/></dd>
<dt><b>-wt_TMprojection</b> \<Real\></dt>
<dd>Weight for hydrophobic mismatch penalty.<br/></dd>
<dt><b>-non_helix</b> \<Boolean\></dt>
<dd>Penalty for non-helix residues in the membrane on/off.<br/></dd>
<dt><b>-wt_non_helix</b> \<Real\></dt>
<dd>Weight for non-helix penalty. <br/></dd>
<dt><b>-termini</b> \<Boolean\></dt>
<dd>Penalty for termini in the membrane on/off.<br/></dd>
<dt><b>-wt_termini</b> \<Real\></dt>
<dd>Weight for termini penalty.<br/></dd>
<dt><b>-secstruct</b> \<Boolean\></dt>
<dd>Penalty if structure-based secondary structure doesn't match predicted one - on/off<br/></dd>
<dt><b>-wt_secstruct</b> \<Real\></dt>
<dd>Weight for secondary structure penalty.<br/></dd>
<dt><b>-spanning</b> \<Boolean\></dt>
<dd>Penalty if structure-based spanning doesn't match spanfile - on/off.<br/></dd>
<dt><b>-wt_spanning</b> \<Real\></dt>
<dd>Weight for spanning penalty.<br/></dd>
</dl>
+ <h3>-mp:lipids</h3>
<dl>
<dt><b>-lipids</b> \<Boolean\></dt>
<dd>lipids option group<br/></dd>
<dt><b>-composition</b> \<String\></dt>
<dd>Type of lipids to use in implicit model representation.<br/>Default: "DLPC"<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>Temperature at which the lipid composition parameters were measured<br/>Default: 37.0<br/></dd>
<dt><b>-has_pore</b> \<Boolean\></dt>
<dd>Manual override don't use pore estimation<br/></dd>
</dl>
+ <h3>-mp:viewer</h3>
<dl>
<dt><b>-viewer</b> \<Boolean\></dt>
<dd>viewer option group<br/></dd>
<dt><b>-thickness</b> \<Real\></dt>
<dd>Thickness of membrane to visualize<br/>Default: 15<br/></dd>
<dt><b>-num_points</b> \<Integer\></dt>
<dd>Number of points to define the membrane planes. x >= 3<br/></dd>
</dl>
+ <h3>-mp:visualize</h3>
<dl>
<dt><b>-visualize</b> \<Boolean\></dt>
<dd>visualize option group<br/></dd>
<dt><b>-embedding</b> \<Boolean\></dt>
<dd>Visualize embedding centers and normals for each pose element<br/>Default: true<br/></dd>
<dt><b>-spacing</b> \<Real\></dt>
<dd>Spacing of virtual membrane residues representing the membrane planes<br/>Default: 5<br/></dd>
<dt><b>-width</b> \<Real\></dt>
<dd>Width of membrane planes for n by n plane<br/>Default: 100<br/></dd>
<dt><b>-thickness</b> \<Real\></dt>
<dd>Thickness of membrane to visualize<br/>Default: 15<br/></dd>
<dt><b>-plane_radius</b> \<Real\></dt>
<dd>Radius of membrane planes to draw in PyMOL - part of the PyMOL viewer plugin<br/></dd>
</dl>
+ <h3>-mp:scoring</h3>
<dl>
<dt><b>-scoring</b> \<Boolean\></dt>
<dd>scoring option group<br/></dd>
<dt><b>-hbond</b> \<Boolean\></dt>
<dd>Hydrogen bonding energy correction for membrane proteins<br/>Default: false<br/></dd>
</dl>
+ <h3>-mp:setup</h3>
<dl>
<dt><b>-setup</b> \<Boolean\></dt>
<dd>setup option group<br/></dd>
<dt><b>-spanfiles</b> \<StringVector\></dt>
<dd>Spanning topology file from Octopus<br/></dd>
<dt><b>-spans_from_structure</b> \<Boolean\></dt>
<dd>Uses spanning topology computed from the PDB; requires the protein to be transformed into the membrane coordinate frame!<br/></dd>
<dt><b>-lipsfile</b> \<String\></dt>
<dd>List of lips files by chain<br/>Default: "mypdb.lips4"<br/></dd>
<dt><b>-center</b> \<RealVector\></dt>
<dd>membrane center x,y,z<br/></dd>
<dt><b>-normal</b> \<RealVector\></dt>
<dd>membrane normal x,y,z<br/></dd>
<dt><b>-membrane_rsd</b> \<Real\></dt>
<dd>membrane residue number<br/></dd>
<dt><b>-transform_into_membrane</b> \<Boolean\></dt>
<dd>score_jd2: transform protein into fixed membrane before scoring; spanfile required<br/></dd>
<dt><b>-position_from_topo</b> \<Boolean\></dt>
<dd>determine a membrane position from the transmembrane spans of the protein<br/></dd>
<dt><b>-optimize1</b> \<Boolean\></dt>
<dd>Optimize position in membrane for partner 1 using membrane scorefunction.<br/>Default: false<br/></dd>
<dt><b>-optimize2</b> \<Boolean\></dt>
<dd>Optimize position in membrane for partner 2 using membrane scorefunction.<br/>Default: false<br/></dd>
</dl>
+ <h3>-mp:lipid_acc</h3>
<dl>
<dt><b>-lipid_acc</b> \<Boolean\></dt>
<dd>lipid_acc option group<br/></dd>
<dt><b>-angle_cutoff</b> \<Real\></dt>
<dd>Cutoff for CA-CB-COM angle to identify lipid accessible residues, in degrees. <90 faces towards COM, >90 faces away from COM.<br/>Default: 65<br/></dd>
<dt><b>-slice_width</b> \<Real\></dt>
<dd>Width of the slice in Angstrom to compute hull.<br/>Default: 10.0<br/></dd>
<dt><b>-shell_radius</b> \<Real\></dt>
<dd>Radius of shell from outermost atoms that are still counted as boundary, i.e. how thick is lipid-exposed layer from the outside.<br/>Default: 5.0<br/></dd>
<dt><b>-dist_cutoff</b> \<Real\></dt>
<dd>Distances between boundary atoms longer than this cutoff (in 2D) will be cut in. Anything larger will be kept as boundary atoms.<br/>Default: 5.0<br/></dd>
<dt><b>-tm_alpha</b> \<Boolean\></dt>
<dd>Is the main secondary structure in the membrane helical?<br/>Default: true<br/></dd>
</dl>
+ <h3>-mp:transform</h3>
<dl>
<dt><b>-transform</b> \<Boolean\></dt>
<dd>transform option group<br/></dd>
<dt><b>-optimize_embedding</b> \<Boolean\></dt>
<dd>Use the scorefunction to optimize the embedding after an initial coarse grained setting<br/></dd>
</dl>
+ <h3>-mp:assembly</h3>
<dl>
<dt><b>-assembly</b> \<Boolean\></dt>
<dd>assembly option group<br/></dd>
<dt><b>-TM_pose_number</b> \<Integer\></dt>
<dd>Number of the PDB file in the -in:file:l list which is located in the membrane. Integer<br/></dd>
<dt><b>-poses</b> \<StringVector\></dt>
<dd>Filenames of the PDB files to consider. StringVector.<br/></dd>
</dl>
+ <h3>-mp:dock</h3>
<dl>
<dt><b>-dock</b> \<Boolean\></dt>
<dd>dock option group<br/></dd>
<dt><b>-weights_cen</b> \<String\></dt>
<dd>Scorefunction for low-resolution step.<br/></dd>
<dt><b>-weights_fa</b> \<String\></dt>
<dd>Scorefunction for high-resolution step.<br/></dd>
<dt><b>-lowres</b> \<Boolean\></dt>
<dd>Use centroid score function for finding interface.<br/></dd>
<dt><b>-allow_flips</b> \<Boolean\></dt>
<dd>Allow partner 2 to flip in the membrane during global search. Default: yes.<br/></dd>
<dt><b>-flexible_bb</b> \<Boolean\></dt>
<dd>Do a flexible backbone docking: runs relax before and after docking.<br/></dd>
<dt><b>-flexible_sc</b> \<Boolean\></dt>
<dd>Do a flexible sidechain docking: repacks before and after docking.<br/></dd>
<dt><b>-slide_threshold</b> \<Real\></dt>
<dd>Theshold for scoreterm to define partner closeness in SlideIntoContact.<br/></dd>
</dl>
+ <h3>-mp:quickrelax</h3>
<dl>
<dt><b>-quickrelax</b> \<Boolean\></dt>
<dd>quickrelax option group<br/></dd>
<dt><b>-angle_max</b> \<Real\></dt>
<dd>Maximum allowed change in dihedral angles. Typical values around 1.<br/></dd>
<dt><b>-nmoves</b> \<String\></dt>
<dd>Number of moves allowed. Typical value is close to the number of residues in the protein: [nres] is allowed value. <br/></dd>
<dt><b>-repack_again</b> \<Boolean\></dt>
<dd>Do an additional round of sidechain repacking, simultaneously including all sidechains.<br/></dd>
</dl>
+ <h3>-mp:mutate_relax</h3>
<dl>
<dt><b>-mutate_relax</b> \<Boolean\></dt>
<dd>mutate_relax option group<br/></dd>
<dt><b>-mutation</b> \<StringVector\></dt>
<dd>Vector of single mutations: Format: One-letter code / residue number / one-letter code. Example: A163F<br/></dd>
<dt><b>-mutant_file</b> \<String\></dt>
<dd>Input file containing mutations<br/></dd>
<dt><b>-nmodels</b> \<Integer\></dt>
<dd>Number of models to produce per construct. Typically between 50 and 1,000.<br/></dd>
<dt><b>-repack_mutation_only</b> \<Boolean\></dt>
<dd>Boolean - Only repack the mutated residue(s), no relax.<br/></dd>
<dt><b>-repack_radius</b> \<Real\></dt>
<dd>Float - Repack within a radius of X Angstrom of the mutated residue(s).<br/></dd>
<dt><b>-relax</b> \<Boolean\></dt>
<dd>Boolean - Do a full relax run with both backbone minimization and repacking.<br/></dd>
</dl>
+ <h3>-mp:benchmark</h3>
<dl>
<dt><b>-benchmark</b> \<Boolean\></dt>
<dd>benchmark option group<br/></dd>
</dl>
+ <h4>-mp:benchmark:ideal_helix</h4>
<dl>
<dt><b>-ideal_helix</b> \<Boolean\></dt>
<dd>ideal_helix option group<br/></dd>
<dt><b>-helix_start</b> \<Real\></dt>
<dd>Start position for ideal helix dihedral angles<br/></dd>
<dt><b>-helix_end</b> \<Real\></dt>
<dd>End position for ideal helix dihedral angles<br/></dd>
</dl>
+ <h4>-mp:benchmark:tilt_angle</h4>
<dl>
<dt><b>-tilt_angle</b> \<Boolean\></dt>
<dd>tilt_angle option group<br/></dd>
<dt><b>-output</b> \<String\></dt>
<dd>Path to tilt angle vs. score output file<br/></dd>
</dl>
+ <h3>-mp:output</h3>
<dl>
<dt><b>-output</b> \<Boolean\></dt>
<dd>output option group<br/></dd>
<dt><b>-normalize_to_thk</b> \<Boolean\></dt>
<dd>Output an additional MEM resdiue data in the PDB where the membrane normal is scaled to match the current membrane thickness (Makes sense for IMM Models<br/></dd>
</dl>
+ <h2>-membrane</h2>
<dl>
<dt><b>-membrane</b> \<Boolean\></dt>
<dd>membrane option group<br/></dd>
<dt><b>-normal_cycles</b> \<Integer\></dt>
<dd>number of membrane normal cycles<br/>Default: 100<br/></dd>
<dt><b>-normal_mag</b> \<Real\></dt>
<dd>magnitude of membrane normal angle search (degrees)<br/>Default: 5<br/></dd>
<dt><b>-center_mag</b> \<Real\></dt>
<dd>magnitude of membrane normal center search (Angstroms)<br/>Default: 1<br/></dd>
<dt><b>-smooth_move_frac</b> \<Real\></dt>
<dd>No description<br/>Default: 0.5<br/></dd>
<dt><b>-no_interpolate_Mpair</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-Menv_penalties</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-Membed_init</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-Fa_Membed_update</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-center_search</b> \<Boolean\></dt>
<dd>perform membrane center search<br/>Default: false<br/></dd>
<dt><b>-normal_search</b> \<Boolean\></dt>
<dd>perform membrane normal search<br/>Default: false<br/></dd>
<dt><b>-center_max_delta</b> \<Integer\></dt>
<dd>magnitude of maximum membrane width deviation during membrane center search (Angstroms)<br/>Default: 5<br/></dd>
<dt><b>-normal_start_angle</b> \<Integer\></dt>
<dd>magnitude of starting angle during membrane normal search (degrees)<br/>Default: 10<br/></dd>
<dt><b>-normal_delta_angle</b> \<Integer\></dt>
<dd>magnitude of angle deviation during membrane normal search (degrees)<br/>Default: 10<br/></dd>
<dt><b>-normal_max_angle</b> \<Integer\></dt>
<dd>magnitude of maximum angle deviation during membrane normal search (degrees)<br/>Default: 40<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-fixed_membrane</b> \<Boolean\></dt>
<dd>fix membrane position, by default the center is at [0,0,0] and membrane normal is the z-axis<br/>Default: false<br/></dd>
<dt><b>-membrane_center</b> \<RealVector\></dt>
<dd>membrane center x,y,z<br/></dd>
<dt><b>-membrane_normal</b> \<RealVector\></dt>
<dd>membrane normal x,y,z<br/></dd>
<dt><b>-view</b> \<Boolean\></dt>
<dd>viewing pose during protocol<br/>Default: false<br/></dd>
<dt><b>-Mhbond_depth</b> \<Boolean\></dt>
<dd>membrane depth dependent correction to the hbond potential<br/>Default: false<br/></dd>
<dt><b>-thickness</b> \<Real\></dt>
<dd>one leaflet hydrocarbon thickness for solvation calculations (Angstroms)<br/>Default: 15<br/></dd>
</dl>
+ <h2>-mistakes</h2>
<dl>
<dt><b>-mistakes</b> \<Boolean\></dt>
<dd>mistakes option group<br/></dd>
<dt><b>-restore_pre_talaris_2013_behavior</b> \<Boolean\></dt>
<dd>Restore the set of defaults that were in place before the Talaris2013 parameters were made default.  This is an umbrella flag and sets the following flags if they are not set on the command line to some other value -mistakes::chemical::pre_talaris2013_geometries true -corrections::score::dun10 false -corrections::score::use_bicubic_interpolation false -corrections::score:hb_sp2_chipen false -corrections::score::hb_fade_energy false -corrections::score::hbond_measure_sp3acc_BAH_from_hvy false -corrections::score::lj_hbond_hdis 1.95 -corrections::score::lj_hbond_OH_donor_dis 3.0 -corrections::chemical::expand_st_chi2sampling false -score::weights pre_talaris_2013_standard.wts -score::patch score12.wts_patch -score::analytic_etable_evaluation false -score::hbond_params score12_params -score::smooth_fa_elec false -score::elec_min_dis 1.5 -chemical::set_atom_properties fa_standard:ONH2:LK_DGFREE:-10.0 fa_standard:NH2O:LK_DGFREE:-10.0 fa_standard:Narg:LK_DGFREE:-11.0 fa_standard:OH:LK_DGFREE:-6.77<br/>Default: false<br/></dd>
</dl>
+ <h3>-mistakes:chemical</h3>
<dl>
<dt><b>-chemical</b> \<Boolean\></dt>
<dd>chemical option group<br/></dd>
<dt><b>-pre_talaris2013_geometries</b> \<Boolean\></dt>
<dd>Use the version of the fa_standard geometries that were active before the Talaris2013 parameters were taken as default<br/>Default: false<br/></dd>
</dl>
+ <h2>-MonteCarlo</h2>
<dl>
<dt><b>-MonteCarlo</b> \<Boolean\></dt>
<dd>MonteCarlo option group<br/></dd>
<dt><b>-temp_initial</b> \<Real\></dt>
<dd>initial temperature for Monte Carlo considerations<br/>Range: 0.001-<br/>Default: 2<br/></dd>
<dt><b>-temp_final</b> \<Real\></dt>
<dd>final temperature for Monte Carlo considerations<br/>Range: 0.001-<br/>Default: 0.6<br/></dd>
</dl>
+ <h2>-optimization</h2>
<dl>
<dt><b>-optimization</b> \<Boolean\></dt>
<dd>optimization option group<br/></dd>
<dt><b>-default_max_cycles</b> \<Integer\></dt>
<dd>max cycles for MinimizerOptions<br/>Default: 2000<br/></dd>
<dt><b>-armijo_min_stepsize</b> \<Real\></dt>
<dd>min stepsize in armijo minimizer<br/>Default: 1e-8<br/></dd>
<dt><b>-scale_normalmode_dampen</b> \<Real\></dt>
<dd>dampening scale over normal mode index, used for NormalModeMinimizer<br/>Default: 0.05<br/></dd>
<dt><b>-lbfgs_M</b> \<Integer\></dt>
<dd>number of corrections to approximate the inverse hessian matrix.<br/>Default: 128<br/></dd>
<dt><b>-scale_d</b> \<Real\></dt>
<dd>max cycles for MinimizerOptions<br/>Default: 1<br/></dd>
<dt><b>-scale_theta</b> \<Real\></dt>
<dd>max cycles for MinimizerOptions<br/>Default: 1<br/></dd>
<dt><b>-scale_rb</b> \<Real\></dt>
<dd>max cycles for MinimizerOptions<br/>Default: 10<br/></dd>
<dt><b>-scale_rbangle</b> \<Real\></dt>
<dd>max cycles for MinimizerOptions<br/>Default: 1<br/></dd>
<dt><b>-scmin_nonideal</b> \<Boolean\></dt>
<dd>Do we allow sidechain nonideality during scmin (e.g. rtmin and min_pack)<br/>Default: false<br/></dd>
<dt><b>-scmin_cartesian</b> \<Boolean\></dt>
<dd>Toggle Cartesian-space minimization during scmin (e.g. rmin and min_pack)<br/>Default: false<br/></dd>
<dt><b>-nonideal</b> \<Boolean\></dt>
<dd>Permit bond geometries to vary from ideal values<br/>Default: false<br/></dd>
<dt><b>-old_sym_min</b> \<Boolean\></dt>
<dd>Use the old approach to symmetric minimization<br/>Default: false<br/></dd>
<dt><b>-debug_inaccurate_G</b> \<Boolean\></dt>
<dd>Debug innacurate G messages<br/>Default: false<br/></dd>
</dl>
+ <h2>-orbitals</h2>
<dl>
<dt><b>-orbitals</b> \<Boolean\></dt>
<dd>orbitals option group<br/></dd>
<dt><b>-Hpol</b> \<Boolean\></dt>
<dd>look at only polar hydrogen interactions<br/>Default: false<br/></dd>
<dt><b>-Haro</b> \<Boolean\></dt>
<dd>look at only aromatic hydrogen interactions<br/>Default: false<br/></dd>
<dt><b>-bb_stats</b> \<Boolean\></dt>
<dd>look at orbital backbone stats<br/>Default: false<br/></dd>
<dt><b>-sc_stats</b> \<Boolean\></dt>
<dd>look at orbital sc stats<br/>Default: false<br/></dd>
</dl>
+ <h2>-pose_metrics</h2>
<dl>
<dt><b>-pose_metrics</b> \<Boolean\></dt>
<dd>pose_metrics option group<br/></dd>
<dt><b>-atomic_burial_cutoff</b> \<Real\></dt>
<dd> maximum SASA that is allowed for an atom to count as buried for the BuriedUnsatisfiedPolarsCalculator<br/>Default: 0.3<br/></dd>
<dt><b>-sasa_calculator_probe_radius</b> \<Real\></dt>
<dd> the probe radius used in the SASA calculator (and thus implicitly in the BuriedUnsatisfiedPolarsCalculator<br/>Default: 1.4<br/></dd>
<dt><b>-interface_cutoff</b> \<Real\></dt>
<dd>distance in angstroms (def. 10.0) for calculating what residues are at an interface via InterfaceNeighborDefinitionCalculator<br/>Default: 10.0<br/></dd>
<dt><b>-min_sequence_separation</b> \<Integer\></dt>
<dd> minimum number of sequence positions that two residues need to be apart to count as nonlocal in the NonlocalContactsCalculator<br/>Default: 6<br/></dd>
<dt><b>-contact_cutoffE</b> \<Real\></dt>
<dd> maximum interaction energy allowed between two residues to count as a contact in the NonlocalContactsCalculator<br/>Default: -1.0<br/></dd>
<dt><b>-neighbor_by_distance_cutoff</b> \<Real\></dt>
<dd>distance in angstroms (def. 10.0) for calculating neighbors of a residue via NeighborByDistanceCalculator<br/>Default: 10.0<br/></dd>
<dt><b>-inter_group_neighbors_cutoff</b> \<Real\></dt>
<dd>distance in angstroms (def. 10.0) for calculating interfaces between domains with InterGroupNeighborsCalculator<br/>Default: 10.0<br/></dd>
<dt><b>-semiex_water_burial_cutoff</b> \<Real\></dt>
<dd>water hbond states fraction cutiff for SemiExplicitWaterUnsatisfiedPolarsCalculator (0.0,1.0)<br/>Default: 0.25<br/></dd>
</dl>
+ <h3>-pose_metrics:shobuns</h3>
<dl>
<dt><b>-shobuns</b> \<Boolean\></dt>
<dd>shobuns option group<br/></dd>
<dt><b>-tgt_amino</b> \<String\></dt>
<dd>Target amino acid type<br/>Default: "_none_"<br/></dd>
<dt><b>-tgt_atom</b> \<String\></dt>
<dd>Target atom name<br/>Default: "_none_"<br/></dd>
<dt><b>-tgt_res</b> \<File\></dt>
<dd>File specifying a subset of target residues<br/>Default: ""<br/></dd>
<dt><b>-sho_cutoff</b> \<Real\></dt>
<dd>max SHO value for an atom to be considered solvent exposed<br/>Default: 4.9<br/></dd>
</dl>
+ <h2>-rigid</h2>
<dl>
<dt><b>-rigid</b> \<Boolean\></dt>
<dd>rigid option group<br/></dd>
<dt><b>-chainbreak_bias</b> \<Real\></dt>
<dd>Strength of bias applied to the translation component of rigid body moves to close chainbreak<br/>Default: 0.00<br/></dd>
<dt><b>-close_loops</b> \<Boolean\></dt>
<dd>Perform loop closure at the end of medal<br/>Default: true<br/></dd>
<dt><b>-fragment_cycles</b> \<Integer\></dt>
<dd>Number of fragment insertion/rigid body cycles<br/>Default: 10000<br/></dd>
<dt><b>-log_accepted_moves</b> \<Boolean\></dt>
<dd>Write accepted moves to silent file output<br/>Default: false<br/></dd>
<dt><b>-max_ca_ca_dist</b> \<Real\></dt>
<dd>Maximum distance between consecutive CA atoms before chunk partitioning occurs<br/>Default: 5.0<br/></dd>
<dt><b>-patch</b> \<File\></dt>
<dd>Patch file containing energy terms and their respective weights<br/></dd>
<dt><b>-residues_backbone_move</b> \<Integer\></dt>
<dd>Number of residues perturbed by a backbone move<br/>Default: 5<br/></dd>
<dt><b>-rotation</b> \<Real\></dt>
<dd>Rotation magnitude<br/>Default: 2.5<br/></dd>
<dt><b>-sampling_prob</b> \<File\></dt>
<dd>Normalized, per-residue sampling probabilities<br/></dd>
<dt><b>-score</b> \<String\></dt>
<dd>Centroid-level score function<br/>Default: "score3"<br/></dd>
<dt><b>-sequence_separation</b> \<Integer\></dt>
<dd>Maximum sequence separation for scoring chainbreaks<br/>Default: 20<br/></dd>
<dt><b>-small_cycles</b> \<Integer\></dt>
<dd>Number of small/shear cycles<br/>Default: 8000<br/></dd>
<dt><b>-stages</b> \<Integer\></dt>
<dd>Number of stages over which to interpolate ramped values<br/>Default: 4<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>Monte Carlo temperature<br/>Default: 2.0<br/></dd>
<dt><b>-translation</b> \<Real\></dt>
<dd>Translation magnitude<br/>Default: 0.5<br/></dd>
</dl>
+ <h2>-sasa</h2>
<dl>
<dt><b>-sasa</b> \<Boolean\></dt>
<dd>sasa option group<br/></dd>
<dt><b>-method</b> \<String\></dt>
<dd>The method used to calculate sasa.  More will hopefully be added in the future.<br/>Default: "LeGrand"<br/></dd>
<dt><b>-include_hydrogens_explicitly</b> \<Boolean\></dt>
<dd>Include hydrogens explicitly in the calculation.  Explicit vs implicit calculations use different radii sets.  These default sets can be controlled via cmd line.  Historically, calculations included hydrogens implicitly.  Some protocols may overwrite this setting to their needs.<br/>Default: true<br/></dd>
<dt><b>-probe_radius</b> \<Real\></dt>
<dd>Probe radius used by SasaCalc.  Default is radius of water.  1.2 is also commonly used.<br/>Default: 1.4<br/></dd>
<dt><b>-include_probe_radius_in_atom_radii</b> \<Boolean\></dt>
<dd>This is typically done in calculation of SASA, and in fact is one of the defining features of SASA.  Turn this off to calculate the Surface Area instead.<br/>Default: true<br/></dd>
<dt><b>-include_only_C_S_in_hsasa</b> \<Boolean\></dt>
<dd>Include only carbon or sulfer in hsasa calculation.  This is typical.  Only revert to false if excluding polar atoms by charge or everything will be counted as hydrophobic. Note hydrogens are dealt with automatically.<br/>Default: true<br/></dd>
<dt><b>-exclude_polar_atoms_by_charge_in_hsasa</b> \<Boolean\></dt>
<dd>Polar carbons and other atoms should not be included in hydrophobic hSASA - though historically they were.  Set this to false to get historic hsasa<br/>Default: false<br/></dd>
<dt><b>-polar_charge_cutoff</b> \<Real\></dt>
<dd>Charge cutoff (abs value) to use on heavy atoms if excluding hydrophobic atoms from hSASA calculation by charge. The default is optimized for protein atom types (which excludes only carbonyl and carboxyl carbons.  By default only carbon and sulfer are excluded.<br/>Default: .4<br/></dd>
<dt><b>-implicit_hydrogen_radii_set</b> \<String\></dt>
<dd>The radii set to use when including hydrogens implicitly instead of explicitly. Chothia 1976 radii are used by the program Naccess.  chothia=naccess<br/>Default: "chothia"<br/></dd>
<dt><b>-explicit_hydrogen_radii_set</b> \<String\></dt>
<dd>The radii set to use when including hydrogens explicitly. Default is reduce, which was generally agreed upon at Minicon 2014 and come from original data from Bondi (1964) and Gavezzotti (1983) .  LJ are the Rosetta leonard-jones radii, which are not quite exactly from Charmm.  Legacy radii were optimized for a no-longer-in-Rosetta scoreterm (Jerry Tsai et al 2003)<br/>Default: "reduce"<br/></dd>
</dl>
+ <h2>-symmetry</h2>
<dl>
<dt><b>-symmetry</b> \<Boolean\></dt>
<dd>symmetry option group<br/></dd>
<dt><b>-symmetry_definition</b> \<String\></dt>
<dd>Text file describing symmetry setup<br/></dd>
<dt><b>-reweight_symm_interactions</b> \<Real\></dt>
<dd>Scale intersubunit interactions by a specified weight<br/>Default: 1.0<br/></dd>
<dt><b>-initialize_rigid_body_dofs</b> \<Boolean\></dt>
<dd>Initialize the RB dofs from the symmetry definition file?<br/>Default: false<br/></dd>
<dt><b>-detect_bonds</b> \<Boolean\></dt>
<dd>allow new cross subunit bond formation<br/>Default: true<br/></dd>
<dt><b>-perturb_rigid_body_dofs</b> \<RealVector\></dt>
<dd>(As in docking) Do a small perturbation of the symmetric DOFs: -perturb_rigid_body_dofs ANGSTROMS DEGREES<br/></dd>
<dt><b>-symmetric_rmsd</b> \<Boolean\></dt>
<dd>calculate the rmsd symmetrically by checking all chain orderings<br/></dd>
</dl>
+ <h2>-abinitio</h2>
<dl>
<dt><b>-abinitio</b> \<Boolean\></dt>
<dd>Ab initio mode<br/></dd>
<dt><b>-membrane</b> \<Boolean\></dt>
<dd>will use the membrane abinitio protocol. sequential insertion of TMH<br/>Default: false<br/></dd>
<dt><b>-use_loophash_filter</b> \<Boolean\></dt>
<dd>use loophash filter to determine if SSEs too far away<br/></dd>
<dt><b>-loophash_filter_acceptance_rate</b> \<Real\></dt>
<dd>fraction at which want to accept poses from loophash filter if no loophash hits found<br/></dd>
<dt><b>-kill_hairpins</b> \<File\></dt>
<dd>setup hairpin killing in score (kill hairpin file or psipred file)<br/></dd>
<dt><b>-kill_hairpins_frequency</b> \<Real\></dt>
<dd>automated hairpin killing frequency (for use with psipred file)<br/>Default: 0.2<br/></dd>
<dt><b>-smooth_cycles_only</b> \<Boolean\></dt>
<dd>Only smooth cycles in abinitio protocol<br/>Default: false<br/></dd>
<dt><b>-relax</b> \<Boolean\></dt>
<dd>Do a relax after abinitio = abrelax ?<br/></dd>
<dt><b>-final_clean_relax</b> \<Boolean\></dt>
<dd>Do a final relax without constraints<br/></dd>
<dt><b>-fastrelax</b> \<Boolean\></dt>
<dd>Do a fastrelax after abinitio = abfastrelax ?<br/></dd>
<dt><b>-multifastrelax</b> \<Boolean\></dt>
<dd>Do a fastrelax after abinitio = abfastrelax ?<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-clear_pose_cache</b> \<Boolean\></dt>
<dd>always clear extra-scores away before output<br/>Default: false<br/></dd>
<dt><b>-explicit_pdb_debug</b> \<Boolean\></dt>
<dd>always dump pdb (not silent ) files during abinitio stages<br/>Default: false<br/></dd>
<dt><b>-use_filters</b> \<Boolean\></dt>
<dd>use RG, contact-order and sheet filters <br/>Default: false<br/></dd>
<dt><b>-increase_cycles</b> \<Real\></dt>
<dd>Increase number of cycles at each stage of fold_abinitio (or pose_abinitio) by this factor<br/>Range: 0.001-<br/>Default: 1.0<br/></dd>
<dt><b>-number_3mer_frags</b> \<Integer\></dt>
<dd>Number of top 3mer fragments to use in fold_abinitio protocol<br/>Range: 0-<br/>Default: 200<br/></dd>
<dt><b>-number_9mer_frags</b> \<Integer\></dt>
<dd>Number of top 9mer fragments to use in fold_abinitio protocol<br/>Range: 0-<br/>Default: 25<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>Temperature used in fold_abinitio<br/>Default: 2.0<br/></dd>
<dt><b>-rg_reweight</b> \<Real\></dt>
<dd>Reweight contribution of radius of gyration to total score by this scale factor<br/>Default: 1.0<br/></dd>
<dt><b>-rsd_wt_helix</b> \<Real\></dt>
<dd>Reweight env,pair,cb for helix residues by this factor<br/>Default: 1.0<br/></dd>
<dt><b>-rsd_wt_strand</b> \<Real\></dt>
<dd>Reweight env,pair,cb for strand residues by this factor<br/>Default: 1.0<br/></dd>
<dt><b>-rsd_wt_loop</b> \<Real\></dt>
<dd>Reweight env,pair,cb for loop residues by this factor<br/>Default: 1.0<br/></dd>
<dt><b>-skip_convergence_check</b> \<Boolean\></dt>
<dd>this option turns off the convergence check in stage3 (score 2/5)<br/></dd>
<dt><b>-stage1_patch</b> \<FileVector\></dt>
<dd>Name of weights patch file (without extension .wts) to use during stage1 abinitio<br/></dd>
<dt><b>-stage2_patch</b> \<FileVector\></dt>
<dd>Name of weights patch file (without extension .wts) to use during stage2 abinitio<br/></dd>
<dt><b>-stage3a_patch</b> \<FileVector\></dt>
<dd>Name of weights patch file (without extension .wts) to use during stage3a abinitio<br/></dd>
<dt><b>-stage3b_patch</b> \<FileVector\></dt>
<dd>Name of weights patch file (without extension .wts) to use during stage3b abinitio<br/></dd>
<dt><b>-stage4_patch</b> \<FileVector\></dt>
<dd>Name of weights patch file (without extension .wts) to use during stage4 abinitio<br/></dd>
<dt><b>-stage5_patch</b> \<FileVector\></dt>
<dd>Name of weights patch file (without extension .wts) to use during stage5 abinitio<br/></dd>
<dt><b>-steal_3mers</b> \<Boolean\></dt>
<dd>stealing: use 3mers from native<br/>Default: false<br/></dd>
<dt><b>-steal_9mers</b> \<Boolean\></dt>
<dd>stealing: use 9mers from native<br/>Default: false<br/></dd>
<dt><b>-no_write_failures</b> \<Boolean\></dt>
<dd>dont write failed structures to silent-out<br/>Default: false<br/></dd>
<dt><b>-relax_failures</b> \<Boolean\></dt>
<dd>relax failures anyway<br/>Default: false<br/></dd>
<dt><b>-relax_with_jumps</b> \<Boolean\></dt>
<dd>switch to allow relax even if loops are not closed <br/>Default: false<br/></dd>
<dt><b>-process_store</b> \<Boolean\></dt>
<dd>run process_decoy on each structure in the structure store<br/>Default: false<br/></dd>
<dt><b>-fix_residues_to_native</b> \<IntegerVector\></dt>
<dd>these residues torsions are copied from native and fixed<br/>Default: 0<br/></dd>
<dt><b>-return_full_atom</b> \<Boolean\></dt>
<dd>return a full-atom structure even if no relax is done<br/>Default: false<br/></dd>
<dt><b>-detect_disulfide_before_relax</b> \<Boolean\></dt>
<dd>run detect_disulfides() before relax<br/>Default: false<br/></dd>
<dt><b>-close_loops</b> \<Boolean\></dt>
<dd>close loops<br/>Default: false<br/></dd>
<dt><b>-bGDT</b> \<Boolean\></dt>
<dd>compute gdtmmm<br/>Default: true<br/></dd>
<dt><b>-dump_frags</b> \<Boolean\></dt>
<dd>for control purposes... dump fragments<br/>Default: false<br/></dd>
<dt><b>-jdist_rerun</b> \<Boolean\></dt>
<dd>go through intput structures and evaluate ( pca, rmsd, cst-energy )<br/>Default: false<br/></dd>
<dt><b>-perturb</b> \<Real\></dt>
<dd>add some perturbation (gaussian) to phi/psi of native<br/>Default: 0.0<br/></dd>
<dt><b>-rerun</b> \<Boolean\></dt>
<dd>go through intput structures and evaluate ( pca, rmsd, cst-energy )<br/>Default: false<br/></dd>
<dt><b>-rmsd_residues</b> \<IntegerVector\></dt>
<dd>give start and end residue for rmsd calcul.<br/>Default: -1<br/></dd>
<dt><b>-start_native</b> \<Boolean\></dt>
<dd>start from native structure (instead of extended)<br/>Default: false<br/></dd>
<dt><b>-cyclic_peptide</b> \<Boolean\></dt>
<dd>set up cyclic peptide (N-to-C cyclization) constraints for abinitio runs<br/>Default: false<br/></dd>
<dt><b>-debug_structures</b> \<Boolean\></dt>
<dd>write structures to debug-out files<br/>Default: false<br/></dd>
<dt><b>-log_frags</b> \<File\></dt>
<dd>fragment insertions (each trial) will be logged to file<br/>Default: ""<br/></dd>
<dt><b>-only_stage1</b> \<Boolean\></dt>
<dd>useful for benchmarks sets cycle of all higher stages to 0<br/>Default: false<br/></dd>
<dt><b>-end_bias</b> \<Real\></dt>
<dd>set the endbias for Fragment moves<br/>Default: 30.0<br/></dd>
<dt><b>-apply_end_bias</b> \<Boolean\></dt>
<dd>eliminate the endbias for Fragment moves<br/>Default: true<br/></dd>
<dt><b>-symmetry_residue</b> \<Integer\></dt>
<dd>hacky symmetry mode for dimers, fragments are inserted at i and i + SR - 1<br/>Default: -1<br/></dd>
<dt><b>-vdw_weight_stage1</b> \<Real\></dt>
<dd>vdw weight in stage1<br/>Default: 1.0<br/></dd>
<dt><b>-override_vdw_all_stages</b> \<Boolean\></dt>
<dd>apply vdw_weight_stage1 for all stages<br/>Default: false<br/></dd>
<dt><b>-recover_low_in_stages</b> \<IntegerVector\></dt>
<dd>say default: 2 3 4 recover_low happens in stages 2 3 4<br/>Default: 0<br/></dd>
<dt><b>-skip_stages</b> \<IntegerVector\></dt>
<dd>say: 2 3 4, and it will skip stages 2 3 4<br/>Default: 0<br/></dd>
<dt><b>-close_chbrk</b> \<Boolean\></dt>
<dd>Chain break closure during classic abinito <br/>Default: false<br/></dd>
<dt><b>-include_stage5</b> \<Boolean\></dt>
<dd>stage5 contains small moves only<br/>Default: false<br/></dd>
<dt><b>-close_loops_by_idealizing</b> \<Boolean\></dt>
<dd>close loops by idealizing the structure after stage 4<br/>Default: false<br/></dd>
<dt><b>-optimize_cutpoints_using_kic</b> \<Boolean\></dt>
<dd>optimize around cutpoints using kinematic relax<br/>Default: false<br/></dd>
<dt><b>-optimize_cutpoints_margin</b> \<Integer\></dt>
<dd><br/>Default: 5<br/></dd>
</dl>
+ <h3>-abinitio:star</h3>
<dl>
<dt><b>-star</b> \<Boolean\></dt>
<dd>star option group<br/></dd>
<dt><b>-initial_dist_cutoff</b> \<Real\></dt>
<dd>Maximum distance cutoff for restraints that constrain aligned residues to their initial positions<br/>Default: 8.0<br/></dd>
<dt><b>-min_unaligned_len</b> \<Integer\></dt>
<dd>Minimum length of an unaligned region<br/>Default: 3<br/></dd>
</dl>
+ <h2>-abrelax</h2>
<dl>
<dt><b>-abrelax</b> \<Boolean\></dt>
<dd>ab initio relax mode<br/></dd>
<dt><b>-fail_unclosed</b> \<Boolean\></dt>
<dd>structures which don't close loops are reported as FAIL_DO_NOT_RETRY<br/>Default: false<br/></dd>
</dl>
+ <h2>-AnchoredDesign</h2>
<dl>
<dt><b>-AnchoredDesign</b> \<Boolean\></dt>
<dd>AnchoredDesign option group<br/></dd>
<dt><b>-anchor</b> \<File\></dt>
<dd>anchor specification file<br/>Default: "anchor"<br/></dd>
<dt><b>-allow_anchor_repack</b> \<Boolean\></dt>
<dd>allow repacking of anchor (default is to prevent)<br/>Default: false<br/></dd>
<dt><b>-vary_cutpoints</b> \<Boolean\></dt>
<dd>vary loop cutpoints.  Picks new cutpoints at start of each nstruct<br/>Default: false<br/></dd>
<dt><b>-no_frags</b> \<Boolean\></dt>
<dd>use no fragments.  Overrides passing an old-style fragment file.  Skips new-style fragment generation.<br/>Default: false<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>debug mode (extra checks and pdb dumps)<br/>Default: false<br/></dd>
<dt><b>-show_extended</b> \<Boolean\></dt>
<dd>dump pre-perturb PDB to check if loop torsions are extended and/or sequence is fuzzed; debugging only<br/>Default: false<br/></dd>
<dt><b>-refine_only</b> \<Boolean\></dt>
<dd>refine only mode (skip perturbation step)<br/>Default: false<br/></dd>
<dt><b>-perturb_show</b> \<Boolean\></dt>
<dd>dump perturbed centroid pdbs as well as final results<br/>Default: false<br/></dd>
<dt><b>-perturb_cycles</b> \<Integer\></dt>
<dd>perturbation phase runs for <input> cycles<br/>Default: 5<br/></dd>
<dt><b>-perturb_temp</b> \<Real\></dt>
<dd>perturbation phase temperature for monte carlo<br/>Default: 0.8<br/></dd>
<dt><b>-perturb_CCD_off</b> \<Boolean\></dt>
<dd>CCD-style loop remodeling off in perturb phase (meaning, KIC only)<br/>Default: false<br/></dd>
<dt><b>-perturb_KIC_off</b> \<Boolean\></dt>
<dd>KIC-style loop remodeling off in perturb phase (meaning, CCD only)<br/>Default: false<br/></dd>
<dt><b>-refine_CCD_off</b> \<Boolean\></dt>
<dd>CCD-style loop remodeling off in refine phase (meaning, KIC only)<br/>Default: false<br/></dd>
<dt><b>-refine_KIC_off</b> \<Boolean\></dt>
<dd>KIC-style loop remodeling off in refine phase (meaning, CCD only)<br/>Default: false<br/></dd>
<dt><b>-refine_cycles</b> \<Integer\></dt>
<dd>refinement phase runs for <input> cycles<br/>Default: 5<br/></dd>
<dt><b>-refine_temp</b> \<Real\></dt>
<dd>refinement phase temperature for monte carlo<br/>Default: 0.8<br/></dd>
<dt><b>-refine_repack_cycles</b> \<Integer\></dt>
<dd>refinement phase runs repack every <input> cycles<br/>Range: 2-<br/>Default: 20<br/></dd>
<dt><b>-rmsd</b> \<Boolean\></dt>
<dd>Calculate result structure CA RMSD from starting structure<br/>Default: false<br/></dd>
<dt><b>-unbound_mode</b> \<Boolean\></dt>
<dd>Ignore the anchor, as if this were loop modeling<br/>Default: false<br/></dd>
<dt><b>-chainbreak_weight</b> \<Real\></dt>
<dd>Chainbreak term weight<br/>Default: 2.0<br/></dd>
</dl>
+ <h3>-AnchoredDesign:filters</h3>
<dl>
<dt><b>-filters</b> \<Boolean\></dt>
<dd>filters option group<br/></dd>
<dt><b>-score</b> \<Real\></dt>
<dd>do not print trajectories with scores greater than this total scorefunction value<br/>Default: 0<br/></dd>
<dt><b>-sasa</b> \<Real\></dt>
<dd>do not print trajectories with sasas less than this interface delta sasa value<br/>Default: 500<br/></dd>
<dt><b>-omega</b> \<Boolean\></dt>
<dd>filter out non-trans omegas<br/>Default: false<br/></dd>
</dl>
+ <h3>-AnchoredDesign:akash</h3>
<dl>
<dt><b>-akash</b> \<Boolean\></dt>
<dd>akash option group<br/></dd>
<dt><b>-dyepos</b> \<Integer\></dt>
<dd>dye position<br/>Default: 0<br/></dd>
</dl>
+ <h3>-AnchoredDesign:testing</h3>
<dl>
<dt><b>-testing</b> \<Boolean\></dt>
<dd>testing option group<br/></dd>
<dt><b>-VDW_weight</b> \<Real\></dt>
<dd>centroid VDW weight; testing if 2 better than 1<br/>Range: 0-<br/>Default: 1.0<br/></dd>
<dt><b>-anchor_via_constraints</b> \<Boolean\></dt>
<dd>allow anchor&jump to move; anchor held in place via constraints - you must specify constraints!<br/>Default: false<br/></dd>
<dt><b>-delete_interface_native_sidechains</b> \<Boolean\></dt>
<dd>benchmarking option.  delete input sidechains as prepacking step before running centroid or fullatom phases.  use if also using use_input_sc and doing benchmarking.  use_input_sc is used because of sidechain minimization, not to maintain input sidechains.<br/></dd>
<dt><b>-RMSD_only_this</b> \<File\></dt>
<dd>Perform only RMSD calculations without modifying input.  Only used for re-running metrics during benchmarking/debugging.<br/></dd>
<dt><b>-anchor_noise_constraints_mode</b> \<Boolean\></dt>
<dd>Hold the anchor loosely (via constraints), not rigidly.  Automatically generate the constraints from the starting pose.  Mildly randomize the anchor's placement before modeling (up to 1 angstrom in x,y,z from initial placement.)  Only compatible with single-residue anchors.  Used to meet a reviewer's commentary.<br/>Default: false<br/></dd>
<dt><b>-super_secret_fixed_interface_mode</b> \<Boolean\></dt>
<dd>hold the anchor-containing loop fixed.  Currently in testing.<br/>Default: false<br/></dd>
<dt><b>-randomize_input_sequence</b> \<Boolean\></dt>
<dd>randomizes the input sequence by packing with a null scorefunction; uses the AnchoredDesign-specified packer task (obeys resfile, etc).<br/>Default: false<br/></dd>
</dl>
+ <h2>-antibody</h2>
<dl>
<dt><b>-antibody</b> \<Boolean\></dt>
<dd>Antibody option group<br/></dd>
<dt><b>-input_ab_scheme</b> \<String\></dt>
<dd>The numbering scheme of the PDB file.<br/>Default: "Chothia_Scheme"<br/></dd>
<dt><b>-output_ab_scheme</b> \<String\></dt>
<dd>Output numbering scheme supported by most antibody apps that output pdbs.  Please see documentation.<br/>Default: "Chothia_Scheme"<br/></dd>
<dt><b>-cdr_definition</b> \<String\></dt>
<dd>The CDR definition to use.  Current Options are: Chothia, Aroop, North, Kabat, Martin<br/>Default: "Aroop"<br/></dd>
<dt><b>-light_chain</b> \<String\></dt>
<dd>Type of light chain if known.  Only used for design for now.<br/>Default: "unknown"<br/></dd>
<dt><b>-check_cdr_chainbreaks</b> \<Boolean\></dt>
<dd>Check CDRs of input antibody for chainbreaks upon initializing RosettaAntibody and RosettaAntibodyDesign.  Chainbreaks found will result in the model not proceeding. A peptide bond in the loop is considered broken if its C-N bond is > 2.0 A<br/>Default: true<br/></dd>
<dt><b>-check_cdr_pep_bond_geom</b> \<Boolean\></dt>
<dd>Check CDRs of input antibody for bad peptide bond geometry.  This checks Ca-C-N and C-N-Ca bond angles for -large- deviations from the min max values found in a recent analysis of protein geometry  - Conformation dependence of backbone geometry in proteins. Structure -.  If found, the model will not proceed.  Use FastRelax with bond angle min to fix issues.  These issues usually arise from poorly resolved crystal loops or incorrectly solved structures.  Many older antibody structures have some of these issues.<br/>Default: false<br/></dd>
<dt><b>-numbering_scheme</b> \<String\></dt>
<dd>Deprecated Numbering Scheme option<br/>Default: "Chothia_Scheme"<br/></dd>
<dt><b>-graft_l1</b> \<Boolean\></dt>
<dd>Graft CDR L1 from template<br/>Default: false<br/></dd>
<dt><b>-l1_template</b> \<String\></dt>
<dd>Choose specified template for CDR L1 grafting<br/>Default: "l1.pdb"<br/></dd>
<dt><b>-graft_l2</b> \<Boolean\></dt>
<dd>Graft CDR L2 from template<br/>Default: false<br/></dd>
<dt><b>-l2_template</b> \<String\></dt>
<dd>Choose specified template for CDR L2 grafting<br/>Default: "l2.pdb"<br/></dd>
<dt><b>-graft_l3</b> \<Boolean\></dt>
<dd>Graft CDR L3 from template<br/>Default: false<br/></dd>
<dt><b>-l3_template</b> \<String\></dt>
<dd>Choose specified template for CDR L3 grafting<br/>Default: "l3.pdb"<br/></dd>
<dt><b>-graft_h1</b> \<Boolean\></dt>
<dd>Graft CDR H1 from template<br/>Default: false<br/></dd>
<dt><b>-h1_template</b> \<String\></dt>
<dd>Choose specified template for CDR H1 grafting<br/>Default: "h1.pdb"<br/></dd>
<dt><b>-graft_h2</b> \<Boolean\></dt>
<dd>Graft CDR H2 from template<br/>Default: false<br/></dd>
<dt><b>-h2_template</b> \<String\></dt>
<dd>Choose specified template for CDR H2 grafting<br/>Default: "h2.pdb"<br/></dd>
<dt><b>-graft_h3</b> \<Boolean\></dt>
<dd>Graft CDR H3 from template<br/>Default: false<br/></dd>
<dt><b>-h3_template</b> \<String\></dt>
<dd>Choose specified template for CDR H3 grafting<br/>Default: "h3.pdb"<br/></dd>
<dt><b>-light_heavy_template</b> \<String\></dt>
<dd>Choose specified template for VL-VH orientation<br/>Default: ""<br/></dd>
<dt><b>-frl_template</b> \<String\></dt>
<dd>Choose specified template for light chain framework<br/>Default: ""<br/></dd>
<dt><b>-frh_template</b> \<String\></dt>
<dd>Choose specified template for heavy chain framework<br/>Default: ""<br/></dd>
<dt><b>-run_snugdock</b> \<Boolean\></dt>
<dd>Run Snugdock after Antibody_H3/RAbD?<br/>Default: false<br/></dd>
<dt><b>-h3_no_stem_graft</b> \<Boolean\></dt>
<dd>Graft CDR H3 from template, use stem to superimpose, but do not copy the stem<br/>Default: false<br/></dd>
<dt><b>-packonly_after_graft</b> \<Boolean\></dt>
<dd>Only do packing after grafting, do not do minimization<br/>Default: false<br/></dd>
<dt><b>-stem_optimize</b> \<Boolean\></dt>
<dd>turn on/off the option to optimize the grafted stems<br/>Default: true<br/></dd>
<dt><b>-stem_optimize_size</b> \<Integer\></dt>
<dd> define the size of the stem to optimize <br/>Default: 4<br/></dd>
<dt><b>-preprocessing_script_version</b> \<String\></dt>
<dd>Rosetta 2 using Perl script has errors for grafting<br/>Default: "R3_Python"<br/></dd>
<dt><b>-model_h3</b> \<Boolean\></dt>
<dd>Model CDR H3 from scratch using fragments<br/>Default: false<br/></dd>
<dt><b>-snugfit</b> \<Boolean\></dt>
<dd>Adjust relative orientation of VL-VH<br/>Default: false<br/></dd>
<dt><b>-refine_h3</b> \<Boolean\></dt>
<dd>Refine CDR H3 in high resolution<br/>Default: true<br/></dd>
<dt><b>-h3_filter</b> \<Boolean\></dt>
<dd>filter decoys having neither kink nor extend form<br/>Default: true<br/></dd>
<dt><b>-h3_filter_tolerance</b> \<Real\></dt>
<dd>maximum number of tries for the filter<br/>Default: 5<br/></dd>
<dt><b>-sc_min</b> \<Boolean\></dt>
<dd>minimize the side chain after finishing the rotamer packing<br/>Default: false<br/></dd>
<dt><b>-rt_min</b> \<Boolean\></dt>
<dd>minimize the rotamer each packing<br/>Default: false<br/></dd>
<dt><b>-extend_h3_before_modeling</b> \<Boolean\></dt>
<dd>extend the H3 to forget the intial H3 configuration<br/>Default: true<br/></dd>
<dt><b>-centroid_refine</b> \<String\></dt>
<dd>Choose a refine method to refine a loop in centroid mode<br/>Default: "refine_kic"<br/></dd>
<dt><b>-constrain_cter</b> \<Boolean\></dt>
<dd>The option to turn on/off the cterminal constrain penalty in loop scoring function<br/>Default: false<br/></dd>
<dt><b>-constrain_vlvh_qq</b> \<Boolean\></dt>
<dd>The option to turn on/off the VL-VH QQ H-bond in docking scoring function<br/>Default: false<br/></dd>
<dt><b>-auto_generate_kink_constraint</b> \<Boolean\></dt>
<dd>Generate the kink constraint on-the-fly<br/>Default: false<br/></dd>
<dt><b>-all_atom_mode_kink_constraint</b> \<Boolean\></dt>
<dd>Enable the kink constraint in the all-atom phase of the simulation<br/>Default: false<br/></dd>
<dt><b>-snug_loops</b> \<Boolean\></dt>
<dd>Allow CDR loop backbone flexibility during minimization<br/>Default: false<br/></dd>
<dt><b>-input_fv</b> \<File\></dt>
<dd>input antibody variable (Fv) region<br/>Default: "FR02.pdb"<br/></dd>
<dt><b>-camelid</b> \<Boolean\></dt>
<dd>Camelid input with only heavy (VH) chain<br/>Default: false<br/></dd>
<dt><b>-camelid_constraints</b> \<Boolean\></dt>
<dd>Display constraints file for use with camelid H3 modeler<br/>Default: false<br/></dd>
<dt><b>-use_mean_cluster_cst_data</b> \<Boolean\></dt>
<dd>Use CDR Dihedral cluster-based constraints which have the means as the actual cluster means.  Setting this to false will use constraints that have the means set as cluster center data.<br/>Default: true<br/></dd>
<dt><b>-force_use_of_cluster_csts_with_outliers</b> \<Boolean\></dt>
<dd>Force the use of cluster dihedral constraints to use ones with outliers.<br/>Default: false<br/></dd>
<dt><b>-cluster_csts_stats_cutoff</b> \<Integer\></dt>
<dd>Value for cluster-based dihedral csts -> general dihedral csts switch.  If number of total structures used for cluster-based constraints is less than this value, general dihedral constraints will be used.  More data = better predictability.<br/>Default: 10<br/></dd>
<dt><b>-general_dihedral_cst_phi_sd</b> \<Real\></dt>
<dd>Standard deviation to use for phi while using general dihedral circular harmonic constraints<br/>Default: 16.0<br/></dd>
<dt><b>-general_dihedral_cst_psi_sd</b> \<Real\></dt>
<dd>Standard deviation to use for psi while using general dihedral circular harmonic constraints<br/>Default: 16.0<br/></dd>
<dt><b>-allow_omega_mismatches_for_north_clusters</b> \<Boolean\></dt>
<dd>Skip first grouping Cis and Trans for clusters in which a Cis/Trans designation currently does not exist.<br/>Default: false<br/></dd>
<dt><b>-prefix</b> \<String\></dt>
<dd>Base/dir name prefix for antibody grafting output, split on /. By default this is grafting/.<br/>Default: "grafting/"<br/></dd>
<dt><b>-grafting_database</b> \<String\></dt>
<dd>Path to the Antibody Grafting Database from Rosetta tools repository. By default this option is empty and grafting_database is looked at ../../tools/antibody and then $ROSETTA/tools/antibody<br/>Default: ""<br/></dd>
<dt><b>-blastp</b> \<String\></dt>
<dd>Path to NCBI-Blast+ executable<br/>Default: "blastp"<br/></dd>
<dt><b>-exclude_pdb</b> \<String\></dt>
<dd>do not use given pdb as graft source (no default)<br/></dd>
<dt><b>-exclude_homologs</b> \<Boolean\></dt>
<dd>Filter BLAST matches by sequence identity? (false by default)<br/>Default: false<br/></dd>
<dt><b>-exclude_homologs_cdr_cutoff</b> \<Real\></dt>
<dd>Sequence identity cutoff for complementarity determining regions (80 percent is default).<br/>Default: 80.0<br/></dd>
<dt><b>-exclude_homologs_fr_cutoff</b> \<Real\></dt>
<dd>Sequence identity cutoff for framework regions (80 percent is default).<br/>Default: 80.0<br/></dd>
<dt><b>-ocd_cutoff</b> \<Real\></dt>
<dd>Orientational coordinate distance cutoff for templates. Introduces diversity when using multi-template grafting (0.5 is default).<br/>Default: 0.5<br/></dd>
<dt><b>-bfactor_cutoff</b> \<Real\></dt>
<dd>Exclude templates regions with an average bfactor above the cutoff (80 is default).<br/>Default: 80.0<br/></dd>
<dt><b>-n_multi_templates</b> \<Integer\></dt>
<dd>Number of multiple templates to use during grafting. Default is 10.<br/>Default: 10<br/></dd>
<dt><b>-json_cdr</b> \<String\></dt>
<dd>define cdr begin/end points with input json<br/></dd>
</dl>
+ <h3>-antibody:design</h3>
<dl>
<dt><b>-design</b> \<Boolean\></dt>
<dd>design option group<br/></dd>
<dt><b>-view</b> \<Boolean\></dt>
<dd>Enable viewing of the antibody design run. Must have built using extras=graphics and run with antibody_designer.graphics executable<br/>Default: false<br/></dd>
<dt><b>-base_cdr_instructions</b> \<String\></dt>
<dd>The Default/Baseline instructions file. Should not need to be changed.<br/>Default: "/sampling/antibodies/design/default_instructions.txt"<br/></dd>
<dt><b>-cdr_instructions</b> \<String\></dt>
<dd>Path to CDR Instruction File<br/></dd>
<dt><b>-antibody_database</b> \<String\></dt>
<dd>Path to the current Antibody Database, updated weekly.  Download from http://dunbrack2.fccc.edu/PyIgClassify/ <br/>Default: "/sampling/antibodies/antibody_database_rosetta_design.db"<br/></dd>
<dt><b>-paper_ab_db</b> \<Boolean\></dt>
<dd>Force the use the Antibody Database with data from the North clustering paper.  This is included in Rosetta. If a newer antibody database is not found, we will use this. The full ab db is available at http://dunbrack2.fccc.edu/PyIgClassify/<br/>Default: false<br/></dd>
<dt><b>-paper_ab_db_path</b> \<String\></dt>
<dd>Path to the North paper ab_db path.  Only used if -paper_ab_db option is passed<br/>Default: "/sampling/antibodies/antibody_database_rosetta_design_north_paper.db"<br/></dd>
<dt><b>-seq_design_cdrs</b> \<StringVector\></dt>
<dd>Enable these CDRs for Sequence-Design.  (Can be set here or in the instructions file. Overrides any set in instructions file if given)<br/></dd>
<dt><b>-graft_design_cdrs</b> \<StringVector\></dt>
<dd>Enable these CDRs for Graft-Design.  (Can be set here or in the instructions file. Overrides any set in instructions file if given)<br/></dd>
<dt><b>-primary_cdrs</b> \<StringVector\></dt>
<dd>Manually set the CDRs which can be chosen in the outer cycle. Normally, we pick any that are sequence or graft -designing.<br/></dd>
<dt><b>-mintype</b> \<String\></dt>
<dd>The default mintype for all CDRs.  Individual CDRs may be set via the instructions file<br/>Default: "min"<br/></dd>
<dt><b>-disallow_aa</b> \<StringVector\></dt>
<dd>Disallow certain amino acids while sequence-designing (could still be in the graft-designed sequence, however).  Useful for optimizing without, for example, cysteines and prolines. Applies to all sequence design profiles and residues from any region (cdrs, framework, antigen).  You can control this per-cdr (or only for the CDRs) through the CDR-instruction file. A resfile is also accepted if you wish to limit specific positions directly.<br/></dd>
<dt><b>-top_designs</b> \<Integer\></dt>
<dd>Number of top designs to keep (ensemble).  These will be written to a PDB and each move onto the next step in the protocol.<br/>Default: 1<br/></dd>
<dt><b>-high_mem_mode</b> \<Boolean\></dt>
<dd>If false, we load the CDRSet (CDRs loaded from the database that could be grafted) on-the-fly for a CDR if it has more than 50 graft-design members.  If true, then we cache the CDRSet before the start of the protocol.  Typically, this will really only to come into play when designing all CDRs.  For de-novo design of 5/6 CDRs, without limiting the CDRSet in the instructions file, you will need 3-4 gb per process for this option.<br/>Default: false<br/></dd>
<dt><b>-cdr_set_cache_limit</b> \<Integer\></dt>
<dd>If high_mem_mode is false, this is the limit of CDRSet cacheing we do before we begin load them on-the-fly instead.  If high_mem_mode is true, then we ignore this setting.  If you have extremely low memory per-process, lower this number<br/>Default: 300<br/></dd>
<dt><b>-design_protocol</b> \<String\></dt>
<dd>Set the main protocol to use.  Note that deterministic is currently only available for the grafting of one CDR.<br/>Default: "even_cluster_mc"<br/></dd>
<dt><b>-run_relax</b> \<Boolean\></dt>
<dd>Run Dualspace Relax on each ensemble after designing (after snugdock if run). Also output pre-relaxed structures<br/>Default: false<br/></dd>
<dt><b>-run_interface_analyzer</b> \<Boolean\></dt>
<dd>Run the Interface Analyzer and add the information to the resulting score function for each top design output.<br/>Default: true<br/></dd>
<dt><b>-paratope</b> \<StringVector\></dt>
<dd>Use these CDRs as the paratope. Default is all of them.  Currently only used for constraints. Note that these site constraints are only used during docking unless -enable_full_protocol_atom_pair_cst is set.<br/></dd>
<dt><b>-epitope</b> \<StringVector\></dt>
<dd>Use these residues as the antigen epitope.  Default is to auto-identify them within the set interface distance at protocol start if epitope constraints are enabled. Currently only used for constraints.  PDB Numbering. Optional insertion code. Example: 1A 1B 1B:A. Note that these site constraints are only used during docking unless -enable_full_protocol_atom_pair_cst is set.<br/>Default: []<br/></dd>
<dt><b>-use_epitope_constraints</b> \<Boolean\></dt>
<dd>Enable use of epitope constraints to add SiteConstraints between the epitope and paratope.  Note that paratope constraints are always used.  Note that these site constraints are only used during docking unless -global_atom_pair_cst_scoring is set.<br/>Default: false<br/></dd>
<dt><b>-dihedral_cst_weight</b> \<Real\></dt>
<dd>Weight to use for CDR CircularHarmonic cluster-based or general constraints that are automatically added to each structure and updated after each graft. Set to zero if you dont want to use these constraints. Note that they are not used for the backrub mintype. Overrides weight/patch settings.<br/>Default: .3<br/></dd>
<dt><b>-atom_pair_cst_weight</b> \<Real\></dt>
<dd>Weight to use for Epitope/Paratope SiteConstraints.  Paratope Side contraints are always used.  Set to zero to completely abbrogate these constraints. Overrides weight/patch settings.<br/>Default: 0.01<br/></dd>
<dt><b>-global_dihedral_cst_scoring</b> \<Boolean\></dt>
<dd>Use the dihedral cst score throughout the protocol, including final scoring of the poses instead of just during minimization step<br/>Default: false<br/></dd>
<dt><b>-global_atom_pair_cst_scoring</b> \<Boolean\></dt>
<dd>Use the atom pair cst score throughout the protocol, including final scoring of the poses instead of just during docking. Typically, the scoreterm is set to zero for scorefxns other than docking to decrease bias via loop lengths, relax, etc.  It may indeed help to target a particular epitope quicker during monte carlo design if epitope constraints are in use, as well for filtering final models on score towards a particular epitope if docking.<br/>Default: true<br/></dd>
<dt><b>-do_dock</b> \<Boolean\></dt>
<dd>Run a short lowres + highres docking step in the inner cycles.  (dock/min).  Recommended 2 inner cycles for better coverage. (dock/min/dock/min). Inner/Outer loops for highres are hard coded, while low-res can be changed through regular low_res options.  If sequence design is enabled, will design regions/CDRs set during the high-res dock. Recommended to <br/>Default: false<br/></dd>
<dt><b>-outer_cycle_rounds</b> \<Integer\></dt>
<dd>Rounds for outer loop of the protocol (not for deterministic_graft ).  Each round chooses a CDR and designs. One run of 100 cycles with relax takes about 12 hours.				  If you decrease this number, you will decrease your run time significantly, but your final decoys will be higher energy.  Make sure to increase the total number of output 				  structures (nstruct) if you use lower than this number.  Typically about 500 - 1000 nstruct is more than sufficient.  Full DeNovo design will require significantly more rounds 				  and nstruct.  If you are docking, runs take about 30 percent longer.<br/>Default: 25<br/></dd>
<dt><b>-inner_cycle_rounds</b> \<Integer\></dt>
<dd>Number of times to run the inner minimization protocol after each graft.  Higher (2-3) rounds recommended for pack/min/backrub mintypes or if including dock in the protocol.<br/>Default: 1<br/></dd>
<dt><b>-dock_cycle_rounds</b> \<Integer\></dt>
<dd>Number of rounds for any docking.  If you are seeing badly docked structures, increase this value.<br/>Default: 1<br/></dd>
<dt><b>-interface_dis</b> \<Real\></dt>
<dd>Interface distance cutoff.  Used for repacking of interface, epitope detection, etc.<br/>Default: 8.0<br/></dd>
<dt><b>-neighbor_dis</b> \<Real\></dt>
<dd>Neighbor distance cutoff.  Used for repacking after graft, minimization, etc.<br/>Default: 6.0<br/></dd>
<dt><b>-use_outliers</b> \<Boolean\></dt>
<dd>Include outlier data for GraftDesign, profile-based sequence design stats, and cluster-based dihedral constraints.  Outliers are defined as having a dihedral distance of > 40 degrees and an RMSD of >1.5 A to the cluster center.  Use to increase sampling of small or rare clusters.<br/>Default: false<br/></dd>
<dt><b>-use_H3_graft_outliers</b> \<Boolean\></dt>
<dd>Include outliers when grafting H3.  H3 does not cluster well, so most structures have high dihedral distance and RMSD to the cluster center.  Due to this, cluster-based dihedral constraints for H3 are not used.  Sequence profiles can be used for clusters, but not usually.<br/>Default: true<br/></dd>
<dt><b>-use_only_H3_kinked</b> \<Boolean\></dt>
<dd>Remove any non-kinked CDRs from the CDRSet if grafting H3.  For now, the match is based on the ramachandran area of the last two residues of the H3. Kinked in this case is defined as having AB or DB regions at the end.  Will be improved for detection.<br/>Default: false<br/></dd>
<dt><b>-design_antigen</b> \<Boolean\></dt>
<dd>Design antigen residues during sequence design.  Intelligently.  Typically, only the neighbor antigen residues of designing cdrs or interfaces will be co-designed.  Useful for specific applications.<br/>Default: false<br/></dd>
<dt><b>-design_framework</b> \<Boolean\></dt>
<dd>Design framework residues during sequence design.  Typically done with only neighbor residues of designing CDRs or during interface minimization.<br/>Default: false<br/></dd>
<dt><b>-conservative_framework_design</b> \<Boolean\></dt>
<dd>If designing Framework positions, use conservative mutations instead of all of them.<br/>Default: true<br/></dd>
<dt><b>-design_H3_stem</b> \<Boolean\></dt>
<dd>Enable design of the first 2 and last 3 residues of the H3 loop if sequence designing H3.  These residues play a role in the extended vs kinked H3 conformation.  Designing these residues may negatively effect the overall H3 structure by potentially switching a kinked loop to an extended and vice versa.  Rosetta may get it right.  But it is off by default to err on the cautious side of design. Sequence designing H3 may be already risky.<br/>Default: false<br/></dd>
<dt><b>-design_proline</b> \<Boolean\></dt>
<dd>Enable proline design.  Profiles for proline are very good, but designing them is a bit risky.  Enable this if you are feeling daring.<br/>Default: false<br/></dd>
<dt><b>-sample_zero_probs_at</b> \<Real\></dt>
<dd>Value for probabilstic design.  Probability that a normally zero prob will be chosen as a potential residue each time packer task is called.  Increase to increase variablility of positions. <br/>Default: 0<br/></dd>
<dt><b>-force_mutate_framework_for_cluster</b> \<Boolean\></dt>
<dd>Force framework mutations that maintain certain clusters. Currently L1-11-1 vs L1-11-2.  See North cluster paper for these dependencies, or checkout rosetta/database/sampling/antibodies/design/cluster_framework_mutations.txt<br/>Default: true<br/></dd>
<dt><b>-no_profile_probabilities</b> \<Boolean\></dt>
<dd>Set to sample all available AAs per position instead of sampling based on weights.  Used to increase diversity and testing purposes.<br/>Default: false<br/></dd>
<dt><b>-seq_design_stats_cutoff</b> \<Integer\></dt>
<dd>Value for probabilistic -> conservative sequence design switch.  If number of total sequences used for probabilistic design for a particular cdr cluster being designed is less than this value, conservative design will occur. More data = better predictability.<br/>Default: 10<br/></dd>
<dt><b>-seq_design_profile_samples</b> \<Integer\></dt>
<dd>If designing using profiles, this is the number of times the profile is sampled each time packing done.  Increase this number to increase variability of designs - especially if not using relax as the mintype.<br/>Default: 1<br/></dd>
<dt><b>-idealize_graft_cdrs</b> \<Boolean\></dt>
<dd>Idealize the CDR before grafting.  May help or hinder. <br/>Default: false<br/></dd>
<dt><b>-add_backrub_pivots</b> \<StringVector\></dt>
<dd>Additional backrub pivot residues if running backrub as the MinType. PDB Numbering. Optional insertion code. Example: 1A 1B 1B:A.  Can also specify ranges: 1A-10:A.  Note no spaces in the range.<br/></dd>
<dt><b>-inner_kt</b> \<Real\></dt>
<dd>KT used in the inner min monte carlo after each graft.<br/>Default: 1.0<br/></dd>
<dt><b>-outer_kt</b> \<Real\></dt>
<dd>KT used for the outer graft Monte Carlo.  Each graft step will use this value<br/>Default: 1.0<br/></dd>
<dt><b>-random_start</b> \<Boolean\></dt>
<dd>Start graft design (currently) with a new set of CDRs from the CDRSets as to not bias the run with native CDRs.<br/>Default: false<br/></dd>
<dt><b>-adapt_graft</b> \<Boolean\></dt>
<dd>Adapt the grafting algorithm to increase rate of closed grafts.  Takes more time.  Grafts that cannot be closed may not be very compatable with the framework in the first place.<br/>Default: true<br/></dd>
<dt><b>-enable_adapt_graft_cartesian</b> \<Boolean\></dt>
<dd>Cartesian minimization seems to be causing numerous bugs since the Lukis AST pointer rewrite.  These only happen on the cluster and it is very difficult to reproduce them. Until this is fixed, we can skip the cartesian adaptation where cartesian minimization would run when the graft could not close properly.  Exceptions are wrapped so that when it does fail we skip the graft. Set this to false to disable its use<br/>Default: false<br/></dd>
<dt><b>-remove_antigen</b> \<Boolean\></dt>
<dd>Remove the antigen from the pose before doing any design on it<br/>Default: false<br/></dd>
<dt><b>-add_graft_log_to_pdb</b> \<Boolean\></dt>
<dd>Add the full graft log to the output pose.  Must also pass -pdb_comments option.<br/>Default: true<br/></dd>
<dt><b>-mutate_framework_for_cluster</b> \<Boolean\></dt>
<dd>Mutate the framework to maintain certain clusters post-graft.<br/>Default: false<br/></dd>
</dl>
+ <h2>-task_operations</h2>
<dl>
<dt><b>-task_operations</b> \<Boolean\></dt>
<dd>task_operations option group<br/></dd>
<dt><b>-cons_design_data_source</b> \<String\></dt>
<dd>Data source used for the ConservativeDesignOperation.  This guides the set of allowed mutations.  Higher blosum means higher conservation (numbers indicate sequence similarity cutoffs.<br/>Default: "blosum62"<br/></dd>
</dl>
+ <h2>-assembly</h2>
<dl>
<dt><b>-assembly</b> \<Boolean\></dt>
<dd>assembly option group<br/></dd>
<dt><b>-pdb1</b> \<File\></dt>
<dd>pdb1 file<br/></dd>
<dt><b>-pdb2</b> \<File\></dt>
<dd>pdb2 file<br/></dd>
</dl>
+ <h2>-backrub</h2>
<dl>
<dt><b>-backrub</b> \<Boolean\></dt>
<dd>backrub option group<br/></dd>
<dt><b>-pivot_residues</b> \<IntegerVector\></dt>
<dd>residues for which contiguous stretches can contain segments (internal residue numbers, defaults to all residues)<br/>Default: utility::vector1<int>()<br/></dd>
<dt><b>-pivot_atoms</b> \<StringVector\></dt>
<dd>main chain atoms usable as pivots<br/>Default: utility::vector1<std::string>(1, "CA")<br/></dd>
<dt><b>-min_atoms</b> \<Integer\></dt>
<dd>minimum backrub segment size (atoms)<br/>Default: 3<br/></dd>
<dt><b>-max_atoms</b> \<Integer\></dt>
<dd>maximum backrub segment size (atoms)<br/>Default: 34<br/></dd>
<dt><b>-ntrials</b> \<Integer\></dt>
<dd>number of Monte Carlo trials to run<br/>Default: 1000<br/></dd>
<dt><b>-sc_prob</b> \<Real\></dt>
<dd>probability of making a side chain move<br/>Default: 0.25<br/></dd>
<dt><b>-sm_prob</b> \<Real\></dt>
<dd>probability of making a small move<br/>Default: 0<br/></dd>
<dt><b>-sc_prob_uniform</b> \<Real\></dt>
<dd>probability of uniformly sampling chi angles<br/>Default: 0.1<br/></dd>
<dt><b>-sc_prob_withinrot</b> \<Real\></dt>
<dd>probability of sampling within the current rotamer<br/>Default: 0.0<br/></dd>
<dt><b>-mc_kt</b> \<Real\></dt>
<dd>value of kT for Monte Carlo<br/>Default: 0.6<br/></dd>
<dt><b>-mm_bend_weight</b> \<Real\></dt>
<dd>weight of mm_bend bond angle energy term<br/>Default: 1.0<br/></dd>
<dt><b>-initial_pack</b> \<Boolean\></dt>
<dd>force a repack at the beginning regardless of whether mutations are set in the resfile<br/>Default: false<br/></dd>
<dt><b>-minimize_movemap</b> \<File\></dt>
<dd>specify degrees of freedom for minimization<br/></dd>
<dt><b>-trajectory</b> \<Boolean\></dt>
<dd>record a trajectory<br/>Default: false<br/></dd>
<dt><b>-trajectory_gz</b> \<Boolean\></dt>
<dd>gzip the trajectory<br/>Default: false<br/></dd>
<dt><b>-trajectory_stride</b> \<Integer\></dt>
<dd>write out a trajectory frame every N steps<br/>Default: 100<br/></dd>
</dl>
+ <h2>-batch_relax</h2>
<dl>
<dt><b>-batch_relax</b> \<Boolean\></dt>
<dd>batch_relax option group<br/></dd>
<dt><b>-batch_size</b> \<Integer\></dt>
<dd>Size of batches - note that thsie affects memory usage significantly<br/>Default: 100<br/></dd>
</dl>
+ <h2>-bbg</h2>
<dl>
<dt><b>-bbg</b> \<Boolean\></dt>
<dd>bbg option group<br/></dd>
<dt><b>-factorA</b> \<Real\></dt>
<dd>Control how big the move would be(acceptance rate), default 1.0<br/>Default: 1.0<br/></dd>
<dt><b>-factorB</b> \<Real\></dt>
<dd>Control how local the move would be(folded 10.0, unfolded 0.1), default 10.0<br/>Default: 10.0<br/></dd>
<dt><b>-ignore_improper_res</b> \<Boolean\></dt>
<dd>Skip improper residues (proline)<br/>Default: false<br/></dd>
<dt><b>-fix_short_segment</b> \<Boolean\></dt>
<dd>Do not apply small mover to short segments, for loop<br/>Default: false<br/></dd>
</dl>
+ <h2>-boinc</h2>
<dl>
<dt><b>-boinc</b> \<Boolean\></dt>
<dd>boinc option group<br/></dd>
<dt><b>-graphics</b> \<Boolean\></dt>
<dd>The boinc client uses this option for the windowed graphics<br/>Default: false<br/></dd>
<dt><b>-fullscreen</b> \<Boolean\></dt>
<dd>The boinc client uses this option for the screensaver full screen graphics<br/>Default: false<br/></dd>
<dt><b>-max_fps</b> \<Integer\></dt>
<dd>Maximum frames per second, overrides user preference.<br/>Default: 0<br/></dd>
<dt><b>-max_cpu</b> \<Integer\></dt>
<dd>Maximum cpu percentage, overrides user preferecne.<br/>Default: 0<br/></dd>
<dt><b>-noshmem</b> \<Boolean\></dt>
<dd>for testing graphics without shared memory.<br/>Default: false<br/></dd>
<dt><b>-cpu_run_time</b> \<Integer\></dt>
<dd>Target cpu run time in seconds<br/>Default: 10800<br/></dd>
<dt><b>-max_nstruct</b> \<Integer\></dt>
<dd>Maximum number of output models (failed or successful) for a given client<br/>Default: 99<br/></dd>
<dt><b>-cpu_frac</b> \<Real\></dt>
<dd>Percentage of CPU time used for graphics<br/>Default: 10.0<br/></dd>
<dt><b>-frame_rate</b> \<Real\></dt>
<dd>Number of frames per second for graphics<br/>Default: 10.0<br/></dd>
<dt><b>-watchdog</b> \<Boolean\></dt>
<dd>Turn watchdog on<br/>Default: false<br/></dd>
<dt><b>-watchdog_time</b> \<Integer\></dt>
<dd>Time interval in seconds used by watchdog to check if run is stuck or going too long (default every 5 minutes)<br/>Default: 300<br/></dd>
<dt><b>-cpu_run_timeout</b> \<Integer\></dt>
<dd>Maximum time the WU may exceed the users WU time settings. Default is 4 hours.  Used by watchdog.<br/>Default: 14400<br/></dd>
<dt><b>-description_file</b> \<File\></dt>
<dd>work unit description file<br/>Default: "rosetta_description.txt"<br/></dd>
<dt><b>-score_cut_pct</b> \<Real\></dt>
<dd>score cut done on the local nodes by percentage, required to return centroid models<br/></dd>
<dt><b>-score_cut_fl</b> \<File\></dt>
<dd>temp file where output is stored in<br/>Default: "score_cut_tmp.out"<br/></dd>
<dt><b>-score_cut_smart_throttle</b> \<Boolean\></dt>
<dd>makes absolutely sure you are generating < 1 model per 60 seconds.(set to 65 sec to be safe)<br/></dd>
</dl>
+ <h2>-broker</h2>
<dl>
<dt><b>-broker</b> \<Boolean\></dt>
<dd>broker option group<br/></dd>
<dt><b>-setup</b> \<FileVector\></dt>
<dd>setup file for topology-broker<br/>Default: "NO_SETUP_FILE"<br/></dd>
<dt><b>-rb_mover_stage1_weight</b> \<Real\></dt>
<dd>weight of RB mover in abinitio stage 1<br/>Default: 5.0<br/></dd>
<dt><b>-large_frag_mover_stage1_weight</b> \<Real\></dt>
<dd>weight of fragment mover in abinitio stage 1<br/>Default: 1.0<br/></dd>
<dt><b>-small_frag_mover_stage1_weight</b> \<Real\></dt>
<dd>weight of fragment mover in abinitio stage 1<br/>Default: 1.0<br/></dd>
</dl>
+ <h2>-bunsat_calc2</h2>
<dl>
<dt><b>-bunsat_calc2</b> \<Boolean\></dt>
<dd>bunsat_calc2 option group<br/></dd>
<dt><b>-sasa_burial_cutoff</b> \<Real\></dt>
<dd>Minimum SASA to be considered exposed<br/>Default: 0.01<br/></dd>
<dt><b>-layered_sasa</b> \<Boolean\></dt>
<dd>Use the variable distance solvent SASA calculator for finding buried unsats<br/>Default: true<br/></dd>
<dt><b>-generous_hbonds</b> \<Boolean\></dt>
<dd>Use generous hbond criteria<br/>Default: true<br/></dd>
<dt><b>-AHD_cutoff</b> \<Real\></dt>
<dd>Minimum AHD angle for secondary geometry based h-bond detection<br/>Default: 120<br/></dd>
<dt><b>-dist_cutoff</b> \<Real\></dt>
<dd>max dist<br/>Default: 3.0<br/></dd>
<dt><b>-hxl_dist_cutoff</b> \<Real\></dt>
<dd>hxl max dist<br/>Default: 3.5<br/></dd>
<dt><b>-sulph_dist_cutoff</b> \<Real\></dt>
<dd>max sulph dist<br/>Default: 3.3<br/></dd>
<dt><b>-metal_dist_cutoff</b> \<Real\></dt>
<dd>max metal dist<br/>Default: 2.7<br/></dd>
</dl>
+ <h2>-canonical_sampling</h2>
<dl>
<dt><b>-canonical_sampling</b> \<Boolean\></dt>
<dd>canonical_sampling option group<br/></dd>
</dl>
+ <h3>-canonical_sampling:probabilities</h3>
<dl>
<dt><b>-probabilities</b> \<Boolean\></dt>
<dd>probabilities option group<br/></dd>
<dt><b>-sc</b> \<Real\></dt>
<dd>probability of making a side chain move<br/>Default: 0.25<br/></dd>
<dt><b>-localbb</b> \<Real\></dt>
<dd>probability of making a small move<br/>Default: 0.75<br/></dd>
<dt><b>-sc_prob_uniform</b> \<Real\></dt>
<dd>probability of uniformly sampling chi angles<br/>Default: 0.1<br/></dd>
<dt><b>-sc_prob_withinrot</b> \<Real\></dt>
<dd>probability of sampling within the current rotamer<br/>Default: 0.9<br/></dd>
<dt><b>-sc_prob_perturbcurrent</b> \<Real\></dt>
<dd>probability of perturbing the current rotamer<br/>Default: 0.0<br/></dd>
<dt><b>-MPI_sync_pools</b> \<Boolean\></dt>
<dd>use MPI to synchronize pools and communicate between nodes<br/>Default: false<br/></dd>
<dt><b>-MPI_bcast</b> \<Boolean\></dt>
<dd>use broadcasting in syncing<br/>Default: false<br/></dd>
<dt><b>-fast_sc_moves</b> \<Boolean\></dt>
<dd>use the fast SidechainMCMover<br/>Default: false<br/></dd>
<dt><b>-fast_sc_moves_ntrials</b> \<Real\></dt>
<dd>specify the number of ntrials for each call of scmover apply<br/>Default: 1000<br/></dd>
<dt><b>-no_jd2_output</b> \<Boolean\></dt>
<dd>do not write to silent-file specified by -out:file:silent<br/>Default: false<br/></dd>
<dt><b>-use_hierarchical_clustering</b> \<Boolean\></dt>
<dd>use the HierarchicalLevel class<br/>Default: false<br/></dd>
<dt><b>-backrub</b> \<Real\></dt>
<dd>set the probability of executing a backrub move when making a backbone move<br/>Default: 0.5<br/></dd>
<dt><b>-conrot</b> \<Real\></dt>
<dd>set relative probability of executing a conrot move when making a backbone move<br/>Default: 0.0<br/></dd>
</dl>
+ <h3>-canonical_sampling:sampling</h3>
<dl>
<dt><b>-sampling</b> \<Boolean\></dt>
<dd>sampling option group<br/></dd>
<dt><b>-no_detailed_balance</b> \<Boolean\></dt>
<dd>preserve detailed balance<br/>Default: false<br/></dd>
<dt><b>-ntrials</b> \<Integer\></dt>
<dd>number of Monte Carlo trials to run<br/>Default: 1000<br/></dd>
<dt><b>-mc_kt</b> \<Real\></dt>
<dd>value of kT for Monte Carlo<br/>Default: 0.6<br/></dd>
<dt><b>-interval_pose_dump</b> \<Integer\></dt>
<dd>dump a pose out every x steps<br/>Default: 1000<br/></dd>
<dt><b>-interval_data_dump</b> \<Integer\></dt>
<dd>dump data out every x steps<br/>Default: 100<br/></dd>
<dt><b>-output_only_cluster_transitions</b> \<Boolean\></dt>
<dd>output only cluster transitions<br/>Default: false<br/></dd>
<dt><b>-transition_threshold</b> \<Real\></dt>
<dd>if rmsd to known_structures larger than X, add a new structure to pool<br/>Default: 2.0<br/></dd>
<dt><b>-max_files_per_dir</b> \<Integer\></dt>
<dd>distribute traj and transition files into subdirectories with max N entries<br/>Default: 1000<br/></dd>
<dt><b>-save_loops_only</b> \<Boolean\></dt>
<dd>save only loop conformation to pool<br/>Default: false<br/></dd>
<dt><b>-dump_loops_only</b> \<Boolean\></dt>
<dd>dump only loop conformation in silent-files<br/>Default: false<br/></dd>
</dl>
+ <h3>-canonical_sampling:out</h3>
<dl>
<dt><b>-out</b> \<Boolean\></dt>
<dd>out option group<br/></dd>
<dt><b>-new_structures</b> \<File\></dt>
<dd><br/>Default: "discovered_decoys.out"<br/></dd>
</dl>
+ <h2>-casp</h2>
<dl>
<dt><b>-casp</b> \<Boolean\></dt>
<dd>casp option group<br/></dd>
<dt><b>-opt_radius</b> \<Real\></dt>
<dd>optimization radius for repacking and minimization<br/></dd>
<dt><b>-repack</b> \<Boolean\></dt>
<dd>should we repack the structure?<br/></dd>
<dt><b>-sc_min</b> \<Boolean\></dt>
<dd>should we sidechain minimize the structure?<br/></dd>
<dt><b>-sequential</b> \<Boolean\></dt>
<dd>should mutations be considered in sequence or all together?<br/></dd>
<dt><b>-num_iterations</b> \<Real\></dt>
<dd>number of iterations to perform<br/></dd>
<dt><b>-refine_res</b> \<String\></dt>
<dd>specifies file that contains which residues to refine<br/></dd>
</dl>
+ <h2>-chemically_conjugated_docking</h2>
<dl>
<dt><b>-chemically_conjugated_docking</b> \<Boolean\></dt>
<dd>chemically_conjugated_docking option group<br/></dd>
<dt><b>-UBQpdb</b> \<File\></dt>
<dd>ubiquitin structure, or the structure for the attached thing that is moving<br/>Default: "1UBQ.pdb"<br/></dd>
<dt><b>-E2pdb</b> \<File\></dt>
<dd>E2 structure, or the structure of the thing that is attached to (has cysteine) and does not move; should be one chain<br/>Default: "2OB4.pdb"<br/></dd>
<dt><b>-E2_residue</b> \<Integer\></dt>
<dd>E2 catalytic cysteine (PDB numbering) (where the ubiquitin gets attached; assumed to be on the first chain of E2pdb<br/>Default: 85<br/></dd>
<dt><b>-SASAfilter</b> \<Real\></dt>
<dd>filter out structures with interface dSASA less than this<br/>Default: 1000<br/></dd>
<dt><b>-scorefilter</b> \<Real\></dt>
<dd>filter out structures with total score greater than this<br/>Default: 10<br/></dd>
<dt><b>-publication</b> \<Boolean\></dt>
<dd>output statistics used in publication.  TURN OFF if not running (original Saha et al.) publication demo.<br/>Default: false<br/></dd>
<dt><b>-n_tail_res</b> \<Integer\></dt>
<dd>Number of c-terminal ~tail~ residues to make flexible (terminus inclusive)<br/>Default: 3<br/></dd>
<dt><b>-two_ubiquitins</b> \<Boolean\></dt>
<dd>Mind-blowing - use two ubiquitins (assembled for a K48 linkage) to try to examine the transition state.  Don't use this option unless trying to reproduce publication XXXX<br/>Default: false<br/></dd>
<dt><b>-extra_bodies</b> \<FileVector\></dt>
<dd>extra structures to add before modeling.  Should be in the coordinate frame of the non-moving partner.  Will not move during modeling.  Will be detected as part of the nonmoving body for repacking purposes.<br/>Default: ""<br/></dd>
<dt><b>-UBQ2_lys</b> \<Integer\></dt>
<dd>which Lys on the second UB will be conjugated<br/>Default: 48<br/></dd>
<dt><b>-UBQ2_pdb</b> \<File\></dt>
<dd>PDB for second ubiquitin (second moving chain).  Only active if -two_ubiquitins is used; inactive otherwise.  Optional; defaults to value of -UBQpdb if not passed.<br/></dd>
<dt><b>-dont_minimize_omega</b> \<Boolean\></dt>
<dd>disable minimization of omega angles near thioester in MoveMap; not present in original publications (Saha; Baker)<br/>Default: false<br/></dd>
<dt><b>-pdz</b> \<Boolean\></dt>
<dd>For the UBQ_Gp_LYX-Cterm executable, if -publication is already on, switch to the PDZ center of mass instead of ubiquitin center of mass for the extra statistics calculations.  Don't use this option unless trying to reproduce publication XXXX<br/>Default: false<br/></dd>
<dt><b>-GTPasepdb</b> \<File\></dt>
<dd>GTPase structure, or the structure of the thing that is attached to (has cysteine) and does not move; should be one chain<br/>Default: "2OB4.pdb"<br/></dd>
<dt><b>-GTPase_residue</b> \<Integer\></dt>
<dd>GTPase lysine (PDB numbering) (where the ubiquitin gets attached; assumed to be on the first chain of GTPase_pdb<br/>Default: 85<br/></dd>
</dl>
+ <h2>-chunk</h2>
<dl>
<dt><b>-chunk</b> \<Boolean\></dt>
<dd>chunk option group<br/></dd>
<dt><b>-pdb2</b> \<File\></dt>
<dd>file for chunk2<br/></dd>
<dt><b>-loop2</b> \<File\></dt>
<dd>rigid region for chunk2<br/></dd>
</dl>
+ <h2>-cloud</h2>
<dl>
<dt><b>-cloud</b> \<Boolean\></dt>
<dd>cloud option group<br/></dd>
<dt><b>-auth</b> \<String\></dt>
<dd>RosettaCloud credentials in form of <user_email>:<password>. To get your credentials visit https://ui.graylab.jhu.edu/settings<br/>Default: ""<br/></dd>
<dt><b>-key</b> \<String\></dt>
<dd>Key to use when process query Cloud server for new ExecutionSummary ID, default is empty string (no key) which mean always create a new ES instance<br/>Default: ""<br/></dd>
<dt><b>-clean</b> \<Boolean\></dt>
<dd>When option `key` is specified tell if Cloud server should clean exising ExecutionSummary instance from all existing files<br/>Default: false<br/></dd>
<dt><b>-host</b> \<String\></dt>
<dd>UI server address<br/>Default: "ui.graylab.jhu.edu"<br/></dd>
<dt><b>-port</b> \<Integer\></dt>
<dd>UI server port<br/>Default: 80<br/></dd>
<dt><b>-block</b> \<Boolean\></dt>
<dd>Specify what to do when network queue is full: block and wait for packets to be be send or drop payload<br/>Default: true<br/></dd>
</dl>
+ <h2>-cluster</h2>
<dl>
<dt><b>-cluster</b> \<Boolean\></dt>
<dd>cluster option group<br/></dd>
<dt><b>-lite</b> \<Boolean\></dt>
<dd>uses light-weight method of outputting cluster-centers, useful for when there's a HUGE amount of data!<br/>Default: false<br/></dd>
<dt><b>-input_score_filter</b> \<Real\></dt>
<dd>Only read in structures below a certain energy<br/>Default: 1000000.0<br/></dd>
<dt><b>-output_score_filter</b> \<Real\></dt>
<dd>Only read in structures below a certain energy<br/>Default: 1000000.0<br/></dd>
<dt><b>-exclude_res</b> \<IntegerVector\></dt>
<dd>Residue numbers to be excluded from cluster RMS calculation<br/>Default: -1<br/></dd>
<dt><b>-thinout_factor</b> \<Real\></dt>
<dd>Ignore this fraction of decoys in the first round !<br/>Default: -1<br/></dd>
<dt><b>-radius</b> \<Real\></dt>
<dd>Cluster radius<br/>Default: 3.0<br/></dd>
<dt><b>-limit_cluster_size</b> \<Integer\></dt>
<dd>For each cluster only retain top N <br/>Default: -1<br/></dd>
<dt><b>-limit_cluster_size_percent</b> \<Real\></dt>
<dd>0 to 1. For each cluster only retain top N % <br/></dd>
<dt><b>-random_limit_cluster_size_percent</b> \<Real\></dt>
<dd>0 to 1. For each cluster only retain random N % <br/></dd>
<dt><b>-limit_clusters</b> \<Integer\></dt>
<dd>Only retain largest N clusters<br/>Default: 100<br/></dd>
<dt><b>-limit_total_structures</b> \<Integer\></dt>
<dd>Only retain the first N structures (ordered by cluster number)<br/>Default: -1<br/></dd>
<dt><b>-max_total_cluster</b> \<Integer\></dt>
<dd>Only ever make N clusters or less<br/>Default: 1000<br/></dd>
<dt><b>-gdtmm</b> \<Boolean\></dt>
<dd>Cluster by gdtmm instead of RMS<br/>Default: false<br/></dd>
<dt><b>-skip_align</b> \<Boolean\></dt>
<dd>Cluster without aligning the structures<br/>Default: false<br/></dd>
<dt><b>-max_rms_matrix</b> \<Integer\></dt>
<dd>Maximum number of structures to use to calculate the full RMSD matrix<br/>Default: 400<br/></dd>
<dt><b>-rna_P</b> \<Boolean\></dt>
<dd>Calculate rmsd from backbone phosphate positions only<br/>Default: false<br/></dd>
<dt><b>-sort_groups_by_energy</b> \<Boolean\></dt>
<dd>Sort clusters by energy<br/>Default: false<br/></dd>
<dt><b>-sort_groups_by_size</b> \<Boolean\></dt>
<dd>Sort clusters by energy<br/>Default: false<br/></dd>
<dt><b>-remove_singletons</b> \<Boolean\></dt>
<dd>Get rid of single-member clusters<br/>Default: false<br/></dd>
<dt><b>-export_only_low</b> \<Boolean\></dt>
<dd>Print only the lowest energy member<br/>Default: false<br/></dd>
<dt><b>-remove_highest_energy_member</b> \<Boolean\></dt>
<dd>Remove highest energy member from each cluster<br/>Default: false<br/></dd>
<dt><b>-idealize_final_structures</b> \<Boolean\></dt>
<dd>Run an idealization over the resulting structures<br/>Default: false<br/></dd>
<dt><b>-limit_dist_matrix</b> \<Integer\></dt>
<dd>Only calculate full matrix for a subset of structres. Then simply assign structures to nearest cluster<br/>Default: -1<br/></dd>
<dt><b>-make_ensemble_cst</b> \<Boolean\></dt>
<dd>Create a set of constraints describing the variablity in each cluster of each residue.<br/>Default: false<br/></dd>
<dt><b>-hotspot_hash</b> \<Boolean\></dt>
<dd>Cluster hotspot hashing results. Each input PDB must contain both the target and the newly docked hotspot (which should be the last residue in the pose).<br/>Default: false<br/></dd>
<dt><b>-loops</b> \<Boolean\></dt>
<dd>Cluster the loop specified with the -loops:loop_file option<br/>Default: false<br/></dd>
<dt><b>-population_weight</b> \<Real\></dt>
<dd>Order Clusters by (1-p)*score - p*size whpere p = population_weight <br/>Default: 0.09<br/></dd>
<dt><b>-template_scores</b> \<String\></dt>
<dd>imple textfile containing template names (in caps) and scores.<br/></dd>
<dt><b>-K_level</b> \<Integer\></dt>
<dd>Hierarchical cluster level number<br/>Default: 1<br/></dd>
<dt><b>-K_radius</b> \<RealVector\></dt>
<dd>Radius list of different level of cluster<br/>Default: utility::vector1<float>(1, 2.0)<br/></dd>
<dt><b>-K_n_cluster</b> \<IntegerVector\></dt>
<dd>How many clusters in each level<br/>Default: utility::vector1<int>(1, 10000)<br/></dd>
<dt><b>-K_style</b> \<StringVector\></dt>
<dd>Which K-cluster engine to use<br/>Default: utility::vector1<std::string>(9, "GKC")<br/></dd>
<dt><b>-K_n_sub</b> \<Integer\></dt>
<dd>Number of clusters in subdir<br/>Default: 100<br/></dd>
<dt><b>-K_deque_size</b> \<Integer\></dt>
<dd>Size of subcluster deque<br/>Default: 20<br/></dd>
<dt><b>-K_deque_level</b> \<Integer\></dt>
<dd>Provide deque in top level<br/>Default: 1<br/></dd>
<dt><b>-K_redundant</b> \<Boolean\></dt>
<dd>Keep all the higher level center structure in sub-pools<br/>Default: true<br/></dd>
<dt><b>-K_not_fit_xyz</b> \<Boolean\></dt>
<dd>Do not rotate xyz when calculate rmsd<br/>Default: false<br/></dd>
<dt><b>-K_save_headers</b> \<Boolean\></dt>
<dd>Save headers in silent file<br/>Default: false<br/></dd>
<dt><b>-score_diff_cut</b> \<Real\></dt>
<dd>score difference cut for RNA and SWA clustering<br/>Default: 1000000.0<br/></dd>
<dt><b>-auto_tune</b> \<Boolean\></dt>
<dd>autotune rmsd for clustering between 0.1A up to 2.0A, for SWA clusterer<br/>Default: false<br/></dd>
<dt><b>-write_centers</b> \<Boolean\></dt>
<dd>Write out a silent file with the cluster centers<br/>Default: false<br/></dd>
</dl>
+ <h3>-cluster:energy_based_clustering</h3>
<dl>
<dt><b>-energy_based_clustering</b> \<Boolean\></dt>
<dd>energy_based_clustering option group<br/></dd>
<dt><b>-prerelax</b> \<Boolean\></dt>
<dd>Should imported structures be subjected to a round of fast relaxation?  Default false.<br/>Default: false<br/></dd>
<dt><b>-relax_rounds</b> \<Integer\></dt>
<dd>The number of fastrelax rounds to apply if the -cluster:energy_based_clustering:prerelax option is used.  Default 1.<br/>Default: 1<br/></dd>
<dt><b>-cluster_by</b> \<String\></dt>
<dd>What should I use as the basis for clustering?  Options are bb_cartesian (xyz coordinates of backbone atoms) and bb_dihedral (phi, psi, omega angles).  Default is bb_cartesian.<br/>Default: "bb_cartesian"<br/></dd>
<dt><b>-use_CB</b> \<Boolean\></dt>
<dd>If clustering by backbone Cartesian coordinates, should beta carbons be included?  Default false.  Note that if this option is used, none of the input structures can contain glycine.<br/>Default: false<br/></dd>
<dt><b>-cluster_radius</b> \<Real\></dt>
<dd>The radius for clustering, in Angstroms for Cartesian clustering and degrees for dihedral clustering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-residues_to_ignore</b> \<IntegerVector\></dt>
<dd>List of residues to ignore in alignments for clustering.  Default empty list.<br/></dd>
<dt><b>-chains_to_ignore</b> \<IntegerVector\></dt>
<dd>List of chains to ignore in alignments for clustering.  Default empty list.<br/></dd>
<dt><b>-limit_structures_per_cluster</b> \<Integer\></dt>
<dd>Maximum number of structures to output per cluster.  Default no limit (0).<br/>Default: 0<br/></dd>
<dt><b>-limit_clusters</b> \<Integer\></dt>
<dd>Maximum number of clusters to output.  Default no limit (0).<br/>Default: 0<br/></dd>
<dt><b>-cyclic</b> \<Boolean\></dt>
<dd>If true, constraints are added to make a peptide bond between the N- and C-termini.  If false (default), the termini are free.  Default false.<br/>Default: false<br/></dd>
<dt><b>-cyclic_symmetry</b> \<Integer\></dt>
<dd>If provided, structures that do not have the desired symmetry are filtered out.  Set to 2 for C2 or S2 symmetry, 3 for C3 symmetry, 4 for C4 or S4 symmetry, etc.  Unused (0) if not specified.  Can only be used with the -cluster:energy_based_clustering:cyclic flag.<br/>Default: 0<br/></dd>
<dt><b>-cyclic_symmetry_mirroring</b> \<Boolean\></dt>
<dd>If true, then SN symmetry is used instead of CN.  Unused if not specified.  Can only be used with the -cluster:energy_based_clustering:cyclic and -cluster:energy_based_clustering:cyclic_symmetry flags.<br/>Default: false<br/></dd>
<dt><b>-cyclic_symmetry_threshold</b> \<Real\></dt>
<dd>The angle threshold, in degrees, for determining whether a cyclic peptide is symmetric.  Can only be used with the -cluster:energy_based_clustering:cyclic and -cluster:energy_based_clustering:cyclic_symmetry flags.  Defaults to 10.0 degrees.<br/>Default: 10.0<br/></dd>
<dt><b>-cluster_cyclic_permutations</b> \<Boolean\></dt>
<dd>If true, all cyclic permutations are tried when comparing two structures for clustering.  Requires -cluster:energy_based_clustering:cyclic true.  Default false.<br/>Default: false<br/></dd>
<dt><b>-cyclic_permutation_offset</b> \<Integer\></dt>
<dd>1 by default, meaning that every cyclic permutation is clustered if -cluster:energy_based_clustering:cluster_cyclic_permutations is true.  Values X > 1 mean that cyclic permutations shifted by X residues will be clustered.<br/>Default: 1<br/></dd>
<dt><b>-perform_ABOXYZ_bin_analysis</b> \<Boolean\></dt>
<dd>If true, Ramachandran bin analysis is performed on all clusters using the A, B, X, Y, and O bins as defined in Hosseinzadeh, Bhardwaj, Mulligan et al. (2018).  Inputs must be all-alpha amino acid or peptoid structures.  False by default.<br/>Default: false<br/></dd>
<dt><b>-mutate_to_ala</b> \<Boolean\></dt>
<dd>If true, the input structures will be converted to a chain of alanines (L- or D-) before scoring.  Default false.<br/>Default: false<br/></dd>
<dt><b>-disulfide_positions</b> \<IntegerVector\></dt>
<dd>A space-separated list of positions that are disulfide-bonded.  For example, -cluster:energy_based_clustering:disulfide_positions 3 8 6 23 would mean that residues 3 and 8 are disulfide-bonded, as are residues 6 and 23.  Defaults to an empty list of the option is not specified, in which case disulfides are auto-detected.<br/></dd>
<dt><b>-homooligomer_swap</b> \<Boolean\></dt>
<dd>If the structures contain multiple chains with identical sequence, setting this to true will test all permutations of chains when clustering.  Default false.<br/>Default: false<br/></dd>
<dt><b>-silent_output</b> \<Boolean\></dt>
<dd>Write output to a silent file instead of to separate PDBs.  This will create two files: one that only contains the first member of each cluster, and one that contains everything.  Default false.<br/>Default: false<br/></dd>
<dt><b>-cst_file</b> \<FileVector\></dt>
<dd>An optional, user-specified list of one or more constraints files.  Default unused.<br/></dd>
<dt><b>-extra_rms_atoms</b> \<StringVector\></dt>
<dd>A list of additional atoms to use in the RMSD calculation, each in the format residue:atomname separated by whitespace.  For example, -extra_rms_atoms 7:SG 12:CG 12:CD 12:CE 12:NZ 14:OG.  Default empty list.<br/></dd>
<dt><b>-rebuild_all_in_dihedral_mode</b> \<Boolean\></dt>
<dd>If true, full poses are rebuilt for output when clustering in dihedral mode.  If false, only backbones are written out.  True by default.<br/>Default: true<br/></dd>
</dl>
+ <h2>-partial_thread</h2>
<dl>
<dt><b>-partial_thread</b> \<Boolean\></dt>
<dd>partial_thread option group<br/></dd>
<dt><b>-skip_repack</b> \<Boolean\></dt>
<dd>Do not repack sidechain missing density and idealize/optimize h-bonds<br/>Default: false<br/></dd>
</dl>
+ <h2>-cm</h2>
<dl>
<dt><b>-cm</b> \<Boolean\></dt>
<dd>cm option group<br/></dd>
</dl>
+ <h3>-cm:sanitize</h3>
<dl>
<dt><b>-sanitize</b> \<Boolean\></dt>
<dd>sanitize option group<br/></dd>
<dt><b>-num_fragments</b> \<Integer\></dt>
<dd>Use the top k fragments at each position during sanitization<br/>Default: 25<br/></dd>
<dt><b>-cst_weight_pair</b> \<Real\></dt>
<dd>atom_pair_constraint weight<br/>Default: 1.0<br/></dd>
<dt><b>-cst_weight_coord</b> \<Real\></dt>
<dd>coordinate_constraint weight<br/>Default: 1.0<br/></dd>
</dl>
+ <h2>-cm</h2>
<dl>
<dt><b>-start_models_only</b> \<Boolean\></dt>
<dd>Make starting models only!<br/>Default: false<br/></dd>
<dt><b>-aln_format</b> \<String\></dt>
<dd>No description<br/>Default: "grishin"<br/></dd>
<dt><b>-recover_side_chains</b> \<Boolean\></dt>
<dd>recover side-chains<br/>Default: false<br/></dd>
<dt><b>-steal_extra_residues</b> \<FileVector\></dt>
<dd>list of template extra residues (ie ligands) to add to query pose in comparative modeling<br/></dd>
<dt><b>-loop_mover</b> \<String\></dt>
<dd>No description<br/>Default: "quick_ccd"<br/></dd>
<dt><b>-loop_close_level</b> \<Integer\></dt>
<dd>level of aggressiveness to use in closing loops. 					The integers that follow flags specify how aggressively 					loops are rebuilt. Each option implies all non-zero levels below it,					so that loop_close_level 2 implies level 1 as well. Meaning of 					the options are: 					NO_REBUILD              0     don't rebuild loops at all 					REBUILD_UNALIGNED       1     rebuild loops around unaligned regions 					REBUILD_CHAINBREAK      2     rebuild loops around chainbreaks 					REBUILD_EXHAUSTIVE      3     rebuild loops around regions with a chainbreak until no chainbreaks remain<br/>Default: 0<br/></dd>
<dt><b>-min_loop_size</b> \<Integer\></dt>
<dd>Minimum size of loops to remodel when building threading models.<br/>Default: 5<br/></dd>
<dt><b>-max_loop_rebuild</b> \<Integer\></dt>
<dd>Maximum number of times to try to rebuild a loop before giving up.<br/>Default: 10<br/></dd>
<dt><b>-loop_rebuild_filter</b> \<Real\></dt>
<dd>Maximum score a structure must have after loop rebuilding.<br/>Default: 0<br/></dd>
<dt><b>-aln_length_filter_quantile</b> \<Real\></dt>
<dd>Only use alignment lengths longer than the Xth quantile. e.g. setting this to 0.75 will only use the 25% longest alignments<br/>Default: 0.0<br/></dd>
<dt><b>-aln_length_filter</b> \<Integer\></dt>
<dd>Only use alignment longer or equal to this length<br/>Default: -1<br/></dd>
<dt><b>-seq_score</b> \<StringVector\></dt>
<dd>sequence-based scoring scheme used for generating alignments<br/>Default: utility::vector1<std::string>(1,"Simple")<br/></dd>
<dt><b>-aligner</b> \<String\></dt>
<dd>algorithm for making sequence alignments<br/></dd>
<dt><b>-min_gap_open</b> \<Real\></dt>
<dd>gap opening penalty for sequence alignments (usually negative)<br/>Default: -2.0<br/></dd>
<dt><b>-max_gap_open</b> \<Real\></dt>
<dd>gap opening penalty for sequence alignments (usually negative)<br/>Default: -2.0<br/></dd>
<dt><b>-min_gap_extend</b> \<Real\></dt>
<dd>gap extension penalty for sequence alignments (usually negative)<br/>Default: -0.2<br/></dd>
<dt><b>-max_gap_extend</b> \<Real\></dt>
<dd>gap extension penalty for sequence alignments (usually negative)<br/>Default: -0.2<br/></dd>
<dt><b>-nn</b> \<Integer\></dt>
<dd>number of neighbors to include in constraint derivation<br/>Default: 500<br/></dd>
<dt><b>-ev_map</b> \<FileVector\></dt>
<dd>Input file that maps pdbChains to blast e-values<br/></dd>
<dt><b>-hh_map</b> \<FileVector\></dt>
<dd>Input file that maps pdbChains to hhsearch probabilities<br/></dd>
<dt><b>-seeds</b> \<IntegerVector\></dt>
<dd>list of tags used as seed parents at prv iteration<br/></dd>
<dt><b>-nremain_reset</b> \<Integer\></dt>
<dd>threshold for number of unused structures to invoke reset<br/>Default: 3<br/></dd>
<dt><b>-quota_per_silent</b> \<RealVector\></dt>
<dd>quota for picking input structures associated with -in:file:silent<br/></dd>
<dt><b>-similarity_cut</b> \<Real\></dt>
<dd>Distance cut on the structure population, used for CSA (in S-score)<br/></dd>
<dt><b>-similarity_limit</b> \<Real\></dt>
<dd>Distance cut for initial filtering (in S-score)<br/></dd>
<dt><b>-refsimilarity_cut</b> \<Real\></dt>
<dd>Lower threshold on model-to-template GDT-HA where it starts to get penalty<br/>Default: 25<br/></dd>
</dl>
+ <h3>-cm:hybridize</h3>
<dl>
<dt><b>-hybridize</b> \<Boolean\></dt>
<dd>hybridize option group<br/></dd>
<dt><b>-starting_template</b> \<IntegerVector\></dt>
<dd>Define starting templates<br/></dd>
<dt><b>-realign_domains</b> \<Boolean\></dt>
<dd>domain parse and realign the starting templates<br/>Default: true<br/></dd>
<dt><b>-realign_domains_stage2</b> \<Boolean\></dt>
<dd>realign the starting templates to the pose after stage1<br/>Default: true<br/></dd>
<dt><b>-add_non_init_chunks</b> \<Integer\></dt>
<dd>add (on average) this many non-template chunks<br/>Default: 0<br/></dd>
<dt><b>-stage1_increase_cycles</b> \<Real\></dt>
<dd>Scale stage 1 cycles<br/>Default: 1.0<br/></dd>
<dt><b>-stage2_increase_cycles</b> \<Real\></dt>
<dd>Scale stage 2 cycles<br/>Default: 1.0<br/></dd>
<dt><b>-stage2min_increase_cycles</b> \<Real\></dt>
<dd>Scale minimizer cycles after stage 2<br/>Default: 1.0<br/></dd>
<dt><b>-stage1_probability</b> \<Real\></dt>
<dd>Probability of hybridizing in stage 1, 0=never, 1=always<br/>Default: 1.0<br/></dd>
<dt><b>-skip_stage2</b> \<Boolean\></dt>
<dd>skip cartesian fragment hybridize stage<br/>Default: false<br/></dd>
<dt><b>-no_global_frame</b> \<Boolean\></dt>
<dd>no global-frame fragment insertions<br/>Default: false<br/></dd>
<dt><b>-linmin_only</b> \<Boolean\></dt>
<dd>linmin only in stage 2<br/>Default: false<br/></dd>
<dt><b>-relax</b> \<Integer\></dt>
<dd>if n==1, perform relax at end; if n>1 perform batch relax over n centroids<br/>Default: 0<br/></dd>
<dt><b>-frag_weight_aligned</b> \<Real\></dt>
<dd>Probability of fragment insertion in the aligned region<br/>Default: 0.<br/></dd>
<dt><b>-max_registry_shift</b> \<Integer\></dt>
<dd>maximum registry shift<br/>Default: 0<br/></dd>
<dt><b>-frag_1mer_insertion_weight</b> \<Real\></dt>
<dd>weight for 1mer fragment insertions where fragments are not allowed vs. template chunk insertions in stage1<br/>Default: 0.0<br/></dd>
<dt><b>-small_frag_insertion_weight</b> \<Real\></dt>
<dd>weight for small fragment insertions where large fragments are not allowed vs. template chunk insertions in stage1<br/>Default: 0.0<br/></dd>
<dt><b>-big_frag_insertion_weight</b> \<Real\></dt>
<dd>weight for big fragment insertions vs. template chunk insertions in stage1<br/>Default: 0.5<br/></dd>
<dt><b>-auto_frag_insertion_weight</b> \<Boolean\></dt>
<dd>automatically set the weight for fragment insertions vs. template chunk insertions in stage1<br/>Default: true<br/></dd>
<dt><b>-stage1_1_cycles</b> \<Integer\></dt>
<dd>Number of cycles for ab initio stage 1 in Stage1<br/>Default: 2000<br/></dd>
<dt><b>-stage1_2_cycles</b> \<Integer\></dt>
<dd>Number of cycles for ab initio stage 2 in Stage1<br/>Default: 2000<br/></dd>
<dt><b>-stage1_3_cycles</b> \<Integer\></dt>
<dd>Number of cycles for ab initio stage 3 in Stage1<br/>Default: 2000<br/></dd>
<dt><b>-stage1_4_cycles</b> \<Integer\></dt>
<dd>Number of cycles for ab initio stage 4 in Stage1<br/>Default: 400<br/></dd>
<dt><b>-stage2_temperature</b> \<Real\></dt>
<dd>Monte Carlo temperature in the stage2<br/>Default: 2.0<br/></dd>
<dt><b>-stage1_4_cenrot_score</b> \<String\></dt>
<dd>Switch to cenrot model in stage1_4<br/>Default: "score_cenrot_cm_stage1_4.wts"<br/></dd>
<dt><b>-include_loop_ss_chunks</b> \<Boolean\></dt>
<dd>include loop secondary structure chunks from templates<br/>Default: false<br/></dd>
</dl>
+ <h2>-contactMap</h2>
<dl>
<dt><b>-contactMap</b> \<Boolean\></dt>
<dd>contactMap option group<br/></dd>
<dt><b>-prefix</b> \<String\></dt>
<dd>Prefix of contactMap filename<br/>Default: "contact_map_"<br/></dd>
<dt><b>-distance_cutoff</b> \<Real\></dt>
<dd>Cutoff Backbone distance for two atoms to be considered interacting<br/>Default: 10.0<br/></dd>
<dt><b>-region_def</b> \<String\></dt>
<dd>Region definition for comparison eg: 1-10:20-30,40-50,A:ligand=X<br/>Default: ""<br/></dd>
<dt><b>-row_format</b> \<Boolean\></dt>
<dd>Flag whether to output in row instead of matrix format<br/>Default: false<br/></dd>
<dt><b>-distance_matrix</b> \<Boolean\></dt>
<dd>Output a distance matrix instead of a contact map<br/>Default: false<br/></dd>
</dl>
+ <h2>-coupled_moves</h2>
<dl>
<dt><b>-coupled_moves</b> \<Boolean\></dt>
<dd>coupled_moves option group<br/></dd>
<dt><b>-ntrials</b> \<Integer\></dt>
<dd>number of Monte Carlo trials to run<br/>Default: 1000<br/></dd>
<dt><b>-number_ligands</b> \<Integer\></dt>
<dd>number of ligands in the pose<br/>Default: 1<br/></dd>
<dt><b>-mc_kt</b> \<Real\></dt>
<dd>value of kT for Monte Carlo<br/>Default: 0.6<br/></dd>
<dt><b>-boltzmann_kt</b> \<Real\></dt>
<dd>value of kT for Boltzmann weighted moves<br/>Default: 0.6<br/></dd>
<dt><b>-mm_bend_weight</b> \<Real\></dt>
<dd>weight of mm_bend bond angle energy term<br/>Default: 1.0<br/></dd>
<dt><b>-trajectory</b> \<Boolean\></dt>
<dd>record a trajectory<br/>Default: false<br/></dd>
<dt><b>-trajectory_gz</b> \<Boolean\></dt>
<dd>gzip the trajectory<br/>Default: false<br/></dd>
<dt><b>-trajectory_stride</b> \<Integer\></dt>
<dd>write out a trajectory frame every N steps<br/>Default: 100<br/></dd>
<dt><b>-trajectory_file</b> \<String\></dt>
<dd>name of trajectory file<br/>Default: "traj.pdb"<br/></dd>
<dt><b>-output_fasta</b> \<String\></dt>
<dd>name of FASTA output file<br/>Default: "sequences.fasta"<br/></dd>
<dt><b>-output_stats</b> \<String\></dt>
<dd>name of stats output file<br/>Default: "sequences.stats"<br/></dd>
<dt><b>-ligand_mode</b> \<Boolean\></dt>
<dd>if true, model protein ligand interaction<br/>Default: false<br/></dd>
<dt><b>-initial_repack</b> \<Boolean\></dt>
<dd>start simulation with repack and design step<br/>Default: true<br/></dd>
<dt><b>-min_pack</b> \<Boolean\></dt>
<dd>use min_pack for initial repack and design step<br/>Default: false<br/></dd>
<dt><b>-save_sequences</b> \<Boolean\></dt>
<dd>save all unique sequences<br/>Default: true<br/></dd>
<dt><b>-save_structures</b> \<Boolean\></dt>
<dd>save structures for all unique sequences<br/>Default: false<br/></dd>
<dt><b>-ligand_prob</b> \<Real\></dt>
<dd>probability of making a ligand move<br/>Default: 0.1<br/></dd>
<dt><b>-fix_backbone</b> \<Boolean\></dt>
<dd>do not make any backbone moves<br/>Default: false<br/></dd>
<dt><b>-uniform_backrub</b> \<Boolean\></dt>
<dd>select backrub rotation angle from uniform distribution<br/>Default: false<br/></dd>
<dt><b>-bias_sampling</b> \<Boolean\></dt>
<dd>if true, bias rotamer selection based on energy<br/>Default: true<br/></dd>
<dt><b>-bump_check</b> \<Boolean\></dt>
<dd>if true, use bump check in generating rotamers<br/>Default: true<br/></dd>
<dt><b>-ligand_weight</b> \<Real\></dt>
<dd>weight for residue - ligand interactions<br/>Default: 1.0<br/></dd>
<dt><b>-output_prefix</b> \<String\></dt>
<dd>prefix for output files<br/>Default: ""<br/></dd>
<dt><b>-walking_perturber_magnitude</b> \<Real\></dt>
<dd>Degree parameter for coupled moves kic walking perturber.<br/>Default: 2.0<br/></dd>
<dt><b>-kic_loop_size</b> \<Real\></dt>
<dd>KIC will try to change the torsion angles of a segment this many residues long. The rotamer of the middle residue will be designed, thus kic_loop_size must be an odd number so a middle residue exists. (Backrub segment length is hardcoded in ShortBackrubMover as 3-residue, or 4-residue if it hits a Proline).<br/>Default: 9<br/></dd>
<dt><b>-kic_perturber</b> \<String\></dt>
<dd>Which perturber to use during kinematic closure (KIC). Current options are walking (default) or fragment. Walking perturber adjusts torsions by degrees, the magnitude of which can be set by -walking_perturber_magnitude. If you specify walking you MAY also specify -walking_perturber_magnitude. If you specify fragment you MUST also specify -loops::frag_files and -loops::frag_sizes.<br/>Default: "walking"<br/></dd>
<dt><b>-backbone_mover</b> \<String\></dt>
<dd>Which backbone mover to use. Current options are backrub (default) or kic. Backrub does not require additional flags, and uses ShortBackrubMover which is hardcoded for 3-residue segments (or 4-residue if it hits a Proline). Kic optionally takes extra flag -kic_perturber.<br/>Default: "backrub"<br/></dd>
<dt><b>-repack_neighborhood</b> \<Boolean\></dt>
<dd>After the backbone move and rotamer move, repack sidechains within 5A of the design residue. Default false for legacy behavior (legacy = Ollikainen 2015).<br/>Default: false<br/></dd>
<dt><b>-exclude_nonclashing_positions</b> \<Boolean\></dt>
<dd>True = For each packable position, ClashBasedShellSelector iterates through rotamers to determine if the residue could clash with any designable positions. If a clash isnt possible, the packable position is changed from NATAA to NATRO. False = Perform side chain moves strictly as defined in resfile. Default true reproduces behavior from Ollikainen 2015.<br/>Default: true<br/></dd>
</dl>
+ <h2>-cp</h2>
<dl>
<dt><b>-cp</b> \<Boolean\></dt>
<dd>cp option group<br/></dd>
<dt><b>-cutoff</b> \<Real\></dt>
<dd>designable neighbor cutoff<br/>Default: 16<br/></dd>
<dt><b>-relax_sfxn</b> \<String\></dt>
<dd>score function for final relaxation step<br/>Default: "score12_full"<br/></dd>
<dt><b>-pack_sfxn</b> \<String\></dt>
<dd>score function for mutational trials<br/>Default: "gauss"<br/></dd>
<dt><b>-minimizer_score_fxn</b> \<String\></dt>
<dd>score function for initial minimization<br/>Default: "score12_full"<br/></dd>
<dt><b>-output</b> \<String\></dt>
<dd>file where we want to dump the final pose<br/>Default: "final_mutant.pdb"<br/></dd>
<dt><b>-ncycles</b> \<Integer\></dt>
<dd>how many cycles to run refinement for<br/>Default: 0<br/></dd>
<dt><b>-max_failures</b> \<Integer\></dt>
<dd>how many failures to tolerate at each iteration before quitting<br/>Default: 1<br/></dd>
<dt><b>-print_reports</b> \<Boolean\></dt>
<dd>print reports to text file?<br/>Default: false<br/></dd>
<dt><b>-vipReportFile</b> \<String\></dt>
<dd>File to print reports to<br/>Default: "reports.txt"<br/></dd>
<dt><b>-exclude_file</b> \<String\></dt>
<dd>Optional input file to specify positions that should not be mutated<br/>Default: "cp_excludes"<br/></dd>
<dt><b>-relax_mover</b> \<String\></dt>
<dd>relax w/o constraints=relax, w constraints=cst_relax<br/>Default: "relax"<br/></dd>
<dt><b>-skip_relax</b> \<Boolean\></dt>
<dd>Skip relax step... may reduce accurate identification of mutations<br/>Default: false<br/></dd>
<dt><b>-local_relax</b> \<Boolean\></dt>
<dd>Limit relax step to neighbors<br/>Default: false<br/></dd>
<dt><b>-print_intermediate_pdbs</b> \<Boolean\></dt>
<dd>Output a pdb file for each consecutive mutation<br/>Default: false<br/></dd>
<dt><b>-use_unrelaxed_starting_points</b> \<Boolean\></dt>
<dd>For subsequent iterations, uses mutation before relaxation<br/>Default: false<br/></dd>
<dt><b>-easy_vip_acceptance</b> \<Boolean\></dt>
<dd>For all iterations, use initial energy for acceptance test<br/>Default: false<br/></dd>
</dl>
+ <h2>-cryst</h2>
<dl>
<dt><b>-cryst</b> \<Boolean\></dt>
<dd>cryst option group<br/></dd>
<dt><b>-mtzfile</b> \<String\></dt>
<dd>mtz file<br/></dd>
<dt><b>-crystal_refine</b> \<Boolean\></dt>
<dd>Turns on crystal-refinement-specific options<br/>Default: false<br/></dd>
<dt><b>-refinable_lattice</b> \<Boolean\></dt>
<dd>In MakeLatticeMover, are the lattice dimensions refineable?<br/>Default: true<br/></dd>
<dt><b>-interaction_shell</b> \<Real\></dt>
<dd>In MakeLatticeMover, what is default interaction shell?<br/>Default: 12.0<br/></dd>
</dl>
+ <h2>-csa</h2>
<dl>
<dt><b>-csa</b> \<Boolean\></dt>
<dd>csa option group<br/></dd>
<dt><b>-useZ</b> \<Boolean\></dt>
<dd>Use absolute zaxis for scoring csa<br/></dd>
</dl>
+ <h2>-cutoutdomain</h2>
<dl>
<dt><b>-cutoutdomain</b> \<Boolean\></dt>
<dd>cutoutdomain option group<br/></dd>
<dt><b>-start</b> \<Integer\></dt>
<dd>start residue<br/>Default: 1<br/></dd>
<dt><b>-end</b> \<Integer\></dt>
<dd>end residue<br/>Default: 2<br/></dd>
</dl>
+ <h2>-cyclization</h2>
<dl>
<dt><b>-cyclization</b> \<Boolean\></dt>
<dd>cyclization option group<br/></dd>
<dt><b>-chains_to_cyclize</b> \<IntegerVector\></dt>
<dd>The chain number to cyclize<br/></dd>
<dt><b>-num_min_rebuild</b> \<Integer\></dt>
<dd>The number of time to iterate between minimization and rebuilding the connection dependant atom positions<br/>Default: 3<br/></dd>
<dt><b>-add_constraints</b> \<Boolean\></dt>
<dd>The add constraints to maintain cycle geometry<br/>Default: true<br/></dd>
</dl>
+ <h2>-cyclic_peptide</h2>
<dl>
<dt><b>-cyclic_peptide</b> \<Boolean\></dt>
<dd>cyclic_peptide option group<br/></dd>
<dt><b>-cyclization_type</b> \<String\></dt>
<dd>The type of cyclization for the peptide (e.g. N-to-C amide bond, terminal disulfide, isopeptide N-terminal lariat, etc.<br/>Default: "n_to_c_amide_bond"<br/></dd>
<dt><b>-use_chainbreak_energy</b> \<Boolean\></dt>
<dd>If true, then the chainbreak energy is used to preserve any N-to-C peptide bond (assuming that this is an N-to-C cyclic peptide).  If false, then constraints are used instead.  True by default.<br/>Default: true<br/></dd>
<dt><b>-rand_checkpoint_file</b> \<String\></dt>
<dd>The name of the checkpoint file used for the random number generator.  Defaults to rng.state.gz.  Not used if the -cyclic_peptide:checkpoint_job_identifier flag isn't used.<br/>Default: "rng.state.gz"<br/></dd>
<dt><b>-checkpoint_file</b> \<String\></dt>
<dd>The name of the checkpoint file.  Defaults to checkpoint.txt.  Not used if the -cyclic_peptide:checkpoint_job_identifier flag isn't used.<br/>Default: "checkpoint.txt"<br/></dd>
<dt><b>-checkpoint_job_identifier</b> \<String\></dt>
<dd>A unique job name for checkpointing.  If none is provided, jobs are not checkpointed.<br/>Default: ""<br/></dd>
<dt><b>-exclude_residues_from_rms</b> \<IntegerVector\></dt>
<dd>A list of residues that should be excluded from the RMSD calculation.  Not used if not provided.<br/></dd>
<dt><b>-default_rama_sampling_table</b> \<String\></dt>
<dd>A custom rama table used for sampling, applied by default to all residues unless the --cyclic_peptide:rama_sampling_table_by_res flag overrides this.  Default unused (in which case the default rama tables for each residue type are used).<br/>Default: ""<br/></dd>
<dt><b>-rama_sampling_table_by_res</b> \<StringVector\></dt>
<dd>Custom rama tables that are to be used for sampling on a per-residue basis.  These must be specified as pairs of [residue_index table_name].  For example: -rama_sampling_table_by_res 2 flat_symm_gly_ramatable 3 flat_symm_pro_ramatable.  Specified values override the -default_rama_sampling_table at the relevant positions.<br/></dd>
<dt><b>-sequence_file</b> \<String\></dt>
<dd>Filename of a file specfying the sequence, as a series of whitespace-separated full residue names (e.g. ALA LYS DARG DPRO HYP).  Required input for the simple_cycpep_predict app.<br/></dd>
<dt><b>-genkic_closure_attempts</b> \<Integer\></dt>
<dd>How many closure attempts should we make for each job attempted by the simple_cycpep_predict app?  Default 1,000.<br/>Default: 1000<br/></dd>
<dt><b>-genkic_min_solution_count</b> \<Integer\></dt>
<dd>How many solutions should genKIC find before picking one when used in the simple_cycpep_predict app?  Default 1.<br/>Default: 1<br/></dd>
<dt><b>-cyclic_permutations</b> \<Boolean\></dt>
<dd>Should cyclic permutations of the sequence be considered when setting up the kinematic closure?  Default true.<br/>Default: true<br/></dd>
<dt><b>-use_rama_filter</b> \<Boolean\></dt>
<dd>Should GenKIC solutions be filtered based on rama score in the simple_cycpep_predict app?  True by default.<br/>Default: true<br/></dd>
<dt><b>-rama_cutoff</b> \<Real\></dt>
<dd>The maximum rama score value that's permitted in the accepted GenKIC solutions if the use_rama_filter option is passed to the simple_cycpep_predict app.  Default 0.8.<br/>Default: 0.8<br/></dd>
<dt><b>-high_hbond_weight_multiplier</b> \<Real\></dt>
<dd>In parts of the simple_cycpep_predict protocol involving upweighting of the backbone hbond terms, by what factor should backbone hbond energy be upweighted?  Default 10.0.<br/>Default: 10.0<br/></dd>
<dt><b>-min_genkic_hbonds</b> \<Real\></dt>
<dd>The minimum number of backbone hbonds for a solution to pass during GenKIC closure in the simple_cycpep_predict app.  Default 3.<br/>Default: 3.0<br/></dd>
<dt><b>-min_final_hbonds</b> \<Real\></dt>
<dd>The minimum number of backbone hbonds for a solution to pass after final relaxtion in the simple_cycpep_predict app.  Default 0 (report only).<br/>Default: 0.0<br/></dd>
<dt><b>-total_energy_cutoff</b> \<Real\></dt>
<dd>An absolute energy threshold, above which solutions are discarded.  Unused if not specified.<br/>Default: 0.0<br/></dd>
<dt><b>-hbond_energy_cutoff</b> \<Real\></dt>
<dd>The mainchain hbond energy threshold for something to be counted as a hydrogen bond in the simple_cycpep_predict app.  Default -0.25.<br/>Default: -0.25<br/></dd>
<dt><b>-do_not_count_adjacent_res_hbonds</b> \<Boolean\></dt>
<dd>When counting hydrogen bonds to a residue, should we skip hydrogen bonds to adjacent residues?  Default true.<br/>Default: true<br/></dd>
<dt><b>-fast_relax_rounds</b> \<Integer\></dt>
<dd>The number of rounds of FastRelax to perform at each FastRelax step in the simple_cycpep_predict protocol.  Note that there are two such steps: a high-hbond initial FastRelax applied to all GenKIC solutions, and a regular scorefunction final FastRelax applied to the best GenKIC solution.  Default 3.<br/>Default: 3<br/></dd>
<dt><b>-count_sc_hbonds</b> \<Boolean\></dt>
<dd>Should sidechain-backbone and sidechain-sidechain hydrogen bonds be counted in the total hydrogen bond count in the simple_cycpep_predict protocol?  Default false.<br/>Default: false<br/></dd>
<dt><b>-require_disulfides</b> \<Boolean\></dt>
<dd>If true, accepted conformations must permit disulfides to be formed.  All permutations of disulfides will be considered, between all disulfide-forming residues.  Default false.<br/>Default: false<br/></dd>
<dt><b>-disulf_cutoff_prerelax</b> \<Real\></dt>
<dd>If require_disulfides is true, this is the maximum disulfide energy per disulfide bond that is allowed prior to relaxation.  If the energy exceeds this value, the solution is rejected.  Default 15.0.<br/>Default: 15.0<br/></dd>
<dt><b>-disulf_cutoff_postrelax</b> \<Real\></dt>
<dd>If require_disulfides is true, this is the maximum disulfide energy per disulfide bond that is allowed following relaxation.  If the energy exceeds this value, the solution is rejected.  Default 0.5.<br/>Default: 0.5<br/></dd>
<dt><b>-user_set_alpha_dihedrals</b> \<RealVector\></dt>
<dd>Allows the user to specify the dihedrals values at one or more alpha-amino acid positions in the peptide.  The flag must be followed by groups of four numbers, where the first is the sequence position and the second, third, and fourth are the phi, psi, and omega values, respectively.  Not used if not specified.<br/></dd>
<dt><b>-user_set_alpha_dihedral_perturbation</b> \<Real\></dt>
<dd>A small, random perturbation added to all dihedral values set with the -user_set_alpha_dihedrals value.  Zero if not specified.<br/>Default: 0.0<br/></dd>
<dt><b>-filter_oversaturated_hbond_acceptors</b> \<Boolean\></dt>
<dd>If true, sampled conformations with more than the allowed number of hydrogen bonds to an acceptor are discarded.  True by default.<br/>Default: true<br/></dd>
<dt><b>-hbond_acceptor_energy_cutoff</b> \<Real\></dt>
<dd>The hydrogen bond energy above which we do not count a hydrogen bond.  Default -0.1.<br/>Default: -0.1<br/></dd>
<dt><b>-sample_cis_pro_frequency</b> \<Real\></dt>
<dd>The fraction of the time that omega=0 degrees is sampled at positions preceding L-proline or D-proline.  Defaults to 0.3.  Set this to 0.0 to prevent all cis-pro sampling.<br/>Default: 0.3<br/></dd>
<dt><b>-design_peptide</b> \<Boolean\></dt>
<dd>If true, then design is attempted for every conformation sampled that passes filters.  Default false.<br/>Default: false<br/></dd>
<dt><b>-allowed_residues_by_position</b> \<File\></dt>
<dd>A text file that lists allowed amino acid resides at each position in the peptide.  Each line must be a whiltespace-separated list of full amino acid names, with the positon index at the start of the line.  Optionally, a DEFAULT setting may be provided (where DEFAULT replaces the position index), which is applied to all positions in the absence of a line describing what's allowed at that position.  In the absence of a DEFAULT line, non-specified positions are repacked with no design.  Not used if not specified (in which case all D- and L-amino acids except cysteine, glycine, and methionine are allowed at all positions).<br/></dd>
<dt><b>-prohibit_D_at_negative_phi</b> \<Boolean\></dt>
<dd>If design is allowed, should D-amino acid residues be prohibited at positions with negative phi values?  Default true.<br/>Default: true<br/></dd>
<dt><b>-prohibit_L_at_positive_phi</b> \<Boolean\></dt>
<dd>If design is allowed, should L-amino acid residues be prohibited at positions with positive phi values?  Default true.<br/>Default: true<br/></dd>
<dt><b>-L_alpha_comp_file</b> \<File\></dt>
<dd>If design is allowed, this is the (optional) aa_composition file used for the right-handed (L-amino acid) alpha-helical region of Ramachandran space.  Unused if not specified.<br/></dd>
<dt><b>-D_alpha_comp_file</b> \<File\></dt>
<dd>If design is allowed, this is the (optional) aa_composition file used for the left-handed (D-amino acid) alpha-helical region of Ramachandran space.  Unused if not specified.<br/></dd>
<dt><b>-L_beta_comp_file</b> \<File\></dt>
<dd>If design is allowed, this is the (optional) aa_composition file used for the negative-phi (L-amino acid) beta-strand region of Ramachandran space.  Unused if not specified.<br/></dd>
<dt><b>-D_beta_comp_file</b> \<File\></dt>
<dd>If design is allowed, this is the (optional) aa_composition file used for the positive-phi (D-amino acid) beta-strand region of Ramachandran space.  Unused if not specified.<br/></dd>
<dt><b>-angle_relax_rounds</b> \<Integer\></dt>
<dd>The number of rounds of FastRelax to perform with flexible bond angles after each standard FastRelax step in the simple_cycpep_predict protocol.  Default 0 (unused).<br/>Default: 0<br/></dd>
<dt><b>-angle_length_relax_rounds</b> \<Integer\></dt>
<dd>The number of rounds of FastRelax to perform with flexible bond angles and bond lengths after each standard FastRelax step in the simple_cycpep_predict protocol.  Default 0 (unused).<br/>Default: 0<br/></dd>
<dt><b>-cartesian_relax_rounds</b> \<Integer\></dt>
<dd>The number of rounds of Cartesian FastRelax to perform after each standard FastRelax step in the simple_cycpep_predict protocol.  Default 0 (unused).<br/>Default: 0<br/></dd>
<dt><b>-use_classic_rama_for_sampling</b> \<Boolean\></dt>
<dd>If true, classic Ramachandran tables are used for sampling instead of the RamaPrePro tables.  Default false (i.e. newer RamaPrePro tables are used by default).<br/>Default: false<br/></dd>
<dt><b>-n_methyl_positions</b> \<IntegerVector\></dt>
<dd>If provided, then these positions are N-methylated.  Not used if not specified.<br/></dd>
<dt><b>-lariat_sidechain_index</b> \<Integer\></dt>
<dd>If a lariat cyclization type is specified (e.g. nterm_isopeptide_lariat, cterm_isopeptide_lariat), then this is the residue that provides the side-chain that connects to the N- or C-terminus of the peptide.  If not specified, the residue of appropriate type closest to the other end is used.<br/>Default: 0<br/></dd>
<dt><b>-sidechain_isopeptide_indices</b> \<IntegerVector\></dt>
<dd>If the sidechain_isopeptide cyclization type is specified, these are the indices of the residues that are linked by a sidechain-sidechain isopeptide bond to make the loop.  If not specified, the residues furthest apart of appropriate types are used.  Note that exactly two indices must be given.<br/></dd>
<dt><b>-TBMB_positions</b> \<IntegerVector\></dt>
<dd>If provided, then these positions will be linked by a 1,3,5-tris(bromomethyl)benzene crosslinker.  3N positions must be specified, and every group of three will be linked.  Unused if not specified.<br/></dd>
<dt><b>-use_TBMB_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between TBMB cysteines and on constraints to discard GenKIC solutions that can't be crosslinked easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-TBMB_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for TBMB cysteines.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-TBMB_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for TBMB cysteines.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-link_all_cys_with_TBMB</b> \<Boolean\></dt>
<dd>If true, then all cysteine residues in the peptide are linked with 1,3,5-tris(bromomethyl)benzene.  There must be exactly three cysteine residues for this flag to be used, and it cannot be used with the -TBMB_positions flag.  False/unused by default.<br/>Default: false<br/></dd>
<dt><b>-TMA_positions</b> \<IntegerVector\></dt>
<dd>If provided, then these positions will be linked by a trimesic acid crosslinker.  The positions must have sidechain primary amines (i.e. be one of lysine [LYS], ornithine [ORN], 2,4-diaminobutyric acid [DAB], or 2,3-diaminopripionic acid [DPP].  There must be 3N positions specified, and every group of three will be linked.  Unused if not specified.<br/></dd>
<dt><b>-use_TMA_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between TMA-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-TMA_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for side-chains linked by trimseic acid (TMA).  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-TMA_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for side-chains linked by trimseic acid (TMA).  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-square_pyramidal_metal_positions</b> \<StringVector\></dt>
<dd>If provided, then these positions will coordinate a metal with square pyramidal coordination.  The positions must have sidechains that can coordinate a metal (e.g. histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,res5,metal.  For example, if positions 4, 6, 9, 13, and 16 were to coordinate a nickel, the string would be 4,6,9,13,16,Ni2.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  The metal will be represented by virtual atoms, and will not be modelled explicitly.  Unused if not specified.<br/></dd>
<dt><b>-use_square_pyramidal_metal_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-square_pyramidal_metal_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for side-chains linked by a metal coordinated with square pyramidal coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-square_pyramidal_metal_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for side-chains linked by a metal coordinated with square pyramidal coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-square_planar_metal_positions</b> \<StringVector\></dt>
<dd>If provided, then these positions will coordinate a metal with square planar coordination.  The positions must have sidechains that can coordinate a metal (e.g. histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,metal.  For example, if positions 6, 9, 13, and 17 were to coordinate a nickel, the string would be 6,9,13,17,Ni2.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  The metal will be represented by virtual atoms, and will not be modelled explicitly.  Unused if not specified.<br/></dd>
<dt><b>-use_square_planar_metal_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-square_planar_metal_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for side-chains linked by a metal coordinated with square planar coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-square_planar_metal_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for side-chains linked by a metal coordinated with square planar coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-trigonal_pyramidal_metal_positions</b> \<StringVector\></dt>
<dd>If provided, then these positions will coordinate a metal with trigonal pyramidal coordination.  The positions must have sidechains that can coordinate a metal (e.g. histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,metal.  For example, if positions 6, 9, and 13 were to coordinate a zinc, the string would be 6,9,13,Zn.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  The metal will be represented by virtual atoms, and will not be modelled explicitly.  Unused if not specified.<br/></dd>
<dt><b>-use_trigonal_pyramidal_metal_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-trigonal_pyramidal_metal_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for side-chains linked by a metal coordinated with trigonal pyramidal coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-trigonal_pyramidal_metal_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for side-chains linked by a metal coordinated with trigonal pyramidal coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-trigonal_planar_metal_positions</b> \<StringVector\></dt>
<dd>If provided, then these positions will coordinate a metal with trigonal planar coordination.  The positions must have sidechains that can coordinate a metal (e.g. histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,metal.  For example, if positions 6, 9, and 13 were to coordinate a zinc, the string would be 6,9,13,Zn.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  The metal will be represented by virtual atoms, and will not be modelled explicitly.  Unused if not specified.<br/></dd>
<dt><b>-use_trigonal_planar_metal_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-trigonal_planar_metal_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for side-chains linked by a metal coordinated with trigonal planar coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-trigonal_planar_metal_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for side-chains linked by a metal coordinated with trigonal planar coordination.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-tetrahedral_metal_positions</b> \<StringVector\></dt>
<dd>If provided, then these positions will coordinate a metal, tetrahedrally.  The positions must have sidechains that can coordinate a metal (e.g. histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,metal.  For example, if positions 4, 6, 9, and 13 were to coordinate a zinc, the string would be 4,6,9,13,Zn.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  The metal will be represented by virtual atoms, and will not be modelled explicitly.  Unused if not specified.<br/></dd>
<dt><b>-use_tetrahedral_metal_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-tetrahedral_metal_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for side-chains linked by a tetrahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-tetrahedral_metal_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for side-chains linked by a tetrahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-octahedral_metal_positions</b> \<StringVector\></dt>
<dd>If provided, then these positions will coordinate a metal, octahedrally.  The positions must have sidechains that can coordinate a metal (e.g. histidine, aspartate, glutamate).  The positions should be specified in the form res1,res2,res3,res4,res5,res6,metal.  For example, if positions 4, 6, 9, 13, 16, and 18 were to coordinate an iron(II), the string would be 4,6,9,13,Fe2.  Multiple sets of metal-coordinating side-chains can be specified, separated by a space.  The metal will be represented by virtual atoms, and will not be modelled explicitly.  Unused if not specified.<br/></dd>
<dt><b>-use_octahedral_metal_filters</b> \<Boolean\></dt>
<dd>If true, then filters are applied based on distance between metal-conjugated sidechains and on constraints to discard GenKIC solutions that can't be crosslinked with a metal easily.  True by default.<br/>Default: true<br/></dd>
<dt><b>-octahedral_metal_sidechain_distance_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the distance cutoff for side-chains linked by a octahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-octahedral_metal_constraints_energy_filter_multiplier</b> \<Real\></dt>
<dd>A multiplier for the constraints energy for side-chains linked by a octahedrally-coordinated metal.  Higher values result in more permissive filtering.  Default 1.0.<br/>Default: 1.0<br/></dd>
<dt><b>-require_symmetry_repeats</b> \<Integer\></dt>
<dd>If this option is used, then only backbones that are cN (or cN/m, if mirror symmetry is required) symmetric will be accepted.  For example, if set to 2, then only c2-symmetric backbones will be accepted.  Unused if not specified.<br/>Default: 1<br/></dd>
<dt><b>-require_symmetry_mirroring</b> \<Boolean\></dt>
<dd>If this option is used, then only backbones with mirror symmetry are accepted.  Must be used with the -cyclic_peptide:require_symmetry_repeats flag.<br/>Default: false<br/></dd>
<dt><b>-require_symmetry_angle_threshold</b> \<Real\></dt>
<dd>The cutoff, in degrees, to use when comparing mainchain torsion values to determine whether symmetry repeats are truely symmetric.  Defaults to 10 degrees.<br/>Default: 10.0<br/></dd>
<dt><b>-require_symmetry_perturbation</b> \<Real\></dt>
<dd>If provided, this is the magnitude of the perturbation to apply when copying mainchain dihedrals for symmetric sampling.  Allows slightly asymmetric conformations to be sampled.  Default is 0.0 (no perturbation).<br/>Default: 0.0<br/></dd>
<dt><b>-MPI_processes_by_level</b> \<IntegerVector\></dt>
<dd>The number of processes at each level of the parallel communications hierarchy, used only by the MPI version.  For example, '1 10 100' would mean that one emperor would talk to 10 masters, which would talk to 100 slaves (implying that each master is assigned 100 slaves).  Similarly, '1 100' would mean that one master would talk directly to 100 slaves.  Required for the MPI version.<br/></dd>
<dt><b>-MPI_batchsize_by_level</b> \<IntegerVector\></dt>
<dd>The number of jobs sent at a time by each communication level to its children.  Given N levels, N-1 values must be specified.  For example, given 3 communications levels, '100 10' would mean that the emperor sends 100 jobs at a time to each master, which sends 10 jobs at a time to each slave.  Must be specified for the simple_cycpep_predict application in MPI mode.<br/></dd>
<dt><b>-MPI_sort_by</b> \<String\></dt>
<dd>The MPI version of the simple_cycpep_predict app has the option of writing out the top N% of solutions.  This determines the sort metric.<br/>Default: "energy"<br/></dd>
<dt><b>-MPI_choose_highest</b> \<Boolean\></dt>
<dd>When outputing the top N% of solutions, should I choose the ones with the higest score for the metric chosen (energy, rmsd, hbonds, etc.) or lowest?  Default false (chose lowest).<br/>Default: false<br/></dd>
<dt><b>-MPI_output_fraction</b> \<Real\></dt>
<dd>The fraction of total structures that will be written out.  This is used in conjunction with 'MPI_sort_by' to output the top N% of job outputs.  For example, '-MPI_output_fraction 0.05 -MPI_sort_by rmsd' means that the 5% of structures with the lowest RMSD values will be written out.<br/>Default: 1.0<br/></dd>
<dt><b>-MPI_stop_after_time</b> \<Integer\></dt>
<dd>If this option is used, the emperor node will send a stop signal after an elapsed period of time, given in seconds.  Slaves jobs currently running will continue, but intermediate masters will not assign any more work.  Useful on HPC clusters with time limits, to ensure that jobs completed are collected at the end.  Unused if not specified.<br/></dd>
<dt><b>-MPI_pnear_lambda</b> \<Real\></dt>
<dd>In MPI mode a goodness-of-funnel metric is automatically calculated at the end (PNear).  This value may be thought of as the probability, from 0 to 1, of the peptide being in the target conformation at any given time.  The parameter lambda controls the bredth of the Gaussian (in RMSD units -- Angstroms) that is used to determine whether a state is native-like or not.  Default 0.5 A.<br/>Default: 0.5<br/></dd>
<dt><b>-MPI_pnear_kbt</b> \<Real\></dt>
<dd>In MPI mode a goodness-of-funnel metric is automatically calculated at the end (PNear).  This value may be thought of as the probability, from 0 to 1, of the peptide being in the target conformation at any given time.  The parameter kbt is the Boltzmann temperature that determines the extent to which higher energy states are likely to be sampled.  Default 1.0 Rosetta energy units.<br/>Default: 1.0<br/></dd>
<dt><b>-threads_per_slave</b> \<Integer\></dt>
<dd>In the multi-threaded MPI compilation, this is the number of threads to launch per slave process.  Note that emperor and master-layer processes do not launch threads.  A value of 1 (the default) means that only standard hierarchical process-based parallelism will be used.  In non-MPI or non-threaded compilations, this option is unused.<br/>Default: 1<br/></dd>
</dl>
+ <h2>-dc</h2>
<dl>
<dt><b>-dc</b> \<Boolean\></dt>
<dd>dc option group<br/></dd>
<dt><b>-useZ</b> \<Boolean\></dt>
<dd>Use absolute zaxis for scoring dc<br/></dd>
</dl>
+ <h2>-ddg</h2>
<dl>
<dt><b>-ddg</b> \<Boolean\></dt>
<dd>ddg option group<br/></dd>
<dt><b>-opt_input_structure</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-pack_until_converge</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-no_constraints</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-use_rotamer_constraints_to_native</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-suppress_checkpointing</b> \<Boolean\></dt>
<dd>boinc specific options to suppress checkpointing behavior<br/>Default: false<br/></dd>
<dt><b>-wt_only</b> \<Boolean\></dt>
<dd>option added to minirosetta app in order to produce only refinement in wt structures<br/>Default: false<br/></dd>
<dt><b>-mut_only</b> \<Boolean\></dt>
<dd>options added to minirosetta app in order to produce refinement in only mutant structure<br/></dd>
<dt><b>-output_silent</b> \<Boolean\></dt>
<dd>No description<br/></dd>
<dt><b>-minimization_scorefunction</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-minimization_patch</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-min_cst</b> \<Boolean\></dt>
<dd>Following sidechain optimization in the packer, should we then proceed to minimize the backbone at all.  Constraints will be used to keep the structure from moving too far.<br/>Default: true<br/></dd>
<dt><b>-lowest_x_decoys</b> \<Integer\></dt>
<dd>No description<br/></dd>
<dt><b>-local_opt_only</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-print_per_res_diff</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-mean</b> \<Boolean\></dt>
<dd>No description<br/></dd>
<dt><b>-min</b> \<Boolean\></dt>
<dd>No description<br/></dd>
<dt><b>-no_bb_movement</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-initial_repack</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-interface_ddg</b> \<Integer\></dt>
<dd>Calculate ddGs across an interface? Uses jump # specified for determining interface.<br/>Default: 0<br/></dd>
<dt><b>-ens_variation</b> \<Real\></dt>
<dd>No description<br/>Default: 0.5<br/></dd>
<dt><b>-sc_min_only</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-rna_all_prot_sc_min_only</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-min_cst_weights</b> \<String\></dt>
<dd>No description<br/>Default: "talaris2013"<br/></dd>
<dt><b>-opt_radius</b> \<Real\></dt>
<dd>No description<br/>Default: 8.0<br/></dd>
<dt><b>-output_dir</b> \<String\></dt>
<dd>No description<br/>Default: "./"<br/></dd>
<dt><b>-last_accepted_pose_dir</b> \<String\></dt>
<dd>No description<br/>Default: "./"<br/></dd>
<dt><b>-min_with_cst</b> \<Boolean\></dt>
<dd>Used in ensemble generation<br/>Default: false<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>because I really dont know what the monte carlo temperature should be set to<br/>Default: 10<br/></dd>
<dt><b>-ramp_repulsive</b> \<Boolean\></dt>
<dd>set fa_rep to 0.1, 0.33 of original value when minimizing in the minimization phase following packing<br/>Default: false<br/></dd>
<dt><b>-mut_file</b> \<String\></dt>
<dd>alternate specification for mutations.  File format described in fix_bb_monomer_ddg.cc above the read_in_mutations function<br/></dd>
<dt><b>-out_pdb_prefix</b> \<String\></dt>
<dd>specifies the prefix assigned to output so that no overwriting happens<br/></dd>
<dt><b>-constraint_weight</b> \<Real\></dt>
<dd>because that other option isnt working<br/>Default: 1.0<br/></dd>
<dt><b>-harmonic_ca_tether</b> \<Real\></dt>
<dd>default CA tether for harmonic constraints<br/>Default: 2.0<br/></dd>
<dt><b>-iterations</b> \<Integer\></dt>
<dd>specifies the number of iterations of refinement<br/>Default: 3<br/></dd>
<dt><b>-force_iterations</b> \<Boolean\></dt>
<dd>Forces the ddg protocol to iterate up to the value set by iterations rather than stoping at convergence.<br/>Default: true<br/></dd>
<dt><b>-out</b> \<String\></dt>
<dd>create output file of predicted ddgs<br/>Default: "ddg_predictions.out"<br/></dd>
<dt><b>-debug_output</b> \<Boolean\></dt>
<dd>specify whether or not to write a whole bunch of debug statements to standard out<br/>Default: false<br/></dd>
<dt><b>-dump_pdbs</b> \<Boolean\></dt>
<dd>specify whether or not to dump repacked wild-type and mutant pdbs<br/>Default: true<br/></dd>
<dt><b>-weight_file</b> \<String\></dt>
<dd>specifies the weight-files to be used in calculations<br/>Default: "ddg.wts"<br/></dd>
<dt><b>-cst_dist_cutoff</b> \<Real\></dt>
<dd>the cutoff distance for generating harmonic csts between residues<br/>Default: 9.0<br/></dd>
<dt><b>-cartesian</b> \<Boolean\></dt>
<dd>Toggle cartesian mode in the CartesianddG app calculations<br/>Default: true<br/></dd>
<dt><b>-extract_element_nbrs</b> \<Integer\></dt>
<dd>How many sequence space nbrs to extract when doing binding calculations<br/>Default: 0<br/></dd>
<dt><b>-frag_nbrs</b> \<Integer\></dt>
<dd>How many (sequence) neighbors should the fragments include. i.e. 2 nbrs = fragments of size 5 with the target in the middle<br/>Default: 2<br/></dd>
<dt><b>-bbnbrs</b> \<Integer\></dt>
<dd>How many (sequence) neighbors should be included in the backbone minimization<br/>Default: 1<br/></dd>
<dt><b>-nfrags</b> \<Integer\></dt>
<dd>How many fragments to pick, and then use, in the cartesian sampler<br/>Default: 30<br/></dd>
<dt><b>-ntrials</b> \<Integer\></dt>
<dd>How many cycles of frag assign to run in the cartesian sampler<br/>Default: 30<br/></dd>
<dt><b>-optimize_proline</b> \<Boolean\></dt>
<dd>Triggers use of fragments and the cartesian sampler to optimize around proline residues.<br/>Default: true<br/></dd>
<dt><b>-flex_bb</b> \<Boolean\></dt>
<dd>Should neighbor residues be allowed to move the backbone.<br/>Default: false<br/></dd>
<dt><b>-fd_mode</b> \<Boolean\></dt>
<dd>Preserving franks mode for testing directional neighborfinding.<br/>Default: false<br/></dd>
<dt><b>-legacy</b> \<Boolean\></dt>
<dd>Call the legacy version of the cartesian_ddg app.<br/>Default: true<br/></dd>
<dt><b>-json</b> \<Boolean\></dt>
<dd>Read and write results in json.<br/>Default: false<br/></dd>
<dt><b>-n_converged</b> \<Integer\></dt>
<dd>How many models need to be in range for the solution to be considered converged.<br/>Default: 2<br/></dd>
<dt><b>-score_cutoff</b> \<Real\></dt>
<dd>What is the score cutoff to be considered converged.<br/>Default: 1.0<br/></dd>
</dl>
+ <h2>-DenovoProteinDesign</h2>
<dl>
<dt><b>-DenovoProteinDesign</b> \<Boolean\></dt>
<dd>DenovoProteinDesign option group<br/></dd>
<dt><b>-redesign_core</b> \<Boolean\></dt>
<dd>redesign core of pdb<br/>Default: false<br/></dd>
<dt><b>-redesign_loops</b> \<Boolean\></dt>
<dd>redesign loops of pdb<br/>Default: false<br/></dd>
<dt><b>-redesign_surface</b> \<Boolean\></dt>
<dd>redesign surface of pdb<br/>Default: false<br/></dd>
<dt><b>-redesign_complete</b> \<Boolean\></dt>
<dd>complete redesign of pdb<br/>Default: false<br/></dd>
<dt><b>-optimize_loops</b> \<Boolean\></dt>
<dd>do serious loop modeling at the end of designrelax mover<br/></dd>
<dt><b>-secondary_structure_file</b> \<File\></dt>
<dd>has fasta file format - describes secondary structure of desired target with H/C/E<br/></dd>
<dt><b>-hydrophobic_polar_pattern</b> \<File\></dt>
<dd>has fasta file format - describes hydrophobic(B) polar(P) pattern<br/></dd>
<dt><b>-use_template_sequence</b> \<Boolean\></dt>
<dd>use the template pdbs sequence when creating starting structures<br/>Default: false<br/></dd>
<dt><b>-use_template_topology</b> \<Boolean\></dt>
<dd>use templates phi/psi in loops and begin/end helix/sheet generate only template like starting structures<br/>Default: false<br/></dd>
<dt><b>-create_from_template_pdb</b> \<File\></dt>
<dd>create starting structure from a template pdb, follow with pdb name<br/></dd>
<dt><b>-create_from_secondary_structure</b> \<Boolean\></dt>
<dd>create starting structure from a file that contains H/C/E to describe topology or B/P pattern, has fasta file format<br/>Default: false<br/></dd>
</dl>
+ <h2>-dna</h2>
<dl>
<dt><b>-dna</b> \<Boolean\></dt>
<dd>dna option group<br/></dd>
</dl>
+ <h3>-dna:specificity</h3>
<dl>
<dt><b>-specificity</b> \<Boolean\></dt>
<dd>specificity option group<br/></dd>
<dt><b>-exclude_dna_dna</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-params</b> \<RealVector\></dt>
<dd>vector of real-valued params<br/></dd>
<dt><b>-frag_files</b> \<FileVector\></dt>
<dd>files to collect frags from<br/></dd>
<dt><b>-only_repack</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-design_DNA</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-soft_rep</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-dump_pdbs</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-fast</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-randomize_motif</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-Wfa_elec</b> \<Real\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-Wdna_bs</b> \<Real\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-Wdna_bp</b> \<Real\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-minimize_tolerance</b> \<Real\></dt>
<dd>No description<br/>Default: 0.001<br/></dd>
<dt><b>-weights_tag</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-weights_tag_list</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-min_type</b> \<String\></dt>
<dd>No description<br/>Default: "lbfgs_armijo_nonmonotone"<br/></dd>
<dt><b>-mode</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-score_function</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-pre_minimize</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-post_minimize</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-pre_pack</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-nloop</b> \<Integer\></dt>
<dd>No description<br/>Default: 20<br/></dd>
<dt><b>-n_inner</b> \<Integer\></dt>
<dd>No description<br/></dd>
<dt><b>-n_outer</b> \<Integer\></dt>
<dd>No description<br/></dd>
<dt><b>-nstep_water</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-moving_jump</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-motif_begin</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-motif_size</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-pdb_pos</b> \<StringVector\></dt>
<dd>list of one or more positions in the input pdb, eg: -pdb_pos 125:A 127:A 4:C<br/>Default: ""<br/></dd>
<dt><b>-methylate</b> \<StringVector\></dt>
<dd>list of one or more positions in the input pdb to be methylated, eg: -methylate 125:A 127:A 4:C<br/>Default: ""<br/></dd>
<dt><b>-dna_backbone_torsion_sdevs</b> \<RealVector\></dt>
<dd>No description<br/></dd>
<dt><b>-dna_sugar_torsion_sdev</b> \<Real\></dt>
<dd>No description<br/>Default: 4.0<br/></dd>
<dt><b>-dna_chi_torsion_sdev</b> \<Real\></dt>
<dd>No description<br/>Default: 15.0<br/></dd>
<dt><b>-lk_ball_wtd_tag</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-lk_ball_for_bb</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-lk_ball_ramp_width_A2</b> \<Real\></dt>
<dd>No description<br/>Default: 3.9<br/></dd>
<dt><b>-lk_ball_overlap_gap</b> \<Real\></dt>
<dd>No description<br/>Default: 0.0<br/></dd>
<dt><b>-lk_ball_overlap_width_A2</b> \<Real\></dt>
<dd>No description<br/>Default: 5.0<br/></dd>
<dt><b>-lk_ball_water_fade</b> \<Real\></dt>
<dd>No description<br/>Default: 1.0<br/></dd>
<dt><b>-lk_ball_wtd_prefactors</b> \<RealVector\></dt>
<dd>6 scale factors that are applied to the lk_ball_wtd per-atom weights; the order is <donor-iso> <donor-ball> <acceptor-iso> <acceptor-ball> <don+acc-iso> <don+acc-ball>; where <don+acc> means atom-types that are both donors and acceptors (SP3 hybridized OH for example)<br/></dd>
<dt><b>-lk_ball_waters_sp2</b> \<RealVector\></dt>
<dd>The geometry of sp2 acceptor waters in lk_ball. Format: ( <length_A> <angle_degrees> <torsion_degrees> )+  Default: 2.65 120 0  2.65 120 180.  No limit on #, but all three params must be specified for each<br/></dd>
<dt><b>-lk_ball_waters_sp3</b> \<RealVector\></dt>
<dd>The geometry of sp3 acceptor waters in lk_ball. Format: ( <length_A> <angle_degrees> <torsion_degrees> )+  Default: 2.65 109 120  2.65 109 240.  No limit on #, but all three params must be specified for each<br/></dd>
<dt><b>-lk_ball_waters_ring</b> \<RealVector\></dt>
<dd>The geometry of ring acceptor waters in lk_ball. Format: ( <length_A> <angle_degrees> <torsion_degrees> )+  Default: 2.65 180 0.  No limit on #, but all three params must be specified for each<br/></dd>
<dt><b>-lk_ball_waters_donor</b> \<Real\></dt>
<dd>The geometry of donor waters in lk_ball. Length along N-H vector<br/></dd>
<dt><b>-lk_ball_bridge_angle_widthscale</b> \<Real\></dt>
<dd>The width scaling on the angular component of lk_ball_bridge (lower = tighter)<br/>Default: 0.0<br/></dd>
</dl>
+ <h3>-dna:design</h3>
<dl>
<dt><b>-design</b> \<Boolean\></dt>
<dd>design option group<br/></dd>
<dt><b>-output_unbound_pdb</b> \<Boolean\></dt>
<dd>write out an unbound pdb if doing binding score calculations<br/>Default: false<br/></dd>
<dt><b>-z_cutoff</b> \<Real\></dt>
<dd>distance along DNA-axis from designing DNA bases to allow amino acids to design<br/>Range: 0-<br/>Default: 3.5<br/></dd>
<dt><b>-protein_scan</b> \<String\></dt>
<dd>single-residue scanning of protein residue types for binding and specificity scores<br/>Default: "ACDEFGHIKLMNPQRSTVWY"<br/></dd>
<dt><b>-checkpoint</b> \<String\></dt>
<dd>write/read checkpoint files for higher-level protocols that proceed linearly for long periods of time.  Provide a checkpoint filename after this option.<br/>Default: ""<br/></dd>
<dt><b>-minimize</b> \<Boolean\></dt>
<dd>Perform minimization in DNA design mode.<br/>Default: false<br/></dd>
<dt><b>-dna_defs</b> \<StringVector\></dt>
<dd><br/>Default: ""<br/></dd>
<dt><b>-dna_defs_file</b> \<String\></dt>
<dd><br/>Default: ""<br/></dd>
<dt><b>-nopdb</b> \<Boolean\></dt>
<dd>use this flag to disable pdb output<br/>Default: false<br/></dd>
<dt><b>-designable_second_shell</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-base_contacts_only</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-probe_specificity</b> \<Integer\></dt>
<dd>Rapidly estimate the explicit specificity of DNA designs during fixed-backbone repacking<br/>Default: 1<br/></dd>
<dt><b>-reversion_scan</b> \<Boolean\></dt>
<dd>Try to revert spurious mutations after designing<br/>Default: false<br/></dd>
<dt><b>-binding</b> \<Boolean\></dt>
<dd>compute a protein-DNA binding energy<br/>Default: false<br/></dd>
<dt><b>-Boltz_temp</b> \<Real\></dt>
<dd>temperature for Boltzmann calculations<br/>Default: 0.6<br/></dd>
<dt><b>-repack_only</b> \<Boolean\></dt>
<dd>Do not allow protein sequences to mutate arbitrarily<br/>Default: false<br/></dd>
<dt><b>-sparse_pdb_output</b> \<Boolean\></dt>
<dd>Output only coordinates that change relative to the input structure<br/>Default: false<br/></dd>
</dl>
+ <h4>-dna:design:specificity</h4>
<dl>
<dt><b>-specificity</b> \<Boolean\></dt>
<dd>specificity option group<br/></dd>
<dt><b>-output_structures</b> \<Boolean\></dt>
<dd>output structures for each sequence combination<br/>Default: false<br/></dd>
<dt><b>-include_dna_potentials</b> \<Boolean\></dt>
<dd>include DNA potentials in calculations of DNA sequence specificity<br/>Default: false<br/></dd>
</dl>
+ <h4>-dna:design:reversion</h4>
<dl>
<dt><b>-reversion</b> \<Boolean\></dt>
<dd>reversion option group<br/></dd>
<dt><b>-dscore_cutoff</b> \<Real\></dt>
<dd>limit for acceptable loss in energy<br/>Default: 1.5<br/></dd>
<dt><b>-dspec_cutoff</b> \<Real\></dt>
<dd>limit for acceptable loss in specificity<br/>Default: -0.05<br/></dd>
</dl>
+ <h2>-DisulfideInsertion</h2>
<dl>
<dt><b>-DisulfideInsertion</b> \<Boolean\></dt>
<dd>DisulfideInsertion option group<br/></dd>
<dt><b>-peptide_chain</b> \<Integer\></dt>
<dd>The number of peptide chain for which to perform a DisulfideInsertion check<br/>Default: 1<br/></dd>
<dt><b>-n_cyd_seqpos</b> \<Integer\></dt>
<dd>The sequential position of the residue in the n-ter of the putative disulfide; 0 signals the peptide n-ter<br/>Default: 0.0<br/></dd>
<dt><b>-c_cyd_seqpos</b> \<Integer\></dt>
<dd>The sequential position of the residue in the c-ter of the putative disulfide; 0 signals the peptide c-ter<br/>Default: 0.0<br/></dd>
<dt><b>-max_dslf_pot</b> \<Real\></dt>
<dd>The maximum allowed match score for disulfide rotation and translation<br/>Default: 2.0<br/></dd>
<dt><b>-max_dslf_energy</b> \<Real\></dt>
<dd>The maximum allowed change in disulfide energy upon peptide disulfide bridge formation<br/>Default: -0.5<br/></dd>
<dt><b>-min_dslf_dist_multiplier</b> \<Real\></dt>
<dd>A multiplier for the minimum allowed distance between residues that might form a disulfide.<br/>Default: 1.0<br/></dd>
<dt><b>-max_dslf_dist_multiplier</b> \<Real\></dt>
<dd>A multiplier for the maximum allowed distance between residues that might form a disulfide.<br/>Default: 1.0<br/></dd>
<dt><b>-scorefxn</b> \<String\></dt>
<dd>The scorefunction to be used in disulfideInsertion<br/></dd>
<dt><b>-constraint_weight</b> \<Real\></dt>
<dd>Weight of the constraints on disulfide bonds formed by the DisulfideInsertionMover; EXPERIMENTAL<br/>Default: 0.0<br/></dd>
</dl>
+ <h2>-docking</h2>
<dl>
<dt><b>-kick_relax</b> \<Boolean\></dt>
<dd>Add relax step at the end of symmetric docking<br/>Default: false<br/></dd>
<dt><b>-docking</b> \<Boolean\></dt>
<dd>Docking option group<br/></dd>
<dt><b>-view</b> \<Boolean\></dt>
<dd>Decide whether to use the viewer (graphical) or not<br/>Default: false<br/></dd>
<dt><b>-no_filters</b> \<Boolean\></dt>
<dd>Toggle the use of filters<br/>Default: false<br/></dd>
<dt><b>-design_chains</b> \<StringVector\></dt>
<dd>Pass in the one-letter chain identifiers, separated by space, for each chain to design: -design_chains A B<br/></dd>
<dt><b>-recover_sidechains</b> \<File\></dt>
<dd>usually side-chains are taken from the input structure if it is fullatom - this overrides this behavior and takes sidechains from the pdb-file<br/></dd>
<dt><b>-partners</b> \<String\></dt>
<dd>defines docking partners by ChainID, example: docking chains L+H with A is -partners LH_A<br/>Default: "_"<br/></dd>
<dt><b>-docking_local_refine</b> \<Boolean\></dt>
<dd>Do a local refinement of the docking position (high resolution)<br/>Default: false<br/></dd>
<dt><b>-low_res_protocol_only</b> \<Boolean\></dt>
<dd>Run only low resolution docking, skip high resolution docking<br/>Default: false<br/></dd>
<dt><b>-docking_low_res_score</b> \<String\></dt>
<dd>Define low resolution docking score function.<br/>Default: "interchain_cen"<br/></dd>
<dt><b>-randomize1</b> \<Boolean\></dt>
<dd>Randomize the first docking partner.<br/>Default: false<br/></dd>
<dt><b>-randomize2</b> \<Boolean\></dt>
<dd>Randomize the second docking partner.<br/>Default: false<br/></dd>
<dt><b>-use_ellipsoidal_randomization</b> \<Boolean\></dt>
<dd>Modify docking randomization to use ellipsoidal rather than spherical method.<br/>Default: false<br/></dd>
<dt><b>-spin</b> \<Boolean\></dt>
<dd>Spin a second docking partner around axes from center of mass of partner1 to partner2<br/>Default: false<br/></dd>
<dt><b>-tilt</b> \<RealVector\></dt>
<dd>tilt the docking partners at a random angle  : -tilt PARTNER1_MAX_DEGREES PARTNER2_MAX_DEGREES.<br/></dd>
<dt><b>-tilt1_center</b> \<String\></dt>
<dd>resID around which rotation of partner1 is centered (default: center of mass of partner 1<br/>Default: ""<br/></dd>
<dt><b>-tilt2_center</b> \<String\></dt>
<dd>resID around which rotation of partner2 is centered (default: center of mass of partner 2<br/>Default: ""<br/></dd>
<dt><b>-dock_pert</b> \<RealVector\></dt>
<dd>Do a small perturbation with partner two: -dock_pert ANGSTROMS DEGREES.  Good values for protein docking are 3 A and 8 deg.<br/></dd>
<dt><b>-uniform_trans</b> \<Real\></dt>
<dd>No description<br/></dd>
<dt><b>-center_at_interface</b> \<Boolean\></dt>
<dd>Perform all initial perturbations with the center of rotation at the interface between partners instead of at the center of mass of the oppposite partner.<br/>Default: false<br/></dd>
<dt><b>-dock_mcm_first_cycles</b> \<Integer\></dt>
<dd>Perfrom 4 cycles to let the filter decide to continue.<br/>Default: 4<br/></dd>
<dt><b>-dock_mcm_second_cycles</b> \<Integer\></dt>
<dd>If the first cycle pass the fliter, continue 45 cycles.<br/>Default: 45<br/></dd>
<dt><b>-docking_centroid_outer_cycles</b> \<Integer\></dt>
<dd>Outer cycles during cking rigid body adaptive moves.<br/>Default: 10<br/></dd>
<dt><b>-docking_centroid_inner_cycles</b> \<Integer\></dt>
<dd>Inner cycles during docking rigid body adaptive moves.<br/>Default: 50<br/></dd>
<dt><b>-dock_min</b> \<Boolean\></dt>
<dd>Minimize the final fullatom structure.<br/>Default: false<br/></dd>
<dt><b>-flexible_bb_docking</b> \<String\></dt>
<dd>How to do flexible backbone docking, if at all. Choices include fixedbb, ccd, alc, and backrub.<br/>Default: "fixedbb"<br/></dd>
<dt><b>-flexible_bb_docking_interface_dist</b> \<Real\></dt>
<dd>Distance between chains required to define a residue as having flexible backbone (ie. loop).<br/>Default: 10.0<br/></dd>
<dt><b>-ensemble1</b> \<String\></dt>
<dd>turns on ensemble mode for partner 1.  String is multi-model pdb file<br/>Default: ""<br/></dd>
<dt><b>-ensemble2</b> \<String\></dt>
<dd>turns on ensemble mode for partner 2.  String is multi-model pdb file<br/>Default: ""<br/></dd>
<dt><b>-dock_mcm_trans_magnitude</b> \<Real\></dt>
<dd>The magnitude of the translational perturbation during mcm in docking.<br/>Default: 0.1<br/></dd>
<dt><b>-dock_mcm_rot_magnitude</b> \<Real\></dt>
<dd>The magnitude of the rotational perturbation during mcm in docking.<br/>Default: 5.0<br/></dd>
<dt><b>-minimization_threshold</b> \<Real\></dt>
<dd>Threhold for Rosetta to decide whether to minimize jump after a rigid_pert<br/>Default: 15<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>Temperature setting for the mc object during rigid-body docking<br/>Default: 0.8<br/></dd>
<dt><b>-repack_period</b> \<Integer\></dt>
<dd>full repack period during dockingMCM<br/>Default: 8<br/></dd>
<dt><b>-extra_rottrial</b> \<Boolean\></dt>
<dd>extra rotamer trial after minimization<br/>Default: false<br/></dd>
<dt><b>-dock_rtmin</b> \<Boolean\></dt>
<dd>does rotamer trials with minimization, RTMIN<br/>Default: false<br/></dd>
<dt><b>-sc_min</b> \<Boolean\></dt>
<dd>does sidechain minimization of interface residues<br/>Default: false<br/></dd>
<dt><b>-norepack1</b> \<Boolean\></dt>
<dd>Do not repack the side-chains of partner 1.<br/>Default: false<br/></dd>
<dt><b>-norepack2</b> \<Boolean\></dt>
<dd>Do not repack the side-chains of partner 2.<br/>Default: false<br/></dd>
<dt><b>-bb_min_res</b> \<IntegerVector\></dt>
<dd>Minimize backbone at these positions.<br/></dd>
<dt><b>-sc_min_res</b> \<IntegerVector\></dt>
<dd>Minimize backbone at these positions.<br/></dd>
<dt><b>-dock_ppk</b> \<Boolean\></dt>
<dd>docking prepack mode<br/>Default: false<br/></dd>
<dt><b>-max_repeats</b> \<Integer\></dt>
<dd>If a decoy does not pass the low- and high-resolution filters, how many attempts to make before failur<br/>Default: 1000<br/></dd>
<dt><b>-dock_lowres_filter</b> \<RealVector\></dt>
<dd>manually sets the lowres docking filter: -dock_lowres_filter <INTERCHAIN_CONTACT CUTOFF> <INTERCHAIN_VDW CUTOFF> <RESTRAINT CUTOFF>. Default values for protein docking are 10.0 and 1.0<br/></dd>
<dt><b>-multibody</b> \<IntegerVector\></dt>
<dd>List of jumps allowed to move during docking<br/></dd>
<dt><b>-ignore_default_docking_task</b> \<Boolean\></dt>
<dd>Allows the user to define another task to give to Docking and will ignore the default DockingTask.  Task will default to designing everything if no other TaskFactory is given to docking.<br/>Default: false<br/></dd>
<dt><b>-low_patch</b> \<String\></dt>
<dd>Name of weights patch file (without extension .wts) to use during rigid body <br/></dd>
<dt><b>-high_patch</b> \<String\></dt>
<dd>Name of weights patch file (without extension .wts) to use during docking<br/></dd>
<dt><b>-high_min_patch</b> \<String\></dt>
<dd>Name of weights patch file (without extension .wts) to use during <br/></dd>
<dt><b>-pack_patch</b> \<String\></dt>
<dd>Name of weights patch file (without extension .wts) to use during packing<br/></dd>
<dt><b>-use_legacy_protocol</b> \<Boolean\></dt>
<dd>Use the legacy high resolution docking algorithm for output compatibility.<br/>Default: false<br/></dd>
<dt><b>-docklowres_trans_magnitude</b> \<Real\></dt>
<dd>The magnitude of the translational perturbation during lowres in docking.<br/>Default: 0.7<br/></dd>
<dt><b>-docklowres_rot_magnitude</b> \<Real\></dt>
<dd>The magnitude of the rotational perturbation during lowres in docking.<br/>Default: 5.0<br/></dd>
<dt><b>-enable_pymol_viewer</b> \<Boolean\></dt>
<dd>See conformer switch moves in PyMOL. Color changes when switch is accepted.<br/>Default: false<br/></dd>
</dl>
+ <h3>-docking:ligand</h3>
<dl>
<dt><b>-ligand</b> \<Boolean\></dt>
<dd>docking:ligand option group<br/></dd>
<dt><b>-protocol</b> \<String\></dt>
<dd>Which protocol to run?<br/>Default: "abbreviated"<br/></dd>
<dt><b>-soft_rep</b> \<Boolean\></dt>
<dd>Use soft repulsive potential?<br/>Default: false<br/></dd>
<dt><b>-tweak_sxfn</b> \<Boolean\></dt>
<dd>Apply default modifications to the score function?<br/>Default: true<br/></dd>
<dt><b>-old_estat</b> \<Boolean\></dt>
<dd>Emulate Rosetta++ electrostatics? (higher weight, ignore protein-protein)<br/>Default: false<br/></dd>
<dt><b>-random_conformer</b> \<Boolean\></dt>
<dd>Start from a random ligand rotamer chosen from the library<br/>Default: false<br/></dd>
<dt><b>-improve_orientation</b> \<Integer\></dt>
<dd>Do N cycles of randomization to minimize clashes with backbone<br/></dd>
<dt><b>-mutate_same_name3</b> \<Boolean\></dt>
<dd>Allow ligand to 'design' to residue types with same name3?  Typically used for protonation states / tautomers.<br/>Default: false<br/></dd>
<dt><b>-subset_to_keep</b> \<Real\></dt>
<dd>When selecting a subset of ligand poses, what fraction (number if > 1.0) to keep?<br/>Default: 0.05<br/></dd>
<dt><b>-min_rms</b> \<Real\></dt>
<dd>When selecting a subset of ligand poses, all must differ by at least this amount.<br/>Default: 0.8<br/></dd>
<dt><b>-max_poses</b> \<Integer\></dt>
<dd>When selecting a subset of ligand poses, select as most this many.<br/>Default: 50<br/></dd>
<dt><b>-minimize_ligand</b> \<Boolean\></dt>
<dd>Allow ligand torsions to minimize?<br/>Default: false<br/></dd>
<dt><b>-harmonic_torsions</b> \<Real\></dt>
<dd>Minimize with harmonic restraints with specified stddev (in degrees)<br/>Default: 10.0<br/></dd>
<dt><b>-use_ambig_constraints</b> \<Boolean\></dt>
<dd>Use ambiguous constraints to restrain torsions instead of adding and removing constraints<br/>Default: false<br/></dd>
<dt><b>-shear_moves</b> \<Integer\></dt>
<dd>Do N pseudo-shear moves on ligand torsions per MCM cycle<br/>Default: 0<br/></dd>
<dt><b>-minimize_backbone</b> \<Boolean\></dt>
<dd>Allow protein backbone to minimize?  Restrained except near ligand.<br/>Default: false<br/></dd>
<dt><b>-harmonic_Calphas</b> \<Real\></dt>
<dd>Minimize with harmonic restraints with specified stddev (in Angstroms)<br/>Default: 0.2<br/></dd>
<dt><b>-tether_ligand</b> \<Real\></dt>
<dd>Restrain ligand to starting point with specified stddev (in Angstroms)<br/></dd>
<dt><b>-start_from</b> \<RealVector\></dt>
<dd>One or more XYZ locations to choose for the ligand:  -start_from X1 Y1 Z1  -start_from X2 Y2 Z2  ...<br/></dd>
<dt><b>-option_file</b> \<String\></dt>
<dd>Name of Ligand Option File for use with multi_ligand_dock application<br/></dd>
<dt><b>-ligand_ensemble</b> \<Real\></dt>
<dd>Weight for correlation adjustment in ligand ensemble docking, ignores ligand-ligand interactions if value is not zero<br/>Default: 0<br/></dd>
</dl>
+ <h4>-docking:ligand:grid</h4>
<dl>
<dt><b>-grid</b> \<Boolean\></dt>
<dd>docking:ligand:grid option group<br/></dd>
<dt><b>-grid_kin</b> \<File\></dt>
<dd>Write kinemage version of generated grid to named file<br/></dd>
<dt><b>-grid_map</b> \<File\></dt>
<dd>Write grid to named file as electron density in BRIX (aka `O'-map) format<br/></dd>
</dl>
+ <h2>-DomainAssembly</h2>
<dl>
<dt><b>-DomainAssembly</b> \<Boolean\></dt>
<dd>DomainAssembly option group<br/></dd>
<dt><b>-da_setup</b> \<Boolean\></dt>
<dd>run DomainAssembly setup routine<br/>Default: false<br/></dd>
<dt><b>-da_setup_option_file</b> \<File\></dt>
<dd>input list of pdbs and linker sequences<br/>Default: "--"<br/></dd>
<dt><b>-da_setup_output_pdb</b> \<File\></dt>
<dd>PDB file output by DomainAssemblySetup<br/>Default: "--"<br/></dd>
<dt><b>-da_linker_file</b> \<File\></dt>
<dd>input file with linker definitions<br/>Default: "--"<br/></dd>
<dt><b>-da_require_buried</b> \<File\></dt>
<dd>Input file containing residues to be buried in the domain interface<br/>Default: "--"<br/></dd>
<dt><b>-da_start_pdb</b> \<File\></dt>
<dd>input pdb for linker optimization<br/>Default: "--"<br/></dd>
<dt><b>-run_fullatom</b> \<Boolean\></dt>
<dd>Run fullatom stage of the protocol<br/>Default: false<br/></dd>
<dt><b>-run_centroid</b> \<Boolean\></dt>
<dd>Run centroid stage of the protocol<br/>Default: false<br/></dd>
<dt><b>-run_centroid_abinitio</b> \<Boolean\></dt>
<dd>Run centroid abinitio stage of the protocol<br/>Default: true<br/></dd>
<dt><b>-da_nruns</b> \<Integer\></dt>
<dd>number of runs<br/>Default: 1<br/></dd>
<dt><b>-da_start_pdb_num</b> \<Integer\></dt>
<dd>starting number for output pdb files<br/>Default: 1<br/></dd>
<dt><b>-da_linker_file_rna</b> \<File\></dt>
<dd>input file with moveable RNA definitions<br/>Default: "--"<br/></dd>
<dt><b>-residues_repack_only</b> \<String\></dt>
<dd>Residues not to be redesigned under any circumstances<br/></dd>
<dt><b>-da_eval_pose_map</b> \<File\></dt>
<dd>input file that maps pose coordinates to structurally related positions of native pose<br/></dd>
</dl>
+ <h2>-dump_trajectory</h2>
<dl>
<dt><b>-dump_trajectory</b> \<Boolean\></dt>
<dd>dump_trajectory option group<br/></dd>
<dt><b>-prefix</b> \<String\></dt>
<dd>Prefix to use when dumping trajectories with dump_trajectory ScoreType.<br/>Default: "traj"<br/></dd>
<dt><b>-gz</b> \<Boolean\></dt>
<dd>Dump trajectories in .pdb.gz format.<br/>Default: false<br/></dd>
</dl>
+ <h2>-edensity</h2>
<dl>
<dt><b>-edensity</b> \<Boolean\></dt>
<dd>edensity option group<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-mapfile</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-mapreso</b> \<Real\></dt>
<dd>No description<br/>Default: 0.0<br/></dd>
<dt><b>-grid_spacing</b> \<Real\></dt>
<dd>No description<br/>Default: 0.0<br/></dd>
<dt><b>-centroid_density_mass</b> \<Real\></dt>
<dd>No description<br/>Default: 0.0<br/></dd>
<dt><b>-sliding_window</b> \<Integer\></dt>
<dd>No description<br/>Default: 1<br/></dd>
<dt><b>-cryoem_scatterers</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-force_apix</b> \<Real\></dt>
<dd>force pixel spacing to take a particular value<br/>Default: 0.0<br/></dd>
<dt><b>-fastdens_wt</b> \<Real\></dt>
<dd>wt of fast edens score<br/>Default: 0.0<br/></dd>
<dt><b>-fastdens_params</b> \<RealVector\></dt>
<dd>parameters for fastdens scoring<br/></dd>
<dt><b>-legacy_fastdens_score</b> \<Boolean\></dt>
<dd>use the pre-June 2013 normalization for scoring<br/>Default: false<br/></dd>
<dt><b>-sliding_window_wt</b> \<Real\></dt>
<dd>wt of edens sliding-window score<br/>Default: 0.0<br/></dd>
<dt><b>-score_sliding_window_context</b> \<Boolean\></dt>
<dd>when using sl. win. density fit, include neighbor atoms (slows trajectory)<br/>Default: false<br/></dd>
<dt><b>-whole_structure_ca_wt</b> \<Real\></dt>
<dd>wt of edens centroid (CA-only) scoring<br/>Default: 0.0<br/></dd>
<dt><b>-whole_structure_allatom_wt</b> \<Real\></dt>
<dd>wt of edens centroid (allatom) scoring<br/>Default: 0.0<br/></dd>
<dt><b>-debug_derivatives</b> \<Boolean\></dt>
<dd>calculate numeric derivatives for density terms and compare with analytical<br/>Default: false<br/></dd>
<dt><b>-realign</b> \<String\></dt>
<dd>how to initially align the pose to density<br/>Default: "no"<br/></dd>
<dt><b>-membrane_axis</b> \<String\></dt>
<dd>the membrane normal axis<br/>Default: "Z"<br/></dd>
<dt><b>-atom_mask</b> \<Real\></dt>
<dd>override default (=3.2A) atom mask radius to this value (hi-res scoring)<br/>Default: 3.2<br/></dd>
<dt><b>-atom_mask_min</b> \<Real\></dt>
<dd>override the 3 sigma minimum value which takes precedence over atom_mask value (hi-res scoring)<br/>Default: 2.0<br/></dd>
<dt><b>-ca_mask</b> \<Real\></dt>
<dd>override default (=6A) CA mask radius to this value (low-res scoring)<br/>Default: 6.0<br/></dd>
<dt><b>-score_symm_complex</b> \<Boolean\></dt>
<dd>If set, scores the structure over the entire symmetric complex; otherwise just use controlling monomer<br/>Default: false<br/></dd>
<dt><b>-sc_scaling</b> \<Real\></dt>
<dd>Scale sidechain density by this amount (default same as mainchain density)<br/>Default: 1.0<br/></dd>
<dt><b>-n_kbins</b> \<Integer\></dt>
<dd>Number of B-factor bins<br/>Default: 1<br/></dd>
<dt><b>-unmask_bb</b> \<Boolean\></dt>
<dd>Only include sidechain atoms in atom mask<br/>Default: false<br/></dd>
<dt><b>-render_density</b> \<Boolean\></dt>
<dd>render electron density in graphics mode build<br/>Default: false<br/></dd>
</dl>
+ <h2>-enzdes</h2>
<dl>
<dt><b>-enzdes</b> \<Boolean\></dt>
<dd>enzdes option group<br/></dd>
<dt><b>-checkpoint</b> \<String\></dt>
<dd>write/read checkpoint files to the desired filename.<br/>Default: ""<br/></dd>
<dt><b>-enz_score</b> \<Boolean\></dt>
<dd>prevent repacking in enzyme design calculation<br/>Default: false<br/></dd>
<dt><b>-enz_repack</b> \<Boolean\></dt>
<dd>prevent redesign in enzyme design calculation<br/>Default: false<br/></dd>
<dt><b>-cst_opt</b> \<Boolean\></dt>
<dd>pre design constraint minimization<br/>Default: false<br/></dd>
<dt><b>-cst_predock</b> \<Boolean\></dt>
<dd>docks a ligand relative the catalytic residue<br/>Default: false<br/></dd>
<dt><b>-trans_magnitude</b> \<Real\></dt>
<dd>rigid body translation in Angstrom<br/>Default: 0.1<br/></dd>
<dt><b>-rot_magnitude</b> \<Real\></dt>
<dd>rigid body rotation in deg<br/>Default: 2<br/></dd>
<dt><b>-dock_trials</b> \<Real\></dt>
<dd>number of docking trials<br/>Default: 100<br/></dd>
<dt><b>-cst_min</b> \<Boolean\></dt>
<dd>after design minimization, constraints turned off<br/>Default: false<br/></dd>
<dt><b>-cst_design</b> \<Boolean\></dt>
<dd>invokes actual design<br/>Default: false<br/></dd>
<dt><b>-design_min_cycles</b> \<Integer\></dt>
<dd>determines how many iterations of designing/minimizing are done during a design run<br/>Default: 1<br/></dd>
<dt><b>-make_consensus_mutations</b> \<Boolean\></dt>
<dd>Invokes mutations back to sequence profile consensus throughout whole protein in EnzdesFixBB protocol. sequence profile file must be specified through -in:pssm option.<br/>Default: false<br/></dd>
<dt><b>-bb_min</b> \<Boolean\></dt>
<dd>allows backbone of active site residues to move during cst_opt and cst_min. In the cst_opt stage, residue Cas will be constrained to their original positions.<br/>Default: false<br/></dd>
<dt><b>-bb_min_allowed_dev</b> \<Real\></dt>
<dd>distance by which Cas are allowed to move during backbone minimization before a penalty is assigned.<br/>Default: 0.5<br/></dd>
<dt><b>-loop_bb_min_allowed_dev</b> \<Real\></dt>
<dd>distance by which Cas are allowed to move during backbone minimization before a penalty is assigned. Applied only for loops as determined by DSSP.<br/>Default: 0.5<br/></dd>
<dt><b>-minimize_ligand_torsions</b> \<Real\></dt>
<dd>degrees by which ligand torsions are allowed to rotate before a penalty is assigned. Only those torsions which have diversity in the conformational ensemble are allowed this std dev. rest are constrained to 0.1<br/>Default: 10.0<br/></dd>
<dt><b>-minimize_all_ligand_torsions</b> \<Real\></dt>
<dd>allows constrained minimization of all ligand torsions using stddev.<br/>Default: 10.0<br/></dd>
<dt><b>-chi_min</b> \<Boolean\></dt>
<dd>allows chi values of active site residues to move during cst_opt and cst_min.<br/>Default: false<br/></dd>
<dt><b>-min_all_jumps</b> \<Boolean\></dt>
<dd>allows all jumps in the pose to minimize  during cst_opt and cst_min. By default only ligand-associated jumps minimize<br/>Default: false<br/></dd>
<dt><b>-cst_dock</b> \<Boolean\></dt>
<dd>ligand docking after design. By default, constraints (except covalent connections will be turned off for this stage.<br/>Default: false<br/></dd>
<dt><b>-run_ligand_motifs</b> \<Boolean\></dt>
<dd>run ligand motif search and add motif rotamers to packer<br/>Default: false<br/></dd>
<dt><b>-enz_debug</b> \<Boolean\></dt>
<dd>invokes various debug routines around the enzdes code<br/>Default: false<br/></dd>
<dt><b>-cstfile</b> \<File\></dt>
<dd>file that contains all necessary constraints for an enzyme design calculation<br/>Default: "constraints.cst"<br/></dd>
<dt><b>-enz_loops_file</b> \<File\></dt>
<dd>file that contains definitions of loop regions<br/>Default: "eloops.els"<br/></dd>
<dt><b>-flexbb_protocol</b> \<Boolean\></dt>
<dd>triggers flexible backbone design<br/>Default: false<br/></dd>
<dt><b>-remodel_protocol</b> \<Boolean\></dt>
<dd>triggers remodel protocol design<br/>Default: false<br/></dd>
<dt><b>-kic_loop_sampling</b> \<Boolean\></dt>
<dd>Generate alternate loop conformations using KIC loop closure instead of backrub<br/>Default: false<br/></dd>
<dt><b>-dump_loop_samples</b> \<String\></dt>
<dd>yes/no? Create loop pdb files named loopreg_[regionid]_[whichsample].pdb for the chosen loop samples; if 'quit_afterwards' is given, then the program exits after all loops have been generated<br/>Default: "no"<br/></dd>
<dt><b>-fix_catalytic_aa</b> \<Boolean\></dt>
<dd>preventing catalytic aa from repacking<br/>Default: false<br/></dd>
<dt><b>-additional_packing_ligand_rb_confs</b> \<Integer\></dt>
<dd>Ligand Rotamers will be built at additional random rigid body positions during packing<br/>Default: 0<br/></dd>
<dt><b>-ex_catalytic_rot</b> \<Integer\></dt>
<dd>convenience option to use higher number of rotamers for catalytic residues. The chosen level will be applied to all chis of every catalytic residue.<br/>Default: 1<br/></dd>
<dt><b>-single_loop_ensemble_size</b> \<Integer\></dt>
<dd>number of conformations generated for each of the independent loops in a flexbb calculation<br/>Default: 100<br/></dd>
<dt><b>-loop_generator_trials</b> \<Integer\></dt>
<dd>number of trials of that the respective loop generator(backrub/kinematic kic) does in enzdes flexbb<br/>Default: 200<br/></dd>
<dt><b>-no_catres_min_in_loopgen</b> \<Boolean\></dt>
<dd>prevents minimization of catalytic residues when generating loop ensembles<br/>Default: false<br/></dd>
<dt><b>-mc_kt_low</b> \<Real\></dt>
<dd>low monte carlo limit for ensemble generation using backrub<br/>Default: 0.6<br/></dd>
<dt><b>-mc_kt_high</b> \<Real\></dt>
<dd>high monte carlo limit for ensemble generation using backrub<br/>Default: 0.9<br/></dd>
<dt><b>-min_cacb_deviation</b> \<Real\></dt>
<dd>Fragment uniqueness filter. On by default.  Minimum CA/CB average deviation that at least one residue must have from all other already-included fragments for a new fragment to be included<br/>Default: 0.3<br/></dd>
<dt><b>-max_bb_deviation</b> \<Real\></dt>
<dd>Fragment smoothness filter.  Off by default. Upper limit on the backbone average deviation a new fragment may have to its most-similar fragment that has already been included in the fragment set.<br/>Default: 0.1<br/></dd>
<dt><b>-max_bb_deviation_from_startstruct</b> \<Real\></dt>
<dd>Fragment native-proximity Filter. Always on. Maximum tolerated backbone average deviation from the starting backbone for a fragment that to be included in the fragment set.<br/>Default: 1.5<br/></dd>
<dt><b>-remodel_trials</b> \<Integer\></dt>
<dd>how often each loop is being remodeled in the enzdes_remodel mover<br/>Default: 100<br/></dd>
<dt><b>-remodel_secmatch</b> \<Boolean\></dt>
<dd>if constrained interactions are missing in the pose during remodel, the SecondaryMatcher will be used to try to find them in the remodeled region. very experimental at this point<br/>Default: false<br/></dd>
<dt><b>-dump_inverse_rotamers</b> \<Boolean\></dt>
<dd>in case of remodel secmatching against inverse rotamers, these rotamers will be dumped before the protocol starts for visual inspection by the user<br/>Default: false<br/></dd>
<dt><b>-remodel_aggressiveness</b> \<Real\></dt>
<dd>determines the aggressiveness with which a given loop is remodeled. legal values between 0 and 1, where 1 is aggressive and 0 conservative.<br/>Default: 0.1<br/></dd>
<dt><b>-favor_native_res</b> \<Real\></dt>
<dd>a bonus energy assigned to the native res during a design calculation<br/>Default: 0.5<br/></dd>
<dt><b>-detect_design_interface</b> \<Boolean\></dt>
<dd>automatically detect design/repack region around ligand(s)<br/>Default: false<br/></dd>
<dt><b>-include_catres_in_interface_detection</b> \<Boolean\></dt>
<dd>if option -detect_design_interface is active, invoking this option causes all residues that are within the specified cuts of any catalytic residue are also set to designing/repacking<br/>Default: false<br/></dd>
<dt><b>-arg_sweep_interface</b> \<Boolean\></dt>
<dd>Use protein-DNA design-like interface detection, involving generation of arginine rotamers at each position, checking to see if argininte can make interaction with ligand.<br/>Default: false<br/></dd>
<dt><b>-arg_sweep_cutoff</b> \<Real\></dt>
<dd>Interaction cutoff distance from arginine to ligand when performing arginine sweep interface detection.<br/>Default: 3.7<br/></dd>
<dt><b>-cut1</b> \<Real\></dt>
<dd>option to specify redesign cutoff 1 in enzdes calculation<br/>Default: 0.0<br/></dd>
<dt><b>-cut2</b> \<Real\></dt>
<dd>option to specify redesign cutoff 2 in enzdes calculation<br/>Default: 0.0<br/></dd>
<dt><b>-cut3</b> \<Real\></dt>
<dd>option to specify repack cutoff 1 in enzdes calculation<br/>Default: 10.0<br/></dd>
<dt><b>-cut4</b> \<Real\></dt>
<dd>option to specify repack cutoff 2 in enzdes calculation<br/>Default: 10.0<br/></dd>
<dt><b>-lig_packer_weight</b> \<Real\></dt>
<dd>specifies the weights for protein ligand interaction during packing (and only packing!! )<br/>Default: 1.0<br/></dd>
<dt><b>-no_unconstrained_repack</b> \<Boolean\></dt>
<dd>no unconstrained repacking after the design stage<br/>Default: false<br/></dd>
<dt><b>-secmatch_Ecutoff</b> \<Real\></dt>
<dd>the maximum constraint energy at which a residue is accepted in the secondary matcher<br/>Default: 1.0<br/></dd>
<dt><b>-change_lig</b> \<File\></dt>
<dd>Can be used with the secondary matching protocol if different incarnations of the ligand are used for design and primary matching. The file needs to contain information on what atoms to superimpose.<br/>Default: "ligchange_file.txt"<br/></dd>
<dt><b>-process_ligrot_separately</b> \<String\></dt>
<dd>In the EnzdesFixBB protocol, causes the protocol to be executed separately for all non_bb clashing ligand rotamers.<br/>Default: "default_lig"<br/></dd>
<dt><b>-start_from_random_rb_conf</b> \<Boolean\></dt>
<dd>In the EnzdesFixBB protocol, if there are additional ligand rigid body conformations available (from a multimodel pdb), a random one of these will be the starting point for the protocol.<br/>Default: false<br/></dd>
<dt><b>-bb_bump_cutoff</b> \<Real\></dt>
<dd>option to specify the maximum allowed backbone energie when replacing a new residue type<br/>Default: 2.0<br/></dd>
<dt><b>-sc_sc_bump_cutoff</b> \<Real\></dt>
<dd>option to specify the maximum allowed energy between two newly placed sidechains in the secondary matcher<br/>Default: 2.0<br/></dd>
<dt><b>-no_packstat_calculation</b> \<Boolean\></dt>
<dd>will determine whether the computationally intensive packstat calculation will be done at the end of a run<br/>Default: false<br/></dd>
<dt><b>-compare_native</b> \<String\></dt>
<dd>triggers comparison of every designed structure to its respective native pdb. the value of the option needs to be a directory path that contains all the native pdb files<br/>Default: "./"<br/></dd>
<dt><b>-final_repack_without_ligand</b> \<Boolean\></dt>
<dd>if a scorefile is requested, this option triggers every structure to be repacked without the ligand. the resulting structure will be output in a multimodel pdb, and differences in energy and rmsd are added to the scorefile.<br/>Default: false<br/></dd>
<dt><b>-dump_final_repack_without_ligand_pdb</b> \<Boolean\></dt>
<dd>If option -final_repack_without_ligand is active, this option will cause the repacked structure to be separately dumped.<br/>Default: false<br/></dd>
<dt><b>-parser_read_cloud_pdb</b> \<Boolean\></dt>
<dd>read cloud format PDB for enzdes in rosetta scripts<br/>Default: false<br/></dd>
</dl>
+ <h2>-fast_loops</h2>
<dl>
<dt><b>-fast_loops</b> \<Boolean\></dt>
<dd>fast_loops option group<br/></dd>
<dt><b>-window_accept_ratio</b> \<Real\></dt>
<dd>windows with more than x percent of good loops in fast-loop sampling are used for scored-sampling<br/>Default: 0.01<br/></dd>
<dt><b>-nr_scored_sampling_passes</b> \<Integer\></dt>
<dd>good windows go into scored-sampling N times<br/>Default: 4<br/></dd>
<dt><b>-nr_scored_fragments</b> \<Integer\></dt>
<dd>scored loops sampled per good window each pass<br/>Default: 20<br/></dd>
<dt><b>-min_breakout_good_loops</b> \<Integer\></dt>
<dd>stop doing scored sampling if N or more good loops have been found<br/>Default: 5<br/></dd>
<dt><b>-min_breakout_fast_loops</b> \<Integer\></dt>
<dd>stop doing fast sampling if N or more good loops have been found<br/>Default: 80<br/></dd>
<dt><b>-min_good_loops</b> \<Integer\></dt>
<dd>treat as failure if less good-loops than<br/>Default: 0<br/></dd>
<dt><b>-min_fast_loops</b> \<Integer\></dt>
<dd>treat as failure if less fast-loops than<br/>Default: 3<br/></dd>
<dt><b>-vdw_delta</b> \<Real\></dt>
<dd>accept as good loop if vdw-score < vdw-score-start+vdw-delta<br/>Default: 0.5<br/></dd>
<dt><b>-give_up</b> \<Integer\></dt>
<dd>if N scored_frag_attemps didnt give any good loop -- jump out<br/>Default: 1000<br/></dd>
<dt><b>-chainbreak_max</b> \<Real\></dt>
<dd>accept only loops that have a maximum chainbreak score of... (sum of linear_chainbreak / chainbreak and overlap_chainbreak<br/>Default: 0.2<br/></dd>
<dt><b>-fragsample_score</b> \<File\></dt>
<dd>Scorefunction used durgin scored-frag sampling<br/>Default: "loop_fragsample.wts"<br/></dd>
<dt><b>-fragsample_patch</b> \<File\></dt>
<dd>Patch weights for scorefunction used during scored-frag sampling<br/></dd>
<dt><b>-overwrite_filter_scorefxn</b> \<File\></dt>
<dd>force Scorefunction to be used during filter stage (instead last score of sampling protocol)<br/></dd>
<dt><b>-patch_filter_scorefxn</b> \<File\></dt>
<dd>apply patch to Scorefunction used during filter stage<br/></dd>
<dt><b>-filter_cst_file</b> \<File\></dt>
<dd>use these constraints to filter loops --- additional to whatever is in pose already<br/></dd>
<dt><b>-filter_cst_weight</b> \<Real\></dt>
<dd>weight for constraints versus normal score (might contain additional constraints)<br/>Default: 1.0<br/></dd>
<dt><b>-fast_relax_sequence_file</b> \<File\></dt>
<dd>use this FastRelax protocol for loop-selection<br/></dd>
</dl>
+ <h2>-flexpack</h2>
<dl>
<dt><b>-flexpack</b> \<Boolean\></dt>
<dd>flexpack option group<br/></dd>
</dl>
+ <h3>-flexpack:annealer</h3>
<dl>
<dt><b>-annealer</b> \<Boolean\></dt>
<dd>annealer option group<br/></dd>
<dt><b>-inner_iteration_scale</b> \<Real\></dt>
<dd>Scale up or down the number of inner iterations in the flexpack annealer<br/></dd>
<dt><b>-outer_iteration_scale</b> \<Real\></dt>
<dd>Scale up or down the number of outer iterations in the flexpack annealer<br/></dd>
<dt><b>-fixbb_substitutions_scale</b> \<Real\></dt>
<dd>Scale up or down the number of fixed-backbone rotamer substitutions in the flexpack annealer<br/></dd>
<dt><b>-pure_movebb_substitutions_scale</b> \<Real\></dt>
<dd>Scale up or down the number of backbone moves<br/></dd>
<dt><b>-rotsub_movebb_substitutions_scale</b> \<Real\></dt>
<dd>Scale up or down the number of rotamer substitions with backbone moves<br/></dd>
</dl>
+ <h2>-flexPepDocking</h2>
<dl>
<dt><b>-flexPepDocking</b> \<Boolean\></dt>
<dd>flexPepDocking option group<br/></dd>
<dt><b>-params_file</b> \<String\></dt>
<dd>parameters file that describe the complex details, like anchor residues, etc.<br/></dd>
<dt><b>-peptide_anchor</b> \<Integer\></dt>
<dd>Set the peptide anchor residue mannualy (instead of using the center of mass<br/>Range: 1-<br/>Default: 1<br/></dd>
<dt><b>-receptor_chain</b> \<String\></dt>
<dd>chain-id of receptor protein<br/></dd>
<dt><b>-peptide_chain</b> \<String\></dt>
<dd>chain-id of peptide protein<br/></dd>
<dt><b>-pep_fold_only</b> \<Boolean\></dt>
<dd>Only fold a peptide, without docking (no input receptor is expected in this case).<br/>Default: false<br/></dd>
<dt><b>-lowres_abinitio</b> \<Boolean\></dt>
<dd>Do a preemptive ab-initio low-resolution peptide docking<br/>Default: false<br/></dd>
<dt><b>-lowres_preoptimize</b> \<Boolean\></dt>
<dd>Do a preemptive optimization in low resolution<br/>Default: false<br/></dd>
<dt><b>-flexPepDockingMinimizeOnly</b> \<Boolean\></dt>
<dd>Just do simple minimization on input structure<br/>Default: false<br/></dd>
<dt><b>-extend_peptide</b> \<Boolean\></dt>
<dd>start the protocol with the peptide in extended conformation<br/>Default: false<br/></dd>
<dt><b>-place_peptide_on_binding_site</b> \<Boolean\></dt>
<dd>places peptide on the binding using SiteConstraints<br/>Default: false<br/></dd>
<dt><b>-sample_pcs</b> \<Integer\></dt>
<dd>number of principle components to use for initial peptide placement and flipping<br/>Range: 0-<br/>Default: 0<br/></dd>
<dt><b>-SlideIntoContact</b> \<Boolean\></dt>
<dd>Slides peptide toward or away from receptor to remove clashes<br/>Default: false<br/></dd>
<dt><b>-recalculate_foldtree</b> \<Boolean\></dt>
<dd>recalculates foldtree after random RB perturbation<br/>Default: false<br/></dd>
<dt><b>-pep_refine</b> \<Boolean\></dt>
<dd>High-resolution peptide refinement over receptor surface, equivalent to the obsolete -rbMCM -torsionsMCM flags<br/>Default: false<br/></dd>
<dt><b>-rbMCM</b> \<Boolean\></dt>
<dd>Do rigid body mcm in the main loop of the protocol (obsolete)<br/>Default: false<br/></dd>
<dt><b>-torsionsMCM</b> \<Boolean\></dt>
<dd>Do torsions (small/shear mcm in the main loop of the protocol (obsolete)<br/>Default: false<br/></dd>
<dt><b>-peptide_loop_model</b> \<Boolean\></dt>
<dd>Do cycles of random loop modeling to peptide backbone<br/>Default: false<br/></dd>
<dt><b>-backrub_peptide</b> \<Boolean\></dt>
<dd>Adds a backrub stage to the protocol<br/>Default: false<br/></dd>
<dt><b>-boost_fa_atr</b> \<Boolean\></dt>
<dd>while ramping up the fa_rep, start from high atr and lower to normal<br/>Default: true<br/></dd>
<dt><b>-ramp_fa_rep</b> \<Boolean\></dt>
<dd>Whether to ramp the full-atom repulsive score during the protocol<br/>Default: true<br/></dd>
<dt><b>-ramp_rama</b> \<Boolean\></dt>
<dd>Whether to ramp the Ramachandran score during the protocol<br/>Default: false<br/></dd>
<dt><b>-flexpep_score_only</b> \<Boolean\></dt>
<dd>just reads in the pose and scores it<br/>Default: false<br/></dd>
<dt><b>-ref_startstruct</b> \<File\></dt>
<dd>Alternative start structure for scoring statistics, instead of the original start structure (useful as reference for rescoring previous runs)<br/></dd>
<dt><b>-use_cen_score</b> \<Boolean\></dt>
<dd>when in score_only mode, uses centroid weights to score<br/>Default: false<br/></dd>
<dt><b>-design_peptide</b> \<Boolean\></dt>
<dd>Add a desing stage to each cycle of the RB-torsions perturbations<br/>Default: false<br/></dd>
<dt><b>-rep_ramp_cycles</b> \<Integer\></dt>
<dd>Number of cycles for the ramping up of repulsion term<br/>Range: 0-<br/>Default: 10<br/></dd>
<dt><b>-mcm_cycles</b> \<Integer\></dt>
<dd>Number of cycles for the mcm procedures (rb/torsions)<br/>Range: 0-<br/>Default: 8<br/></dd>
<dt><b>-random_phi_psi_preturbation</b> \<Real\></dt>
<dd>Size of random perturbation of peptide's phi/psi<br/>Range: 0.0-<br/>Default: 0.0<br/></dd>
<dt><b>-smove_angle_range</b> \<Real\></dt>
<dd>Defines the perturbations size of small/sheer moves<br/>Range: 0.0-<br/>Default: 6.0<br/></dd>
<dt><b>-min_receptor_bb</b> \<Boolean\></dt>
<dd>Whether to include protein backbone in minimization<br/>Default: false<br/></dd>
<dt><b>-random_trans_start</b> \<Real\></dt>
<dd>Size of random perturbation of peptide's rigid body translation<br/>Range: 0.0-<br/>Default: 0.0<br/></dd>
<dt><b>-random_rot_start</b> \<Real\></dt>
<dd>Size of random perturbation of peptide's rigid body rotation<br/>Range: 0.0-<br/>Default: 0.0<br/></dd>
<dt><b>-flexpep_prepack</b> \<Boolean\></dt>
<dd>Prepack an initial structure and exit<br/>Default: false<br/></dd>
<dt><b>-flexpep_noprepack1</b> \<Boolean\></dt>
<dd>Do not repack the side-chains of partner 1 ( = globular protein).<br/>Default: false<br/></dd>
<dt><b>-flexpep_noprepack2</b> \<Boolean\></dt>
<dd>Do not repack the side-chains of partner 2 ( = peptide).<br/>Default: false<br/></dd>
<dt><b>-score_filter</b> \<Real\></dt>
<dd>Only output decoys with scores lower than this filter.<br/>Default: 10000.0<br/></dd>
<dt><b>-hb_filter</b> \<Integer\></dt>
<dd>Only output decoys with more h-bonds than this filter.<br/>Range: 0-<br/>Default: 0<br/></dd>
<dt><b>-hotspot_filter</b> \<Integer\></dt>
<dd>Only output decoys with more hotspots than this filter.<br/>Range: 0-<br/>Default: 0<br/></dd>
<dt><b>-frag5</b> \<String\></dt>
<dd>5-mer fragments for ab-initio flexPepDock<br/></dd>
<dt><b>-frag9_weight</b> \<Real\></dt>
<dd>Relative weight of 9-mers in ab-initio<br/>Range: 0-<br/>Default: 0.1<br/></dd>
<dt><b>-frag5_weight</b> \<Real\></dt>
<dd>relative weight of 5-mers in ab-initio<br/>Range: 0-<br/>Default: 0.25<br/></dd>
<dt><b>-frag3_weight</b> \<Real\></dt>
<dd>Relative weight of 3-mers in ab-initio<br/>Range: 0-<br/>Default: 1.0<br/></dd>
<dt><b>-pSer2Asp_centroid</b> \<Boolean\></dt>
<dd>convert pSer to Asp during centroid mode<br/>Default: false<br/></dd>
<dt><b>-pSer2Glu_centroid</b> \<Boolean\></dt>
<dd>convert pSer to Glu during centroid mode<br/>Default: false<br/></dd>
<dt><b>-dumpPDB_abinitio</b> \<Boolean\></dt>
<dd>dump PDB during Monte-Carlo ab-initio<br/>Default: false<br/></dd>
<dt><b>-dumpPDB_lowres</b> \<Boolean\></dt>
<dd>dump PDB during Monte-Carlo low-res<br/>Default: false<br/></dd>
<dt><b>-dumpPDB_hires</b> \<Boolean\></dt>
<dd>dump PDB during Monte-Carlo hi-res<br/>Default: false<br/></dd>
</dl>
+ <h2>-FloppyTail</h2>
<dl>
<dt><b>-FloppyTail</b> \<Boolean\></dt>
<dd>FloppyTail option group<br/></dd>
<dt><b>-flexible_start_resnum</b> \<Integer\></dt>
<dd>starting residue for the flexible region, using PDB numbering<br/>Default: 180<br/></dd>
<dt><b>-flexible_stop_resnum</b> \<Integer\></dt>
<dd>stop residue for the flexible region, using PDB numbering.  If unspecified, it assumes the end of the pose.<br/>Default: 0<br/></dd>
<dt><b>-flexible_chain</b> \<String\></dt>
<dd>chain ID for flexible region<br/>Default: "C"<br/></dd>
<dt><b>-shear_on</b> \<Real\></dt>
<dd>fraction of perturb moves when shear turns on (0.5 = halfway through)<br/>Default: 1.0/3.0<br/></dd>
<dt><b>-pair_off</b> \<Boolean\></dt>
<dd>turn off Epair electrostatics term.  Used once for a simple side experiment, not meant for general use.<br/>Default: false<br/></dd>
<dt><b>-publication</b> \<Boolean\></dt>
<dd>output statistics used in publication.  TURN OFF if not running publication demo.<br/>Default: false<br/></dd>
<dt><b>-C_root</b> \<Boolean\></dt>
<dd>Reroot the fold_tree to the C-terminus.  If your flexible region is N-terminal, or closer to the first half of the pose, this will speed computation.<br/>Default: false<br/></dd>
<dt><b>-COM_root</b> \<Boolean\></dt>
<dd>Reroot the fold_tree to the center of mass. This allows you to flop the N- & C-termini simultaneously.<br/>Default: false<br/></dd>
<dt><b>-force_linear_fold_tree</b> \<Boolean\></dt>
<dd>Force a linear fold tree.  Used in combination with C_root and reordering the chains in your input PDB to ensure you get exactly the right kinematics<br/>Default: false<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>debug mode (extra checks and pdb dumps)<br/>Default: false<br/></dd>
<dt><b>-cen_weights</b> \<String\></dt>
<dd>Use a different/custom scorefunction for centroid step<br/></dd>
<dt><b>-perturb_show</b> \<Boolean\></dt>
<dd>dump perturbed centroid pdbs as well as final results<br/>Default: false<br/></dd>
<dt><b>-perturb_cycles</b> \<Integer\></dt>
<dd>perturbation phase runs for <input> cycles<br/>Default: 5<br/></dd>
<dt><b>-perturb_temp</b> \<Real\></dt>
<dd>perturbation phase temperature for monte carlo<br/>Default: 0.8<br/></dd>
<dt><b>-refine_cycles</b> \<Integer\></dt>
<dd>refinement phase runs for <input> cycles<br/>Default: 5<br/></dd>
<dt><b>-refine_temp</b> \<Real\></dt>
<dd>refinement phase temperature for monte carlo<br/>Default: 0.8<br/></dd>
<dt><b>-refine_repack_cycles</b> \<Integer\></dt>
<dd>refinement phase runs repack every <input> cycles<br/>Range: 2-<br/>Default: 20<br/></dd>
</dl>
+ <h3>-FloppyTail:short_tail</h3>
<dl>
<dt><b>-short_tail</b> \<Boolean\></dt>
<dd>short_tail option group<br/></dd>
<dt><b>-short_tail_fraction</b> \<Real\></dt>
<dd>what fraction of the flexible segment is used in the short-tail section of refinement (not compatible with non-terminal flexible regions)<br/>Default: 1.0<br/></dd>
<dt><b>-short_tail_off</b> \<Real\></dt>
<dd>fraction of refine cycles where movemap reverts to full tail (0.5 = halfway through)<br/>Default: 0.0<br/></dd>
</dl>
+ <h2>-flxbb</h2>
<dl>
<dt><b>-flxbb</b> \<Boolean\></dt>
<dd>flxbb option group<br/></dd>
<dt><b>-view</b> \<Boolean\></dt>
<dd>viewing pose during protocol<br/></dd>
<dt><b>-ncycle</b> \<Integer\></dt>
<dd>number of cycles of design and relax<br/></dd>
<dt><b>-constraints_sheet</b> \<Real\></dt>
<dd>weight constraints between Ca atoms in beta sheet<br/></dd>
<dt><b>-constraints_sheet_include_cacb_pseudotorsion</b> \<Boolean\></dt>
<dd>puts an additional constraint on two residues paired in a beta-sheet to ensure their CA-CB vectors are pointing the same way.<br/>Default: false<br/></dd>
<dt><b>-constraints_NtoC</b> \<Real\></dt>
<dd>weight constraints between N- and C- terminal CA atoms<br/></dd>
<dt><b>-filter_trial</b> \<Integer\></dt>
<dd>number of filtering trial <br/></dd>
<dt><b>-filter_type</b> \<String\></dt>
<dd>filter type name, currently only packstat is available<br/></dd>
<dt><b>-blueprint</b> \<File\></dt>
<dd>blueprint file <br/></dd>
<dt><b>-movemap_from_blueprint</b> \<Boolean\></dt>
<dd>viewing pose during protocol<br/></dd>
</dl>
+ <h3>-flxbb:layer</h3>
<dl>
<dt><b>-layer</b> \<String\></dt>
<dd>design core, boundary, and surface with different aa types<br/>Default: "normal"<br/></dd>
</dl>
+ <h2>-fold_and_dock</h2>
<dl>
<dt><b>-fold_and_dock</b> \<Boolean\></dt>
<dd>fold_and_dock option group<br/></dd>
<dt><b>-move_anchor_points</b> \<Boolean\></dt>
<dd>move the anchor points that define symmetric coordinate system during symmetry fragment insertion<br/>Default: false<br/></dd>
<dt><b>-set_anchor_at_closest_point</b> \<Boolean\></dt>
<dd>set the anchor points that define symmetric coordinate system to the nearest point between two consecutive chains during fragment insertion<br/>Default: false<br/></dd>
<dt><b>-rotate_anchor_to_x</b> \<Boolean\></dt>
<dd>rotate the anchor residue to the x-axis before applying rigid body transformations<br/>Default: true<br/></dd>
<dt><b>-trans_mag_smooth</b> \<Real\></dt>
<dd>translation perturbation size for smooth refinement<br/>Default: 0.1<br/></dd>
<dt><b>-rot_mag_smooth</b> \<Real\></dt>
<dd>rotational perturbation size for smooth refinement<br/>Default: 1.0<br/></dd>
<dt><b>-rb_rot_magnitude</b> \<Real\></dt>
<dd>rotational perturbation size for rigid body pertubations<br/>Default: 8.0<br/></dd>
<dt><b>-rb_trans_magnitude</b> \<Real\></dt>
<dd>translational perturbation size rigid body pertubations<br/>Default: 3.0<br/></dd>
<dt><b>-rigid_body_cycles</b> \<Integer\></dt>
<dd>number of rigid bosy cycles during fold and dock fragment insertion<br/>Default: 50<br/></dd>
<dt><b>-move_anchor_frequency</b> \<Real\></dt>
<dd>Frequency of slide-anchor moves<br/>Default: 1.0<br/></dd>
<dt><b>-rigid_body_frequency</b> \<Real\></dt>
<dd>The fraction of times rigid body cycles are applied during fragment assembly moves<br/>Default: 0.2<br/></dd>
<dt><b>-rigid_body_disable_mc</b> \<Boolean\></dt>
<dd>Dissallow moves to be accepted locally by MC criteria within the rigid body mover <br/>Default: false<br/></dd>
<dt><b>-slide_contact_frequency</b> \<Real\></dt>
<dd>The fraction of times subunits are slided together during fragment assembly moves<br/>Default: 0.1<br/></dd>
</dl>
+ <h2>-fold_cst</h2>
<dl>
<dt><b>-fold_cst</b> \<Boolean\></dt>
<dd>fold_cst option group<br/></dd>
<dt><b>-constraint_skip_rate</b> \<Real\></dt>
<dd>if e.g., 0.95 it will randomly select 5% if the constraints each round -- full-cst score in  extra column<br/>Default: 0<br/></dd>
<dt><b>-violation_skip_basis</b> \<Integer\></dt>
<dd>local skip_rate is viol/base<br/>Default: 100<br/></dd>
<dt><b>-violation_skip_ignore</b> \<Integer\></dt>
<dd>no skip for numbers below this level<br/>Default: 10<br/></dd>
<dt><b>-keep_skipped_csts</b> \<Boolean\></dt>
<dd>final score only with active constraints<br/>Default: false<br/></dd>
<dt><b>-no_minimize</b> \<Boolean\></dt>
<dd>No minimization moves in fold_constraints protocol. Useful for testing wheather fragment moves alone can recapitulate a given structure.<br/>Default: false<br/></dd>
<dt><b>-force_minimize</b> \<Boolean\></dt>
<dd>Minimization moves in fold_constraints protocol also if no constraints present<br/>Default: false<br/></dd>
<dt><b>-seq_sep_stages</b> \<RealVector\></dt>
<dd>give vector with sequence_separation after stage1, stage3 and stage4<br/>Default: 0<br/></dd>
<dt><b>-reramp_cst_cycles</b> \<Integer\></dt>
<dd>in stage2 do xxx cycles where atom_pair_constraint is ramped up<br/>Default: 0<br/></dd>
<dt><b>-reramp_start_cstweight</b> \<Real\></dt>
<dd>drop cst_weight to this value and ramp to 1.0 in stage2 -- needs reramp_cst_cycles > 0<br/>Default: 0.01<br/></dd>
<dt><b>-reramp_iterations</b> \<Integer\></dt>
<dd>do X loops of annealing cycles<br/>Default: 1<br/></dd>
<dt><b>-skip_on_noviolation_in_stage1</b> \<Boolean\></dt>
<dd>if constraints report no violations --- skip cycles<br/>Default: false<br/></dd>
<dt><b>-stage1_ramp_cst_cycle_factor</b> \<Real\></dt>
<dd>spend x*<standard cycles> on each step of sequence separation<br/>Default: 0.25<br/></dd>
<dt><b>-stage2_constraint_threshold</b> \<Real\></dt>
<dd>stop runs that violate this threshold at end of stage2<br/>Default: 0<br/></dd>
<dt><b>-ignore_sequence_seperation</b> \<Boolean\></dt>
<dd>usually constraints are switched on according to their separation in the fold-tree<br/>Default: false<br/></dd>
<dt><b>-no_recover_low_at_constraint_switch</b> \<Boolean\></dt>
<dd>dont recover low when max_seq_sep is increased<br/>Default: false<br/></dd>
<dt><b>-ramp_coord_cst</b> \<Boolean\></dt>
<dd>ramp coord csts just like chainbreak-weights during fold-cst<br/>Default: false<br/></dd>
</dl>
+ <h2>-fold_from_loops</h2>
<dl>
<dt><b>-fold_from_loops</b> \<Boolean\></dt>
<dd>fold_from_loops option group<br/></dd>
<dt><b>-native_ca_cst</b> \<Boolean\></dt>
<dd>derive constraints from the native topology<br/>Default: false<br/></dd>
<dt><b>-swap_loops</b> \<File\></dt>
<dd>pdb of the target loops <br/>Default: "--"<br/></dd>
<dt><b>-checkpoint</b> \<String\></dt>
<dd>write/read checkpoint files for nstruct. Provide a checkpoint filename after this option.<br/>Default: ""<br/></dd>
<dt><b>-ca_csts_dev</b> \<Real\></dt>
<dd>standard deviation allowed to each constraint<br/>Default: 0.5<br/></dd>
<dt><b>-add_relax_cycles</b> \<Integer\></dt>
<dd>additional relax cycles<br/>Default: 2<br/></dd>
<dt><b>-loop_mov_nterm</b> \<Integer\></dt>
<dd>Movable region inside the provided loop(nterm)<br/>Default: 0<br/></dd>
<dt><b>-loop_mov_cterm</b> \<Integer\></dt>
<dd>Moveable region inside the provided loop(cterm)<br/>Default: 0<br/></dd>
<dt><b>-ca_rmsd_cutoff</b> \<Real\></dt>
<dd>Filter the decoys to pass the relax-design stage <br/>Default: 5.0<br/></dd>
<dt><b>-res_design_bs</b> \<IntegerVector\></dt>
<dd>enumerate the residues to be designed within the fixed binding site<br/></dd>
<dt><b>-clear_csts</b> \<File\></dt>
<dd>input loops file with ranges free of CA csts<br/>Default: "--"<br/></dd>
<dt><b>-output_centroid</b> \<Boolean\></dt>
<dd>output centroid structures befor the design stage<br/>Default: false<br/></dd>
<dt><b>-add_cst_loop</b> \<Boolean\></dt>
<dd>add CA csts of motif to constraint set<br/>Default: false<br/></dd>
</dl>
+ <h2>-frags</h2>
<dl>
<dt><b>-frags</b> \<Boolean\></dt>
<dd>frags option group<br/></dd>
<dt><b>-j</b> \<Integer\></dt>
<dd>Number of threads to use<br/></dd>
<dt><b>-filter_JC</b> \<Boolean\></dt>
<dd>Filter J-coupling values in the dynamic range <br/>Default: false<br/></dd>
<dt><b>-bounded_protocol</b> \<Boolean\></dt>
<dd>makes the picker use bounded protocol to select fragments. This is teh default behavior<br/>Default: true<br/></dd>
<dt><b>-keep_all_protocol</b> \<Boolean\></dt>
<dd>makes the picker use keep-all protocol to select fragments. The default is bounded protocol<br/>Default: false<br/></dd>
<dt><b>-quota_protocol</b> \<Boolean\></dt>
<dd>quota protocol implies the use of a QuotaCollector and a QuotaSelelctor, no matter what user set up by other flags.<br/>Default: false<br/></dd>
<dt><b>-nonlocal_pairs</b> \<Boolean\></dt>
<dd>identifies and outputs nonlocal fragment pairs.<br/>Default: false<br/></dd>
<dt><b>-fragment_contacts</b> \<Boolean\></dt>
<dd>identifies and outputs fragment contacts.<br/>Default: false<br/></dd>
<dt><b>-p_value_selection</b> \<Boolean\></dt>
<dd>the final fragment selection will b based on p-value rather than on a total score for the given fragment<br/>Default: false<br/></dd>
<dt><b>-n_frags</b> \<Integer\></dt>
<dd>number of fragments per position<br/>Default: 200<br/></dd>
<dt><b>-allowed_pdb</b> \<File\></dt>
<dd>provides a text file with allowed PDB chains (five characters per entry, e.g.'4mbA'). Only these PDB chains from Vall will be used to pick fragments<br/></dd>
<dt><b>-ss_pred</b> \<StringVector\></dt>
<dd>provides one or more files with secondary structure prediction (PsiPred SS2 format) , to be used by secondary structure scoring and quota selector. Each file name must be followed by a string ID.<br/></dd>
<dt><b>-spine_x</b> \<File\></dt>
<dd>provides phi and psi torsion angle predictions and solvent accessibility prediction from Spine-X<br/></dd>
<dt><b>-depth</b> \<File\></dt>
<dd>provides residue depth values from DEPTH<br/></dd>
<dt><b>-denied_pdb</b> \<File\></dt>
<dd>provides a text file with denied PDB chains (five characters per entry, e.g.'4mbA'). This way close homologs may be excluded from fragment picking.<br/></dd>
<dt><b>-frag_sizes</b> \<IntegerVector\></dt>
<dd>sizes of fragments to pick from the vall<br/>Default: ['9', '3', '1']<br/></dd>
<dt><b>-write_ca_coordinates</b> \<Boolean\></dt>
<dd>Fragment picker will store CA Cartesian coordinates in output fragment files. By default only torsion coordinates are stored.<br/>Default: false<br/></dd>
<dt><b>-write_scores</b> \<Boolean\></dt>
<dd>Fragment picker will write scores in output fragment files.<br/>Default: false<br/></dd>
<dt><b>-annotate</b> \<Boolean\></dt>
<dd>read the annotation from the rosetta++ fragment file<br/>Default: false<br/></dd>
<dt><b>-nr_large_copies</b> \<Integer\></dt>
<dd>make N copies for each standard 9mer (or so) fragment<br/>Default: 1<br/></dd>
<dt><b>-n_candidates</b> \<Integer\></dt>
<dd>number of fragment candidates per position; the final fragments will be selected from them<br/>Default: 200<br/></dd>
<dt><b>-write_rama_tables</b> \<Boolean\></dt>
<dd>Fragment picker will spit out sequence specific ramachandran score tables for your viewing pleasure. These ramachandran tables are based on the secondary structure predictions fed into RamaScore, and you may occasionally want to look at what the program has defined.<br/>Default: false<br/></dd>
<dt><b>-rama_C</b> \<Real\></dt>
<dd>Constant in RamaScore equation, command line is for optimization tests<br/>Default: 0.0<br/></dd>
<dt><b>-rama_B</b> \<Real\></dt>
<dd>Constant in RamaScore equation, command line is for optimization tests<br/>Default: 1.0<br/></dd>
<dt><b>-sigmoid_cs_A</b> \<Real\></dt>
<dd>Constant in CSScore equation, command line is for optimization tests<br/>Default: 2.0<br/></dd>
<dt><b>-sigmoid_cs_B</b> \<Real\></dt>
<dd>Constant in CSScore equation, command line is for optimization tests<br/>Default: 4.0<br/></dd>
<dt><b>-seqsim_H</b> \<Real\></dt>
<dd>Secondary structure type prediction multiplier, for use in fragment picking<br/>Default: 1.0<br/></dd>
<dt><b>-seqsim_E</b> \<Real\></dt>
<dd>Secondary structure type prediction multiplier, for use in fragment picking<br/>Default: 1.0<br/></dd>
<dt><b>-seqsim_L</b> \<Real\></dt>
<dd>Secondary structure type prediction multiplier, for use in fragment picking<br/>Default: 1.0<br/></dd>
<dt><b>-rama_norm</b> \<Real\></dt>
<dd>Used to multiply rama table values after normalization, default (0.0) means use raw counts (unnormalized)<br/>Default: 0.0<br/></dd>
<dt><b>-describe_fragments</b> \<String\></dt>
<dd>Writes scores for all fragments into a file<br/>Default: ""<br/></dd>
<dt><b>-picking_old_max_score</b> \<Real\></dt>
<dd>maximal score allowed for fragments picked by the old vall (used by RosettaRemodel).<br/>Default: 1000000.0<br/></dd>
<dt><b>-write_sequence_only</b> \<Boolean\></dt>
<dd>Fragment picker will output fragment sequences only. This option is for creating structure based sequence profiles using the FragmentCrmsdResDepth score.<br/>Default: false<br/></dd>
<dt><b>-output_silent</b> \<Boolean\></dt>
<dd>Fragment picker will output fragments into a silent file.<br/>Default: false<br/></dd>
<dt><b>-output_index</b> \<Boolean\></dt>
<dd>Fragment picker will output fragments into an index file.<br/>Default: false<br/></dd>
<dt><b>-score_output_silent</b> \<Boolean\></dt>
<dd>Fragment picker will output fragments into a silent file. Scores of relaxed fragments are added to the silent file.<br/>Default: false<br/></dd>
</dl>
+ <h3>-frags:scoring</h3>
<dl>
<dt><b>-scoring</b> \<Boolean\></dt>
<dd>scoring option group<br/></dd>
<dt><b>-config</b> \<File\></dt>
<dd>scoring scheme used for picking fragments<br/>Default: ""<br/></dd>
<dt><b>-profile_score</b> \<String\></dt>
<dd>scoring scheme used for profile-profile comparison<br/>Default: "L1"<br/></dd>
</dl>
+ <h3>-frags:picking</h3>
<dl>
<dt><b>-picking</b> \<Boolean\></dt>
<dd>picking option group<br/></dd>
<dt><b>-selecting_rule</b> \<String\></dt>
<dd>the way how fragments are selected from candidates, e.g. QuotaSelector of BestTotalScoreSelector<br/>Default: "BestTotalScoreSelector"<br/></dd>
<dt><b>-selecting_scorefxn</b> \<String\></dt>
<dd>in the case user chose BestTotalScoreSelector to be used, this option provides a custom scoring function to be used at the selection step<br/></dd>
<dt><b>-quota_config_file</b> \<File\></dt>
<dd>provides a configuration file for quota selector<br/></dd>
<dt><b>-query_pos</b> \<IntegerVector\></dt>
<dd>provide sequence position for which fragments will be picked. By default fragments are picked for the whole query sequence<br/></dd>
</dl>
+ <h3>-frags:nonlocal</h3>
<dl>
<dt><b>-nonlocal</b> \<Boolean\></dt>
<dd>nonlocal option group<br/></dd>
<dt><b>-relax_input</b> \<Boolean\></dt>
<dd>relax input before running protocol<br/></dd>
<dt><b>-relax_input_with_coordinate_constraints</b> \<Boolean\></dt>
<dd>relax input with coordinate constraints before running protocol<br/></dd>
<dt><b>-relax_frags_repeats</b> \<Integer\></dt>
<dd>relax repeats for relaxing fragment pair<br/></dd>
<dt><b>-single_chain</b> \<Boolean\></dt>
<dd>non-local fragment pairs will be restricted to the same chain<br/></dd>
<dt><b>-min_contacts_per_res</b> \<Real\></dt>
<dd>minimum contacts per residue in fragment to be considered a fragment pair<br/>Default: 1.0<br/></dd>
<dt><b>-max_ddg_score</b> \<Real\></dt>
<dd>maximum DDG score of fragment pair<br/></dd>
<dt><b>-max_rmsd_after_relax</b> \<Real\></dt>
<dd>maximum rmsd of fragment pair after relax<br/></dd>
<dt><b>-output_frags_pdbs</b> \<Boolean\></dt>
<dd>output non-local fragment pair PDBs<br/></dd>
<dt><b>-output_idealized</b> \<Boolean\></dt>
<dd>output an idealized pose which can be used for generating a new VALL<br/></dd>
<dt><b>-output_silent</b> \<Boolean\></dt>
<dd>output non-local fragment pairs silent file<br/>Default: true<br/></dd>
</dl>
+ <h3>-frags:contacts</h3>
<dl>
<dt><b>-contacts</b> \<Boolean\></dt>
<dd>contacts option group<br/></dd>
<dt><b>-min_seq_sep</b> \<Integer\></dt>
<dd>minimum sequence separation between contacts<br/>Default: 12<br/></dd>
<dt><b>-dist_cutoffs</b> \<RealVector\></dt>
<dd>distance cutoffs to be considered a contact. contact counts will only be saved.<br/>Default: ['9.0']<br/></dd>
<dt><b>-centroid_distance_scale_factor</b> \<Real\></dt>
<dd>Scaling factor for centroid distance cutoffs.<br/>Default: 1.0<br/></dd>
<dt><b>-type</b> \<StringVector\></dt>
<dd>Atom considered for contacts<br/>Default: utility::vector1<std::string>(1,"ca")<br/></dd>
<dt><b>-neighbors</b> \<Integer\></dt>
<dd>number of adjacent residues to a contact for finding neighboring contacts<br/>Default: 0<br/></dd>
<dt><b>-output_all</b> \<Boolean\></dt>
<dd>output all contacts<br/>Default: false<br/></dd>
</dl>
+ <h3>-frags:ABEGO</h3>
<dl>
<dt><b>-ABEGO</b> \<Boolean\></dt>
<dd>ABEGO option group<br/></dd>
<dt><b>-phi_psi_range_A</b> \<Real\></dt>
<dd>Further filter phi&psi during frag picking process in design<br/>Default: 999.0<br/></dd>
</dl>
+ <h2>-holes</h2>
<dl>
<dt><b>-holes</b> \<Boolean\></dt>
<dd>holes option group<br/></dd>
<dt><b>-dalphaball</b> \<File\></dt>
<dd>The DAlaphaBall_surf program<br/></dd>
<dt><b>-params</b> \<File\></dt>
<dd>File containing score parameters<br/>Default: "holes_params.dat"<br/></dd>
<dt><b>-h_mode</b> \<Integer\></dt>
<dd>include H's or no... see PoseBalls.cc<br/>Default: 0<br/></dd>
<dt><b>-water</b> \<Boolean\></dt>
<dd>include water or no<br/>Default: false<br/></dd>
<dt><b>-make_pdb</b> \<Boolean\></dt>
<dd>make pdb with scores<br/>Default: false<br/></dd>
<dt><b>-make_voids</b> \<Boolean\></dt>
<dd>do separate SLOW void calculation<br/>Default: false<br/></dd>
<dt><b>-atom_scores</b> \<Boolean\></dt>
<dd>output scores for all atoms<br/>Default: false<br/></dd>
<dt><b>-residue_scores</b> \<Boolean\></dt>
<dd>output scores for all residues (avg over atoms)<br/>Default: false<br/></dd>
<dt><b>-minimize</b> \<String\></dt>
<dd>RosettaHoles params to use: decoy15, decoy25 or resl<br/>Default: "decoy15"<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>dump debug output<br/>Default: false<br/></dd>
</dl>
+ <h2>-hotspot</h2>
<dl>
<dt><b>-hotspot</b> \<Boolean\></dt>
<dd>hotspot option group<br/></dd>
<dt><b>-allow_gly</b> \<Boolean\></dt>
<dd>Allow glycines in hotspot hashing constraints?<br/>Default: false<br/></dd>
<dt><b>-allow_proline</b> \<Boolean\></dt>
<dd>Allow prolines in hotspot hashing constraints?<br/>Default: false<br/></dd>
<dt><b>-benchmark</b> \<Boolean\></dt>
<dd>Score existing interface?<br/>Default: false<br/></dd>
<dt><b>-residue</b> \<StringVector\></dt>
<dd>mini residue name3 to use for hotspot hashing<br/>Default: utility::vector1<std::string>(1,"ALL")<br/></dd>
<dt><b>-hashfile</b> \<File\></dt>
<dd>Existing hotspot hash file.<br/></dd>
<dt><b>-target</b> \<File\></dt>
<dd>Target PDB of the hotspot hash. Used for both de novo hashing and making hash density maps.<br/></dd>
<dt><b>-target_res</b> \<Integer\></dt>
<dd>Rosetta residue number of interest on the target PDB. Used for targeted hashing<br/></dd>
<dt><b>-target_dist</b> \<Real\></dt>
<dd>Tolerated distance from the target residue. Used for targeted hashing<br/>Default: 20<br/></dd>
<dt><b>-density</b> \<File\></dt>
<dd>Filename to write *unweighted* hotspot density (compared to -target PDB).<br/></dd>
<dt><b>-weighted_density</b> \<File\></dt>
<dd>Filename to write *score weighted* hotspot density (compared to -target PDB).<br/></dd>
<dt><b>-rms_target</b> \<File\></dt>
<dd>Filename to write best rms of hotspot to target complex. Suitable for pymol data2b_res<br/></dd>
<dt><b>-rms_hotspot</b> \<File\></dt>
<dd>Filename to write best rms of hotspot to target complex. Suitable for rms vs E scatter plots.<br/></dd>
<dt><b>-rms_hotspot_res</b> \<Integer\></dt>
<dd>Rosetta residue # to use for calculating rms_hotspot.<br/></dd>
<dt><b>-rescore</b> \<Boolean\></dt>
<dd>Rescore hotspots from -hashfile based on the supplied -target PDB.<br/>Default: false<br/></dd>
<dt><b>-threshold</b> \<Real\></dt>
<dd>Score threshold for hotspot accepts. Found hotspots must be better than or equal to threshold<br/>Default: -1.0<br/></dd>
<dt><b>-sc_only</b> \<Boolean\></dt>
<dd>Make backbone atoms virtual to find sidechain-only hotspots?<br/>Default: true<br/></dd>
<dt><b>-fxnal_group</b> \<Boolean\></dt>
<dd>Only use a stubs functional group for rmsd calculations.<br/>Default: true<br/></dd>
<dt><b>-cluster</b> \<Boolean\></dt>
<dd>Cluster stubset. Will take place before colonyE.<br/>Default: false<br/></dd>
<dt><b>-colonyE</b> \<Boolean\></dt>
<dd>Rescore hotspots from -hashfile based on colony energy.<br/>Default: false<br/></dd>
<dt><b>-length</b> \<Integer\></dt>
<dd>Length of hotspot peptide to use for hashing. Sidechain-containing group will be in the center.<br/>Default: 1<br/></dd>
<dt><b>-envhb</b> \<Boolean\></dt>
<dd>Use environment dependent Hbonds when scoring hotspots.<br/>Default: false<br/></dd>
<dt><b>-angle</b> \<Real\></dt>
<dd>Maximum allowed angle between stubCA, target CoM, and stubCB. Used to determine if stub is pointing towards target. Negative numbers deactivates this check (default)<br/>Default: -1<br/></dd>
<dt><b>-angle_res</b> \<Integer\></dt>
<dd>Residue to use for angle calculation from stubCA, <this option>, and stubCB. Used to determine if stub is pointing towards target. 0 uses the default, which is the targets center of mass<br/>Default: 0<br/></dd>
<dt><b>-batch_size</b> \<Integer\></dt>
<dd>Run stub hashing in batches of this size. (Ignored if target_res is set) <br/>Default: 10<br/></dd>
</dl>
+ <h2>-indexed_structure_store</h2>
<dl>
<dt><b>-indexed_structure_store</b> \<Boolean\></dt>
<dd>indexed_structure_store option group<br/></dd>
<dt><b>-fragment_store</b> \<File\></dt>
<dd>Fragment store. [.h5] file<br/></dd>
<dt><b>-fragment_threshold_distance</b> \<Real\></dt>
<dd>sets the fragment threshold distance when being read in by the VallLookback score function<br/>Default: 0.4<br/></dd>
<dt><b>-store_name</b> \<String\></dt>
<dd>name of store in hdf5<br/>Default: "9_mer"<br/></dd>
<dt><b>-exclude_homo</b> \<String\></dt>
<dd>turns on delete homologs from hdf5 database and gives files<br/></dd>
</dl>
+ <h2>-lh</h2>
<dl>
<dt><b>-lh</b> \<Boolean\></dt>
<dd>lh option group<br/></dd>
<dt><b>-loopsizes</b> \<IntegerVector\></dt>
<dd>Which loopsizes to use<br/>Default: ['10', '15', '20']<br/></dd>
<dt><b>-num_partitions</b> \<Integer\></dt>
<dd>Number of partitions to split the database into<br/>Default: 1<br/></dd>
<dt><b>-db_path</b> \<Path\></dt>
<dd>Path to database<br/>Default: ""<br/></dd>
<dt><b>-exclude_homo</b> \<Boolean\></dt>
<dd>Use a homolog exclusion filter<br/>Default: false<br/></dd>
<dt><b>-bss</b> \<Boolean\></dt>
<dd>Use BinaryProteinSilentStruct instead of ProteinSilentStruct (needed for nonideal)<br/>Default: false<br/></dd>
<dt><b>-refstruct</b> \<String\></dt>
<dd>File with a target reference structure<br/>Default: ""<br/></dd>
<dt><b>-homo_file</b> \<String\></dt>
<dd>File containing homologs to exclude<br/>Default: ""<br/></dd>
<dt><b>-createdb_rms_cutoff</b> \<RealVector\></dt>
<dd>RMS cutoff used for throwing out similar fragments.<br/>Default: ['0', '0', '0']<br/></dd>
<dt><b>-min_bbrms</b> \<Real\></dt>
<dd>No description<br/>Default: 20.0<br/></dd>
<dt><b>-max_bbrms</b> \<Real\></dt>
<dd>No description<br/>Default: 1400.0<br/></dd>
<dt><b>-min_rms</b> \<Real\></dt>
<dd>No description<br/>Default: 0.5<br/></dd>
<dt><b>-max_rms</b> \<Real\></dt>
<dd>No description<br/>Default: 4.0<br/></dd>
<dt><b>-filter_by_phipsi</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-max_radius</b> \<Integer\></dt>
<dd>No description<br/>Default: 4<br/></dd>
<dt><b>-max_struct</b> \<Integer\></dt>
<dd>No description<br/>Default: 10<br/></dd>
<dt><b>-max_struct_per_radius</b> \<Integer\></dt>
<dd>No description<br/>Default: 10<br/></dd>
<dt><b>-grid_space_multiplier</b> \<Real\></dt>
<dd>No description<br/>Default: 1<br/></dd>
<dt><b>-grid_angle_multiplier</b> \<Real\></dt>
<dd>No description<br/>Default: 2.5<br/></dd>
<dt><b>-skim_size</b> \<Integer\></dt>
<dd>No description<br/>Default: 100<br/></dd>
<dt><b>-rounds</b> \<Integer\></dt>
<dd>No description<br/>Default: 100<br/></dd>
<dt><b>-jobname</b> \<String\></dt>
<dd>Prefix (Ident string) !<br/>Default: "default"<br/></dd>
<dt><b>-max_lib_size</b> \<Integer\></dt>
<dd>No description<br/>Default: 2<br/></dd>
<dt><b>-max_emperor_lib_size</b> \<Integer\></dt>
<dd>No description<br/>Default: 25<br/></dd>
<dt><b>-max_emperor_lib_round</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-library_expiry_time</b> \<Integer\></dt>
<dd>No description<br/>Default: 2400<br/></dd>
<dt><b>-objective_function</b> \<String\></dt>
<dd>What to use as the objective function<br/>Default: "score"<br/></dd>
<dt><b>-expire_after_rounds</b> \<Integer\></dt>
<dd>If set to > 0 this causes the Master to expire a structure after it has gone through this many cycles<br/>Default: 0<br/></dd>
<dt><b>-mpi_resume</b> \<String\></dt>
<dd>Prefix (Ident string) for resuming a previous job!<br/></dd>
<dt><b>-mpi_feedback</b> \<String\></dt>
<dd>No description<br/>Default: "no"<br/></dd>
<dt><b>-mpi_batch_relax_chunks</b> \<Integer\></dt>
<dd>No description<br/>Default: 100<br/></dd>
<dt><b>-mpi_batch_relax_absolute_max</b> \<Integer\></dt>
<dd>No description<br/>Default: 300<br/></dd>
<dt><b>-mpi_outbound_wu_buffer_size</b> \<Integer\></dt>
<dd>No description<br/>Default: 60<br/></dd>
<dt><b>-mpi_loophash_split_size    </b> \<Integer\></dt>
<dd>No description<br/>Default: 50<br/></dd>
<dt><b>-mpi_metropolis_temp</b> \<Real\></dt>
<dd>No description<br/>Default: 1000000.0<br/></dd>
<dt><b>-mpi_save_state_interval</b> \<Integer\></dt>
<dd>No description<br/>Default: 1200<br/></dd>
<dt><b>-mpi_master_save_score_only</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-max_loophash_per_structure</b> \<Integer\></dt>
<dd>No description<br/>Default: 1<br/></dd>
<dt><b>-prob_terminus_ramapert</b> \<Real\></dt>
<dd>Prob. to run ramapert instead of fraginsert on terminus<br/>Default: 0.0<br/></dd>
<dt><b>-rms_limit</b> \<Real\></dt>
<dd>How to deal with returned relaxed structures<br/>Default: 2.0<br/></dd>
<dt><b>-similarity_reference</b> \<Real\></dt>
<dd>How to deal with returned relaxed structures<br/>Default: 2.0<br/></dd>
<dt><b>-centroid_only</b> \<Boolean\></dt>
<dd>false<br/>Default: false<br/></dd>
<dt><b>-write_centroid_structs</b> \<Boolean\></dt>
<dd>Output raw loophashed decoys as well as relaxed ones<br/>Default: false<br/></dd>
<dt><b>-write_all_fa_structs</b> \<Boolean\></dt>
<dd>Write out all structures returned from batch relax<br/>Default: false<br/></dd>
<dt><b>-sandbox</b> \<Boolean\></dt>
<dd>Sand box mode<br/>Default: false<br/></dd>
<dt><b>-create_db</b> \<Boolean\></dt>
<dd>Make database with this loopsize<br/>Default: false<br/></dd>
<dt><b>-sample_weight_file</b> \<File\></dt>
<dd>Holds the initial per residue sample weights<br/></dd>
<dt><b>-radius_size</b> \<Real\></dt>
<dd>tune the radius for hypershell<br/>Default: 2<br/></dd>
<dt><b>-max_ref_lib_size</b> \<Integer\></dt>
<dd>No description<br/>Default: 2<br/></dd>
<dt><b>-multi_objective_functions</b> \<StringVector\></dt>
<dd>What to use as the objective function<br/>Default: utility::vector1<std::string>(1,"score")<br/></dd>
<dt><b>-additional_objective_functions</b> \<StringVector\></dt>
<dd>What to add for the multi-objective function<br/></dd>
<dt><b>-edensity_weight_for_sampling</b> \<Real\></dt>
<dd>weight for elec_dens_fast in WorkUnit_Samplers<br/>Default: 0.0<br/></dd>
<dt><b>-mpi_master_schfile</b> \<String\></dt>
<dd>schedule file<br/>Default: ""<br/></dd>
<dt><b>-mpi_master_cpu_weight</b> \<IntegerVector\></dt>
<dd>weight on number of slaves<br/>Default: ['0.0']<br/></dd>
<dt><b>-mpi_loophash_scan_type</b> \<String\></dt>
<dd>No description<br/>Default: "random"<br/></dd>
<dt><b>-mpi_read_structure_for_emperor</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-mpi_packmin_init</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-max_sample_per_structure</b> \<Integer\></dt>
<dd>No description<br/>Default: 1<br/></dd>
<dt><b>-loop_string</b> \<String\></dt>
<dd>string to be parsed for loop region, e.g. 1-10,15-20,32-38<br/>Default: ""<br/></dd>
<dt><b>-seg_string</b> \<String\></dt>
<dd>string to be parsed for segment region, e.g. 1-10,15-20,32-38<br/>Default: ""<br/></dd>
<dt><b>-loopresdef</b> \<StringVector\></dt>
<dd>String vector that tells connectivity, e.g. peptide:1,2,3,4,5-6 SSbond:3,2,1-9,8,7,6<br/>Default: ['']<br/></dd>
<dt><b>-pert_init_loop</b> \<Boolean\></dt>
<dd>Try perturbing loops from starting structure at the beginning<br/>Default: false<br/></dd>
<dt><b>-NMdist</b> \<Real\></dt>
<dd>normalmodemover distance cut<br/>Default: 10.0<br/></dd>
<dt><b>-objective_dominate_cut</b> \<RealVector\></dt>
<dd>cut for objective function domination<br/>Default: ['0.0', '0.0', '3.0']<br/></dd>
<dt><b>-objective_cut_increment</b> \<RealVector\></dt>
<dd>objective_dominate_cut increment for every call<br/>Default: ['0.0', '0.0', '0.0']<br/></dd>
<dt><b>-similarity_method</b> \<String\></dt>
<dd>No description<br/>Default: "sum"<br/></dd>
<dt><b>-similarity_measure</b> \<String\></dt>
<dd>No description<br/>Default: "Sscore"<br/></dd>
<dt><b>-similarity_tolerance</b> \<Real\></dt>
<dd>No description<br/>Default: 0.5<br/></dd>
<dt><b>-parent_selection_kT</b> \<Real\></dt>
<dd>No description<br/>Default: 0.2<br/></dd>
<dt><b>-sim_replace_obj</b> \<String\></dt>
<dd>No description<br/>Default: "goap"<br/></dd>
<dt><b>-ulr_mulfactor</b> \<Real\></dt>
<dd>No description<br/>Default: 1.8<br/></dd>
<dt><b>-filter_up_to_maxlib</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-minimize_after_nmsearch</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
</dl>
+ <h3>-lh:fragpdb</h3>
<dl>
<dt><b>-fragpdb</b> \<Boolean\></dt>
<dd>fragpdb option group<br/></dd>
<dt><b>-out_path</b> \<String\></dt>
<dd>Path where pdbs are saved<br/>Default: ""<br/></dd>
<dt><b>-indexoffset</b> \<IntegerVector\></dt>
<dd>list of index offset pairs<br/>Default: ['-1']<br/></dd>
<dt><b>-bin</b> \<StringVector\></dt>
<dd>list of bin keys<br/>Default: utility::vector1<std::string>()<br/></dd>
</dl>
+ <h3>-lh:symfragrm</h3>
<dl>
<dt><b>-symfragrm</b> \<Boolean\></dt>
<dd>symfragrm option group<br/></dd>
<dt><b>-pdblist</b> \<FileVector\></dt>
<dd>list of pdbs to be processed<br/></dd>
</dl>
+ <h2>-loopfcst</h2>
<dl>
<dt><b>-loopfcst</b> \<Boolean\></dt>
<dd>loopfcst option group<br/></dd>
<dt><b>-coord_cst_weight</b> \<Real\></dt>
<dd>use coord constraints for template<br/>Default: 0.0<br/></dd>
<dt><b>-coord_cst_all_atom</b> \<Boolean\></dt>
<dd>use coord constraints on all atoms and not just CA<br/>Default: false<br/></dd>
<dt><b>-use_general_protocol</b> \<Boolean\></dt>
<dd>use the new machinery around classes KinematicXXX<br/>Default: false<br/></dd>
<dt><b>-coord_cst_weight_array</b> \<File\></dt>
<dd>use these weights (per seqpos) for coord cst in rigid regions<br/>Default: ""<br/></dd>
<dt><b>-dump_coord_cst_weight_array</b> \<File\></dt>
<dd>dump these weights (per seqpos) for coord cst in rigid regions<br/>Default: ""<br/></dd>
</dl>
+ <h2>-LoopModel</h2>
<dl>
<dt><b>-LoopModel</b> \<Boolean\></dt>
<dd>LoopModel option group<br/></dd>
<dt><b>-input_pdb</b> \<File\></dt>
<dd>input pdb file<br/>Default: "LoopModel::input_pdb"<br/></dd>
</dl>
+ <h2>-make_rot_lib</h2>
<dl>
<dt><b>-make_rot_lib</b> \<Boolean\></dt>
<dd>make_rot_lib option group<br/></dd>
<dt><b>-options_file</b> \<File\></dt>
<dd>path to make rot lib options file<br/></dd>
<dt><b>-output_logging</b> \<Boolean\></dt>
<dd>If true (the default), then logfiles are written for every mainchain torsion bin attempted.  These can take up a lot of space, so this can be disabled by setting this to false.<br/>Default: true<br/></dd>
<dt><b>-two_fold_symmetry_135_315</b> \<IntegerVector\></dt>
<dd>the chi number at which to apply two fold symmetry across the 135/315 axis<br/></dd>
<dt><b>-two_fold_symmetry_0_180</b> \<IntegerVector\></dt>
<dd>the chi number at which to apply two fold symmetry across the 0/180 axis<br/></dd>
<dt><b>-three_fold_symmetry_90_210_330</b> \<IntegerVector\></dt>
<dd>the chi number at which to apply three fold symmetry across the 0/180 axis<br/></dd>
<dt><b>-use_terminal_residues</b> \<Boolean\></dt>
<dd>Use separate ACE and NME residues as terminal capping groups, rather than patches<br/>Default: false<br/></dd>
<dt><b>-k_medoids</b> \<Boolean\></dt>
<dd>Use k-medoids instead of k-means clustering<br/>Default: false<br/></dd>
<dt><b>-patch_name_for_residue</b> \<String\></dt>
<dd>Provide an explicit description of the patches for terminal capping<br/></dd>
<dt><b>-polymeric_context</b> \<File\></dt>
<dd>A file containing the RT at PDB number 0 and the flanking context as well.<br/></dd>
</dl>
+ <h2>-make_mainchain_potential</h2>
<dl>
<dt><b>-make_mainchain_potential</b> \<Boolean\></dt>
<dd>make_mainchain_potential option group<br/></dd>
<dt><b>-do_minimization</b> \<Boolean\></dt>
<dd>If true, each side-chain rotamer is minimized using the Rosetta molecular mechanics forcefield prior to scoring.  True by default.<br/>Default: true<br/></dd>
<dt><b>-mainchain_potential_points_per_dimension</b> \<IntegerVector\></dt>
<dd>The number of points for each dimension in the multidimensional mainchain potential, provided as a whitespace-separated list of integers.  Each integer must be strictly positive.  Required input.<br/></dd>
<dt><b>-mainchain_torsions_covered</b> \<IntegerVector\></dt>
<dd>The mainchain torsions that are covered by this potential.  For example, an oligourea has four mainchain torsions, but only torsions 1, 2, and 3 are covered (and the fourth is restrained by the omega scoreterm), in which case this option can be set to 1 2 3.  If not specified, it defaults to all mainchain torsions.<br/></dd>
<dt><b>-make_pre_proline_potential</b> \<Boolean\></dt>
<dd>If true, then this application will make a potential for a position preceding a proline, sarcosine, peptoid, or other N-substituted building-block.  If false (the default), then it generates a potential for a position preceding an unsubstituted position (e.g. the 19 canonical amino acids other than proline).<br/>Default: false<br/></dd>
<dt><b>-output_filename</b> \<File\></dt>
<dd>Output file to which the generated mainchain potential will be written.  Defaults to generated_mainchain_potential.txt<br/>Default: "generated_mainchain_potential.txt"<br/></dd>
<dt><b>-residue_name</b> \<String\></dt>
<dd>The name of the residue type for which we will be generating a mainchain potential.  Defaults to ALA if not set, but should be set by the user.<br/>Default: "ALA"<br/></dd>
<dt><b>-symmetrize_output</b> \<Boolean\></dt>
<dd>If true, the output will be made symmetric.  False by default.  Note that this necessitates a five degree offset.<br/>Default: false<br/></dd>
<dt><b>-write_potentials_for_individual_scoreterms</b> \<Boolean\></dt>
<dd>If true, a separate potential file is written for each scoreterm.  This is used to fit the weights for the molecular mechanics forcefield used by the make_mainchain_potential application.  Note that these tables will be written unnormalized and with weights of 1.0 for each term.  False by default.<br/>Default: false<br/></dd>
</dl>
+ <h2>-match</h2>
<dl>
<dt><b>-match</b> \<Boolean\></dt>
<dd>match option group<br/></dd>
<dt><b>-lig_name</b> \<String\></dt>
<dd>Name of the ligand to be matched.  This should be the same as the NAME field of the ligand's parameter file (the .params file)<br/></dd>
<dt><b>-bump_tolerance</b> \<Real\></dt>
<dd>The permitted level of spherical overlap betweeen any two atoms.  Used to detect collisions between the upstream atoms and the background, the upstream atoms and the downstream atoms, and the downstream atoms and the background<br/>Default: 0.0<br/></dd>
<dt><b>-active_site_definition_by_residue</b> \<File\></dt>
<dd>File describing the active site of the scaffold as a set of resid/radius pairs<br/></dd>
<dt><b>-active_site_definition_by_gridlig</b> \<File\></dt>
<dd>File containing 1s and Os describing the volume of space for the active site.  .gridlig file format from Rosetta++<br/></dd>
<dt><b>-required_active_site_atom_names</b> \<File\></dt>
<dd>File listing the downstream-residue-atom names which must reside in the defined active site.  Requires either the flag active_site_definition_by_residue or the flag active_site_definition_by_gridlig to be specified.<br/></dd>
<dt><b>-grid_boundary</b> \<File\></dt>
<dd>File describing the volume in space in which the third orientation atom must lie<br/>Default: ""<br/></dd>
<dt><b>-geometric_constraint_file</b> \<File\></dt>
<dd>File describing the geometry of the downstream object relative to the upstream object<br/></dd>
<dt><b>-scaffold_active_site_residues</b> \<File\></dt>
<dd>File with the residue indices on the scaffold that should be 			considered as potential launch points for the scaffold's active site.  File format described in MatcherTask.cc 			in the details section of the initialize_scaffold_active_site_residue_list_from_command_line() method.<br/>Default: ""<br/></dd>
<dt><b>-scaffold_active_site_residues_for_geomcsts</b> \<File\></dt>
<dd>File which lists the residue indices on the 			scaffold to consider as potential launch points for the scaffold's active site for each geometric constraint; 			each constraint may have a separate set of residue ids. File format described in MatcherTask.cc in the details 			section of the initialize_scaffold_active_site_residue_list_from_command_line() method.<br/>Default: ""<br/></dd>
<dt><b>-euclid_bin_size</b> \<Real\></dt>
<dd>The bin width for the 3-dimensional coordinate hasher, in Angstroms<br/>Default: 1.0<br/></dd>
<dt><b>-euler_bin_size</b> \<Real\></dt>
<dd>The bin width for the euler angle hasher, in degrees<br/>Default: 10.0<br/></dd>
<dt><b>-consolidate_matches</b> \<Boolean\></dt>
<dd>Instead of outputting all matches, group matches and then write only the top -match::output_matches_per_group from each group.<br/>Default: false<br/></dd>
<dt><b>-output_matches_per_group</b> \<Integer\></dt>
<dd>The number of matches to output per group. Requires the -match::consolidate_matches flag is active.<br/>Default: 10<br/></dd>
<dt><b>-orientation_atoms</b> \<StringVector\></dt>
<dd>The three atoms, by name, on the downstream partner 			to use to describe its 6 dimensional coordinate; its position and orientation. 			Only usable when the downstream partner is a single residue. Exactly 3 atom names must be given. 			If these atoms are unspecified, the matcher will use the residues neighbor atom and two atoms 			bonded to the neighbor atom to define the orientation.  The euclidean coordinate of the third 			orientation atom is used as the first the dimensions of the downstream residues 6D coordinate; the 			other three dimensions are the three euler angles described by creating a coordinate frame at orientation 			atom 3, with the z axis along the vector from orientation atom 2 to orientation atom 3, and the y axis 			lying in the plane with orientation atoms 1,2&3.<br/></dd>
<dt><b>-output_format</b> \<String\></dt>
<dd>The format in which the matches are output<br/>Default: "CloudPDB"<br/></dd>
<dt><b>-match_grouper</b> \<String\></dt>
<dd>The parameters that matches are grouped according to by the MatchConsolidator or the CloudPDBWriter<br/>Default: "SameSequenceAndDSPositionGrouper"<br/></dd>
<dt><b>-grouper_downstream_rmsd</b> \<Real\></dt>
<dd>Maximum allowed rmsd between two orientations of the downstream pose to be considered part of the same group <br/>Default: 1.5<br/></dd>
<dt><b>-output_matchres_only</b> \<Boolean\></dt>
<dd>Whether to output the matched residues only or the whole pose for every match<br/>Default: false<br/></dd>
<dt><b>-geom_csts_downstream_output</b> \<IntegerVector\></dt>
<dd>For which of the geometric constraints the downstream residue/ligand will be output<br/>Default: ['1']<br/></dd>
<dt><b>-filter_colliding_upstream_residues</b> \<Boolean\></dt>
<dd>Filter the output matches if the hits induce a collision between the upstream residues<br/>Default: true<br/></dd>
<dt><b>-upstream_residue_collision_tolerance</b> \<Real\></dt>
<dd>The amount of atom overlap allowed between upstream residues in a match.  If this is unspecified on the command line, then the value in the bump_tolerance option is used<br/>Default: 0.0<br/></dd>
<dt><b>-upstream_residue_collision_score_cutoff</b> \<Real\></dt>
<dd>The score cutoff for upstream residue pairs to use in the collision filter.  Activating this cutoff uses the etable atr/rep/sol terms to evaluate residue-pair interactions instead of hard-sphere overlap detection<br/>Default: 10.0<br/></dd>
<dt><b>-upstream_residue_collision_Wfa_atr</b> \<Real\></dt>
<dd>The fa_atr weight to use in the upstream-collision filter; use in tandem with upstream_residue_collision_score_cutoff<br/>Default: 0.8<br/></dd>
<dt><b>-upstream_residue_collision_Wfa_rep</b> \<Real\></dt>
<dd>The fa_rep weight to use in the upstream-collision filter; use in tandem with upstream_residue_collision_score_cutoff<br/>Default: 0.44<br/></dd>
<dt><b>-upstream_residue_collision_Wfa_sol</b> \<Real\></dt>
<dd>The fa_sol weight to use in the upstream-collision filter; use in tandem with upstream_residue_collision_score_cutoff<br/>Default: 0.0<br/></dd>
<dt><b>-filter_upstream_downstream_collisions</b> \<Boolean\></dt>
<dd>Filter the output matches if the hits induce a collision between the upstream residues and the downstream pose<br/>Default: true<br/></dd>
<dt><b>-updown_collision_tolerance</b> \<Real\></dt>
<dd>The amount of atom overlap allowed between upstream and downstream atoms in a match.  If this is unspecified on the command line, then the value in the bump_tolerance option is used<br/>Default: 0.0<br/></dd>
<dt><b>-updown_residue_collision_score_cutoff</b> \<Real\></dt>
<dd>The score cutoff for upstream/downstream residue pairs to use in the collision filter.  Activating this cutoff uses the etable atr/rep/sol terms to evaluate residue-pair interactions instead of hard-sphere overlap detection<br/>Default: 10.0<br/></dd>
<dt><b>-updown_residue_collision_Wfa_atr</b> \<Real\></dt>
<dd>The fa_atr weight to use in the upstream-downstream-collision filter; use in tandem with updown_residue_collision_score_cutoff<br/>Default: 0.8<br/></dd>
<dt><b>-updown_residue_collision_Wfa_rep</b> \<Real\></dt>
<dd>The fa_rep weight to use in the upstream-downstream-collision filter; use in tandem with updown_residue_collision_score_cutoff<br/>Default: 0.44<br/></dd>
<dt><b>-updown_residue_collision_Wfa_sol</b> \<Real\></dt>
<dd>The fa_sol weight to use in the upstream-downstream-collision filter; use in tandem with updown_residue_collision_score_cutoff<br/>Default: 0.0<br/></dd>
<dt><b>-define_match_by_single_downstream_positioning</b> \<Boolean\></dt>
<dd>Enumerate combinations of matches where a 			single positioning of the downstream partner as well as the conformations of the upstream residues defines the 			match; it is significantly faster to enumerate unique matches when they are defined this way instead of enumerating the 			(combinatorially many) matches when a match is defined by n-geometric-constraint locations of the downstream partner. 			This faster technique for outputting matches is automatically chosen when the flag -match::output_format is PDB.<br/></dd>
<dt><b>-ligand_rotamer_index</b> \<Integer\></dt>
<dd>Match with a particular conformation of the ligand; the index 			represents which conformation in the multi-model .pdb file specified in the ligand's .params file by the 			PDB_ROTAMERS field.  The index of the first conformation in that file is 1; valid indices range from 1 to 			the number of entries in the multi-model .pdb file.  If this command-line flag is not used, then the conformation 			of the ligand described by the ICOOR_INTERNAL lines of the ligand's .params file is used instead.<br/></dd>
<dt><b>-enumerate_ligand_rotamers</b> \<Boolean\></dt>
<dd>Match with all ligand rotamers specified in the multi-model 			.pdb file specified in the ligand's .params file by the PDB_ROTAMERS field.  This flag may not be used in 			combination with the match::ligand_rotamer_index flag.  Geometry of the ligand rotamers in the .pdb file will 			be idealized to the .params file bond angles and lengths.<br/>Default: true<br/></dd>
<dt><b>-only_enumerate_non_match_redundant_ligand_rotamers</b> \<Boolean\></dt>
<dd>Only defined if enumerate_ligand_rotamers is true 			this option causes the matcher to determine which rotamers in the ligand rotamer library are redundant in terms of matching, 			meaning the atoms they're matched through are superimposable. after having subdivided the ligand rotamer library into match-redundant 			subgroups, the matcher will then only place the first nonclashing rotamer from each subgroup. <br/>Default: true<br/></dd>
<dt><b>-dynamic_grid_refinement</b> \<Boolean\></dt>
<dd>When too many hits land in the same 'connected component', requiring the 			enumeration of twoo many matches, refine the grid size to be smaller so that fewer matches have to be enumerated. 			This process works on individual connected components and is not applied to all regions of 6D.  This is significantly 			more efficient than enumerating all matches, while allowing the grid size to remain large and the rotamer and external 			geometry to remain dense. (*A connected component refers to <br/></dd>
<dt><b>-build_round1_hits_twice</b> \<Boolean\></dt>
<dd>Memory saving strategy that avoids paying for the storage of all the round-1 hits 			and instead records only what 6D voxels those hits fall in to.  Then the second round of matching proceeds storing only the hits that 			fall into the same voxels that the hits from the first round fell into.  Then the matcher goes back and generates the first-round hits 			again, but only keeps the ones that land into the same voxels that hits from round 2 fell into.  To be used, round 2 must also use the 			classic match algorithm (and must not use secondary matching).<br/>Default: false<br/></dd>
</dl>
+ <h2>-matdes</h2>
<dl>
<dt><b>-matdes</b> \<Boolean\></dt>
<dd>matdes option group<br/></dd>
<dt><b>-num_subs_building_block</b> \<Integer\></dt>
<dd>The number of subunits in the oligomeric building block<br/>Default: 1<br/></dd>
<dt><b>-num_subs_total</b> \<Integer\></dt>
<dd>The number of subunits in the target assembly<br/>Default: 1<br/></dd>
<dt><b>-pdbID</b> \<String\></dt>
<dd>The PDB ID<br/>Default: "0xxx"<br/></dd>
<dt><b>-prefix</b> \<String\></dt>
<dd>Prefix appended to output PDB files. Perhaps useful to describe the architecture, e.g., 532_3_...<br/>Default: "pre_"<br/></dd>
<dt><b>-radial_disp</b> \<RealVector\></dt>
<dd>Specify the radial displacement from the center of a closed point group assembly. Use with -in::olig_search::dump_pdb<br/></dd>
<dt><b>-angle</b> \<RealVector\></dt>
<dd>Specify the angle by which a building block is rotated in a symmetrical assembly. Use with -in::olig_search::dump_pdb<br/></dd>
<dt><b>-tag</b> \<String\></dt>
<dd>Four digit ID tag attached to a design model during design<br/></dd>
</dl>
+ <h3>-matdes:dock</h3>
<dl>
<dt><b>-dock</b> \<Boolean\></dt>
<dd>dock option group<br/></dd>
<dt><b>-neg_r</b> \<Real\></dt>
<dd>Specify whether radial displacement is positive or negative. 1 for negative, 0 for positive.<br/>Default: 0<br/></dd>
<dt><b>-dump_pdb</b> \<Boolean\></dt>
<dd>Dump a pdb of a particular docked configuration<br/>Default: false<br/></dd>
<dt><b>-dump_chainA_only</b> \<Boolean\></dt>
<dd>Only output chain A (the asymmetric unit) of the symmetrical assembly. Use with -in::olig_search::dump_pdb<br/>Default: false<br/></dd>
</dl>
+ <h3>-matdes:design</h3>
<dl>
<dt><b>-design</b> \<Boolean\></dt>
<dd>design option group<br/></dd>
<dt><b>-contact_dist</b> \<Real\></dt>
<dd>CA-CA distance for defining interface residues<br/>Default: 10.0<br/></dd>
<dt><b>-grid_size_angle</b> \<Real\></dt>
<dd>The width of angle space to start design/minimize runs from, centered on the starting angle<br/>Default: 1.0<br/></dd>
<dt><b>-grid_size_radius</b> \<Real\></dt>
<dd>The width of radius space to start design/minimize runs from, centered on the starting radius<br/>Default: 1.0<br/></dd>
<dt><b>-grid_nsamp_angle</b> \<Integer\></dt>
<dd>The number of samples the rigid body grid is divided into in angle space<br/>Default: 9<br/></dd>
<dt><b>-grid_nsamp_radius</b> \<Integer\></dt>
<dd>The number of samples the rigid body grid is divided into in radius space<br/>Default: 9<br/></dd>
<dt><b>-fav_nat_bonus</b> \<Real\></dt>
<dd>Bonus to be awarded to native residues<br/>Default: 0.0<br/></dd>
</dl>
+ <h3>-matdes:mutalyze</h3>
<dl>
<dt><b>-mutalyze</b> \<Boolean\></dt>
<dd>mutalyze option group<br/></dd>
<dt><b>-calc_rot_boltz</b> \<Boolean\></dt>
<dd>Specify whether to calculate RotamerBoltzmann probabilities or not<br/>Default: 0<br/></dd>
<dt><b>-ala_scan</b> \<Boolean\></dt>
<dd>Specify whether to calculate ddGs for alanine-scanning mutants at the designed interface<br/>Default: 1<br/></dd>
<dt><b>-revert_scan</b> \<Boolean\></dt>
<dd>Specify whether to calculate ddGs for reversion mutants at the designed interface<br/>Default: 1<br/></dd>
<dt><b>-min_rb</b> \<Boolean\></dt>
<dd>Specify whether to minimize the rigid body DOFs<br/>Default: 1<br/></dd>
</dl>
+ <h2>-mc</h2>
<dl>
<dt><b>-mc</b> \<Boolean\></dt>
<dd>mc option group<br/></dd>
<dt><b>-log_scores_in_MC</b> \<Boolean\></dt>
<dd>Score each decoy during a simulation and output it to log; slows down run!<br/>Default: false<br/></dd>
<dt><b>-hierarchical_pool</b> \<String\></dt>
<dd>specify prefix in order to look for hierarchical pool<br/></dd>
<dt><b>-read_structures_into_pool</b> \<File\></dt>
<dd>specify the silent-structs to create a hierarchy for lazy users<br/></dd>
<dt><b>-convergence_check_frequency</b> \<Integer\></dt>
<dd>how often check for convergences in MC object?<br/>Default: 100<br/></dd>
<dt><b>-known_structures</b> \<File\></dt>
<dd>specify a filename of a silent-file containing known structures<br/>Default: "known_structs.in"<br/></dd>
<dt><b>-max_rmsd_against_known_structures</b> \<Real\></dt>
<dd>stop sampling if rmsd to a known-structure is lower than X<br/>Default: 1.5<br/></dd>
<dt><b>-excluded_residues_from_rmsd</b> \<IntegerVector\></dt>
<dd>residues that are not used for RMSD computation in pool<br/></dd>
<dt><b>-heat_convergence_check</b> \<Integer\></dt>
<dd>jump out of current abinitio run if X unsuccesful mc-trials reached<br/>Default: 0<br/></dd>
</dl>
+ <h2>-mean_field</h2>
<dl>
<dt><b>-mean_field</b> \<Boolean\></dt>
<dd>mean_field option group<br/></dd>
<dt><b>-bb_list</b> \<FileVector\></dt>
<dd>Specifies list of pdb files in backbone ensemble<br/></dd>
<dt><b>-dump_transfac</b> \<File\></dt>
<dd>filename prefix for dumping the predicted specificity profile in transfac format<br/>Default: ""<br/></dd>
<dt><b>-spec_profile</b> \<File\></dt>
<dd>specify filename of specificity profile (PWM) (transfac format).  Used as gold standard to compare to mean-field predicted result.<br/>Default: ""<br/></dd>
<dt><b>-bb_boltz_probs</b> \<File\></dt>
<dd>specify filename of backbone Boltzmann probabilities.  Can be used in conjunction with bb_list as Boltz probs of backbones in bb_list.<br/>Default: ""<br/></dd>
<dt><b>-rot_norm_weight</b> \<Real\></dt>
<dd>weight rot_norm term<br/>Default: 0.0<br/></dd>
<dt><b>-bb_average_weight</b> \<Real\></dt>
<dd>bb_average_weight term<br/>Default: 0.0<br/></dd>
<dt><b>-rf_peptide</b> \<File\></dt>
<dd>specify filename of resfile used for identifying peptide residues (or residues designated for sequence tolerance analysis)<br/>Default: ""<br/></dd>
<dt><b>-include_all_aa</b> \<Boolean\></dt>
<dd>upweight probabilities of all amino acids by adding 50 to each value<br/>Default: false<br/></dd>
<dt><b>-ga_pack_detect_interface</b> \<Boolean\></dt>
<dd>automatically detect protein-peptide interface for calculation of fitness function<br/>Default: false<br/></dd>
<dt><b>-biased_dist_all_gen</b> \<Boolean\></dt>
<dd>use biased distribution (as specified in spec_profile) for all generations of GA<br/>Default: false<br/></dd>
</dl>
+ <h2>-mh</h2>
<dl>
<dt><b>-mh</b> \<Boolean\></dt>
<dd>mh option group<br/></dd>
<dt><b>-motif_out_file</b> \<String\></dt>
<dd>file to dump ResPairMotifs to<br/>Default: "motifs"<br/></dd>
<dt><b>-harvest_motifs</b> \<FileVector\></dt>
<dd>files to harvest ResPairMotifs from<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-print_motifs</b> \<FileVector\></dt>
<dd>files to print ResPairMotifs from<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-remove_duplicates</b> \<FileVector\></dt>
<dd>files to remove dup ResPairMotifs from<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-dump_motif_pdbs</b> \<FileVector\></dt>
<dd>files to extract ResPairMotifs clusters from<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-merge_motifs</b> \<FileVector\></dt>
<dd>files to merge ResPairMotifs from<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-merge_scores</b> \<FileVector\></dt>
<dd>files to merge scores from<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-merge_motifs_one_per_bin</b> \<Boolean\></dt>
<dd>keep only one motif per hash bin (for sepcified grid)<br/>Default: false<br/></dd>
<dt><b>-gen_reverse_motifs_on_load</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-dump_input_pdb</b> \<FileVector\></dt>
<dd>files to dump biount interpretation from<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-score_pdbs</b> \<FileVector\></dt>
<dd>files to score with input counts file<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-sequence_recovery</b> \<FileVector\></dt>
<dd>pdb files to score<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-explicit_motif_score</b> \<FileVector\></dt>
<dd>pdb files to score<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-harvest_scores</b> \<FileVector\></dt>
<dd>get counts from ResPairMotif files and dump to binary counts file<br/>Default: ""<br/></dd>
<dt><b>-print_scores</b> \<File\></dt>
<dd>print a binary counts file<br/>Default: ""<br/></dd>
<dt><b>-dump_matching_motifs</b> \<FileVector\></dt>
<dd>pdb files to score<br/>Default: "SPECIFY_ME_DUMMY"<br/></dd>
<dt><b>-score_across_chains_only</b> \<Boolean\></dt>
<dd>ignore intra-chain motifs<br/>Default: false<br/></dd>
<dt><b>-normalize_score_ncontact</b> \<Boolean\></dt>
<dd>normalize by total num contacts<br/>Default: true<br/></dd>
<dt><b>-harvest_motifs_min_hh_ends</b> \<Integer\></dt>
<dd>restrict to middle of hilix contacts <br/>Default: 0<br/></dd>
<dt><b>-ignore_io_errors</b> \<Boolean\></dt>
<dd> <br/>Default: false<br/></dd>
<dt><b>-motif_match_radius</b> \<Real\></dt>
<dd>width of euler angle bin<br/>Default: 9e9<br/></dd>
<dt><b>-merge_similar_motifs</b> \<RealVector\></dt>
<dd>give 3 hash params<br/></dd>
</dl>
+ <h3>-mh:score</h3>
<dl>
<dt><b>-score</b> \<Boolean\></dt>
<dd>score option group<br/></dd>
<dt><b>-background_weight</b> \<Real\></dt>
<dd>weight on cb contacts, kinda<br/>Default: 0.0<br/></dd>
<dt><b>-ca_cb_clash_weight</b> \<Real\></dt>
<dd>weight on cb clashes, kinda<br/>Default: 1.0<br/></dd>
<dt><b>-noloops</b> \<Boolean\></dt>
<dd>ignore loop ss in scored structs<br/>Default: false<br/></dd>
<dt><b>-nosheets</b> \<Boolean\></dt>
<dd>ignore strand ss in scored structs<br/>Default: false<br/></dd>
<dt><b>-nohelix</b> \<Boolean\></dt>
<dd>ignore helix ss in scored structs<br/>Default: false<br/></dd>
<dt><b>-spread_ss_element</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-min_cover_fraction</b> \<Real\></dt>
<dd><br/>Default: 0.0<br/></dd>
<dt><b>-strand_pair_weight</b> \<Real\></dt>
<dd><br/>Default: 1.0<br/></dd>
<dt><b>-anti_polar_weight</b> \<Real\></dt>
<dd><br/>Default: 1.0<br/></dd>
<dt><b>-min_contact_pairs</b> \<Real\></dt>
<dd><br/>Default: 1.0<br/></dd>
<dt><b>-max_contact_pairs</b> \<Real\></dt>
<dd><br/>Default: 9e9<br/></dd>
<dt><b>-max_cb_dis</b> \<Real\></dt>
<dd><br/>Default: 9.0<br/></dd>
<dt><b>-coverage_pow</b> \<Real\></dt>
<dd><br/>Default: 0.0<br/></dd>
<dt><b>-use_ss1</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-use_ss2</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-use_aa1</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-use_aa2</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-use_log</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
</dl>
+ <h3>-mh:path</h3>
<dl>
<dt><b>-path</b> \<Boolean\></dt>
<dd>path option group<br/></dd>
<dt><b>-biounit</b> \<StringVector\></dt>
<dd>path to search for biounits in the ab/1abc.pdb1.gz format<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-biounit_ideal</b> \<StringVector\></dt>
<dd>idealized biounit coords, missing PDBInfo metadatab<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-pdb</b> \<StringVector\></dt>
<dd>path to search for pdbs in the ab/1abc.pdb.gz format<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-motifs</b> \<StringVector\></dt>
<dd>concrete motifs in .rpm.bin.gz format<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-motifs_SC_SC</b> \<StringVector\></dt>
<dd>concrete SC_SC motifs, try to replace with path::motifs<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-motifs_SC_BB</b> \<StringVector\></dt>
<dd>concrete SC_BB motifs, try to replace with path::motifs<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-motifs_BB_BB</b> \<StringVector\></dt>
<dd>concrete BB_BB motifs, try to replace with path::motifs<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-motifs_BB_PH</b> \<StringVector\></dt>
<dd>concrete BB_PH motifs, try to replace with path::motifs<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-motifs_BB_PO</b> \<StringVector\></dt>
<dd>concrete BB_PO motifs, try to replace with path::motifs<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-motifs_PH_PO</b> \<StringVector\></dt>
<dd>concrete PH_PO motifs, try to replace with path::motifs<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-scores</b> \<StringVector\></dt>
<dd>motif hash data for scoring, mixed, may not use<br/></dd>
<dt><b>-scores_SC_SC</b> \<StringVector\></dt>
<dd>motif hash data for scoring SC_SC<br/></dd>
<dt><b>-scores_SC_BB</b> \<StringVector\></dt>
<dd>motif hash data for scoring SC_BB<br/></dd>
<dt><b>-scores_BB_BB</b> \<StringVector\></dt>
<dd>motif hash data for scoring<br/></dd>
<dt><b>-scores_BB_PH</b> \<StringVector\></dt>
<dd>motif hash data for scoring BB_PH<br/></dd>
<dt><b>-scores_BB_PO</b> \<StringVector\></dt>
<dd>motif hash data for scoring BB_PO<br/></dd>
<dt><b>-scores_PH_PO</b> \<StringVector\></dt>
<dd>motif hash data for scoring strand pairings<br/></dd>
<dt><b>-scores_frags</b> \<StringVector\></dt>
<dd>motif hash data for scoring strand pairings<br/></dd>
</dl>
+ <h3>-mh:harvest</h3>
<dl>
<dt><b>-harvest</b> \<Boolean\></dt>
<dd>harvest option group<br/></dd>
<dt><b>-hash_cart_resl</b> \<Real\></dt>
<dd>width of cartesian bin<br/>Default: 0.8<br/></dd>
<dt><b>-hash_angle_resl</b> \<Real\></dt>
<dd>width of euler angle bin<br/>Default: 15.0<br/></dd>
<dt><b>-smoothing_factor</b> \<Real\></dt>
<dd>smoothing radius exp(-d/resl**2 * factor)<br/>Default: 1.0<br/></dd>
<dt><b>-idealize</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-dump</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-min_bin_val</b> \<Real\></dt>
<dd><br/>Default: 0.0<br/></dd>
<dt><b>-sep_aa</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-sep_aa1</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-sep_aa2</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-sep_ss</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-sep_dssp</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-sep_lj</b> \<RealVector\></dt>
<dd><br/>Default: utility::vector1<double>()<br/></dd>
<dt><b>-sep_hb</b> \<RealVector\></dt>
<dd><br/>Default: utility::vector1<double>()<br/></dd>
<dt><b>-sep_nbrs</b> \<RealVector\></dt>
<dd><br/>Default: utility::vector1<double>()<br/></dd>
<dt><b>-sep_bfac</b> \<RealVector\></dt>
<dd><br/>Default: utility::vector1<double>()<br/></dd>
<dt><b>-sep_dist</b> \<RealVector\></dt>
<dd><br/>Default: utility::vector1<double>()<br/></dd>
<dt><b>-weight_by_energy</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-max_rmsd</b> \<Real\></dt>
<dd>skip structure if refined rms to input is higher than this<br/>Default: 0.5<br/></dd>
<dt><b>-max_res</b> \<Integer\></dt>
<dd>max res in biounit (or whatever) for harvest<br/>Default: 1000<br/></dd>
<dt><b>-agg_with_max</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-multiplier</b> \<Real\></dt>
<dd><br/>Default: 1.0<br/></dd>
</dl>
+ <h3>-mh:match</h3>
<dl>
<dt><b>-match</b> \<Boolean\></dt>
<dd>match option group<br/></dd>
<dt><b>-interface_only</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-ss</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-ss1</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-ss2</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-aa</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-aa1</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-aa2</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
</dl>
+ <h3>-mh:dump</h3>
<dl>
<dt><b>-dump</b> \<Boolean\></dt>
<dd>dump option group<br/></dd>
<dt><b>-limit_per_pair</b> \<Integer\></dt>
<dd><br/>Default: 999999<br/></dd>
<dt><b>-max_per_res</b> \<Integer\></dt>
<dd><br/>Default: 30<br/></dd>
<dt><b>-max_ca_dis</b> \<Real\></dt>
<dd><br/>Default: 12.0<br/></dd>
<dt><b>-max_rms</b> \<Real\></dt>
<dd><br/>Default: 0.5<br/></dd>
<dt><b>-resfile_min_pair_score</b> \<Real\></dt>
<dd><br/>Default: 0.00<br/></dd>
<dt><b>-resfile_min_tot_score</b> \<Real\></dt>
<dd><br/>Default: 0.00<br/></dd>
<dt><b>-resfile_dump</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-symmetric_motifs</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
</dl>
+ <h3>-mh:filter</h3>
<dl>
<dt><b>-filter</b> \<Boolean\></dt>
<dd>filter option group<br/></dd>
<dt><b>-filter_harvest</b> \<Boolean\></dt>
<dd>filter while harvesting<br/>Default: false<br/></dd>
<dt><b>-filter_io</b> \<Boolean\></dt>
<dd>filter while reading filter<br/>Default: true<br/></dd>
<dt><b>-pdb</b> \<String\></dt>
<dd>4/5 letter pdb code<br/></dd>
<dt><b>-lig</b> \<String\></dt>
<dd>3 letter lig code<br/></dd>
<dt><b>-motif_type</b> \<String\></dt>
<dd>bb pb sc pp<br/></dd>
<dt><b>-restype1</b> \<String\></dt>
<dd>allowed res types for res1<br/>Default: "ACDEFGHIKLMNPQRSTVWY"<br/></dd>
<dt><b>-restype2</b> \<String\></dt>
<dd>allowed res types for res2<br/>Default: "ACDEFGHIKLMNPQRSTVWY"<br/></dd>
<dt><b>-restype</b> \<String\></dt>
<dd>allowed res types<br/>Default: "ACDEFGHIKLMNPQRSTVWY"<br/></dd>
<dt><b>-restype_one</b> \<String\></dt>
<dd>allowed res types need at least one<br/>Default: "ACDEFGHIKLMNPQRSTVWY"<br/></dd>
<dt><b>-not_restype</b> \<String\></dt>
<dd>disallowed res types<br/>Default: "ACGP"<br/></dd>
<dt><b>-not_restype_one</b> \<String\></dt>
<dd>disallowed res types at least one not<br/>Default: "ACGP"<br/></dd>
<dt><b>-seqsep</b> \<Integer\></dt>
<dd>min filter seqsep<br/>Default: 0<br/></dd>
<dt><b>-max_seqsep</b> \<Integer\></dt>
<dd>min filter seqsep<br/>Default: 99999<br/></dd>
<dt><b>-no_hb_bb</b> \<Boolean\></dt>
<dd>no bb hbonded<br/>Default: false<br/></dd>
<dt><b>-mindist2</b> \<Real\></dt>
<dd>min CA-CA dist sq<br/>Default: 0.0<br/></dd>
<dt><b>-maxdist2</b> \<Real\></dt>
<dd>max CA-CA dist sq<br/>Default: 999999.0<br/></dd>
<dt><b>-ss1</b> \<String\></dt>
<dd>filter ss1<br/>Default: ""<br/></dd>
<dt><b>-ss2</b> \<String\></dt>
<dd>filter ss2<br/>Default: ""<br/></dd>
<dt><b>-dssp1</b> \<String\></dt>
<dd>filter dssp1<br/>Default: ""<br/></dd>
<dt><b>-dssp2</b> \<String\></dt>
<dd>filter dssp2<br/>Default: ""<br/></dd>
<dt><b>-aa1</b> \<String\></dt>
<dd>filter aa1<br/>Default: ""<br/></dd>
<dt><b>-aa2</b> \<String\></dt>
<dd>filter aa2<br/>Default: ""<br/></dd>
<dt><b>-sasa</b> \<Real\></dt>
<dd>filter max sasa<br/>Default: 999.0<br/></dd>
<dt><b>-faatr</b> \<Real\></dt>
<dd>filter max faatr (default 999.0 = no filtering<br/>Default: 999.0<br/></dd>
<dt><b>-hb_sc</b> \<Real\></dt>
<dd>filter max hb_sc (default 999.0 = no filtering<br/>Default: 999.0<br/></dd>
<dt><b>-hb_bb_sc</b> \<Real\></dt>
<dd>filter max hb_bb_sc (default 999.0 = no filtering<br/>Default: 999.0<br/></dd>
<dt><b>-hb_bb</b> \<Real\></dt>
<dd>filter max hb_bb (default 999.0 = no filtering<br/>Default: 999.0<br/></dd>
<dt><b>-occupancy</b> \<Real\></dt>
<dd>filter min occupancy (default 0.0 = no filtering<br/>Default: 0.0<br/></dd>
<dt><b>-coorderr</b> \<Real\></dt>
<dd>filter max bfac coorderr = sqrt(B/8*pi**2)) (default 999.0 = no filtering<br/>Default: 999.0<br/></dd>
<dt><b>-uniformfrag</b> \<Boolean\></dt>
<dd>is frag and all same ss in frag<br/>Default: false<br/></dd>
<dt><b>-faatr_or_hbbb</b> \<Real\></dt>
<dd>filter require atr or hb (bb allowed) below thresh<br/>Default: 999.0<br/></dd>
<dt><b>-faatr_or_hb</b> \<Real\></dt>
<dd>filter require atr or hb below thresh<br/>Default: 999.0<br/></dd>
<dt><b>-noloops</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-oneloop</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-nodisulf</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-score</b> \<Real\></dt>
<dd>filter on ResPairMotir::score()<br/>Default: 999.0<br/></dd>
</dl>
+ <h2>-magnesium</h2>
<dl>
<dt><b>-magnesium</b> \<Boolean\></dt>
<dd>magnesium option group<br/></dd>
<dt><b>-scan</b> \<Boolean\></dt>
<dd>default mode: scan Mg(2+) through PDB<br/>Default: true<br/></dd>
<dt><b>-mg_res</b> \<IntegerVector\></dt>
<dd>supply PDB residue numbers of Mg(2+) to look at [leave blank to scan a new Mg(2+)]<br/></dd>
<dt><b>-minimize_during_scoring</b> \<Boolean\></dt>
<dd>minimize mg(2+) during scoring/hydration of each position<br/>Default: true<br/></dd>
<dt><b>-ligand_res</b> \<ResidueChainVector\></dt>
<dd>in scan, look at positions near these residues (PDB numbering/chains)<br/></dd>
<dt><b>-pose_ligand_res</b> \<IntegerVector\></dt>
<dd>in scan, look at positions near these residues, pose numbering (1,2,..)<br/></dd>
<dt><b>-lores_scan</b> \<Boolean\></dt>
<dd>do not try hydration or minimization during scan<br/>Default: false<br/></dd>
<dt><b>-xyz_step</b> \<Real\></dt>
<dd>increment in Angstroms for xyz scan<br/>Default: 0.50<br/></dd>
<dt><b>-score_cut</b> \<Real\></dt>
<dd>score cut for silent output (5.0 for hires; -8.0 for lores)<br/>Default: 5.0<br/></dd>
<dt><b>-score_cut_PDB</b> \<Real\></dt>
<dd>score cut for PDB output from scanning (deprecated)<br/>Default: 0.0<br/></dd>
<dt><b>-integration_test</b> \<Boolean\></dt>
<dd>Stop after first mg position found -- for testing<br/>Default: false<br/></dd>
<dt><b>-tether_to_closest_res</b> \<Boolean\></dt>
<dd>stay near closest ligand res; helps force unique grid sampling in different cluster jobs.<br/>Default: false<br/></dd>
<dt><b>-fixup</b> \<Boolean\></dt>
<dd>test mode: align the 6 octahedral virtual 'orbitals' for specified mg_res<br/>Default: false<br/></dd>
<dt><b>-pack_water_hydrogens</b> \<Boolean\></dt>
<dd>test mode: strip out non-mg waters, align mg frames, pack mg waters for specified mg_res<br/>Default: false<br/></dd>
<dt><b>-hydrate</b> \<Boolean\></dt>
<dd>test mode: strip out waters and hydrate mg(2+) for specified mg_res<br/>Default: false<br/></dd>
<dt><b>-monte_carlo</b> \<Boolean\></dt>
<dd>test mode: monte carlo sampling of Mg(2+) and surrounding waters<br/>Default: false<br/></dd>
<dt><b>-scored_hydrogen_sampling</b> \<Boolean\></dt>
<dd>in -pack_water_hydrogens test mode, when packing water hydrogens, use a complete scorefunction to rank (slow)<br/>Default: false<br/></dd>
<dt><b>-all_hydration_frames</b> \<Boolean\></dt>
<dd>in -hydration test mode, Sample all hydration frames (slow)<br/>Default: false<br/></dd>
<dt><b>-leave_other_waters</b> \<Boolean\></dt>
<dd>in -hydration test mode, do not remove all waters<br/>Default: false<br/></dd>
<dt><b>-minimize</b> \<Boolean\></dt>
<dd>minimize Mg(2+) after hydration or hydrogen-packing<br/>Default: false<br/></dd>
<dt><b>-minimize_mg_coord_constraint_distance</b> \<Real\></dt>
<dd>harmonic tether to Mg(2+) during minimize<br/>Default: 0.2<br/></dd>
</dl>
+ <h3>-magnesium:montecarlo</h3>
<dl>
<dt><b>-montecarlo</b> \<Boolean\></dt>
<dd>montecarlo option group<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>temperature for Monte Carlo<br/>Default: 1.0<br/></dd>
<dt><b>-cycles</b> \<Integer\></dt>
<dd>Monte Carlo cycles<br/>Default: 100000<br/></dd>
<dt><b>-dump</b> \<Boolean\></dt>
<dd>dump PDBs from Mg monte carlo<br/>Default: false<br/></dd>
<dt><b>-add_delete_frequency</b> \<Real\></dt>
<dd>add_delete_frequency for Monte Carlo<br/>Default: 0.1<br/></dd>
</dl>
+ <h2>-motifs</h2>
<dl>
<dt><b>-motifs</b> \<Boolean\></dt>
<dd>motifs option group<br/></dd>
<dt><b>-close_enough</b> \<Real\></dt>
<dd>4-atom rmsd cutoff beyond which you don't bother trying an inverse rotamer<br/>Default: 1.0<br/></dd>
<dt><b>-max_depth</b> \<Integer\></dt>
<dd>Maximum recursion depth - i.e., maximum number of motifs to incorporate<br/>Default: 1<br/></dd>
<dt><b>-keep_motif_xtal_location</b> \<Boolean\></dt>
<dd>used to dna_motif_collector - controls whether motifs are moved away from original PDB location (comparison is easier if they are moved, so that's default)<br/>Default: false<br/></dd>
<dt><b>-pack_score_cutoff</b> \<Real\></dt>
<dd>used in dna_motif_collector - fa_atr + fa_rep energy threshold for a two-residue interaction to determine if it is a motif<br/>Default: -0.5<br/></dd>
<dt><b>-hb_score_cutoff</b> \<Real\></dt>
<dd>used in dna_motif_collector - hbond_sc energy threshold for a two-residue interaction to determine if it is a motif<br/>Default: -0.3<br/></dd>
<dt><b>-water_score_cutoff</b> \<Real\></dt>
<dd>used in dna_motif_collector - h2o_hbond energy threshold for a two-residue interaction to determine if it is a motif<br/>Default: -0.3<br/></dd>
<dt><b>-pack_min_threshold</b> \<Real\></dt>
<dd>Used for motif extraction - packing scores below this value will cause a motif to be discarded<br/>Default: -9999.0<br/></dd>
<dt><b>-pack_max_threshold</b> \<Real\></dt>
<dd>Used for motif extraction - packing scores above this value will cause a motif to be discarded<br/>Default: 9999.0<br/></dd>
<dt><b>-hbond_min_threshold</b> \<Real\></dt>
<dd>Used for motif extraction - hbond scores below this value will cause a motif to be discarded<br/>Default: -9999.0<br/></dd>
<dt><b>-hbond_max_threshold</b> \<Real\></dt>
<dd>Used for motif extraction - hbond scores above this value will cause a motif to be discarded<br/>Default: 9999.0<br/></dd>
<dt><b>-elec_min_threshold</b> \<Real\></dt>
<dd>Used for motif extraction - fa_elec scores below this value will cause a motif to be discarded<br/>Default: -9999.0<br/></dd>
<dt><b>-elec_max_threshold</b> \<Real\></dt>
<dd>Used for motif extraction - fa_elec scores above this value will cause a motif to be discarded<br/>Default: 9999.0<br/></dd>
<dt><b>-duplicate_dist_cutoff</b> \<Real\></dt>
<dd>Value for determining whether a motif is different from others already in a library<br/>Default: 1.0<br/></dd>
<dt><b>-duplicate_angle_cutoff</b> \<Real\></dt>
<dd>Value for determining whether a motif is different from others already in a library<br/>Default: 0.4<br/></dd>
<dt><b>-motif_output_directory</b> \<String\></dt>
<dd>used in dna_motif_collector - path for the directory where all the collected motifs are dumped as 2-residue pdbs<br/></dd>
<dt><b>-eliminate_weak_motifs</b> \<Boolean\></dt>
<dd>used to dna_motif_collector - controls whether only the top 1-2 motifs are counted for every protein position in a protein-DNA interface<br/>Default: true<br/></dd>
<dt><b>-duplicate_motif_cutoff</b> \<Real\></dt>
<dd>used in dna_motif_collector - RMSD cutoff for an identical base placed via a motif to see if that motif already exists in a motif library<br/>Default: 0.2<br/></dd>
<dt><b>-preminimize_motif_pdbs</b> \<Boolean\></dt>
<dd>used to dna_motif_collector - controls whether the input PDB structure sidechains and bb are minimized before motifs are collected<br/>Default: false<br/></dd>
<dt><b>-preminimize_motif_pdbs_sconly</b> \<Boolean\></dt>
<dd>used to dna_motif_collector - controls whether the input PDB structure sidechains are minimized before motifs are collected<br/>Default: false<br/></dd>
<dt><b>-place_adduct_waters</b> \<Boolean\></dt>
<dd>used to dna_motif_collector - whether or not adduct waters are placed before motifs are collected, there will be no water interaction calculated if this is false<br/>Default: true<br/></dd>
<dt><b>-list_motifs</b> \<FileVector\></dt>
<dd>File(s) containing list(s) of PDB files to process<br/></dd>
<dt><b>-motif_filename</b> \<String\></dt>
<dd>File containing motifs<br/></dd>
<dt><b>-file_prefix</b> \<String\></dt>
<dd>File containing motifs<br/>Default: "motif"<br/></dd>
<dt><b>-build_residue_file</b> \<String\></dt>
<dd>File containing the target positions for building and incorporating motifs<br/></dd>
<dt><b>-motif_flexible_loop_file</b> \<String\></dt>
<dd>File containing the flexible loop definition<br/></dd>
<dt><b>-residue_trim_file</b> \<String\></dt>
<dd>File a list of residues to trim to Ala before motif incorporation.<br/></dd>
<dt><b>-BPData</b> \<String\></dt>
<dd>File containing BuildPosition specific motifs and/or rotamers<br/></dd>
<dt><b>-list_dnaconformers</b> \<FileVector\></dt>
<dd>File(s) containing list(s) of PDB files to process<br/></dd>
<dt><b>-target_dna_defs</b> \<StringVector\></dt>
<dd><br/>Default: ""<br/></dd>
<dt><b>-motif_build_defs</b> \<StringVector\></dt>
<dd><br/>Default: ""<br/></dd>
<dt><b>-motif_build_positions</b> \<IntegerVector\></dt>
<dd><br/></dd>
<dt><b>-r1</b> \<Real\></dt>
<dd>RMSD cutoff between motif anchor position and motif target position for allowing a particular motif rotamer to continue on to expand with DNA conformers<br/>Range: 0-<br/>Default: 4.5<br/></dd>
<dt><b>-r2</b> \<Real\></dt>
<dd>RMSD cutoff between motif anchor position and motif target position for accepting the motif<br/>Range: 0-<br/>Default: 1.1<br/></dd>
<dt><b>-z1</b> \<Real\></dt>
<dd>DNA motif specific: cutoff between motif target DNA position and standardized base for allowing a particular motif to continue on to expand with DNA conformers<br/>Range: 0-<br/>Default: 0.75<br/></dd>
<dt><b>-z2</b> \<Real\></dt>
<dd>DNA motif specific: cutoff between motif target DNA position and DNA conformer placed according to motif for accepting the pair of residues<br/>Range: 0-<br/>Default: 0.95<br/></dd>
<dt><b>-dtest</b> \<Real\></dt>
<dd>DNA motif specific: cutoff between motif target DNA position and DNA conformer placed according to motif for accepting the pair of residues<br/>Range: 0-<br/>Default: 5.5<br/></dd>
<dt><b>-rotlevel</b> \<Integer\></dt>
<dd>level of rotamer sampling for motif search<br/>Range: 1-<br/>Default: 5<br/></dd>
<dt><b>-num_repacks</b> \<Integer\></dt>
<dd>number of cycles of dropping special_rot weight and design<br/>Range: 0-<br/>Default: 5<br/></dd>
<dt><b>-minimize</b> \<Boolean\></dt>
<dd>whether or not to minimize the motifs toward the xtal structure DNA<br/>Default: true<br/></dd>
<dt><b>-minimize_dna</b> \<Boolean\></dt>
<dd>whether or not to minimize DNA after every round of design with special_rot weight dropping<br/>Default: true<br/></dd>
<dt><b>-run_motifs</b> \<Boolean\></dt>
<dd>whether or not to use motifs in DnaPackerMotif<br/>Default: true<br/></dd>
<dt><b>-expand_motifs</b> \<Boolean\></dt>
<dd>whether or not to use expand (use all types) motifs in DnaPackerMotif<br/>Default: true<br/></dd>
<dt><b>-aromatic_motifs</b> \<Boolean\></dt>
<dd>whether or not to use expand (use aromatic only types) motifs in DnaPackerMotif<br/>Default: true<br/></dd>
<dt><b>-dump_motifs</b> \<Boolean\></dt>
<dd>whether or not to output pdbs with the best rotamer/conformer for each motifs<br/>Default: true<br/></dd>
<dt><b>-quick_and_dirty</b> \<Boolean\></dt>
<dd>quick motif run to get a list of all possible motifs before doing a real run<br/>Default: true<br/></dd>
<dt><b>-special_rotweight</b> \<Real\></dt>
<dd>starting weight for the weight on motif rotamers<br/>Default: -40.0<br/></dd>
<dt><b>-output_file</b> \<String\></dt>
<dd>name of output file for all the best motifs and rotamers or for the dna_motif_collector it is the file where all the motifs are dumped<br/></dd>
<dt><b>-data_file</b> \<String\></dt>
<dd>name of output file for any data about how many rotamers and motifs pass what tests, etc<br/></dd>
<dt><b>-target_aa</b> \<String\></dt>
<dd>three letter code for the target amino acid for finding motifs<br/>Default: "LEU"<br/></dd>
<dt><b>-flex_sugar</b> \<Boolean\></dt>
<dd>whether or not to add the flexible sugar, not using PB way of adding options<br/>Default: true<br/></dd>
<dt><b>-clear_bprots</b> \<Boolean\></dt>
<dd>whether or not to clear the rotamers that were read in from a previous run and restart with only the motifs that were read in and the specified rotlevel<br/>Default: true<br/></dd>
<dt><b>-rots2add</b> \<Integer\></dt>
<dd>number of rotamers to add to design from the MotifSearch for each amino acid type<br/>Range: 1-<br/>Default: 100<br/></dd>
<dt><b>-restrict_to_wt</b> \<Boolean\></dt>
<dd>restrict the motif search to finding motifs of the same amino acid as the starting pose, for homology modeling<br/>Default: true<br/></dd>
<dt><b>-rerun_motifsearch</b> \<Boolean\></dt>
<dd>setting the MotifSearch to run again, using the rotamers in the build position, most likely to change stringency or amino acid type on a second run<br/>Default: true<br/></dd>
<dt><b>-no_rotamer_bump</b> \<Boolean\></dt>
<dd>skip the bump check when making the rotamers that will be tested for motif interactions, makes code much slower, but it is advised to increase the max_rotbump_energy to at least 10.0 instead of the default of 5.0 if bump_check is being used<br/>Default: false<br/></dd>
<dt><b>-ligand_motif_sphere</b> \<Real\></dt>
<dd>option to specify radius of motif search around ligand<br/>Default: 6.0<br/></dd>
</dl>
+ <h2>-ms</h2>
<dl>
<dt><b>-ms</b> \<Boolean\></dt>
<dd>ms option group<br/></dd>
<dt><b>-pop_from_ss</b> \<Integer\></dt>
<dd>generate starting sequence population based on single-state design results<br/>Default: 0<br/></dd>
<dt><b>-pop_size</b> \<Integer\></dt>
<dd>genetic algorithm population size<br/>Default: 100<br/></dd>
<dt><b>-generations</b> \<Integer\></dt>
<dd>number of genetic algorithm generations<br/>Default: 20<br/></dd>
<dt><b>-num_packs</b> \<Integer\></dt>
<dd>number of repack trials per sequence/state combination<br/>Default: 1<br/></dd>
<dt><b>-numresults</b> \<Integer\></dt>
<dd>number of top-fitness results to save for explicit reference at the end of multistate design<br/>Default: 1<br/></dd>
<dt><b>-anchor_offset</b> \<Real\></dt>
<dd>energy offset from the energy of single-state design toward the target state -- used to generate an affinity anchor for fitness calculations<br/>Default: 5.0<br/></dd>
<dt><b>-Boltz_temp</b> \<Real\></dt>
<dd>thermodynamic temperature to use for specificity calculations<br/>Default: 0.6<br/></dd>
<dt><b>-mutate_rate</b> \<Real\></dt>
<dd>rate of mutation per position<br/>Default: 0.5<br/></dd>
<dt><b>-fraction_by_recombination</b> \<Real\></dt>
<dd>fraction of the population that should be generated by recombination during the evolution stage<br/>Default: 0.5<br/></dd>
</dl>
+ <h3>-ms:checkpoint</h3>
<dl>
<dt><b>-checkpoint</b> \<Boolean\></dt>
<dd>checkpoint option group<br/></dd>
<dt><b>-prefix</b> \<String\></dt>
<dd>prefix to add to the beginning of checkpoint file names<br/>Default: ""<br/></dd>
<dt><b>-interval</b> \<Integer\></dt>
<dd>frequency with which the entity checkpoint is written<br/>Default: 0<br/></dd>
<dt><b>-gz</b> \<Boolean\></dt>
<dd>compress checkpoing files with gzip<br/>Default: false<br/></dd>
<dt><b>-rename</b> \<Boolean\></dt>
<dd>rename checkpoint files after genetic algorithm completes<br/>Default: false<br/></dd>
</dl>
+ <h2>-mutate</h2>
<dl>
<dt><b>-mutate</b> \<Boolean\></dt>
<dd>mutate option group<br/></dd>
<dt><b>-mutation</b> \<StringVector\></dt>
<dd>Vector of single mutations: Format: One-letter code / residue number / one-letter code. Example: A163F<br/></dd>
<dt><b>-mutant_file</b> \<String\></dt>
<dd>Input file containing mutations<br/></dd>
</dl>
+ <h2>-nmr</h2>
<dl>
<dt><b>-nmr</b> \<Boolean\></dt>
<dd>nmr option group<br/></dd>
</dl>
+ <h3>-nmr:pcs</h3>
<dl>
<dt><b>-pcs</b> \<Boolean\></dt>
<dd>pcs option group<br/></dd>
<dt><b>-input_file</b> \<File\></dt>
<dd>PCS input file.<br/></dd>
<dt><b>-nls_repeats</b> \<Integer\></dt>
<dd>Number of repeats in non-linear least squares fitting of the PCS tensor.<br/>Range: 1-100<br/>Default: 5<br/></dd>
<dt><b>-optimize_tensor</b> \<Boolean\></dt>
<dd>Optimize the lanthanide ion position and other parameters of the PCS tensor after grid search.<br/>Default: false<br/></dd>
<dt><b>-multiset_weights</b> \<RealVector\></dt>
<dd>Vector of weights of PCSMultiSets. One PCSMultiSet refers to data collected for multiple lanthanides at one tagging site.<br/></dd>
<dt><b>-normalize_data</b> \<Boolean\></dt>
<dd>Normalize PCS data of every experiment by their standard deviation.<br/>Default: false<br/></dd>
<dt><b>-use_symmetry_calc</b> \<Boolean\></dt>
<dd>Consider the contribution from symmetric subunits for PCS calculation. Only the PCSs of the asymmetric subunit must to be provided as input. The symmetric residues are deduced from the symmetry information carried by the pose. Alternatively, one can provide all residues contributing to one PCS as an ambiguous atom selection in the input file.<br/>Default: false<br/></dd>
<dt><b>-show_info</b> \<Boolean\></dt>
<dd>Show additional information about PCS calculation (experimental vs. back-calculated PCSs and PCS tensor summary) at the end of every ab-initio folding stage.<br/>Default: false<br/></dd>
</dl>
+ <h3>-nmr:rdc</h3>
<dl>
<dt><b>-rdc</b> \<Boolean\></dt>
<dd>rdc option group<br/></dd>
<dt><b>-input_file</b> \<File\></dt>
<dd>RDC input file.<br/></dd>
<dt><b>-nls_repeats</b> \<Integer\></dt>
<dd>Number of repeats in non-linear least squares fitting of the alignment tensor.<br/>Range: 1-100<br/>Default: 5<br/></dd>
<dt><b>-multiset_weights</b> \<RealVector\></dt>
<dd>Vector of weights of RDCMultiSets. One RDCMultiSet refers data collected for multiple experiments in one alignment medium.<br/></dd>
<dt><b>-use_symmetry_calc</b> \<Boolean\></dt>
<dd>Consider the contribution from symmetric subunits for RDC calculation. Only RDCs of the asymmetric subunit must be provided as input. The symmetric residues are deduced from the symmetry information carried by the pose. This option is still experimental and works so far for cases with C-symmetry and D2-symmetry for which the alignment tensor axes coincide with the symmetry axes.<br/>Default: false<br/></dd>
<dt><b>-show_info</b> \<Boolean\></dt>
<dd>Show additional information about RDC calculation (experimental vs. back-calculated RDCs and alignment tensor summary) at the end of every ab-initio folding stage.<br/>Default: false<br/></dd>
<dt><b>-normalization_type</b> \<String\></dt>
<dd>Apply scaling of input RDC values. Possible options are NH, CH or none. By default RDCs are expected not to be normalized and will be scaled relative to N-H (i.e. option NH). In case of option CH RDCs will be scaled relative to CA-HA. If option none is chosen it is assumed that RDC values have been normalized to H-N before and thus no additional scaling will be applied.<br/>Default: "NH"<br/></dd>
<dt><b>-correct_sign</b> \<Boolean\></dt>
<dd>Use the correct sign of the 15N gyromagnetic ratio and thus of the dipolar coupling constants i.e. positive for NC and NH and negative for CH. Use this option if input couplings have different signs. By default the 15N gyromagnetic ratio is taken to be positive and the dipolar coupling constants to have the same sign.<br/>Default: false<br/></dd>
</dl>
+ <h3>-nmr:pre</h3>
<dl>
<dt><b>-pre</b> \<Boolean\></dt>
<dd>pre option group<br/></dd>
<dt><b>-input_file</b> \<File\></dt>
<dd>PRE input file.<br/></dd>
<dt><b>-nls_repeats</b> \<Integer\></dt>
<dd>Number of repeats in non-linear least squares fitting of the spinlabel correlation time.<br/>Range: 1-100<br/>Default: 3<br/></dd>
<dt><b>-optimize_para_ion_position</b> \<Boolean\></dt>
<dd>Optimize the position of the paramagnetic ion. Only in combination with a gridsearch.<br/>Default: false<br/></dd>
<dt><b>-multiset_weights</b> \<RealVector\></dt>
<dd>Vector of weights of PREMultiSets. One PREMultiSet refers to multiple datasets collected for the same spinlabel site.<br/></dd>
<dt><b>-normalize_data</b> \<Boolean\></dt>
<dd>Normalize PRE data of every experiment by their standard deviation.<br/>Default: false<br/></dd>
<dt><b>-use_symmetry_calc</b> \<Boolean\></dt>
<dd>Consider the contribution from symmetric subunits for PRE calculation. Only the PREs of the asymmetric subunit must be provided as input. The symmetric residues are deduced from the symmetry information carried by the pose. Alternatively, one can provide all residues contributing to one PRE as an ambiguous atom selection in the input file.<br/>Default: false<br/></dd>
<dt><b>-show_info</b> \<Boolean\></dt>
<dd>Show additional information about PRE calculation (experimental vs. back-calculated PREs and PRE spinlabel summary) at the end of every ab-initio folding stage.<br/>Default: false<br/></dd>
</dl>
+ <h3>-nmr:spinlabel</h3>
<dl>
<dt><b>-spinlabel</b> \<Boolean\></dt>
<dd>spinlabel option group<br/></dd>
<dt><b>-max_ensemble_size</b> \<Integer\></dt>
<dd>Maximum number of spinlabel rotamers that make up the ensemble. If the ensemble size is higher, rotamers are binned to speed up the calculation.<br/>Default: 20<br/></dd>
<dt><b>-highres_conformer_filter_type</b> \<String\></dt>
<dd>Type of filtering spinlabel conformers in Rosetta full-atom mode. Possible modes are: DISTANCE and BUMP_ENERGY. Default is BUMP_ENERGY in which case conformers are checked for clashes by their packer energy. The DISTANCE filter detects clashes by measuring the distance of spin-label side-chain heavy atoms to the NBR_ATOM of neighborhood residues.<br/>Default: "BUMP_ENERGY"<br/></dd>
<dt><b>-elaborate_rotamer_clash_check</b> \<Boolean\></dt>
<dd>If true, perform an elaborate clash check of every heavy atom of all spinlabel rotamers with the atoms in the surrounding amino acid residues. If all rotamers produce at least one clash, return that rotamer with the lowest number of clashes. If false, consider only heavy atoms in non-clashing rotamers and return a random member in case their are no non-clashing rotamers.<br/>Default: false<br/></dd>
<dt><b>-boltzmann_kt</b> \<Real\></dt>
<dd>Scaling factor for Boltzmann weighting of the spinlabel rotamer probabilities.<br/>Default: 2.0<br/></dd>
</dl>
+ <h3>-nmr:score</h3>
<dl>
<dt><b>-score</b> \<Boolean\></dt>
<dd>score option group<br/></dd>
<dt><b>-verbose</b> \<Boolean\></dt>
<dd>Write separate score values and Q-factors for each spinlabel site, alignment medium and/or lanthanide ion to the scorefile.<br/>Default: false<br/></dd>
<dt><b>-output_exp_calc</b> \<Boolean\></dt>
<dd>Write a table of experimental vs. calculated NMR values for each NMR dataset to prediction file.<br/>Default: false<br/></dd>
<dt><b>-output_tensor_info</b> \<Boolean\></dt>
<dd>Write tensor and/or spinlabel info for each NMR dataset to info file.<br/>Default: false<br/></dd>
</dl>
+ <h2>-nonlocal</h2>
<dl>
<dt><b>-nonlocal</b> \<Boolean\></dt>
<dd>nonlocal option group<br/></dd>
<dt><b>-chunks</b> \<File\></dt>
<dd>Decsribes how the structure is partitioned into chunks. Each residue must be present in 1 and only 1 chunk. Loop file format.<br/></dd>
<dt><b>-randomize_missing</b> \<Boolean\></dt>
<dd>Randomize the coordinates of missing loops. This occurs often in broken-chain folding from a sequence alignment and template pdb. Default value is false to preserve existing behavior in ThreadingJobInputter<br/>Default: false<br/></dd>
</dl>
+ <h2>-optE</h2>
<dl>
<dt><b>-optE</b> \<Boolean\></dt>
<dd>optE option group<br/></dd>
<dt><b>-load_from_silent</b> \<String\></dt>
<dd>load from silent instead of pdb - uses path of requested pdb to find silent file, each PDB needs to have all of its structures in its own folder (ie: 1agy/pdb_set.silent) - only works in optimize_decoy_discrimination<br/>Default: "pdb_set.silent"<br/></dd>
<dt><b>-data_in</b> \<String\></dt>
<dd>file from which to read in optE data<br/>Default: "optE.data"<br/></dd>
<dt><b>-data_out</b> \<String\></dt>
<dd>file to which to write optE data<br/>Default: "optE.data.out"<br/></dd>
<dt><b>-weights</b> \<String\></dt>
<dd>a conventional weightfile that optE will use to determine which weights will be counted.  All non-zero weights in the file will contribute to rotamer energies and be fit; use the -optE::fix option to fix any of these weights.  Weight values will also be used as starting values for optimization.<br/></dd>
<dt><b>-fix</b> \<StringVector\></dt>
<dd>weights to be fixed (must also appear in the weightfile given by the -optE::weights option)<br/></dd>
<dt><b>-free</b> \<File\></dt>
<dd>IterativeOptEDriver flag: specify a file to read score types that are free -- optionally include a starting weight for each score type<br/></dd>
<dt><b>-fixed</b> \<File\></dt>
<dd>IterativeOptEDriver flag: specify a file to read score types and weights for score types that are on but fixed<br/></dd>
<dt><b>-parse_tagfile</b> \<File\></dt>
<dd>a file in utility::tag format that optE may parse to customize its operation<br/></dd>
<dt><b>-constant_logic_taskops_file</b> \<File\></dt>
<dd>a file in utility::tag format that optE uses to build a task that will not change with the context of the pose after design<br/></dd>
<dt><b>-optE_soft_rep</b> \<Boolean\></dt>
<dd>Instruct the IterativeOptEDriver to use the soft-repulsion etable<br/></dd>
<dt><b>-no_hb_env_dependence</b> \<Boolean\></dt>
<dd>Disable environmental dependent weighting of hydrogen bond terms<br/></dd>
<dt><b>-no_hb_env_dependence_DNA</b> \<Boolean\></dt>
<dd>Disable environmental dependent weighting of hydrogen bonds involving DNA<br/></dd>
<dt><b>-optE_no_protein_fa_elec</b> \<Boolean\></dt>
<dd>Instruct the IterativeOptEDriver to use the soft-repulsion etable<br/>Default: false<br/></dd>
<dt><b>-include_intra_res_protein</b> \<Boolean\></dt>
<dd>Instruct the IterativeOptEDriver to turn on intra-residue interactions (needed for BetaNov15 score function)<br/>Default: false<br/></dd>
<dt><b>-centroid_rot</b> \<Boolean\></dt>
<dd>Use CENTROID_ROT vdw radii<br/>Default: false<br/></dd>
<dt><b>-centroid_rot_min</b> \<Boolean\></dt>
<dd>Use CENTROID_ROT_MIN vdw radii<br/>Default: false<br/></dd>
<dt><b>-design_first</b> \<Boolean\></dt>
<dd>Do not optimize the weights in the context of the native structure, but rather, start by designing the protein with the input weight set.  Requires that all score types listed in -optE::free have specificed weights.<br/></dd>
<dt><b>-n_design_cycles</b> \<Integer\></dt>
<dd>The number of outer-loop design cycles to complete; default of 10 after which convergence has usually occurred<br/>Default: 10<br/></dd>
<dt><b>-recover_nat_rot</b> \<Boolean\></dt>
<dd>With the iterative optE driver, repack to recover the native rotamers<br/></dd>
<dt><b>-component_weights</b> \<File\></dt>
<dd>With the iterative optE driver, weight the individual components according to the input file -- default weight of 1 for all components.  Weight file consists of component-name/weight pairs on separate lines: e.g. prob_native_structure 100.0<br/></dd>
<dt><b>-optimize_nat_aa</b> \<Boolean\></dt>
<dd>With the iterative optE driver, optimize weights to maximize the probability of the native rotamer<br/></dd>
<dt><b>-optimize_nat_rot</b> \<Boolean\></dt>
<dd>With the iterative optE driver, optimize weights to maximize the probability of the native rotamer in the native context<br/></dd>
<dt><b>-optimize_ligand_rot</b> \<File\></dt>
<dd>With the iterative optE driver, optimize weights to maximize the probability of the native rotamer around the ligand<br/></dd>
<dt><b>-optimize_pssm</b> \<Boolean\></dt>
<dd>With the iterative optE driver, optimize weights to maximize the match between a BLAST generated pssm probabillity distribution<br/></dd>
<dt><b>-optimize_dGbinding</b> \<File\></dt>
<dd>With the iterative optE driver, optimize weights to minimize squared error between the predicted dG of binding and the experimental dG; provide a file listing 1. bound PDB structure, 2. unbound PDB structure, and 3. measured dG<br/></dd>
<dt><b>-optimize_ddG_bind_correlation</b> \<File\></dt>
<dd>With the iterative optE driver, optimize weights to minimize squared error between the predicted ddG of binding for a mutation to the experimental ddG; provide a file listing 1. list file containing wt complexes, 2. list file containing mut complexes, 3. list file containing wt unbounds structures, 4. list file containing mut unbounds structures, and 5. measured ddG of binding<br/></dd>
<dt><b>-optimize_ddGmutation</b> \<File\></dt>
<dd>With the iterative optE driver, optimize weights to minimize the predicted ddG of mutation and the measured ddG; provide a file listing 1. repacked wt pdb list, 2. repacked mut pdb list, and 3. measured ddG triples<br/></dd>
<dt><b>-optimize_ddGmutation_straight_mean</b> \<Boolean\></dt>
<dd>With the iterative optE driver, predict the the ddGmut to be the difference between the straight mean (1/n Sum(E_i)) of the WT and MUT structures provided.  Requires the -optimize_ddGmutation flag be set.<br/></dd>
<dt><b>-optimize_ddGmutation_boltzman_average</b> \<Boolean\></dt>
<dd>With the iterative optE driver, predict the the ddGmut to be the difference between the boltzman average energies ( Sum( E_i * e**-E_i/kT)/Sum( e**-E_i/kT) ) of the WT and MUT structures provided.  Requires the -optimize_ddGmutation flag be set.<br/></dd>
<dt><b>-exclude_badrep_ddGs</b> \<Real\></dt>
<dd>With the iterative optE driver, consider only ddG data where the unweighted repulsive energy delta mut-wt < given value<br/></dd>
<dt><b>-pretend_no_ddG_repulsion</b> \<Boolean\></dt>
<dd>With the iterative optE driver, set all repulsive scores to zero when looking for ddG correlations<br/></dd>
<dt><b>-optimize_decoy_discrimination</b> \<File\></dt>
<dd>With the iterative optE driver, optimize weights to maximize the partition between relaxed natives and low-scoring decoys.  File is a list of file-list pairs and a single pdb file < native_pdb_list, decoy_pdb_list, crystal_native_pdb >.<br/></dd>
<dt><b>-normalize_decoy_score_spread</b> \<String\></dt>
<dd>In decoy discrimination optimization, normalize both the native and decoy energies generated by a set of weights by sigma_curr /sigma_start where sigma_start is computed as the standard deviation of the decoy energies given an input weight set<br/></dd>
<dt><b>-ramp_nativeness</b> \<Boolean\></dt>
<dd>In decoy discrimination optimization, give structures in the range between max_rms_from_native and min_decoy_rms_to_native a nativeness score (which ramps linearly from 1 to 0 in that range) and include scores from structures in the numerator of the partition.<br/></dd>
<dt><b>-n_top_natives_to_optimize</b> \<Integer\></dt>
<dd>For use with the -optimize_decoy_discrimination flag.  Objective function considers top N natives in partition function<br/>Default: 1<br/></dd>
<dt><b>-approximate_decoy_entropy</b> \<Real\></dt>
<dd>Alpha expansion of conformation space size as a function of nres: size ~ alpha ^ nres; entropy ~ nres ln alpha.<br/></dd>
<dt><b>-repack_and_minimize_decoys</b> \<Boolean\></dt>
<dd>Generate new structures in each round of iterative optE by repacking and minimizing the input decoys & natives using the weights obtained in the last round<br/></dd>
<dt><b>-repack_and_minimize_input_structures</b> \<Boolean\></dt>
<dd>Minimizing the input decoys & natives using the starting weights -- allows structures a chance to see the energy function before decoy discrimination begins without the memory overhead of the repack_and_minimize_decoys flag<br/></dd>
<dt><b>-output_top_n_new_decoys</b> \<Integer\></dt>
<dd>For use with repack_and_minimize_decoys flag: Write out the top N decoys generated each round in this iterative refinement<br/>Default: 0<br/></dd>
<dt><b>-optimize_ligand_discrimination</b> \<File\></dt>
<dd>With the iterative optE driver, optimize weights to maximize the partition between relaxed natives and low-scoring decoys.  File is a list of file-list pairs and a single pdb file < native_pdb_list, decoy_pdb_list, crystal_native_pdb >.<br/></dd>
<dt><b>-no_design</b> \<Boolean\></dt>
<dd>Don't bother loading pdbs and doing design; just optimize weights for decoy-discrim and or native rotamer recovery<br/></dd>
<dt><b>-sqrt_pssm</b> \<Boolean\></dt>
<dd>Turn the pssm probability vectors into unit vectors so that dot product is a true similarity measure<br/></dd>
<dt><b>-min_decoy_rms_to_native</b> \<Real\></dt>
<dd>For use with the optimize_decoy_discrimination flag: exclude decoys that are within a certain RMS of the native structure<br/></dd>
<dt><b>-max_rms_from_native</b> \<Real\></dt>
<dd>For use with the optimize_decoy_discrimination flag: exclude natives that are more than a certain RMS of the crystal structure.  max_rms_from_native of 1.5, min_decoy_rms_from_native 2.0 would throw out structures in the range of 1.5 and 2.0 RMS from consideration<br/></dd>
<dt><b>-optimize_starting_free_weights</b> \<Boolean\></dt>
<dd>With the iterative optE driver, try many different starting points for the minimization<br/>Default: false<br/></dd>
<dt><b>-wrap_dof_optimization</b> \<File\></dt>
<dd>Create new dofs and setup arithmetic dependencies for free dofs.<br/></dd>
<dt><b>-randomly_perturb_starting_free_weights</b> \<Real\></dt>
<dd>With the iterative optE driver, perturb the weights by +/- <input value> for those weights listed as free<br/></dd>
<dt><b>-inv_kT_natrot</b> \<Real\></dt>
<dd>1 / kT for the pNativeRotamer fitness function<br/>Default: 1<br/></dd>
<dt><b>-inv_kT_nataa</b> \<Real\></dt>
<dd>1 / kT for the pNatAA and PSSM fitness function<br/>Default: 1<br/></dd>
<dt><b>-inv_kT_natstruct</b> \<Real\></dt>
<dd>1 / kT for the pNativeStructure fitness function<br/>Default: 1<br/></dd>
<dt><b>-mpi_weight_minimization</b> \<Boolean\></dt>
<dd>Distribute OptEMultifunc func/dfunc evaluations across nodes<br/></dd>
<dt><b>-dont_use_reference_energies</b> \<Boolean\></dt>
<dd>Do not use reference energies anywhere during the protocol.<br/>Default: false<br/></dd>
<dt><b>-number_of_swarm_particles</b> \<Integer\></dt>
<dd>The number of particles to use during particle swarm weight optimization.<br/>Default: 100<br/></dd>
<dt><b>-number_of_swarm_cycles</b> \<Integer\></dt>
<dd>The number of cycles to run the swarm minimizer for.<br/>Default: 20<br/></dd>
<dt><b>-constrain_weights</b> \<File\></dt>
<dd>When minimizing the fitness objective function, also include weight constraints in the objective function<br/></dd>
<dt><b>-fit_reference_energies_to_aa_profile_recovery</b> \<Boolean\></dt>
<dd>In the inner-loop sequence recovery/weight tweaking stage, accept/reject weight sets based on both the sequence recovery rate, and the mutual information between the expected and observed amino acid frequency distributions<br/></dd>
<dt><b>-starting_refEs</b> \<File\></dt>
<dd>IterativeOptEDriver flag: specify a weights file to read reference energies from; do not optimize reference energies in the first round of weight fitting<br/></dd>
<dt><b>-repeat_swarm_optimization_until_fitness_improves</b> \<Boolean\></dt>
<dd>After the first time though the particle swarm optimization phase, if the end fitness is not better than the start fitness, recreate the swarm around the start dofs and repeat the swarm optimization.<br/>Default: false<br/></dd>
<dt><b>-design_with_minpack</b> \<Boolean\></dt>
<dd>Use the min-packer to design during the sequence recovery stages.<br/>Default: false<br/></dd>
<dt><b>-design_with_offrotpack</b> \<Boolean\></dt>
<dd>Use the off-rotamer-packer to design during the sequence recovery stages.<br/>Default: false<br/></dd>
<dt><b>-limit_bad_scores</b> \<Boolean\></dt>
<dd>Quit after 100,000 inf or NaN errors in optE objective function<br/></dd>
<dt><b>-no_design_pdb_output</b> \<Boolean\></dt>
<dd>Do not write out the designed pdbs to the workdir_ directories over the course of the optE run<br/></dd>
</dl>
+ <h3>-optE:rescore</h3>
<dl>
<dt><b>-rescore</b> \<Boolean\></dt>
<dd>rescore option group<br/></dd>
<dt><b>-weights</b> \<File\></dt>
<dd>Weight set to use when rescoring optE partition functions<br/></dd>
<dt><b>-context_round</b> \<Integer\></dt>
<dd>Integer of the context PDBs generated during design to use to measure the pNatAA<br/></dd>
<dt><b>-outlog</b> \<File\></dt>
<dd>File to which the OptEPosition data should be written<br/></dd>
<dt><b>-measure_sequence_recovery</b> \<Boolean\></dt>
<dd>When rescoring a weight set, run design with that weight set and measure the sequence recovery.<br/>Default: false<br/></dd>
</dl>
+ <h2>-packstat</h2>
<dl>
<dt><b>-packstat</b> \<Boolean\></dt>
<dd>packstat option group<br/></dd>
<dt><b>-include_water</b> \<Boolean\></dt>
<dd>Revert to old style etables<br/>Default: false<br/></dd>
<dt><b>-oversample</b> \<Integer\></dt>
<dd>Precision of SASA measurements<br/>Default: 0<br/></dd>
<dt><b>-packstat_pdb</b> \<Boolean\></dt>
<dd>Output a pdb with packing visualizations<br/>Default: false<br/></dd>
<dt><b>-surface_accessibility</b> \<Boolean\></dt>
<dd>Compute extra cavity burial information<br/>Default: false<br/></dd>
<dt><b>-residue_scores</b> \<Boolean\></dt>
<dd>Output the score for each resdiue<br/>Default: false<br/></dd>
<dt><b>-cavity_burial_probe_radius</b> \<Real\></dt>
<dd>Radius probe to consider a cavity buried<br/>Default: 1.4<br/></dd>
<dt><b>-raw_stats</b> \<Boolean\></dt>
<dd>Output the raw stats per-residue (for training, etc...)<br/>Default: false<br/></dd>
<dt><b>-threads</b> \<Integer\></dt>
<dd>Number of threads to use (0 for no threading)<br/>Default: 0<br/></dd>
<dt><b>-cluster_min_volume</b> \<Real\></dt>
<dd>voids smaller than this will not be shown.<br/>Default: 30<br/></dd>
<dt><b>-min_surface_accessibility</b> \<Real\></dt>
<dd>voids must be at least this exposed<br/>Default: -1.0<br/></dd>
<dt><b>-min_cluster_overlap</b> \<Real\></dt>
<dd>void-balls must overlap by this much to be clustered<br/>Default: 0.1<br/></dd>
<dt><b>-min_cav_ball_radius</b> \<Real\></dt>
<dd>radius of smallest void-ball to consider<br/>Default: 0.7<br/></dd>
</dl>
+ <h2>-patterson</h2>
<dl>
<dt><b>-patterson</b> \<Boolean\></dt>
<dd>patterson option group<br/></dd>
<dt><b>-weight</b> \<Real\></dt>
<dd>wt of patterson correlation<br/>Default: 0.0<br/></dd>
<dt><b>-sc_scaling</b> \<Real\></dt>
<dd>Scale sidechain density by this amount (default = same as mainchain density)<br/>Default: 1.0<br/></dd>
<dt><b>-radius_cutoffs</b> \<RealVector\></dt>
<dd>patterson-space radius cuttoffs<br/></dd>
<dt><b>-resolution_cutoffs</b> \<RealVector\></dt>
<dd>reciprocal space F^2 cuttoffs<br/></dd>
<dt><b>-Bsol</b> \<Real\></dt>
<dd>solvent B<br/>Default: 300.0<br/></dd>
<dt><b>-Fsol</b> \<Real\></dt>
<dd>solvent fraction<br/>Default: 0.95<br/></dd>
<dt><b>-model_B</b> \<Real\></dt>
<dd>B factor computing patterson CC<br/>Default: 0.0<br/></dd>
<dt><b>-rmsd</b> \<Real\></dt>
<dd>Expected RMS error for sigma-A calculation<br/>Default: 2.0<br/></dd>
<dt><b>-no_ecalc</b> \<Boolean\></dt>
<dd>Do not normalize p_o with ecalc<br/>Default: false<br/></dd>
<dt><b>-nshells</b> \<Integer\></dt>
<dd>Number of resolution shells for patterson normalization<br/>Default: 50<br/></dd>
<dt><b>-use_spline_interpolation</b> \<Boolean\></dt>
<dd>use spline interpolation for derivative evaluation? (default trilinear)<br/>Default: false<br/></dd>
<dt><b>-use_on_repack</b> \<Boolean\></dt>
<dd>SLOW - use patterson correlation on repacks (default no)<br/>Default: false<br/></dd>
<dt><b>-dont_use_symm_in_pcalc</b> \<Boolean\></dt>
<dd>perform Pcalc in P1 (default no)<br/>Default: false<br/></dd>
</dl>
+ <h2>-pb_potential</h2>
<dl>
<dt><b>-pb_potential</b> \<Boolean\></dt>
<dd>pb_potential option group<br/></dd>
<dt><b>-charged_chains</b> \<IntegerVector\></dt>
<dd>Chain numbers that carries charge in the PB calculation<br/>Default: 1<br/></dd>
<dt><b>-sidechain_only</b> \<Boolean\></dt>
<dd>Only calculate interactions to sidechain.<br/>Default: true<br/></dd>
<dt><b>-revamp_near_chain</b> \<IntegerVector\></dt>
<dd>Scale down PB interactions if near the given chain. Use chain numbers as input.<br/></dd>
<dt><b>-apbs_path</b> \<String\></dt>
<dd>Path to the APBS (Adaptive Poisson-Boltzmann Solver) executable<br/></dd>
<dt><b>-potential_cap</b> \<Real\></dt>
<dd>Cap for PB potential input<br/>Default: 20.0<br/></dd>
<dt><b>-tolerance</b> \<Real\></dt>
<dd>Tolerance in A.  When a charged atom moves byond this tolerance, the PDE is resolved.<br/>Default: 1.0<br/></dd>
<dt><b>-apbs_debug</b> \<Integer\></dt>
<dd>APBS debug level [0-6]<br/>Default: 2<br/></dd>
<dt><b>-calcenergy</b> \<Boolean\></dt>
<dd>Calculate energy?<br/>Default: false<br/></dd>
</dl>
+ <h2>-PCS</h2>
<dl>
<dt><b>-PCS</b> \<Boolean\></dt>
<dd>PCS option group<br/></dd>
<dt><b>-write_extra</b> \<File\></dt>
<dd>Write into the File PCS calc, PCS exp, PCS dev, tensor informations, AT EACH ENERGY EVALUATION. More suited for rescoring<br/></dd>
<dt><b>-normalization_id</b> \<Integer\></dt>
<dd>Normalize individual data set. The integer identify the normalization method to be used<br/></dd>
</dl>
+ <h2>-PCSTS1</h2>
<dl>
<dt><b>-PCSTS1</b> \<Boolean\></dt>
<dd>PCSTS1 option group<br/></dd>
<dt><b>-write_extra</b> \<File\></dt>
<dd>Write into the File PCS calc, PCS exp, PCS dev, tensor imformation, AT EACH ENERGY EVALUATION. More suited for rescoring<br/></dd>
<dt><b>-normalization_id</b> \<Integer\></dt>
<dd>Normalize individual data set. The integer identify the normalization method to be used<br/></dd>
</dl>
+ <h2>-PCSTS2</h2>
<dl>
<dt><b>-PCSTS2</b> \<Boolean\></dt>
<dd>PCSTS2 option group<br/></dd>
<dt><b>-write_extra</b> \<File\></dt>
<dd>Write into the File PCS calc, PCS exp, PCS dev, tensor imformation, AT EACH ENERGY EVALUATION. More suited for rescoring<br/></dd>
<dt><b>-normalization_id</b> \<Integer\></dt>
<dd>Normalize individual data set. The integer identify the normalization method to be used<br/></dd>
</dl>
+ <h2>-PCSTS3</h2>
<dl>
<dt><b>-PCSTS3</b> \<Boolean\></dt>
<dd>PCSTS3 option group<br/></dd>
<dt><b>-write_extra</b> \<File\></dt>
<dd>Write into the File PCS calc, PCS exp, PCS dev, tensor imformation, AT EACH ENERGY EVALUATION. More suited for rescoring<br/></dd>
<dt><b>-normalization_id</b> \<Integer\></dt>
<dd>Normalize individual data set. The integer identify the normalization method to be used<br/></dd>
</dl>
+ <h2>-PCSTS4</h2>
<dl>
<dt><b>-PCSTS4</b> \<Boolean\></dt>
<dd>PCSTS4 option group<br/></dd>
<dt><b>-write_extra</b> \<File\></dt>
<dd>Write into the File PCS calc, PCS exp, PCS dev, tensor imformation, AT EACH ENERGY EVALUATION. More suited for rescoring<br/></dd>
<dt><b>-normalization_id</b> \<Integer\></dt>
<dd>Normalize individual data set. The integer identify the normalization method to be used<br/></dd>
</dl>
+ <h2>-pepspec</h2>
<dl>
<dt><b>-pepspec</b> \<Boolean\></dt>
<dd>pepspec option group<br/></dd>
<dt><b>-soft_wts</b> \<String\></dt>
<dd>No description<br/>Default: "soft_rep.wts"<br/></dd>
<dt><b>-cen_wts</b> \<String\></dt>
<dd>No description<br/>Default: "cen_ghost.wts"<br/></dd>
<dt><b>-binding_score</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-no_cen</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-no_cen_rottrials</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-run_sequential</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-pep_anchor</b> \<Integer\></dt>
<dd>No description<br/></dd>
<dt><b>-pep_chain</b> \<String\></dt>
<dd>No description<br/>Default: " "<br/></dd>
<dt><b>-n_peptides</b> \<Integer\></dt>
<dd>No description<br/>Default: 8<br/></dd>
<dt><b>-n_build_loop</b> \<Integer\></dt>
<dd>No description<br/>Default: 1000<br/></dd>
<dt><b>-n_cgrelax_loop</b> \<Integer\></dt>
<dd>No description<br/>Default: 1<br/></dd>
<dt><b>-n_dock_loop</b> \<Integer\></dt>
<dd>No description<br/>Default: 4<br/></dd>
<dt><b>-interface_cutoff</b> \<Real\></dt>
<dd>No description<br/>Default: 5.0<br/></dd>
<dt><b>-use_input_bb</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-remove_input_bb</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-homol_csts</b> \<String\></dt>
<dd>No description<br/>Default: "prep.csts"<br/></dd>
<dt><b>-p_homol_csts</b> \<Real\></dt>
<dd>No description<br/>Default: 1.0<br/></dd>
<dt><b>-gen_pep_bb_sequential</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-input_seq</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-ss_type</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-upweight_interface</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-calc_sasa</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-diversify_pep_seqs</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-diversify_lvl</b> \<Integer\></dt>
<dd>No description<br/>Default: 10<br/></dd>
<dt><b>-dump_cg_bb</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-save_low_pdbs</b> \<Boolean\></dt>
<dd>No description<br/>Default: true<br/></dd>
<dt><b>-save_all_pdbs</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-no_design</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-pdb_list</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-ref_pdb_list</b> \<String\></dt>
<dd>No description<br/></dd>
<dt><b>-add_buffer_res</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-cg_res_type</b> \<String\></dt>
<dd>No description<br/>Default: "ALA"<br/></dd>
<dt><b>-native_pep_anchor</b> \<Integer\></dt>
<dd>No description<br/></dd>
<dt><b>-native_pep_chain</b> \<String\></dt>
<dd>No description<br/>Default: ""<br/></dd>
<dt><b>-native_align</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-rmsd_analysis</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-anchor_type</b> \<String\></dt>
<dd>No description<br/>Default: "ALA"<br/></dd>
<dt><b>-no_prepack_prot</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-prep_use_ref_rotamers</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-n_prepend</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-n_append</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-clash_cutoff</b> \<Real\></dt>
<dd>No description<br/>Default: 5<br/></dd>
<dt><b>-n_anchor_dock_std_devs</b> \<Real\></dt>
<dd>No description<br/>Default: 1.0<br/></dd>
<dt><b>-prep_trans_std_dev</b> \<Real\></dt>
<dd>No description<br/>Default: 0.5<br/></dd>
<dt><b>-prep_rot_std_dev</b> \<Real\></dt>
<dd>No description<br/>Default: 10.0<br/></dd>
<dt><b>-seq_align</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-prep_align_prot_to</b> \<String\></dt>
<dd>No description<br/></dd>
</dl>
+ <h2>-pH</h2>
<dl>
<dt><b>-pH</b> \<Boolean\></dt>
<dd>pH option group<br/></dd>
<dt><b>-pH_mode</b> \<Boolean\></dt>
<dd>Allow protonated/deprotonated versions of the residues based on pH<br/>Default: false<br/></dd>
<dt><b>-keep_input_protonation_state</b> \<Boolean\></dt>
<dd>Read in residue protonation states from input pdb?<br/>Default: false<br/></dd>
<dt><b>-value_pH</b> \<Real\></dt>
<dd>pH value input for the pHEnergy score<br/>Default: 7.0<br/></dd>
</dl>
+ <h3>-pH:calc_pka</h3>
<dl>
<dt><b>-calc_pka</b> \<Boolean\></dt>
<dd>calc_pka option group<br/></dd>
<dt><b>-pka_all</b> \<Boolean\></dt>
<dd>Calculate pKa values for all protonatable protein residues in the PDB?<br/>Default: false<br/></dd>
<dt><b>-pka_for_resnos</b> \<RealVector\></dt>
<dd>Residue no whose pKa value is to be determined<br/>Default: 0<br/></dd>
<dt><b>-pka_for_chainno</b> \<String\></dt>
<dd>Chain no of the residue whose pKa is to be determined<br/>Default: "A"<br/></dd>
<dt><b>-pH_neighbor_pack</b> \<Boolean\></dt>
<dd>Pack the neighbors while calculating pKa?<br/>Default: false<br/></dd>
<dt><b>-pka_rad</b> \<Real\></dt>
<dd>Radius of repack<br/>Default: 5.0<br/></dd>
<dt><b>-pH_prepack</b> \<Boolean\></dt>
<dd>Prepack structure before calculating pKa values?<br/>Default: false<br/></dd>
<dt><b>-pH_relax</b> \<Boolean\></dt>
<dd>Relax structure before calculating pKa values?<br/>Default: false<br/></dd>
<dt><b>-rotamer_prot_stats</b> \<Boolean\></dt>
<dd>Get rotamer protonation statistics when titrating?<br/>Default: false<br/></dd>
</dl>
+ <h2>-pH</h2>
<dl>
<dt><b>-pH_unbound</b> \<FileVector\></dt>
<dd>Name(s) of unbound receptor and ligand PDB file(s)<br/></dd>
<dt><b>-output_raw_scores</b> \<Boolean\></dt>
<dd>Return raw scores contributing to interface score?<br/></dd>
<dt><b>-pre_process</b> \<Boolean\></dt>
<dd>Refine rigid body orientation?<br/></dd>
<dt><b>-cognate_partners</b> \<String\></dt>
<dd>Chain IDs for the cognate complex<br/>Default: "_"<br/></dd>
<dt><b>-cognate_pdb</b> \<File\></dt>
<dd>File containing the cognate Antigen-Antibody complex<br/></dd>
</dl>
+ <h2>-pocket_grid</h2>
<dl>
<dt><b>-pocket_grid</b> \<Boolean\></dt>
<dd>pocket_grid option group<br/></dd>
<dt><b>-pocket_grid_size</b> \<Real\></dt>
<dd>grid spacing in Angstroms<br/>Default: 0<br/></dd>
<dt><b>-pocket_grid_size_x</b> \<Real\></dt>
<dd>grid spacing in Angstroms<br/>Default: 10<br/></dd>
<dt><b>-pocket_grid_size_y</b> \<Real\></dt>
<dd>grid spacing in Angstroms<br/>Default: 10<br/></dd>
<dt><b>-pocket_grid_size_z</b> \<Real\></dt>
<dd>grid spacing in Angstroms<br/>Default: 10<br/></dd>
<dt><b>-pocket_grid_spacing</b> \<Real\></dt>
<dd>grid spacing in Angstroms<br/>Default: 0.5<br/></dd>
<dt><b>-pocket_max_spacing</b> \<Real\></dt>
<dd>Maximum residue-residue distance to be considered a pocket<br/>Default: 8<br/></dd>
<dt><b>-pocket_min_size</b> \<Real\></dt>
<dd>Minimum pocket size to score, in cubic Angstroms<br/>Default: 10<br/></dd>
<dt><b>-pocket_max_size</b> \<Real\></dt>
<dd>Maximum pocket size to report, in cubic Angstroms, 0 for no limit<br/>Default: 0<br/></dd>
<dt><b>-pocket_probe_radius</b> \<Real\></dt>
<dd>radius of surface probe molecule<br/>Default: 1.0<br/></dd>
<dt><b>-central_relax_pdb_num</b> \<String\></dt>
<dd>Residue number:(optional)Chain around which to do Pocket Constraint<br/>Default: "-1"<br/></dd>
<dt><b>-pocket_ntrials</b> \<Integer\></dt>
<dd>Number of trials to use for backrub<br/>Default: 100000<br/></dd>
<dt><b>-pocket_num_angles</b> \<Integer\></dt>
<dd>Number of different pose angles to measure pocket score at<br/>Default: 1<br/></dd>
<dt><b>-pocket_side</b> \<Boolean\></dt>
<dd>Include only side chain residues for target surface<br/>Default: false<br/></dd>
<dt><b>-pocket_dump_pdbs</b> \<Boolean\></dt>
<dd>Generate PDB files<br/>Default: false<br/></dd>
<dt><b>-pocket_dump_exemplars</b> \<Boolean\></dt>
<dd>Generate exemplar PDB files<br/>Default: false<br/></dd>
<dt><b>-pocket_filter_by_exemplar</b> \<Boolean\></dt>
<dd>Restrict the pocket to the exemplars<br/>Default: false<br/></dd>
<dt><b>-pocket_limit_exemplar_color</b> \<Boolean\></dt>
<dd>Include surface donors/acceptors only when they are within range of the main pocket<br/>Default: true<br/></dd>
<dt><b>-pocket_limit_small_exemplars</b> \<Boolean\></dt>
<dd>Require exemplar to have at least 5 hydrophobic elements to output to exemplar file<br/>Default: true<br/></dd>
<dt><b>-pocket_dump_rama</b> \<Boolean\></dt>
<dd>Generate Ramachandran maps for each pocket cluster<br/>Default: false<br/></dd>
<dt><b>-pocket_restrict_size</b> \<Boolean\></dt>
<dd>Pockets that are too large return score of 0<br/>Default: false<br/></dd>
<dt><b>-pocket_ignore_buried</b> \<Boolean\></dt>
<dd>Ignore pockets that are not solvent exposed<br/>Default: true<br/></dd>
<dt><b>-pocket_only_buried</b> \<Boolean\></dt>
<dd>Identify only pockets buried in the protein core (automatically sets -pocket_ignored_buried false)<br/>Default: false<br/></dd>
<dt><b>-pocket_psp</b> \<Boolean\></dt>
<dd>Mark Pocket-Solvent-Pocket events as well<br/>Default: true<br/></dd>
<dt><b>-pocket_sps</b> \<Boolean\></dt>
<dd>Unmark Solvent-Pocket-Solvent events<br/>Default: false<br/></dd>
<dt><b>-pocket_search13</b> \<Boolean\></dt>
<dd>Search in 13 directions (all faces and edges of a cube) versus faces and diagonal<br/>Default: false<br/></dd>
<dt><b>-pocket_surface_score</b> \<Real\></dt>
<dd>Score given to pocket surface<br/>Default: 0<br/></dd>
<dt><b>-pocket_surface_dist</b> \<Real\></dt>
<dd>Distance to consider pocket surface<br/>Default: 2.5<br/></dd>
<dt><b>-pocket_buried_score</b> \<Real\></dt>
<dd>Score given to deeply buried pocket points<br/>Default: 5.0<br/></dd>
<dt><b>-pocket_buried_dist</b> \<Real\></dt>
<dd>Distance to consider pocket buried<br/>Default: 2.0<br/></dd>
<dt><b>-pocket_exemplar_vdw_pen</b> \<Real\></dt>
<dd>Temporary max penalty for vdW class in exemplar discovery<br/>Default: 300.0<br/></dd>
<dt><b>-pocket_debug_output</b> \<Boolean\></dt>
<dd>Print any and all debuggind output related to pockets<br/>Default: false<br/></dd>
<dt><b>-dump_pocketGrid</b> \<Boolean\></dt>
<dd>print the pocket grid points into a PDB file<br/>Default: false<br/></dd>
<dt><b>-dump_Grid</b> \<Boolean\></dt>
<dd>print the grid points into a PDB file<br/>Default: false<br/></dd>
<dt><b>-extend_eggshell</b> \<Boolean\></dt>
<dd>Extend the eggshell points<br/>Default: false<br/></dd>
<dt><b>-extend_eggshell_dist</b> \<Real\></dt>
<dd>Distance to extend eggshell<br/>Default: 1<br/></dd>
<dt><b>-extra_eggshell_dist</b> \<Real\></dt>
<dd>Distance to extend extra eggshell points<br/>Default: 4<br/></dd>
<dt><b>-eggshell_dist</b> \<Real\></dt>
<dd>Distance to extend eggshell points from ligand atoms<br/>Default: 4<br/></dd>
<dt><b>-reduce_rays</b> \<Boolean\></dt>
<dd>reduce no. of rays by rounding and removing duplicate xyz coordinates<br/>Default: true<br/></dd>
<dt><b>-pocket_static_grid</b> \<Boolean\></dt>
<dd>No autoexpanding grid<br/>Default: false<br/></dd>
<dt><b>-dump_espGrid</b> \<Boolean\></dt>
<dd>print the electrostaticpotential grid into a PDB file<br/>Default: false<br/></dd>
<dt><b>-dump_connollySurface</b> \<Boolean\></dt>
<dd>print the connolly surface points into a PDB file<br/>Default: false<br/></dd>
<dt><b>-esp_buffer_dist</b> \<Real\></dt>
<dd>buffer dist added to Vdw radius atom while assigining electrostatic potential values<br/>Default: 0.5<br/></dd>
<dt><b>-round_pocketGrid_center</b> \<Boolean\></dt>
<dd>round_pocketGrid_center<br/>Default: true<br/></dd>
</dl>
+ <h2>-gen_pharmacophore</h2>
<dl>
<dt><b>-gen_pharmacophore</b> \<Boolean\></dt>
<dd>gen_pharmacophore option group<br/></dd>
<dt><b>-clash_distance_cutoff</b> \<Real\></dt>
<dd>clash distance cutoff to include ideal hydrogen bonding atoms<br/>Default: 1.0<br/></dd>
<dt><b>-ring_sasa_cutoff</b> \<Integer\></dt>
<dd>ring_sasa_cutoff to include in pharmacophore<br/>Default: 25<br/></dd>
<dt><b>-min_num_ring</b> \<Integer\></dt>
<dd>minimimum number of rings to be in a cluster<br/>Default: 1<br/></dd>
<dt><b>-ring_ring_dist_cutoff</b> \<Real\></dt>
<dd>ring - ringatom distance to include in the pharmacophore clusters<br/>Default: 5.0<br/></dd>
<dt><b>-ring_atm_dist_cutoff</b> \<Real\></dt>
<dd>ring - hbond atom distance to include in the pharmacophore clusters<br/>Default: 5.0<br/></dd>
</dl>
+ <h2>-fingerprint</h2>
<dl>
<dt><b>-fingerprint</b> \<Boolean\></dt>
<dd>fingerprint option group<br/></dd>
<dt><b>-print_eggshell</b> \<Boolean\></dt>
<dd>print the eggshell points into a PDB file<br/>Default: false<br/></dd>
<dt><b>-atom_radius_scale</b> \<Real\></dt>
<dd>Scale to shrink the radius of atom<br/>Default: 0.9<br/></dd>
<dt><b>-atom_radius_buffer</b> \<Real\></dt>
<dd>Value to subtract from all atomic radii, to match PocketGrid buffer thickness<br/>Default: 1.0<br/></dd>
<dt><b>-packing_weight</b> \<Real\></dt>
<dd>Add weight to rho large deviation<br/>Default: 1<br/></dd>
<dt><b>-dist_cut_off</b> \<Real\></dt>
<dd>set cut_off distance to add packing weight<br/>Default: 5<br/></dd>
<dt><b>-include_extrashell_to_set_origin</b> \<Boolean\></dt>
<dd>include extrashell points to set origin<br/>Default: false<br/></dd>
<dt><b>-include_hydrogens</b> \<Boolean\></dt>
<dd>include hydrogen atoms for fingerprint<br/>Default: false<br/></dd>
<dt><b>-multiple_origin</b> \<Boolean\></dt>
<dd>set multiple origin points for ray casting<br/>Default: false<br/></dd>
<dt><b>-use_DARC_gpu</b> \<Boolean\></dt>
<dd>use GPU when computing DARC score<br/>Default: false<br/></dd>
<dt><b>-square_score</b> \<Boolean\></dt>
<dd>square the terms in DARC scoring function<br/>Default: false<br/></dd>
<dt><b>-darc_components</b> \<Boolean\></dt>
<dd>get the score for individual components in DARC scoring function<br/>Default: false<br/></dd>
<dt><b>-set_origin</b> \<Integer\></dt>
<dd>option to set orgin: 0 to choose origin based on R(rugedness) value, 1 for protein_center, 2 for eggshell_bottom, 3 for vector from eggshell_plane closest to protein_center, 4 for vector from eggshell_plane distant to protein_center, 5 for choosing a residue center as origin(use the flag -origin_res_num for choosing the residue number)<br/>Default: 0<br/></dd>
<dt><b>-origin_res_num</b> \<String\></dt>
<dd>Residue number:(optional)Chain to be used as origin for ray-casting<br/>Default: "1"<br/></dd>
<dt><b>-add_esp</b> \<Boolean\></dt>
<dd>add electrostatic calculations<br/>Default: false<br/></dd>
<dt><b>-darc_shape_only</b> \<Boolean\></dt>
<dd>darc with shape only<br/>Default: false<br/></dd>
<dt><b>-darc_elsts_only</b> \<Boolean\></dt>
<dd>darc with electrostatics only<br/>Default: false<br/></dd>
<dt><b>-esp_weight</b> \<Real\></dt>
<dd>add weight for electrostatic energy<br/>Default: 0.117<br/></dd>
<dt><b>-esp_protein_wt</b> \<Real\></dt>
<dd>add weight for electrostatic energy inside protein<br/>Default: 0<br/></dd>
<dt><b>-esp_surface_wt</b> \<Real\></dt>
<dd>add weight for electrostatic energy on protein surface<br/>Default: 0<br/></dd>
<dt><b>-delphi_grid</b> \<Boolean\></dt>
<dd>input electrostatic potential grid if from DELPHI, default is ZAP grid<br/>Default: false<br/></dd>
<dt><b>-cap_e_potential</b> \<Real\></dt>
<dd>max/min value to cap electrostatic potential<br/>Default: 10.0<br/></dd>
<dt><b>-return_zero_darc_score</b> \<Boolean\></dt>
<dd>return 0 as darc score<br/>Default: false<br/></dd>
<dt><b>-set_surface_esp_to_zero</b> \<Boolean\></dt>
<dd>set surface electrostatic potential to zero<br/>Default: false<br/></dd>
<dt><b>-set_protein_esp_to_zero</b> \<Boolean\></dt>
<dd>set protein electrostatic potential to zero<br/>Default: false<br/></dd>
<dt><b>-inp_lig</b> \<String\></dt>
<dd>inp_lig<br/>Default: "inp_lig.pdb"<br/></dd>
<dt><b>-ref_lig</b> \<String\></dt>
<dd>ref_lig<br/>Default: "ref_lig.pdb"<br/></dd>
</dl>
+ <h2>-ProQ</h2>
<dl>
<dt><b>-ProQ</b> \<Boolean\></dt>
<dd>ProQ option group<br/></dd>
<dt><b>-svmmodel</b> \<Integer\></dt>
<dd>SVM model to use (in cross-validation, default is to use all [1-5])<br/>Default: 1<br/></dd>
<dt><b>-basename</b> \<String\></dt>
<dd>basename location for sequence specific inputfile)<br/>Default: ""<br/></dd>
<dt><b>-membrane</b> \<Boolean\></dt>
<dd>use membrane version (ProQM)<br/>Default: false<br/></dd>
<dt><b>-prof_bug</b> \<Boolean\></dt>
<dd>reproduce the profile bug in ProQres<br/>Default: false<br/></dd>
<dt><b>-output_feature_vector</b> \<Boolean\></dt>
<dd>outputs the feature vector<br/>Default: false<br/></dd>
<dt><b>-output_local_prediction</b> \<Boolean\></dt>
<dd>outputs the local predicted values<br/>Default: false<br/></dd>
<dt><b>-prefix</b> \<String\></dt>
<dd>prefix for outputfiles)<br/>Default: ""<br/></dd>
<dt><b>-use_gzip</b> \<Boolean\></dt>
<dd>gzip output files<br/>Default: false<br/></dd>
<dt><b>-normalize</b> \<Real\></dt>
<dd>Normalizing factor (usually target sequence length)<br/>Default: 1.0<br/></dd>
</dl>
+ <h2>-qsar</h2>
<dl>
<dt><b>-qsar</b> \<Boolean\></dt>
<dd>qsar option group<br/></dd>
<dt><b>-weights</b> \<String\></dt>
<dd>select qsar weight set to use<br/>Default: "talaris2013"<br/></dd>
<dt><b>-grid_dir</b> \<String\></dt>
<dd>Directory to store grids in<br/></dd>
<dt><b>-max_grid_cache_size</b> \<Integer\></dt>
<dd>delete old grids if grid cache exceeds specified size<br/></dd>
</dl>
+ <h2>-rbe</h2>
<dl>
<dt><b>-rbe</b> \<Boolean\></dt>
<dd>rbe option group<br/></dd>
<dt><b>-server_url</b> \<String\></dt>
<dd>serverurl for rosetta backend<br/></dd>
<dt><b>-server_port</b> \<String\></dt>
<dd>port for rosetta backend<br/>Default: "80"<br/></dd>
<dt><b>-poll_frequency</b> \<Real\></dt>
<dd>No description<br/>Default: 1.0<br/></dd>
</dl>
+ <h2>-RBSegmentRelax</h2>
<dl>
<dt><b>-RBSegmentRelax</b> \<Boolean\></dt>
<dd>RBSegmentRelax option group<br/></dd>
<dt><b>-input_pdb</b> \<File\></dt>
<dd>input pdb file<br/>Default: "--"<br/></dd>
<dt><b>-rb_file</b> \<File\></dt>
<dd>input rb segment file<br/>Default: "--"<br/></dd>
<dt><b>-nrbmoves</b> \<Integer\></dt>
<dd>number of rigid-body moves<br/>Default: 100<br/></dd>
<dt><b>-nrboutercycles</b> \<Integer\></dt>
<dd>number of rigid-body moves<br/>Default: 5<br/></dd>
<dt><b>-rb_scorefxn</b> \<String\></dt>
<dd>number of rigid-body moves<br/>Default: "score5"<br/></dd>
<dt><b>-skip_fragment_moves</b> \<Boolean\></dt>
<dd>omit fragment insertions (in SS elements)<br/>Default: false<br/></dd>
<dt><b>-skip_seqshift_moves</b> \<Boolean\></dt>
<dd>omit sequence shifting moves<br/>Default: false<br/></dd>
<dt><b>-skip_rb_moves</b> \<Boolean\></dt>
<dd>omit rigid-body moves<br/>Default: false<br/></dd>
<dt><b>-helical_movement_params</b> \<RealVector\></dt>
<dd>helical-axis-rotation, helical-axis-translation, off-axis-rotation, off-axis-translation<br/>Default: utility::vector1<float>(4,0.0)<br/></dd>
<dt><b>-strand_movement_params</b> \<RealVector\></dt>
<dd>strand-in-plane-rotation, strand-in-plane-translation, out-of-plane-rotation, out-of-plane-translationn<br/>Default: utility::vector1<float>(4,0.0)<br/></dd>
<dt><b>-default_movement_params</b> \<RealVector\></dt>
<dd>default-rotation, default-translation<br/>Default: utility::vector1<float>(2,0.0)<br/></dd>
<dt><b>-cst_seqwidth</b> \<Integer\></dt>
<dd>sequence width on constraints<br/>Default: 0<br/></dd>
</dl>
+ <h2>-hydrate</h2>
<dl>
<dt><b>-hydrate</b> \<Boolean\></dt>
<dd>hydrate option group<br/></dd>
<dt><b>-hyfile</b> \<File\></dt>
<dd>This file defines which residues to hydrate; add waters de novo around their polar atoms.<br/></dd>
<dt><b>-hydrate_all</b> \<Boolean\></dt>
<dd>Add de novo water molecules to the entire structure, not compatible with design.<br/>Default: false<br/></dd>
<dt><b>-ignore_fa_sol_at_positions</b> \<IntegerVector\></dt>
<dd>Set all implicit solvation contributions to zero when involving the position numbers in the given IntegerVector.<br/>Default: []<br/></dd>
<dt><b>-attempt_all_polar</b> \<Boolean\></dt>
<dd>Attempt to hydrate all polar atoms regardless of them having room or not.<br/>Default: false<br/></dd>
<dt><b>-partial_hydrate_dew</b> \<Real\></dt>
<dd>During the first round of packing when using double edge water (dew) molecules, only this fraction of de novo waters will be considered.<br/>Default: 0.75<br/></dd>
<dt><b>-water_energy_threshold</b> \<Real\></dt>
<dd>Water molecules with energy above this threshold will be removed after packing.<br/>Default: 5.0<br/></dd>
<dt><b>-water_rotamers_cap</b> \<Integer\></dt>
<dd>Limits the maximum number of water rotamers.<br/>Default: 500<br/></dd>
<dt><b>-water_packing_radius</b> \<Real\></dt>
<dd>Defines the radius a water molecule is allowed to explore during packing<br/>Default: 1.0<br/></dd>
<dt><b>-water_angular_resolution</b> \<Real\></dt>
<dd>Defines the angular resolution for water rotamers. As a corollary, it also defines the number of rotamers for each water molecule ((2*space_res+1)^3 * 2 * 2*ang_res^2).<br/>Default: 3<br/></dd>
<dt><b>-water_space_resolution</b> \<Real\></dt>
<dd>Defines the spacial resolution for water rotamers. As a corollary, it also defines the number of rotamers for each water molecule ((2*space_res+1)^3 * 2 * 2*ang_res^2).<br/>Default: 2<br/></dd>
<dt><b>-hbond_threshold</b> \<Real\></dt>
<dd>Hydrogen bond threshold. New water rotamers must make hbond of at least this value.<br/>Default: -0.1<br/></dd>
<dt><b>-hbond_entropy_threshold</b> \<Real\></dt>
<dd>Threshold for water hbonds to contribute to entropy.<br/>Default: -0.5<br/></dd>
<dt><b>-water_desolvation</b> \<Real\></dt>
<dd>Desolvation energy of a water molecule. Energy difference between a molecule in bulk water and near a protein. This value will be scaled by the scoring function weight for wat_desolv<br/>Default: 4.8<br/></dd>
<dt><b>-pack_nloop</b> \<Integer\></dt>
<dd>How many times to repack<br/>Default: 25<br/></dd>
<dt><b>-pre_bump_check</b> \<Boolean\></dt>
<dd>Do bump check before store them in memory<br/>Default: true<br/></dd>
<dt><b>-bias_design_search_to_native</b> \<Boolean\></dt>
<dd>It gives an artificially large negative energy to any native rotamer during packing. It was implemented to test the use of design waters.<br/>Default: false<br/></dd>
<dt><b>-show_derivatives_check</b> \<Boolean\></dt>
<dd>Show derivatives check when minimizing in the hydrate protocol.<br/>Default: false<br/></dd>
<dt><b>-keep_non_buried_waters</b> \<Boolean\></dt>
<dd>Keep non buried waters in the final structure (not recommended).<br/>Default: false<br/></dd>
<dt><b>-display_water_hb_network</b> \<Boolean\></dt>
<dd>Shows the water hydrogen bonds connections.<br/>Default: true<br/></dd>
<dt><b>-show_pre_post_filter_water_rotamers</b> \<Boolean\></dt>
<dd>Shows the exigen location of the post and pre filtered water rotamers.<br/>Default: false<br/></dd>
<dt><b>-show_pre_filtered_water_rotamers_count</b> \<Boolean\></dt>
<dd>Shows the total number of pre-filtered water rotamers; Helps assessing the memory requirements.<br/>Default: false<br/></dd>
<dt><b>-show_residues_near_water</b> \<Boolean\></dt>
<dd>Print out the residues that are near hydratable water after water packing and placement.<br/>Default: false<br/></dd>
<dt><b>-only_remove_non_buried_waters</b> \<Boolean\></dt>
<dd>Remove non-buried waters from input, then exit.<br/>Default: false<br/></dd>
<dt><b>-just_score</b> \<Boolean\></dt>
<dd>Just score the input structures with the hybrid solvation protocol.<br/>Default: false<br/></dd>
<dt><b>-show_rotamer_count</b> \<Boolean\></dt>
<dd>Output the rotamer counts for each water and amino acid, then exit.<br/>Default: false<br/></dd>
<dt><b>-protein_flexibility</b> \<String\></dt>
<dd>Defines the protein flexibility during the run<br/>Default: "not"<br/></dd>
<dt><b>-near_water_threshold</b> \<Real\></dt>
<dd>Threshold for res to be considered flexible when using the near_water option in -hydrate:protein_flexibility<br/>Default: 4.0<br/></dd>
<dt><b>-minimize_bb_where_packing</b> \<Boolean\></dt>
<dd>Allow backbone to move when minimizing.<br/>Default: false<br/></dd>
<dt><b>-dont_hydrate_hb_engaged_bb_O</b> \<Boolean\></dt>
<dd>Avoid hydrating hydrogen bond engaged backbone oxygens, even if it is just one hb. The purpose is to avoid disrupting atable structures (helices and sheets).<br/>Default: true<br/></dd>
<dt><b>-short_residence_time_mode</b> \<Boolean\></dt>
<dd>A faster mode to capture short residence time water molecules. Not good for energy predictions, and the results are better analyzed as an ensamble rather than a single structure.<br/>Default: false<br/></dd>
<dt><b>-min_backbone_file</b> \<File\></dt>
<dd>This file defines whether the backbone is allowed to move for a specific residue.<br/></dd>
<dt><b>-single_away_rotamer</b> \<Boolean\></dt>
<dd>Use single away water rotamer. The sampling gets biased towards keeping more water present.<br/>Default: false<br/></dd>
<dt><b>-force_enforce_all_waters</b> \<Boolean\></dt>
<dd>Keep water molecules enforced throughout hybrid solvation protocol.<br/>Default: false<br/></dd>
</dl>
+ <h2>-rdc</h2>
<dl>
<dt><b>-rdc</b> \<Boolean\></dt>
<dd>rdc option group<br/></dd>
<dt><b>-correct_NH_length</b> \<Boolean\></dt>
<dd>fix N-H bond-vector to 1.04 as measured in ottiger&bax 98<br/>Default: true<br/></dd>
<dt><b>-reduced_couplings</b> \<Boolean\></dt>
<dd>gives more equal weights to different bond-vectors<br/>Default: false<br/></dd>
<dt><b>-weights</b> \<File\></dt>
<dd>specify weights for individual residues ( works for all couplings at this reside)<br/></dd>
<dt><b>-iterate_weights</b> \<Real\></dt>
<dd>do a wRDC computation, i.e., iterate tensor calculation until weights are ~exp ( -dev2/sigma )<br/>Default: 1<br/></dd>
<dt><b>-segment_file</b> \<File\></dt>
<dd>Definition of rigid segments for alignment tensor optimization<br/></dd>
<dt><b>-segment_scoring_mode</b> \<String\></dt>
<dd>Type of treatment of alignment tensor-based scoring : pairwise or fixed_axis_z (e.g. for homo-dimers) <br/></dd>
<dt><b>-total_weight</b> \<Real\></dt>
<dd>Weight for RDC scores of individual al. tensors<br/>Default: 1.0<br/></dd>
<dt><b>-tensor_weight</b> \<Real\></dt>
<dd>Weight for pairwise scoring of al. tensors<br/>Default: 1.0<br/></dd>
<dt><b>-print_rdc_values</b> \<File\></dt>
<dd>print computed vs experimental RDC values<br/></dd>
<dt><b>-iterate_tol</b> \<Real\></dt>
<dd>tolerance for tensor iterations<br/>Default: 0.01<br/></dd>
<dt><b>-iterate_reset</b> \<Boolean\></dt>
<dd>reset weights to 1.0 when optimizing for new structure<br/>Default: false<br/></dd>
<dt><b>-dump_weight_trajectory</b> \<File\></dt>
<dd>if yes, write weights to file for each scoring event<br/></dd>
<dt><b>-fix_normAzz</b> \<RealVector\></dt>
<dd>divide by this axial tensor component<br/></dd>
<dt><b>-fit_method</b> \<String\></dt>
<dd>No description<br/>Default: "nls"<br/></dd>
<dt><b>-fixDa</b> \<RealVector\></dt>
<dd>No description<br/></dd>
<dt><b>-fixR</b> \<RealVector\></dt>
<dd>No description<br/></dd>
<dt><b>-nlsrepeat</b> \<Integer\></dt>
<dd>No description<br/>Default: 5<br/></dd>
</dl>
+ <h2>-relax</h2>
<dl>
<dt><b>-relax</b> \<Boolean\></dt>
<dd>relax option group<br/></dd>
<dt><b>-fast</b> \<Boolean\></dt>
<dd>Do a preset, small cycle number FastRelax<br/></dd>
<dt><b>-thorough</b> \<Boolean\></dt>
<dd>Do a preset, large cycle number FastRelax<br/></dd>
<dt><b>-centroid_mode</b> \<Boolean\></dt>
<dd>Use centroid relax protocol<br/>Default: false<br/></dd>
<dt><b>-default_repeats</b> \<Integer\></dt>
<dd>Default number of repeats done by FastRelax. Has no effect if a custom script is used!<br/>Default: 5<br/></dd>
<dt><b>-dualspace</b> \<Boolean\></dt>
<dd>Do 3 FastRelax cycles of internal coordinate relax followed by two cycles of Cartesian relax - cart_bonded energy term is required, pro_close energy term should be turned off, and use of -relax::minimize_bond_angles is recommended.  Use of the -nonideal flag switches all these and sets up correct min cycles, minimizer type, etc.<br/></dd>
<dt><b>-cyclic_peptide</b> \<Boolean\></dt>
<dd>Set up N-to-C constraints in a cyclic peptide<br/></dd>
</dl>
+ <h3>-relax:range</h3>
<dl>
<dt><b>-range</b> \<Boolean\></dt>
<dd>range option group<br/></dd>
<dt><b>-set_tm_helical</b> \<Boolean\></dt>
<dd>Set helical secondary structure in TM region<br/>Default: false<br/></dd>
<dt><b>-kT</b> \<Real\></dt>
<dd>Advanced option: kT<br/>Default: 1.0<br/></dd>
<dt><b>-angle_max</b> \<Real\></dt>
<dd>Maximum dihedral angle deviation for Small and ShearMover inside RangeRelax<br/>Default: 0.1<br/></dd>
<dt><b>-nmoves</b> \<String\></dt>
<dd>Number of Small and Shear moves inside RangeRelax, can be 'nres' for all residues or an integer<br/>Default: "nres"<br/></dd>
<dt><b>-spherical_wave</b> \<Boolean\></dt>
<dd>Relax in a spherical wave pattern starting at the center residue outwards.<br/>Default: false<br/></dd>
<dt><b>-repack_again</b> \<Boolean\></dt>
<dd>Do an additional round of repacking all residues after the RangeRelax<br/>Default: false<br/></dd>
<dt><b>-cycles</b> \<Integer\></dt>
<dd>Maximum number of cycles for repacking and minimization. Default 3<br/>Default: 3<br/></dd>
<dt><b>-min_cycles</b> \<Integer\></dt>
<dd>Maximum number of cycles within the Minimizer. Default 2000<br/>Default: 2000<br/></dd>
<dt><b>-idealize</b> \<Boolean\></dt>
<dd>Idealize decoy after run. Default: true<br/>Default: true<br/></dd>
<dt><b>-skip_relax</b> \<Boolean\></dt>
<dd>Skip relax step. Default: false<br/>Default: false<br/></dd>
</dl>
+ <h2>-relax</h2>
<dl>
<dt><b>-ramady</b> \<Boolean\></dt>
<dd>Run ramady code which aleviates stuck bad ramachandran energies<br/>Default: false<br/></dd>
<dt><b>-ramady_rms_limit</b> \<Real\></dt>
<dd>(ramady-only) Reject rama changes which perturb structure by more than this<br/>Default: 0.5<br/></dd>
<dt><b>-ramady_cutoff</b> \<Real\></dt>
<dd>(ramady-only) Cutoff at which a rama is considered bad<br/>Default: 2.0<br/></dd>
<dt><b>-ramady_max_rebuild</b> \<Integer\></dt>
<dd>(ramady-only) The maximum number of bad ramas to fix per repack-min cycle<br/>Default: 1<br/></dd>
<dt><b>-ramady_force</b> \<Boolean\></dt>
<dd>(ramady-only) Force rebuilding of bad ramas (normal skip-rate = 10%)<br/>Default: false<br/></dd>
<dt><b>-script</b> \<File\></dt>
<dd>Relax script file<br/>Default: ""<br/></dd>
<dt><b>-script_max_accept</b> \<Integer\></dt>
<dd>Limit number of best accepts<br/>Default: 10000000<br/></dd>
<dt><b>-superimpose_to_native</b> \<Boolean\></dt>
<dd>Superimpose input structure to native<br/>Default: false<br/></dd>
<dt><b>-superimpose_to_file</b> \<File\></dt>
<dd>Superimpose input structure to file<br/>Default: "false"<br/></dd>
<dt><b>-constrain_relax_to_native_coords</b> \<Boolean\></dt>
<dd>For relax and fastrelax, tether backbone coordinates of the pdbs being relaxed to the coordinates in the xtal native<br/>Default: false<br/></dd>
<dt><b>-constrain_relax_to_start_coords</b> \<Boolean\></dt>
<dd>For relax and fastrelax, tether backbone coordinates of the pdbs being relaxed to the coordinates in the xtal native<br/>Default: false<br/></dd>
<dt><b>-coord_constrain_sidechains</b> \<Boolean\></dt>
<dd>For relax and fastrelax, also tether sidechain heavy atom coordinates (requires either -constrain_relax_to_native_coords or -constrain_relax_to_start_coords)<br/>Default: false<br/></dd>
<dt><b>-sc_cst_maxdist</b> \<Real\></dt>
<dd>Use distance constraints between pairs of input side-chains atoms which are closer than the given upper distance cutoff (0 => no sc-sc restraints)<br/>Default: 0.0<br/></dd>
<dt><b>-limit_aroma_chi2</b> \<Boolean\></dt>
<dd>limit chi2 rotamer of PHE,TYR, and HIS around 90 <br/>Default: false<br/></dd>
<dt><b>-respect_resfile</b> \<Boolean\></dt>
<dd>Tell FastRelax to respect the input resfile.  Used mainly for doing design within FastRelax.<br/>Default: false<br/></dd>
<dt><b>-use_explicit_water</b> \<Boolean\></dt>
<dd>Consider explicit waters (part of the hybrid solvation protocol) during relax<br/>Default: false<br/></dd>
<dt><b>-bb_move</b> \<Boolean\></dt>
<dd>allow backbone to move during relax<br/>Default: true<br/></dd>
<dt><b>-chi_move</b> \<Boolean\></dt>
<dd>allow sidechain to move during relax<br/>Default: true<br/></dd>
<dt><b>-jump_move</b> \<Boolean\></dt>
<dd>allow jump to move during relax<br/>Default: false<br/></dd>
<dt><b>-dna_move</b> \<Boolean\></dt>
<dd>allow dna to move during relax + allow DNA-DNA interactions. Best if used with orbitals scorefunction. DNA stays together with great molprobity results.  Not recommended for general use at this time.<br/>Default: false<br/></dd>
<dt><b>-fix_omega</b> \<Boolean\></dt>
<dd>Fix omega angles during relax<br/>Default: false<br/></dd>
<dt><b>-minimize_bond_lengths</b> \<Boolean\></dt>
<dd>Free bond length DOFs during relax for all atoms<br/>Default: false<br/></dd>
<dt><b>-minimize_bond_angles</b> \<Boolean\></dt>
<dd>Free bond angle DOFs during relax for all atoms<br/>Default: false<br/></dd>
<dt><b>-minimize_bondlength_subset</b> \<Integer\></dt>
<dd>Minimize only a subset of bondlengths 0 Default  all bondlengths 1          backbone only 2          sidechain only 3          CA only (Ca-C,Ca-N and Ca-Cb)<br/>Default: 0<br/></dd>
<dt><b>-minimize_bondangle_subset</b> \<Integer\></dt>
<dd>Minimize only a subset of bondlengths 0 Default  all bondangles 1          backbone only 2          sidechain only 3          tau only 4          Ca-Cb only<br/>Default: 0<br/></dd>
<dt><b>-min_type</b> \<String\></dt>
<dd>minimizer to use during relax.<br/>Default: "lbfgs_armijo_nonmonotone"<br/></dd>
<dt><b>-cartesian</b> \<Boolean\></dt>
<dd>Use Cartesian minimizer<br/>Default: false<br/></dd>
<dt><b>-chainbreak_weight</b> \<Real\></dt>
<dd>chainbreak weight<br/>Default: 0.0<br/></dd>
<dt><b>-linear_chainbreak_weight</b> \<Real\></dt>
<dd>linear chainbreak weight<br/>Default: 0.0<br/></dd>
<dt><b>-overlap_chainbreak_weight</b> \<Real\></dt>
<dd>overlap chainbreak weight<br/>Default: 0.0<br/></dd>
<dt><b>-classic</b> \<Boolean\></dt>
<dd>Do very old classic relax ! This is a poor protocol - don't use it !<br/></dd>
<dt><b>-sequence_file</b> \<File\></dt>
<dd>Relax script file<br/>Default: ""<br/></dd>
<dt><b>-quick</b> \<Boolean\></dt>
<dd>Do a preset, small cycle number FastRelax<br/></dd>
<dt><b>-sequence</b> \<Boolean\></dt>
<dd>Do a preset, small cycle number FastRelax<br/></dd>
<dt><b>-minirelax_repeats</b> \<Integer\></dt>
<dd><br/>Default: 2<br/></dd>
<dt><b>-minirelax_sdev</b> \<Real\></dt>
<dd>tether on coordinate constraints for minirelax<br/>Default: 0.5<br/></dd>
<dt><b>-wobblemoves</b> \<Boolean\></dt>
<dd>Do Wobble moves ?<br/>Default: false<br/></dd>
<dt><b>-constrain_relax_segments</b> \<File\></dt>
<dd>loop definition file<br/>Default: ""<br/></dd>
<dt><b>-coord_cst_width</b> \<Real\></dt>
<dd>Width on coordinate constraints from constrain_relax_* options<br/>Default: 0.0<br/></dd>
<dt><b>-coord_cst_stdev</b> \<Real\></dt>
<dd>Stdev on coordinate constraints from constrain_relax_* options<br/>Default: 0.5<br/></dd>
<dt><b>-ramp_constraints</b> \<Boolean\></dt>
<dd>Ramp constraints during phase1 of relax from full to zero<br/>Default: false<br/></dd>
<dt><b>-energycut</b> \<Real\></dt>
<dd>Rottrial energycut (per residue!)<br/>Default: 0.01<br/></dd>
<dt><b>-mini</b> \<Boolean\></dt>
<dd>perform a relax that is only a minimization and repack.<br/>Default: false<br/></dd>
<dt><b>-stage1_ramp_cycles</b> \<Integer\></dt>
<dd>Ramp cyclesin stage 1 <br/>Default: 8<br/></dd>
<dt><b>-stage1_ramp_inner_cycles</b> \<Integer\></dt>
<dd>Inner cycles means how many small shear moves + rottrials<br/>Default: 1<br/></dd>
<dt><b>-stage2_repack_period</b> \<Integer\></dt>
<dd>Full repack after how many cycles in stage 2<br/>Default: 100<br/></dd>
<dt><b>-stage2_cycles</b> \<Integer\></dt>
<dd>How many stage 2 cycles ? (by default its -1 means Nresidues*4 )<br/>Default: -1<br/></dd>
<dt><b>-min_tolerance</b> \<Real\></dt>
<dd>Minimizer tolerance<br/>Default: 0.00025<br/></dd>
<dt><b>-stage3_cycles</b> \<Integer\></dt>
<dd>How many stage 3 cycles ? (by default its -1 means Nresidues )<br/>Default: -1<br/></dd>
<dt><b>-cycle_ratio</b> \<Real\></dt>
<dd>Post-multiplier for cycle numbers<br/>Default: 1.0<br/></dd>
<dt><b>-filter_stage2_beginning</b> \<Real\></dt>
<dd>FArelax score filter<br/>Default: 99999999.00<br/></dd>
<dt><b>-filter_stage2_quarter</b> \<Real\></dt>
<dd>FArelax score filter<br/>Default: 99999999.00<br/></dd>
<dt><b>-filter_stage2_half</b> \<Real\></dt>
<dd>FArelax score filter<br/>Default: 99999999.00<br/></dd>
<dt><b>-filter_stage2_end</b> \<Real\></dt>
<dd>FArelax score filter<br/>Default: 99999999.00<br/></dd>
</dl>
+ <h3>-relax:centroid</h3>
<dl>
<dt><b>-centroid</b> \<Boolean\></dt>
<dd>centroid option group<br/></dd>
<dt><b>-weights</b> \<String\></dt>
<dd>Weights to use for centroid minimization<br/>Default: "score4_smooth_cen_relax"<br/></dd>
<dt><b>-ramp_vdw</b> \<Boolean\></dt>
<dd>Ramp up the VDW weight<br/>Default: true<br/></dd>
<dt><b>-ramp_rama</b> \<Boolean\></dt>
<dd>Ramp up the rama/rama2b weight<br/>Default: false<br/></dd>
<dt><b>-parameters</b> \<String\></dt>
<dd>Database file for ramp/min parameter<br/>Default: "sampling/cen_relax/default_relax_parameters.txt"<br/></dd>
<dt><b>-do_final_repack</b> \<Boolean\></dt>
<dd>Repack sidechains in movemap after protocol if given a fullatom structure<br/>Default: false<br/></dd>
<dt><b>-increase_vdw_radii</b> \<Boolean\></dt>
<dd>Increase BB vdw radii<br/>Default: false<br/></dd>
</dl>
+ <h2>-remodel</h2>
<dl>
<dt><b>-remodel</b> \<Boolean\></dt>
<dd>remodel option group<br/></dd>
<dt><b>-blueprint</b> \<File\></dt>
<dd>blueprint file name<br/></dd>
<dt><b>-cstfile</b> \<File\></dt>
<dd>description<br/></dd>
<dt><b>-cst_fa_only</b> \<Boolean\></dt>
<dd>false<br/></dd>
<dt><b>-cstfilter</b> \<Integer\></dt>
<dd>filter cst energy<br/>Default: 10<br/></dd>
<dt><b>-cen_sfxn</b> \<String\></dt>
<dd>centroid score function to be used for building<br/>Default: "remodel_cen"<br/></dd>
<dt><b>-check_scored_centroid</b> \<Boolean\></dt>
<dd>dump centroid structures after build<br/>Default: false<br/></dd>
<dt><b>-num_trajectory</b> \<Integer\></dt>
<dd>Number of remodel trajectories.<br/>Default: 10<br/></dd>
<dt><b>-save_top</b> \<Integer\></dt>
<dd>the number of final low scoring pdbs to keep.<br/>Default: 5<br/></dd>
<dt><b>-swap_refine_confirm_protocols</b> \<Boolean\></dt>
<dd>swapping the protocols used refinement and confirmation<br/>Default: false<br/></dd>
<dt><b>-bypass_fragments</b> \<Boolean\></dt>
<dd>only works on input PDB, so no extensions or deletions are honored in the blueprint.  Blueprint (H,L,E,D) becomes allow_move definitionsi.<br/></dd>
<dt><b>-use_same_length_fragments</b> \<Boolean\></dt>
<dd>harvest fragments that matches the length to rebuild<br/>Default: true<br/></dd>
<dt><b>-no_jumps</b> \<Boolean\></dt>
<dd>will setup simple foldtree and fold through it during centroid build.<br/>Default: false<br/></dd>
<dt><b>-reroot_tree</b> \<Integer\></dt>
<dd>rerooting the tree for the build.<br/>Default: 1<br/></dd>
<dt><b>-use_blueprint_sequence </b> \<Boolean\></dt>
<dd> picks fragments based on both secondary structure and the second column (sequence) in blueprint file<br/></dd>
<dt><b>-quick_and_dirty </b> \<Boolean\></dt>
<dd> only do fragment insertion<br/></dd>
<dt><b>-checkpoint </b> \<Boolean\></dt>
<dd> this writes out the best pdbs collected so far after each design step.<br/></dd>
<dt><b>-use_pose_relax </b> \<Boolean\></dt>
<dd> an alternative to the default minimization step, but use constraints in a similar way.<br/></dd>
<dt><b>-use_cart_relax </b> \<Boolean\></dt>
<dd> an alternative to the default minimization step, but use constraints in a similar way.<br/></dd>
<dt><b>-free_relax </b> \<Boolean\></dt>
<dd> running pose_relax with no constraints.<br/>Default: false<br/></dd>
<dt><b>-generic_aa</b> \<String\></dt>
<dd>the type of AA for centroid building<br/>Default: "V"<br/></dd>
<dt><b>-cluster_radius</b> \<Real\></dt>
<dd>cluster radius for accumulator, default to auto set value<br/>Default: -1.0<br/></dd>
<dt><b>-use_clusters</b> \<Boolean\></dt>
<dd>use clustering in accumulator<br/>Default: false<br/></dd>
<dt><b>-run_confirmation</b> \<Boolean\></dt>
<dd>use KIC rms confirmation<br/>Default: false<br/></dd>
<dt><b>-cluster_on_entire_pose</b> \<Boolean\></dt>
<dd>cluster use all pose, not just loops<br/>Default: false<br/></dd>
<dt><b>-dr_cycles</b> \<Integer\></dt>
<dd>number of design-refine cycles to use<br/>Default: 3<br/></dd>
<dt><b>-two_chain_tree</b> \<Integer\></dt>
<dd>label the start of the second chain<br/></dd>
<dt><b>-repeat_structure</b> \<Integer\></dt>
<dd>build identical repeats this many times<br/>Default: 1<br/></dd>
<dt><b>-lh_ex_limit</b> \<Integer\></dt>
<dd>loophasing neighboring bin expansion limit<br/>Default: 5<br/></dd>
<dt><b>-lh_filter_string</b> \<StringVector\></dt>
<dd>loophash ABEGO filter target fragment type. list sequentially for each loop<br/></dd>
<dt><b>-lh_cbreak_selection</b> \<Integer\></dt>
<dd>loophash with cbreak dominant weight<br/>Default: 10<br/></dd>
<dt><b>-lh_closure_filter</b> \<Boolean\></dt>
<dd>filter for close rms when bypass_closure is used<br/>Default: false<br/></dd>
<dt><b>-cen_minimize</b> \<Boolean\></dt>
<dd>centroid minimization after fragment building<br/>Default: false<br/></dd>
<dt><b>-core_cutoff</b> \<Integer\></dt>
<dd>number of neighbors required to consider core in auto design<br/>Default: 18<br/></dd>
<dt><b>-boundary_cutoff</b> \<Integer\></dt>
<dd>number of neighbors required to consider boundary in auto design<br/>Default: 15<br/></dd>
<dt><b>-coreAA</b> \<String\></dt>
<dd>amino acid set for core<br/>Default: ""<br/></dd>
<dt><b>-boundaryAA</b> \<String\></dt>
<dd>amino acid set for boundary<br/>Default: ""<br/></dd>
<dt><b>-surfaceAA</b> \<String\></dt>
<dd>amino acid set for surface<br/>Default: ""<br/></dd>
<dt><b>-design_around_ligand</b> \<Boolean\></dt>
<dd>apply manual design mode around the ligand<br/>Default: false<br/></dd>
<dt><b>-move_ligand</b> \<Boolean\></dt>
<dd>apply ligand handler to move ligand<br/>Default: false<br/></dd>
<dt><b>-resclass_by_sasa</b> \<Boolean\></dt>
<dd>switch to use sasa for residue classification<br/>Default: false<br/></dd>
<dt><b>-helical_rise</b> \<Real\></dt>
<dd>helical parameter: rise<br/>Default: 0.0<br/></dd>
<dt><b>-helical_radius</b> \<Real\></dt>
<dd>helical parameter: radius<br/>Default: 0.0<br/></dd>
<dt><b>-helical_omega</b> \<Real\></dt>
<dd>helical parameter: omega<br/>Default: 0.0<br/></dd>
<dt><b>-filter_rise</b> \<RealVector\></dt>
<dd>filter value range for helical params rise<br/></dd>
<dt><b>-filter_radius</b> \<RealVector\></dt>
<dd>filter value range for helical params radius<br/></dd>
<dt><b>-filter_omega</b> \<RealVector\></dt>
<dd>filter value range for helical params omega<br/></dd>
<dt><b>-COM_sd</b> \<Real\></dt>
<dd>center of mass coordinate constraint sd value<br/>Default: 1.0<br/></dd>
<dt><b>-COM_tolerance</b> \<Real\></dt>
<dd>center of mass coordinate constraint tolerance value<br/>Default: 0.0<br/></dd>
<dt><b>-vdw</b> \<Real\></dt>
<dd>set vdw weight<br/>Default: 1.0<br/></dd>
<dt><b>-rama</b> \<Real\></dt>
<dd>set rama weight<br/>Default: 0.1<br/></dd>
<dt><b>-cbeta</b> \<Real\></dt>
<dd>set cbeta weight<br/>Default: 0.0<br/></dd>
<dt><b>-cenpack</b> \<Real\></dt>
<dd>set cenpack weight<br/>Default: 0.0<br/></dd>
<dt><b>-rg_local</b> \<Real\></dt>
<dd>set rg_local weight<br/>Default: 0.0<br/></dd>
<dt><b>-hb_lrbb</b> \<Real\></dt>
<dd>set hbond_lrbb weight<br/>Default: 0.0<br/></dd>
<dt><b>-hb_srbb</b> \<Real\></dt>
<dd>set hbond_srbb weight<br/>Default: 0.0<br/></dd>
<dt><b>-rg</b> \<Real\></dt>
<dd>set rg weight<br/></dd>
<dt><b>-rsigma</b> \<Real\></dt>
<dd>set rsigma weight<br/>Default: 0.0<br/></dd>
<dt><b>-ss_pair</b> \<Real\></dt>
<dd>set sspair weight<br/>Default: 0.0<br/></dd>
<dt><b>-build_disulf</b> \<Boolean\></dt>
<dd>build disulfides<br/>Default: false<br/></dd>
<dt><b>-match_rt_limit</b> \<Real\></dt>
<dd>match RT score cutoff<br/>Default: 0.4<br/></dd>
<dt><b>-disulf_landing_range</b> \<IntegerVector\></dt>
<dd>residue range for disulf landing sites<br/></dd>
<dt><b>-rank_by_bsasa</b> \<Boolean\></dt>
<dd>rank results by bsasa.<br/></dd>
</dl>
+ <h3>-remodel:staged_sampling</h3>
<dl>
<dt><b>-staged_sampling</b> \<Boolean\></dt>
<dd>sampling first with 9mers then 3mers. Staged energies. For rebuilding entire structure not loop closure<br/>Default: false<br/></dd>
<dt><b>-loop_9mer_score_file</b> \<String\></dt>
<dd>stage1_score<br/></dd>
<dt><b>-loop_3mer_score_file</b> \<String\></dt>
<dd>stage2_score<br/></dd>
<dt><b>-all_9mer_score_file</b> \<String\></dt>
<dd>stage3_score<br/></dd>
<dt><b>-all_3mer_score_file</b> \<String\></dt>
<dd>stage4_score<br/></dd>
<dt><b>-loop_9mer_cycles</b> \<Integer\></dt>
<dd>stage1_cycles<br/></dd>
<dt><b>-loop_3mer_cycles</b> \<Integer\></dt>
<dd>stage2_cycles<br/></dd>
<dt><b>-all_9mer_cycles</b> \<Integer\></dt>
<dd>stage3_cycles<br/></dd>
<dt><b>-all_3mer_cycles</b> \<Integer\></dt>
<dd>stage4_cycles<br/></dd>
<dt><b>-fa_mode</b> \<Boolean\></dt>
<dd>does the fragment assembly stage in fa<br/>Default: false<br/></dd>
<dt><b>-fa_relax_moves</b> \<Boolean\></dt>
<dd>Adds a stage of fa relax<br/>Default: false<br/></dd>
<dt><b>-loop_btw_parametric_components</b> \<Boolean\></dt>
<dd>Sets up a mode where a loop can be inserted into a parametric repeat<br/>Default: false<br/></dd>
<dt><b>-pre_centroid</b> \<Boolean\></dt>
<dd>initialize fa mode with 200 cycles of centroid<br/>Default: false<br/></dd>
<dt><b>-sample_over_loops</b> \<Boolean\></dt>
<dd>sample residues defined as loops in the blueprint<br/>Default: false<br/></dd>
<dt><b>-small_moves</b> \<Boolean\></dt>
<dd>add a stage of small moves<br/>Default: false<br/></dd>
<dt><b>-starting_sequence</b> \<String\></dt>
<dd>AA sequence to start<br/>Default: ""<br/></dd>
<dt><b>-starting_pdb</b> \<File\></dt>
<dd>pdb to start<br/>Default: ""<br/></dd>
<dt><b>-starting_non_canonical</b> \<String\></dt>
<dd>position,non canonical to be added<br/>Default: ""<br/></dd>
<dt><b>-start_w_ideal_helices</b> \<Boolean\></dt>
<dd>begins with all helices set to -63.8 phi and -41.1 for psi.<br/>Default: false<br/></dd>
<dt><b>-sym_move</b> \<Boolean\></dt>
<dd>Adds a symmetry move to the abinitio stage<br/>Default: false<br/></dd>
<dt><b>-residues_to_sample</b> \<File\></dt>
<dd>residues to allow sampling (format:1,3,5)<br/>Default: ""<br/></dd>
<dt><b>-require_frags_match_blueprint</b> \<Boolean\></dt>
<dd>makes sure the frags match the definition in the blueprint<br/>Default: true<br/></dd>
</dl>
+ <h3>-remodel:domainFusion</h3>
<dl>
<dt><b>-domainFusion</b> \<Boolean\></dt>
<dd>domainFusion option group<br/></dd>
<dt><b>-insert_segment_from_pdb</b> \<File\></dt>
<dd>segment pdb file to be inserted [insert pdb file name].<br/>Default: ""<br/></dd>
<dt><b>-insert_segment2_from_pdb</b> \<File\></dt>
<dd>segment2 pdb file to be inserted [insert pdb file name].<br/>Default: ""<br/></dd>
</dl>
+ <h3>-remodel:design</h3>
<dl>
<dt><b>-design</b> \<Boolean\></dt>
<dd>design option group<br/></dd>
<dt><b>-no_design </b> \<Boolean\></dt>
<dd> skips all design steps. WARNING: will only output centroid level structures and dump all fragment tries.<br/></dd>
<dt><b>-design_all</b> \<Boolean\></dt>
<dd> force AUTO design procedure (layered) to perform design on all positions. <br/></dd>
<dt><b>-allow_rare_aro_chi</b> \<Boolean\></dt>
<dd>allow all aromatic rotamers, not issuing AroChi2 filter<br/>Default: false<br/></dd>
<dt><b>-skip_partial</b> \<Boolean\></dt>
<dd> skip design stage that operate only on burial positions<br/>Default: false<br/></dd>
<dt><b>-design_neighbors</b> \<Boolean\></dt>
<dd>design neighbors.<br/>Default: false<br/></dd>
<dt><b>-find_neighbors</b> \<Boolean\></dt>
<dd>find neighbors for design/repack<br/>Default: false<br/></dd>
<dt><b>-include_current</b> \<Boolean\></dt>
<dd>include current rotamers<br/>Default: true<br/></dd>
</dl>
+ <h3>-remodel:RemodelLoopMover</h3>
<dl>
<dt><b>-RemodelLoopMover</b> \<Boolean\></dt>
<dd>RemodelLoopMover option group<br/></dd>
<dt><b>-max_linear_chainbreak</b> \<Real\></dt>
<dd>linear chainbreak is <= this value, loop is considered closed (default 0.07) <br/>Default: 0.07<br/></dd>
<dt><b>-randomize_loops</b> \<Boolean\></dt>
<dd>randomize loops prior to running main protocol (default true)<br/>Default: true<br/></dd>
<dt><b>-use_loop_hash</b> \<Boolean\></dt>
<dd>centroid build with loop hash (default false)<br/>Default: false<br/></dd>
<dt><b>-set_segment</b> \<File\></dt>
<dd>directly set segment phi-psi-omega from file<br/>Default: ""<br/></dd>
<dt><b>-allowed_closure_attempts</b> \<Integer\></dt>
<dd>the allowed number of overall closure attempts (default 1)<br/>Default: 1<br/></dd>
<dt><b>-loophash_cycles</b> \<Integer\></dt>
<dd>the number of loophash closure cycles to perform (default 8)<br/>Default: 8<br/></dd>
<dt><b>-simultaneous_cycles</b> \<Integer\></dt>
<dd>the number of simultaneous closure cycles to perform (default 2)<br/>Default: 2<br/></dd>
<dt><b>-independent_cycles</b> \<Integer\></dt>
<dd>the number of independent closure cycles to perform (default 8)<br/>Default: 8<br/></dd>
<dt><b>-boost_closure_cycles</b> \<Integer\></dt>
<dd>the maximum number of possible lockdown closure cycles to perform (default 30)<br/>Default: 30<br/></dd>
<dt><b>-threshold_for_boost_closure</b> \<Real\></dt>
<dd>numerical chainbreak threshold for entering boost_closure_stage<br/>Default: 1.0<br/></dd>
<dt><b>-force_cutting_index</b> \<Integer\></dt>
<dd>force a cutpoint shift index of blueprint assignment<br/>Default: 1<br/></dd>
<dt><b>-force_cutting_N</b> \<Boolean\></dt>
<dd>force a cutpoint at N-term side of blueprint assignment<br/>Default: false<br/></dd>
<dt><b>-bypass_closure</b> \<Boolean\></dt>
<dd>turning off CCD closure in the mover for tethered docking purpose<br/>Default: false<br/></dd>
<dt><b>-cyclic_peptide</b> \<Boolean\></dt>
<dd>circularize structure joining N and C-term.<br/>Default: false<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>temperature for monte carlo ( default 2.0)<br/>Default: 2.0<br/></dd>
</dl>
+ <h2>-resample</h2>
<dl>
<dt><b>-resample</b> \<Boolean\></dt>
<dd>resample option group<br/></dd>
<dt><b>-silent</b> \<File\></dt>
<dd>a silent file for decoys to restart sampling from <br/>Default: ""<br/></dd>
<dt><b>-tag</b> \<String\></dt>
<dd>which decoy to select from silent file <br/>Default: ""<br/></dd>
<dt><b>-stage1</b> \<Boolean\></dt>
<dd>if true restart after stage1, otherwise after stage2 <br/>Default: false<br/></dd>
<dt><b>-stage2</b> \<Boolean\></dt>
<dd>if true restart after stage1, otherwise after stage2 <br/>Default: false<br/></dd>
<dt><b>-jumps</b> \<Boolean\></dt>
<dd>if true restart after stage1, otherwise after stage2 <br/>Default: false<br/></dd>
<dt><b>-min_max_start_seq_sep</b> \<RealVector\></dt>
<dd>range of (random) start values for seq-separation<br/>Default: 0<br/></dd>
</dl>
+ <h2>-rescore</h2>
<dl>
<dt><b>-rescore</b> \<Boolean\></dt>
<dd>rescore option group<br/></dd>
<dt><b>-assign_ss</b> \<Boolean\></dt>
<dd>Invoke DSSP to assign secondary structure.<br/>Default: false<br/></dd>
<dt><b>-skip</b> \<Boolean\></dt>
<dd>Dont actually call scoring function (i.e. get evaluators only)<br/></dd>
<dt><b>-verbose</b> \<Boolean\></dt>
<dd>Full break down of weights, raw scores and weighted scores ?<br/></dd>
</dl>
+ <h2>-rna</h2>
<dl>
<dt><b>-rna</b> \<Boolean\></dt>
<dd>rna option group<br/></dd>
<dt><b>-corrected_geo</b> \<Boolean\></dt>
<dd>Use PHENIX-based RNA sugar close energy and params files<br/>Default: true<br/></dd>
<dt><b>-vary_geometry</b> \<Boolean\></dt>
<dd>Let bond lengths and angles vary from ideal in minimizer<br/>Default: false<br/></dd>
<dt><b>-data_file</b> \<String\></dt>
<dd>RDAT or legacy-format file with RNA chemical mapping data<br/>Default: ""<br/></dd>
<dt><b>-cut_at_rna_chainbreak</b> \<Boolean\></dt>
<dd>If O3' to P distance is > 2.5 Angstroms, assume cutpoint.<br/>Default: false<br/></dd>
<dt><b>-evaluate_base_pairs</b> \<Boolean\></dt>
<dd>In final scoring, compute number of Watson-Crick, non-Watson-Crick pairs; compare to native if available.<br/></dd>
</dl>
+ <h3>-rna:denovo</h3>
<dl>
<dt><b>-denovo</b> \<Boolean\></dt>
<dd>denovo option group<br/></dd>
<dt><b>-cycles</b> \<Integer\></dt>
<dd>Default number of Monte Carlo cycles<br/>Default: 0<br/></dd>
<dt><b>-rna_protein_docking_freq</b> \<Real\></dt>
<dd>RNA/protein docking frequency (between 0 (no docking) and 1 (all docking))<br/>Default: 0.4<br/></dd>
<dt><b>-rounds</b> \<Integer\></dt>
<dd>Number of rounds to split cycles into during fragment assembly<br/>Default: 10<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>temperature<br/>Default: 2.0<br/></dd>
<dt><b>-minimize_rna</b> \<Boolean\></dt>
<dd>Minimize RNA after fragment assembly<br/>Default: false<br/></dd>
<dt><b>-sequence</b> \<StringVector\></dt>
<dd>RNA sequence to model (better to supply in -fasta)<br/></dd>
<dt><b>-secstruct</b> \<String\></dt>
<dd>RNA sec struct to model (better to supply in -secstruct_file)<br/>Default: ""<br/></dd>
<dt><b>-secstruct_general</b> \<String\></dt>
<dd>RNA sec struct to model with possible noncanonical pairs<br/>Default: ""<br/></dd>
<dt><b>-secstruct_file</b> \<String\></dt>
<dd>RNA sec struct to model in dot-parens notation<br/>Default: ""<br/></dd>
<dt><b>-secstruct_general_file</b> \<String\></dt>
<dd>RNA sec struct (+non-canonical pairs) to model in dot-parens notation<br/>Default: ""<br/></dd>
<dt><b>-secstruct_legacy</b> \<String\></dt>
<dd>RNA sec struct in old 1D notation: H,helix; L,loop; X,unknown; N,bulge<br/>Default: ""<br/></dd>
<dt><b>-lores_scorefxn</b> \<String\></dt>
<dd>Low resolution scorefunction weights file<br/>Default: "farna/rna_lores.wts"<br/></dd>
<dt><b>-set_lores_weights</b> \<StringVector\></dt>
<dd>Modification to lores scorefxnweights via the command line. Applied in ScoreFunctionFactory::create_score_function inside the function apply_user_defined_reweighting_. Format is a list of paired strings: -set_lores_weights <score_type1> <setting1> <score_type2> <setting2> ...<br/>Default: []<br/></dd>
<dt><b>-symm_hack_arity</b> \<Integer\></dt>
<dd>For hacky symmetry that forces matching fragment insertions, what's the n-repeats?<br/>Default: 1<br/></dd>
<dt><b>-exhaustive_fragment_insertion</b> \<Integer\></dt>
<dd>Instead of doing a single random fragment insertion per move, do the BEST one from among n random trials.<br/>Default: 1<br/></dd>
<dt><b>-params_file</b> \<String\></dt>
<dd>Input file for pairings [deprecated!]<br/>Default: "default.prm"<br/></dd>
<dt><b>-filter_lores_base_pairs</b> \<Boolean\></dt>
<dd>Filter for models that satisfy structure parameters<br/>Default: true<br/></dd>
<dt><b>-filter_lores_base_pairs_early</b> \<Boolean\></dt>
<dd>Filter for models that satisfy structure parameters at round 2 of 10<br/>Default: true<br/></dd>
<dt><b>-filter_chain_closure</b> \<Boolean\></dt>
<dd>Filter for models that have closed chains after lores before minimize<br/>Default: true<br/></dd>
<dt><b>-filter_chain_closure_halfway</b> \<Boolean\></dt>
<dd>Filter for models that have closed chains after lores before minimize at round 5 of 10<br/>Default: true<br/></dd>
<dt><b>-filter_chain_closure_distance</b> \<Real\></dt>
<dd>Mean distance across 3 chainbreak atoms to filter models that have closed chains after lores<br/>Default: 6.0<br/></dd>
<dt><b>-relax_rna</b> \<Boolean\></dt>
<dd>Relax RNA after fragment assembly<br/>Default: false<br/></dd>
<dt><b>-simple_relax</b> \<Boolean\></dt>
<dd>Relax by minimizing after any fragment insertion<br/>Default: false<br/></dd>
<dt><b>-ignore_secstruct</b> \<Boolean\></dt>
<dd>Ignore sec struct in input file<br/>Default: false<br/></dd>
<dt><b>-jump_change_frequency</b> \<Real\></dt>
<dd>jump change frequency<br/>Default: 0.1<br/></dd>
<dt><b>-close_loops</b> \<Boolean\></dt>
<dd>close loops after de novo protocol and again after minimization<br/>Default: true<br/></dd>
<dt><b>-close_loops_after_each_move</b> \<Boolean\></dt>
<dd>close loops during frag insertion and jump mover -- can be expensive<br/>Default: false<br/></dd>
<dt><b>-heat</b> \<Boolean\></dt>
<dd>Heat (random frag insertions)<br/>Default: false<br/></dd>
<dt><b>-staged_constraints</b> \<Boolean\></dt>
<dd>Apply constraints in stages depending on sequence separation<br/>Default: false<br/></dd>
<dt><b>-jump_library_file</b> \<String\></dt>
<dd>Input file for jumps<br/>Default: "RNA18_HUB_2.154_2.5.jump"<br/></dd>
<dt><b>-vall_torsions</b> \<String\></dt>
<dd>Torsions file containing information on fragments from RNA models<br/>Default: "RNA18_HUB_2.154_2.5.torsions"<br/></dd>
<dt><b>-use_1jj2_torsions</b> \<Boolean\></dt>
<dd>Use original (ribosome) fragments, 1JJ2<br/>Default: false<br/></dd>
<dt><b>-fuzz_fragments</b> \<Real\></dt>
<dd>When picking fragments, fuzz fragments with multiple samples with Gaussians of this standard deviation<br/>Default: 0<br/></dd>
<dt><b>-rna_lores_chainbreak_weight</b> \<Real\></dt>
<dd>chainbreak weight for lo res sampling<br/>Default: 0.0<br/></dd>
<dt><b>-rna_lores_linear_chainbreak_weight</b> \<Real\></dt>
<dd>linear chainbreak weight for lo res sampling<br/>Default: 0.0<br/></dd>
<dt><b>-fixed_stems</b> \<Boolean\></dt>
<dd>Seed each stem with a Watson-Crick base pair instead of having the strands find each other<br/>Default: false<br/></dd>
<dt><b>-allow_bulge</b> \<Boolean\></dt>
<dd>Automatically virtualize residues that are not energetically stable<br/>Default: false<br/></dd>
<dt><b>-allowed_bulge_res</b> \<IntegerVector\></dt>
<dd>Use with allow_bulge, allowable pos for virtualization<br/>Default: []<br/></dd>
<dt><b>-allow_consecutive_bulges</b> \<Boolean\></dt>
<dd>allow_consecutive_bulges<br/>Default: false<br/></dd>
<dt><b>-move_first_rigid_body</b> \<Boolean\></dt>
<dd>first_rigid_body is usually kept frozen, but might be useful to sample it.<br/>Default: false<br/></dd>
<dt><b>-root_at_first_rigid_body</b> \<Boolean\></dt>
<dd>places coordinate system away from the usual last virtual residue and puts it on the first rigid body. useful if this rigidbody needs to be fixed, but other bodies need to move as if this one is moving. Use with -move_first_rigid_body. <br/>Default: false<br/></dd>
<dt><b>-dock_each_chunk</b> \<Boolean\></dt>
<dd>Dock each chunk, set fold tree up so that there are jumps from root virtual residue to all chunks, very useful for optimizing positions in density, use with -new_fold_tree_initializer<br/>Default: true<br/></dd>
<dt><b>-dock_each_chunk_per_chain</b> \<Boolean\></dt>
<dd>Dock each chunk, including multiple chunks from the same chain, set fold tree up so that there are jumps from root virtual residue to all chunks, very useful for optimizing positions in density, use with -dock_each_chunk and -new_fold_tree_initializer, may also want to use with -initial_structures<br/>Default: false<br/></dd>
<dt><b>-center_jumps_in_single_stranded</b> \<Boolean\></dt>
<dd>For RNA chains that don't have any base pairs, set up jumps in the center rather than at the first residue in the chain, use with -new_fold_tree_initializer and -dock_each_chunk<br/>Default: false<br/></dd>
<dt><b>-initial_structures</b> \<FileVector\></dt>
<dd>Initial structure for fragment assembly, useful for initializing rigid body orientations for docking especially with density<br/>Default: ""<br/></dd>
<dt><b>-helical_substructs</b> \<FileVector\></dt>
<dd>Files provided with -s or -in:file:silent that represent helices, use with dock_each_chunk_per_chain and -new_fold_tree_initializer, includes moves that rotate and translate these helices along their helical axis<br/>Default: ""<br/></dd>
<dt><b>-suppress_bp_constraint</b> \<Real\></dt>
<dd>Factor by which to lower base pair constraint weight. <br/>Default: 1.0<br/></dd>
<dt><b>-output_filters</b> \<Boolean\></dt>
<dd>output lores scores at early stage (round  2 of 10) and at end -- could be useable for early termination of unpromising early starts<br/>Default: false<br/></dd>
<dt><b>-autofilter</b> \<Boolean\></dt>
<dd>Automatically skip output/minimize if lores score is worse than 20th percentile, updated on the fly.<br/>Default: true<br/></dd>
<dt><b>-no_filters</b> \<Boolean\></dt>
<dd>Turn off filters in FARFAR. (umbrella flag) -autofilter false -filter_lores_base_pairs false -filter_lores_base_pairs_early false -filter_chain_closure false -filter_chain_closure_halfway false -filter_chain_closure_distance false<br/>Default: false<br/></dd>
<dt><b>-output_res_num</b> \<ResidueChainVector\></dt>
<dd>Numbering (and chain) of residues in output PDB or silent file<br/>Default: []<br/></dd>
<dt><b>-offset</b> \<Integer\></dt>
<dd>Numbering offset for output PDB or silent file (better to use -output_res_num))<br/>Default: 0<br/></dd>
<dt><b>-input_silent_res</b> \<ResidueChainVector\></dt>
<dd>Input residues for silent files<br/>Default: []<br/></dd>
<dt><b>-virtual_anchor</b> \<ResidueChainVector\></dt>
<dd>In rigid body movements, which residues in each body are rotation centers<br/>Default: []<br/></dd>
<dt><b>-obligate_pair</b> \<ResidueChainVector\></dt>
<dd>Residue pairs that must form a base pair (possibly non canonical)<br/>Default: []<br/></dd>
<dt><b>-obligate_pair_explicit</b> \<StringVector\></dt>
<dd>Residue pairs that must form a base pair, with specification of base edges (W/H/S/X) and orientation (A/P/X or C/T/X)<br/>Default: []<br/></dd>
<dt><b>-chain_connection</b> \<StringVector\></dt>
<dd>Give SET1 ... and SET2 ... to define segments forming at least one base pair<br/>Default: []<br/></dd>
<dt><b>-remove_pair</b> \<ResidueChainVector\></dt>
<dd>Residue pairs to remove from secondary structure<br/>Default: []<br/></dd>
<dt><b>-remove_obligate_pair</b> \<ResidueChainVector\></dt>
<dd>Residue pairs to remove from obligate pair list<br/>Default: []<br/></dd>
<dt><b>-refine_silent_file</b> \<String\></dt>
<dd>Name of the silent file to be refined.<br/>Default: ""<br/></dd>
<dt><b>-refine_silent_tags</b> \<StringVector\></dt>
<dd>Tags of structures from the silent file to be refined.<br/></dd>
<dt><b>-refine_silent_number_of_poses</b> \<Integer\></dt>
<dd>Number of low scoring poses to refine from the refine_silent_file<br/>Default: 0<br/></dd>
<dt><b>-get_fold_tree_from_silent_file</b> \<String\></dt>
<dd>Use the fold tree specified in a silent file<br/>Default: ""<br/></dd>
<dt><b>-fold_tree_from_silent_file_tag</b> \<StringVector\></dt>
<dd>Tag of the structure in the get_fold_tree_from_silent_file to use<br/></dd>
<dt><b>-refine_native_get_good_FT</b> \<Boolean\></dt>
<dd>Get a reasonable fold tree when refining native - especially important if some stuff shold stay fixed<br/>Default: false<br/></dd>
<dt><b>-refine_native</b> \<Boolean\></dt>
<dd>Refine starting from the native pose<br/>Default: false<br/></dd>
<dt><b>-override_refine_pose_rounds</b> \<Boolean\></dt>
<dd>Override rounds/other run parameters that get set if refining pose<br/>Default: false<br/></dd>
<dt><b>-bps_moves</b> \<Boolean\></dt>
<dd>Base pair step moves<br/>Default: true<br/></dd>
<dt><b>-disallow_bps_at_extra_min_res</b> \<Boolean\></dt>
<dd>Disallow base pair step moves inside input domains, even extra_min_res<br/>Default: false<br/></dd>
<dt><b>-allow_fragment_moves_in_bps</b> \<Boolean\></dt>
<dd>Allow fragment/jump moves in regions claimed by base pair steps<br/>Default: false<br/></dd>
<dt><b>-frag_size</b> \<Integer\></dt>
<dd>Force specific fragment size rather than staged from 3 to 2 to 1<br/>Default: 0<br/></dd>
<dt><b>-VDW_rep_screen_include_sidechains</b> \<Boolean\></dt>
<dd>Include side chains in the VDW rep screen, use with -VDW_rep_screen_info<br/>Default: true<br/></dd>
<dt><b>-gradual_constraints</b> \<Boolean\></dt>
<dd>Gradually turn on the atom_pair_constraints and coordinate_constraints?<br/>Default: true<br/></dd>
<dt><b>-ramp_rnp_vdw</b> \<Boolean\></dt>
<dd>Gradually turn on rnp_vdw?<br/>Default: false<br/></dd>
<dt><b>-grid_vdw_weight</b> \<Real\></dt>
<dd>Weight for the grid vdw score term<br/>Default: 1.0<br/></dd>
<dt><b>-tag</b> \<String\></dt>
<dd>tag for naming silent file; legacy of rna_denovo_setup.py<br/>Default: ""<br/></dd>
<dt><b>-working_native</b> \<String\></dt>
<dd>Native to use if we only know a fragment<br/>Default: "false"<br/></dd>
<dt><b>-use_legacy_setup</b> \<Boolean\></dt>
<dd>Use old de novo setup without residue/chain mapping<br/>Default: false<br/></dd>
<dt><b>-cst_gap</b> \<Boolean\></dt>
<dd>Setup up atompair constraints to keep chain ends close if they are known to be part of the same chain in full model pose<br/>Default: false<br/></dd>
<dt><b>-convert_protein_CEN</b> \<Boolean\></dt>
<dd>Convert protein residues to centroid mode during low-res fragment assembly<br/>Default: true<br/></dd>
<dt><b>-rna_protein_docking</b> \<Boolean\></dt>
<dd>Do RNA/protein docking?<br/>Default: false<br/></dd>
<dt><b>-small_docking_moves</b> \<Boolean\></dt>
<dd>Use small translation and rotation perturbation magnitudes<br/>Default: false<br/></dd>
<dt><b>-docking_move_size</b> \<Real\></dt>
<dd>Size of docking moves, between 0.0 and 1.0, 1.0 is normal docking move sizes, 0.0 is smallest docking moves<br/>Default: 1.0<br/></dd>
<dt><b>-rna_protein_docking_legacy</b> \<Boolean\></dt>
<dd>Do RNA/protein docking, legacy style?<br/>Default: false<br/></dd>
<dt><b>-rnp_high_res_relax</b> \<Boolean\></dt>
<dd>Do additional high res relaxation/refinement stage for RNPs<br/>Default: true<br/></dd>
<dt><b>-rnp_high_res_cycles</b> \<Integer\></dt>
<dd>Number of RNP high res refinement cycles to do<br/>Default: 10<br/></dd>
<dt><b>-rnp_pack_first</b> \<Boolean\></dt>
<dd>Pack protein sidechains first in RNP high res mover<br/>Default: false<br/></dd>
<dt><b>-rnp_min_first</b> \<Boolean\></dt>
<dd>Minimize the structure before RNP high res mover is applied<br/>Default: false<br/></dd>
<dt><b>-rnp_ramp_rep</b> \<Boolean\></dt>
<dd>Ramp fa_rep in RNP high res mover<br/>Default: false<br/></dd>
<dt><b>-new_fold_tree_initializer</b> \<Boolean\></dt>
<dd>Use the new fold tree initializer framework<br/>Default: false<br/></dd>
<dt><b>-randomize_init_rnp</b> \<Boolean\></dt>
<dd>Randomize the initial rigid body position and orientation of the RNA relative to proteins<br/>Default: true<br/></dd>
<dt><b>-dock_into_density</b> \<Boolean\></dt>
<dd>Do rigid body transforms to dock the pose into the density?<br/>Default: false<br/></dd>
<dt><b>-dock_into_density_legacy</b> \<Boolean\></dt>
<dd>Do rigid body transforms to dock the pose into the density legacy style?<br/>Default: false<br/></dd>
<dt><b>-exclude_fragments</b> \<IntegerVector\></dt>
<dd>Exclude these fragments from vall<br/>Default: []<br/></dd>
<dt><b>-exclusion_match_type</b> \<String\></dt>
<dd>How tightly should we match fragments? Either sequence-independent (MATCH_ALL), purine vs. pyrimidine (MATCH_YR), or exact (MATCH_EXACT)<br/>Default: "MATCH_EXACT"<br/></dd>
<dt><b>-fragment_homology_rmsd</b> \<Real\></dt>
<dd>Distance in RMSD below which a fragment is considered homologous to the native<br/>Default: 1.0<br/></dd>
<dt><b>-exclude_native_fragments</b> \<Boolean\></dt>
<dd>Exclude fragments from -in:file:native<br/>Default: false<br/></dd>
<dt><b>-exclude_fragment_files</b> \<StringVector\></dt>
<dd>Files from which to exclude fragments<br/>Default: []<br/></dd>
<dt><b>-dump_stems</b> \<Boolean\></dt>
<dd>Dump initial stem assignment<br/>Default: false<br/></dd>
</dl>
+ <h4>-rna:denovo:out</h4>
<dl>
<dt><b>-out</b> \<Boolean\></dt>
<dd>out option group<br/></dd>
<dt><b>-output_lores_silent_file</b> \<Boolean\></dt>
<dd>output lores stuff<br/>Default: false<br/></dd>
<dt><b>-dump</b> \<Boolean\></dt>
<dd>Dump pdb<br/>Default: false<br/></dd>
<dt><b>-binary_output</b> \<Boolean\></dt>
<dd>force output to binary rna silentstruct<br/>Default: false<br/></dd>
<dt><b>-output_score_file</b> \<String\></dt>
<dd>output running score to this file [specify 'none' if no score output; .SCORES.txt in default]<br/>Default: ""<br/></dd>
<dt><b>-output_score_frequency</b> \<Integer\></dt>
<dd>output running score with this frequency [0 means no running output]<br/>Default: 0<br/></dd>
<dt><b>-output_jump_res</b> \<ResidueChainVector\></dt>
<dd>output jump information for these two residues<br/></dd>
<dt><b>-output_jump_o3p_to_o5p</b> \<Boolean\></dt>
<dd>compute jump from o3' to o5' (instead of base centroid coordinate systems)<br/>Default: false<br/></dd>
<dt><b>-output_jump_chainbreak</b> \<Boolean\></dt>
<dd>compute jump from lower chainbreak triad to upper chainbreak triad; perfect overlapwill be (Vector(0.0), identity matrix). <br/>Default: false<br/></dd>
<dt><b>-output_rotation_vector</b> \<Boolean\></dt>
<dd>output rotation information as rotation vector (in degrees), not euler angles<br/>Default: false<br/></dd>
<dt><b>-output_jump_reference_RT</b> \<String\></dt>
<dd>output jump information relative to this rigid body transformation [if empty provided, code will error out but give reference RT for -native or -align_pdb]<br/>Default: ""<br/></dd>
<dt><b>-target_xyz</b> \<RealVector\></dt>
<dd>Target coordinates for harmonic penalty, o5' relative to o3' stub<br/>Default: []<br/></dd>
<dt><b>-save_jump_histogram</b> \<Boolean\></dt>
<dd>Save jump information into a 6D histogram<br/>Default: false<br/></dd>
<dt><b>-output_histogram_file</b> \<String\></dt>
<dd>output histogram to this file [specify 'none' if no score output; .HISTOGRAM.txt is default]<br/>Default: ""<br/></dd>
<dt><b>-jump_histogram_boxsize</b> \<Real\></dt>
<dd>Boxsize (max +/-x,y,z), Angstroms<br/>Default: 40.0<br/></dd>
<dt><b>-jump_histogram_binwidth</b> \<Real\></dt>
<dd>Bin-width for x,y,z,, Angstroms<br/>Default: 4.0<br/></dd>
<dt><b>-jump_histogram_binwidth_rotvector</b> \<Real\></dt>
<dd>Bin-width for rotation vector (degrees)<br/>Default: 36.0<br/></dd>
</dl>
+ <h4>-rna:denovo:db</h4>
<dl>
<dt><b>-db</b> \<Boolean\></dt>
<dd>db option group<br/></dd>
<dt><b>-jump_database</b> \<Boolean\></dt>
<dd>Generate a database of jumps extracted from base pairings from a big RNA file<br/>Default: false<br/></dd>
<dt><b>-bps_database</b> \<Boolean\></dt>
<dd>Generate a database of base pair steps extracted from a big RNA file<br/>Default: false<br/></dd>
</dl>
+ <h4>-rna:denovo:minimize</h4>
<dl>
<dt><b>-minimize</b> \<Boolean\></dt>
<dd>minimize option group<br/></dd>
<dt><b>-minimize_rounds</b> \<Integer\></dt>
<dd>The number of rounds of minimization.<br/>Default: 2<br/></dd>
<dt><b>-skip_coord_constraints</b> \<Boolean\></dt>
<dd>Skip first stage of minimize with coordinate constraints<br/>Default: false<br/></dd>
<dt><b>-skip_o2prime_trials</b> \<Boolean\></dt>
<dd>No O2* packing in minimizer<br/>Default: false<br/></dd>
<dt><b>-deriv_check</b> \<Boolean\></dt>
<dd>In rna_minimize, check derivatives numerically<br/>Default: false<br/></dd>
<dt><b>-minimizer_use_coordinate_constraints</b> \<Boolean\></dt>
<dd>Use coordinate constraints for first round of minimizer<br/>Default: true<br/></dd>
<dt><b>-min_type</b> \<String\></dt>
<dd>Minimizer type<br/>Default: "lbfgs_armijo_nonmonotone"<br/></dd>
<dt><b>-minimize_bps</b> \<Boolean\></dt>
<dd>Minimize base pair steps (from Rosetta library)<br/>Default: true<br/></dd>
<dt><b>-minimize_all_protein</b> \<Boolean\></dt>
<dd>Minimize protein residues?<br/>Default: false<br/></dd>
<dt><b>-minimize_protein_sc</b> \<Boolean\></dt>
<dd>Minimize protein sidechains?<br/>Default: false<br/></dd>
<dt><b>-protein_packing</b> \<Boolean\></dt>
<dd>Pack protein residues?<br/>Default: false<br/></dd>
<dt><b>-protein_pack_all</b> \<Boolean\></dt>
<dd>Pack all protein residues?<br/>Default: false<br/></dd>
<dt><b>-protein_packing_distance</b> \<Real\></dt>
<dd>Pack protein residues within this distance of RNA<br/>Default: 10.0<br/></dd>
<dt><b>-extra_minimize_res</b> \<ResidueChainVector\></dt>
<dd>Extra residues during minimize step<br/>Default: []<br/></dd>
<dt><b>-extra_minimize_chi_res</b> \<ResidueChainVector\></dt>
<dd>Extra side-chain chis to move during minimize step<br/>Default: []<br/></dd>
<dt><b>-minimize_use_nblist</b> \<Boolean\></dt>
<dd>Use neighbor list during minimization)<br/>Default: true<br/></dd>
<dt><b>-minimize_nblist_auto_update</b> \<Boolean\></dt>
<dd>Auto-update neighbor list during minimization)<br/>Default: true<br/></dd>
<dt><b>-minimize_max_iter</b> \<Integer\></dt>
<dd>Maximum number of iterations in minimizer<br/>Default: 2000<br/></dd>
</dl>
+ <h3>-rna:erraser</h3>
<dl>
<dt><b>-erraser</b> \<Boolean\></dt>
<dd>erraser option group<br/></dd>
<dt><b>-rna_prot_erraser</b> \<Boolean\></dt>
<dd>Allows rna_prot_erraser residue type set, featuring both RNA and protein (for ERRASER purposes).  You must also use -rna:corrected_geo.<br/>Default: false<br/></dd>
<dt><b>-constrain_P</b> \<Boolean\></dt>
<dd>constrain phosphate<br/>Default: false<br/></dd>
<dt><b>-fixed_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues to be held fixed in minimizer<br/>Default: []<br/></dd>
<dt><b>-ready_set_only</b> \<Boolean\></dt>
<dd>load in and output directly for reformatting the pdb<br/>Default: false<br/></dd>
<dt><b>-skip_minimize</b> \<Boolean\></dt>
<dd>output the pdb without minimization<br/>Default: false<br/></dd>
<dt><b>-attempt_pyrimidine_flip</b> \<Boolean\></dt>
<dd>try to flip pyrimidine by 180 degrees and pick the better energy conformer<br/>Default: false<br/></dd>
</dl>
+ <h2>-rotamerdump</h2>
<dl>
<dt><b>-rotamerdump</b> \<Boolean\></dt>
<dd>rotamerdump option group<br/></dd>
<dt><b>-xyz</b> \<Boolean\></dt>
<dd>when using the RotamerDump application, output the xyz coords of every rotamer<br/>Default: false<br/></dd>
<dt><b>-one_body</b> \<Boolean\></dt>
<dd>when using the RotamerDump application, output the one_body energies of every rotamer<br/>Default: false<br/></dd>
<dt><b>-two_body</b> \<Boolean\></dt>
<dd>when using the RotamerDump application, output the two_body energies of every rotamer<br/>Default: false<br/></dd>
<dt><b>-annealer</b> \<Boolean\></dt>
<dd>Run the annealer and output the rotamers it chose<br/>Default: false<br/></dd>
</dl>
+ <h2>-sample_around</h2>
<dl>
<dt><b>-sample_around</b> \<Boolean\></dt>
<dd>sample_around option group<br/></dd>
<dt><b>-alpha_increment</b> \<Real\></dt>
<dd>if sampling jump, rotation increment, in degrees<br/>Default: 40.0<br/></dd>
<dt><b>-cosbeta_increment</b> \<Real\></dt>
<dd>if sampling jump, cosbeta increment, no units<br/>Default: 0.25<br/></dd>
<dt><b>-gamma_increment</b> \<Real\></dt>
<dd>if sampling jump, rotation increment, in degrees<br/>Default: 40.0<br/></dd>
</dl>
+ <h2>-sicdock</h2>
<dl>
<dt><b>-sicdock</b> \<Boolean\></dt>
<dd>sicdock option group<br/></dd>
<dt><b>-clash_dis</b> \<Real\></dt>
<dd>max acceptable clash dis<br/>Default: 3.5<br/></dd>
<dt><b>-contact_dis</b> \<Real\></dt>
<dd>max acceptable contact dis<br/>Default: 12.0<br/></dd>
<dt><b>-hash_2D_vs_3D</b> \<Real\></dt>
<dd>grid spacing top 2D hash<br/>Default: 1.3<br/></dd>
</dl>
+ <h2>-legacy_sewing</h2>
<dl>
<dt><b>-legacy_sewing</b> \<Boolean\></dt>
<dd>legacy_sewing option group<br/></dd>
<dt><b>-model_file_name</b> \<File\></dt>
<dd>Filename for model file (creation or reading)<br/></dd>
<dt><b>-score_file_name</b> \<File\></dt>
<dd>Filename for scores file (creation or reading)<br/></dd>
<dt><b>-new_model_file_name</b> \<File\></dt>
<dd>Filename for new model file to be written<br/></dd>
<dt><b>-remove_any_dssp</b> \<String\></dt>
<dd>If a given model has *any* segments with this DSSP, remove it<br/>Default: ""<br/></dd>
<dt><b>-remove_all_dssp</b> \<String\></dt>
<dd>If a given model has *all* non-loop segments with this DSSP, remove it<br/>Default: ""<br/></dd>
<dt><b>-min_helix_length</b> \<Integer\></dt>
<dd>Helices less than supplied length will be removed from model file<br/>Default: 0<br/></dd>
<dt><b>-max_helix_length</b> \<Integer\></dt>
<dd>Helices greater than supplied length will be removed from model file<br/>Default: 1000<br/></dd>
<dt><b>-min_loop_length</b> \<Integer\></dt>
<dd>Loops less than supplied length will be removed from model file<br/>Default: 0<br/></dd>
<dt><b>-max_loop_length</b> \<Integer\></dt>
<dd>Loops greater than supplied length will be removed from model file<br/>Default: 1000<br/></dd>
<dt><b>-min_strand_length</b> \<Integer\></dt>
<dd>Strands less than supplied length will be removed from model file<br/>Default: 0<br/></dd>
<dt><b>-max_strand_length</b> \<Integer\></dt>
<dd>Strands greater than supplied length will be removed from model file<br/>Default: 1000<br/></dd>
<dt><b>-leave_models_by_ss_num</b> \<Boolean\></dt>
<dd>Only models with certain number of secondary structures remain<br/>Default: false<br/></dd>
<dt><b>-model_should_have_this_num_of_ss</b> \<Integer\></dt>
<dd>Only models with this number of secondary structures remain<br/></dd>
<dt><b>-model_should_have_at_least_1_E_at_terminal_segment</b> \<Boolean\></dt>
<dd>model_should_have_at_least_one_E_at_terminal_segment<br/>Default: false<br/></dd>
<dt><b>-model_should_have_at_least_1_E</b> \<Boolean\></dt>
<dd>model_should_have_at_least_one_E<br/>Default: false<br/></dd>
<dt><b>-model_should_have_at_least_1_H</b> \<Boolean\></dt>
<dd>model_should_have_at_least_one_H<br/>Default: false<br/></dd>
<dt><b>-leave_models_with_E_terminal_ss</b> \<Boolean\></dt>
<dd>leave only models_with_E_terminal_ss<br/>Default: false<br/></dd>
<dt><b>-leave_models_with_H_terminal_ss</b> \<Boolean\></dt>
<dd>leave only models_with_H_terminal_ss<br/>Default: false<br/></dd>
<dt><b>-leave_antiparallel_way_H_bonded_models_by_terminal_strands</b> \<Boolean\></dt>
<dd>leave only anti-pa H_bonded_models by_terminal_strands<br/>Default: false<br/></dd>
<dt><b>-leave_parallel_way_H_bonded_models_by_terminal_strands</b> \<Boolean\></dt>
<dd>leave only pa H_bonded_models by_terminal_strands<br/>Default: false<br/></dd>
<dt><b>-leave_certain_model_ids</b> \<Boolean\></dt>
<dd>Only models with selected ids are left<br/>Default: false<br/></dd>
<dt><b>-leave_these_model_ids</b> \<String\></dt>
<dd>Only models with selected ids are left<br/></dd>
<dt><b>-box_length</b> \<Integer\></dt>
<dd>Neighborhood lookup box size, 3 for 27 boxes, 4 for 64 boxes etc<br/>Default: 3<br/></dd>
<dt><b>-mode</b> \<String\></dt>
<dd>The mode sewing_hasher should run.<br/>Default: "hash"<br/></dd>
<dt><b>-disregard_num_segment_matches</b> \<Boolean\></dt>
<dd>if true, disregard num_segment_matches<br/></dd>
<dt><b>-do_not_remove_connection_inconsistencies</b> \<Boolean\></dt>
<dd>if true, do not remove_connection_inconsistencies<br/></dd>
<dt><b>-score_between_opposite_terminal_segments</b> \<Boolean\></dt>
<dd>if true, score_between_opposite_terminal_segments like 1-5 or 5-1<br/>Default: true<br/></dd>
<dt><b>-num_models_to_dump</b> \<Integer\></dt>
<dd>Used for ModelDumper. How many random models should be dumped?<br/></dd>
<dt><b>-models_to_dump</b> \<IntegerVector\></dt>
<dd>Used for ModelDumper for specifying model ids you want to dump<br/></dd>
<dt><b>-min_hash_score</b> \<Integer\></dt>
<dd>Minimum number of overlapping atoms per segment<br/>Default: 10<br/></dd>
<dt><b>-max_clash_score</b> \<Integer\></dt>
<dd>Maximum number of atoms found in the same bin, but not from superimposed fragments<br/>Default: 0<br/></dd>
<dt><b>-num_segments_to_match</b> \<Integer\></dt>
<dd>Number of segments required to have min_hash_score atom matches<br/>Default: 1<br/></dd>
<dt><b>-match_segments</b> \<IntegerVector\></dt>
<dd>Segment scored by the hasher<br/></dd>
<dt><b>-max_models</b> \<Integer\></dt>
<dd>Maximum models to hash, for testing purposes only<br/></dd>
<dt><b>-starting_model</b> \<Integer\></dt>
<dd>Starting model for hashing<br/></dd>
<dt><b>-num_procs</b> \<Integer\></dt>
<dd>Number of processors to split up hashing with<br/></dd>
<dt><b>-rank</b> \<Integer\></dt>
<dd>The processor rank for this process<br/></dd>
<dt><b>-hash_tag_only_terminal_Es</b> \<Boolean\></dt>
<dd>hash_tag_only_terminal_Es<br/>Default: false<br/></dd>
<dt><b>-assembly_type</b> \<String\></dt>
<dd>Type of Assembly class to generate<br/>Default: "continuous"<br/></dd>
<dt><b>-num_edges_to_follow</b> \<Integer\></dt>
<dd>Maximum number of edges on graph to follow<br/></dd>
<dt><b>-base_native_bonus</b> \<Real\></dt>
<dd>Weighting term for packing native rotamers<br/></dd>
<dt><b>-neighbor_cutoff</b> \<Integer\></dt>
<dd>Cutoff for favoring natives in SEWING refinement. Any residues with fewer neighbors is not favored<br/></dd>
<dt><b>-dump_pdbs</b> \<Boolean\></dt>
<dd>Dump intermediate PDBs<br/>Default: false<br/></dd>
<dt><b>-skip_refinement</b> \<Boolean\></dt>
<dd>Should you refine the final assembly<br/>Default: false<br/></dd>
<dt><b>-skip_filters</b> \<Boolean\></dt>
<dd>Should the Assembly be filtered before refinment<br/>Default: false<br/></dd>
<dt><b>-min_motif_score</b> \<Real\></dt>
<dd>Minimum allowable motif score<br/>Default: 20<br/></dd>
<dt><b>-may_add_already_added_model</b> \<Boolean\></dt>
<dd>may_add_already_added_model<br/>Default: false<br/></dd>
<dt><b>-offset_bump_dsq</b> \<Real\></dt>
<dd>offset to bump_dsq<br/>Default: 0<br/></dd>
<dt><b>-num_repeats</b> \<Integer\></dt>
<dd>Number of repeats to print in final structures<br/>Default: 3<br/></dd>
<dt><b>-repeat</b> \<Boolean\></dt>
<dd>Should the AssemblyConstraintsMover treat this as a repeat?<br/>Default: false<br/></dd>
<dt><b>-pose_segment_starts</b> \<IntegerVector\></dt>
<dd>Segment begin indices<br/></dd>
<dt><b>-pose_segment_ends</b> \<IntegerVector\></dt>
<dd>Segment end indices<br/></dd>
<dt><b>-keep_source_segments</b> \<Boolean\></dt>
<dd>Keep the source segments rather than the target segments. For use with append<br/>Default: false<br/></dd>
<dt><b>-partner_pdb</b> \<File\></dt>
<dd>A PDB that is not part of the Assembly, but will be used for clash checking<br/></dd>
<dt><b>-keep_model_residues</b> \<IntegerVector\></dt>
<dd>A list of residues from the input pose that will not be designed (but are repacked)<br/></dd>
<dt><b>-output_alignments_to_file</b> \<Boolean\></dt>
<dd>Write alignments of input pose and edge file to an alignment file?<br/>Default: true<br/></dd>
<dt><b>-min_lh_fragments</b> \<Integer\></dt>
<dd>Minimium number of LoopHash fragments necessary for each designed loop<br/>Default: 10<br/></dd>
<dt><b>-skip_loop_generation</b> \<Boolean\></dt>
<dd>Should you skip generation of loops<br/>Default: false<br/></dd>
<dt><b>-calcium_motif_score_weight</b> \<Real\></dt>
<dd>Sets weight of motif score variant that promotes packing on both sides of an input model<br/>Default: 0.0<br/></dd>
<dt><b>-max_ss_num</b> \<Integer\></dt>
<dd>max_ss_num so either 3 (smotif) or 5 (5-ss_models)<br/>Default: 5<br/></dd>
<dt><b>-dump_every_model</b> \<Boolean\></dt>
<dd>dump_every_model<br/>Default: false<br/></dd>
</dl>
+ <h2>-sewing</h2>
<dl>
<dt><b>-sewing</b> \<Boolean\></dt>
<dd>sewing option group<br/></dd>
<dt><b>-edge_file_name</b> \<String\></dt>
<dd>Name of SEWING edge file (new format)<br/></dd>
<dt><b>-model_file_name</b> \<File\></dt>
<dd>Filename for segment file (creation or reading) for new SEWING<br/></dd>
<dt><b>-match_segments</b> \<IntegerVector\></dt>
<dd>Segment scored by the hasher<br/></dd>
<dt><b>-pose_segment_starts</b> \<IntegerVector\></dt>
<dd>Segment begin indices<br/></dd>
<dt><b>-pose_segment_ends</b> \<IntegerVector\></dt>
<dd>Segment end indices<br/></dd>
<dt><b>-recursive_depth</b> \<Integer\></dt>
<dd>How many layers of edges from the current node to generate? E.g. a recursive depth of 2 would generate edges from the starting model and to all models with edges to that model.<br/>Default: 2<br/></dd>
<dt><b>-min_hash_score</b> \<Integer\></dt>
<dd>Minimum number of overlapping atoms per segment<br/>Default: 10<br/></dd>
<dt><b>-max_clash_score</b> \<Integer\></dt>
<dd>Maximum number of atoms found in the same bin, but not from superimposed fragments<br/>Default: 0<br/></dd>
<dt><b>-box_length</b> \<Integer\></dt>
<dd>Neighborhood lookup box size, 3 for 27 boxes, 4 for 64 boxes etc<br/>Default: 3<br/></dd>
<dt><b>-score_between_opposite_terminal_segments</b> \<Boolean\></dt>
<dd>if true, score_between_opposite_terminal_segments like 1-5 or 5-1<br/>Default: true<br/></dd>
</dl>
+ <h2>-SSrbrelax</h2>
<dl>
<dt><b>-SSrbrelax</b> \<Boolean\></dt>
<dd>SSrbrelax option group<br/></dd>
<dt><b>-rb_file</b> \<File\></dt>
<dd>rb definition file<br/>Default: "rb_file"<br/></dd>
<dt><b>-rb_param_file</b> \<File\></dt>
<dd>rb param file<br/>Default: "rb_param_file"<br/></dd>
<dt><b>-frag_sizes</b> \<IntegerVector\></dt>
<dd>lengths of fragments to be used in loop modeling<br/>Default: ['9', '3', '1']<br/></dd>
<dt><b>-frag_files</b> \<FileVector\></dt>
<dd>fragment libraries files<br/>Default: ['"FragFile9"', '"FragFile3"', '"FragFile1"']<br/></dd>
</dl>
+ <h2>-stepwise</h2>
<dl>
<dt><b>-stepwise</b> \<Boolean\></dt>
<dd>stepwise option group<br/></dd>
<dt><b>-s1</b> \<StringVector\></dt>
<dd>input file(s)<br/></dd>
<dt><b>-s2</b> \<StringVector\></dt>
<dd>input file(s)<br/></dd>
<dt><b>-silent1</b> \<StringVector\></dt>
<dd>input file<br/></dd>
<dt><b>-silent2</b> \<StringVector\></dt>
<dd>input file<br/></dd>
<dt><b>-tags1</b> \<StringVector\></dt>
<dd>input tag(s)<br/></dd>
<dt><b>-tags2</b> \<StringVector\></dt>
<dd>input tag(s)<br/></dd>
<dt><b>-slice_res1</b> \<IntegerVector\></dt>
<dd>Residues to slice out of starting file<br/>Default: []<br/></dd>
<dt><b>-slice_res2</b> \<IntegerVector\></dt>
<dd>Residues to slice out of starting file<br/>Default: []<br/></dd>
<dt><b>-input_res1</b> \<IntegerVector\></dt>
<dd>Residues already present in starting file<br/>Default: []<br/></dd>
<dt><b>-input_res2</b> \<IntegerVector\></dt>
<dd>Residues already present in starting file2<br/>Default: []<br/></dd>
<dt><b>-backbone_only1</b> \<Boolean\></dt>
<dd>just copy protein backbone DOFS, useful for homology modeling<br/></dd>
<dt><b>-backbone_only2</b> \<Boolean\></dt>
<dd>just copy protein backbone DOFS, useful for homology modeling<br/></dd>
<dt><b>-fixed_res</b> \<IntegerVector\></dt>
<dd>Do not move these residues during minimization.<br/>Default: []<br/></dd>
<dt><b>-test_encapsulation</b> \<Boolean\></dt>
<dd>Test ability StepWiseRNA Modeler to figure out what it needs from just the pose - no JobParameters<br/>Default: false<br/></dd>
<dt><b>-choose_random</b> \<Boolean\></dt>
<dd>ask swa residue sampler for a random solution<br/>Default: false<br/></dd>
<dt><b>-num_random_samples</b> \<Integer\></dt>
<dd>In choose_random/monte-carlo mode, number of samples from swa residue sampler before minimizing best<br/>Default: 20<br/></dd>
<dt><b>-max_tries_multiplier_for_ccd</b> \<Integer\></dt>
<dd>In choose_random/monte-carlo mode, when CCD closure needs to occur, multiple # tries by this factor<br/>Default: 10<br/></dd>
<dt><b>-num_pose_minimize</b> \<Integer\></dt>
<dd>optional: set_num_pose_minimize by Minimizer<br/>Default: 0<br/></dd>
<dt><b>-atr_rep_screen</b> \<Boolean\></dt>
<dd>In sampling, screen for contacts (but no clash) between partitions before packing<br/>Default: true<br/></dd>
<dt><b>-atr_rep_screen_for_docking</b> \<Boolean\></dt>
<dd>In just docking moves, screen for contacts (but no clash) between partitions before packing<br/>Default: false<br/></dd>
<dt><b>-align_pdb</b> \<String\></dt>
<dd>PDB to align to. Default will be -native, or no alignment<br/>Default: ""<br/></dd>
<dt><b>-new_align_pdb</b> \<String\></dt>
<dd>PDB to align to with the new RNA_AlignmentEnergy.<br/>Default: ""<br/></dd>
<dt><b>-enumerate</b> \<Boolean\></dt>
<dd>For SWM. Force enumeration (SWA-like) instead of random<br/>Default: false<br/></dd>
<dt><b>-preminimize</b> \<Boolean\></dt>
<dd>For SWM. Just prepack and minimize<br/>Default: false<br/></dd>
<dt><b>-skip_preminimize</b> \<Boolean\></dt>
<dd>Skip preminimize before stepwise monte carlo<br/>Default: false<br/></dd>
<dt><b>-minimize_waters</b> \<Boolean\></dt>
<dd>When hydrating magnesiums, minimize any waters that appear<br/>Default: false<br/></dd>
<dt><b>-test_all_moves</b> \<Boolean\></dt>
<dd>Try all moves from starting pose, recursing through additions <br/>Default: false<br/></dd>
<dt><b>-new_move_selector</b> \<Boolean\></dt>
<dd>For SWM. Use new move selector which does keep track of proposal probabilities.<br/>Default: true<br/></dd>
<dt><b>-dump</b> \<Boolean\></dt>
<dd>Dump intermediate silent & PDB files<br/>Default: false<br/></dd>
<dt><b>-VERBOSE</b> \<Boolean\></dt>
<dd>VERBOSE<br/>Default: false<br/></dd>
<dt><b>-use_green_packer</b> \<Boolean\></dt>
<dd>use packer instead of rotamer trials for side-chain packing and O2' optimization<br/>Default: false<br/></dd>
<dt><b>-rmsd_screen</b> \<Real\></dt>
<dd>keep sampled residues within this rmsd from the native pose<br/>Default: 0.0<br/></dd>
<dt><b>-skip_minimize</b> \<Boolean\></dt>
<dd>Skip minimize, e.g. in prepack step<br/>Default: false<br/></dd>
<dt><b>-virtualize_packable_moieties_in_screening_pose</b> \<Boolean\></dt>
<dd>Virtualize 2'-OH, terminal phosphates in stepwise contact screening, before actual packing <br/>Default: false<br/></dd>
<dt><b>-minimizer_mode</b> \<String\></dt>
<dd>Minimize using thermal sampler (THERMAL_SAMPLER) or traditionally (TRADITIONAL_MINIMIZER, or really anything else)<br/>Default: "TRADITIONAL_MINIMIZER"<br/></dd>
<dt><b>-sampler_silent_file</b> \<String\></dt>
<dd>In StepWiseConnectionSampler, where to output all poses that pass filters<br/>Default: ""<br/></dd>
<dt><b>-superimpose_over_all</b> \<Boolean\></dt>
<dd>In final superimposition, do not keep any domains fixed, superimpose over everything<br/>Default: true<br/></dd>
<dt><b>-alignment_anchor_res</b> \<ResidueChainVector\></dt>
<dd>Single residue that resides in the single input domain that should be superimposed prior to RMSD calculation<br/></dd>
<dt><b>-move</b> \<StringVector\></dt>
<dd>For SWM. Format: 'ADD 5 BOND_TO_PREVIOUS 4'<br/>Default: []<br/></dd>
<dt><b>-min_type</b> \<String\></dt>
<dd>Minimizer type<br/>Default: "lbfgs_armijo_nonmonotone"<br/></dd>
<dt><b>-min_tolerance</b> \<Real\></dt>
<dd>Minimizer tolerance<br/>Default: 0.000025<br/></dd>
<dt><b>-output_minimized_pose_list</b> \<Boolean\></dt>
<dd>Use legacy output that puts out all minimized poses; set to true in legacy SWA<br/>Default: false<br/></dd>
<dt><b>-virtualize_free_moieties_in_native</b> \<Boolean\></dt>
<dd>Virtualize bulges, terminal phosphates, and 2' hydroxyls detected to be non-interacting ('free') in native pose. I.e., do not calculate RMSD over those atoms.<br/>Default: true<br/></dd>
<dt><b>-output_cluster_size</b> \<Boolean\></dt>
<dd>Output cluster_size in StepWiseClusterer as an extra score in the pose<br/>Default: false<br/></dd>
<dt><b>-lores</b> \<Boolean\></dt>
<dd>Use coarse-grained energy function to sample; no minimize.<br/>Default: false<br/></dd>
<dt><b>-verbose_sampler</b> \<Boolean\></dt>
<dd>verbose output from StepWiseConnectionSampler sample-and-screen.<br/>Default: false<br/></dd>
<dt><b>-pack_protein_side_chains</b> \<Boolean\></dt>
<dd>allow neighboring protein side chains to be packed.<br/>Default: true<br/></dd>
<dt><b>-definitely_virtualize</b> \<IntegerVector\></dt>
<dd>definitely virtualize these residues (by seqpos)<br/>Default: []<br/></dd>
<dt><b>-force_moving_res_for_erraser</b> \<Boolean\></dt>
<dd>For ERRASER resample moves, ENSURE that the appropriate residue is moving<br/>Default: false<br/></dd>
<dt><b>-boltzmann_choice_post_enumerated_minimize</b> \<Boolean\></dt>
<dd>When enumerating and generating a big pose list, make a Boltzmann-weighted choice rather than just getting the lowest energy pose.<br/>Default: false<br/></dd>
</dl>
+ <h3>-stepwise:monte_carlo</h3>
<dl>
<dt><b>-monte_carlo</b> \<Boolean\></dt>
<dd>monte_carlo option group<br/></dd>
<dt><b>-verbose_scores</b> \<Boolean\></dt>
<dd>Show all score components<br/>Default: false<br/></dd>
<dt><b>-skip_deletions</b> \<Boolean\></dt>
<dd>no delete moves -- just for testing<br/>Default: false<br/></dd>
<dt><b>-allow_internal_hinge_moves</b> \<Boolean\></dt>
<dd>Allow moves in which internal suites are sampled (hinge-like motions)<br/>Default: true<br/></dd>
<dt><b>-allow_internal_local_moves</b> \<Boolean\></dt>
<dd>Allow moves in which internal cutpoints are created to allow ERRASER rebuilds<br/>Default: true<br/></dd>
<dt><b>-allow_skip_bulge</b> \<Boolean\></dt>
<dd>Allow moves in which an intervening residue is skipped and the next one is modeled as floating base<br/>Default: false<br/></dd>
<dt><b>-skip_bulge_frequency</b> \<Real\></dt>
<dd>Compared to 'normal' add moves, how often to skip a bulge and do addition.<br/>Default: 0.0<br/></dd>
<dt><b>-from_scratch_frequency</b> \<Real\></dt>
<dd>Allow modeling of 'free' dinucleotides that are not part of input poses<br/>Default: 0.1<br/></dd>
<dt><b>-allow_split_off</b> \<Boolean\></dt>
<dd>Allow chunks that do not contain fixed domains to split off after nucleating on fixed domains.<br/>Default: true<br/></dd>
<dt><b>-cycles</b> \<Integer\></dt>
<dd>Number of Monte Carlo cycles<br/>Default: 50<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>Monte Carlo temperature<br/>Default: 1.0<br/></dd>
<dt><b>-add_proposal_density_factor</b> \<Real\></dt>
<dd>Increase/decrease the proposal_density_ratio for add moves by this factor<br/>Default: 1.0<br/></dd>
<dt><b>-add_delete_frequency</b> \<Real\></dt>
<dd>Frequency of add/delete vs. resampling<br/>Default: 0.5<br/></dd>
<dt><b>-docking_frequency</b> \<Real\></dt>
<dd>Frequency of docking vs. folding moves<br/>Default: 0.2<br/></dd>
<dt><b>-submotif_frequency</b> \<Real\></dt>
<dd>Frequency of submotif additions<br/>Default: 0.2<br/></dd>
<dt><b>-intermolecular_frequency</b> \<Real\></dt>
<dd>Same as -docking_frequency, to be deprecated soon<br/>Default: 0.2<br/></dd>
<dt><b>-minimize_single_res_frequency</b> \<Real\></dt>
<dd>Frequency with which to minimize the residue that just got rebuilt, instead of all<br/>Default: 0.0<br/></dd>
<dt><b>-allow_variable_bond_geometry</b> \<Boolean\></dt>
<dd>In 10% of moves, let bond angles & distance change<br/>Default: true<br/></dd>
<dt><b>-switch_focus_frequency</b> \<Real\></dt>
<dd>Frequency with which to switch the sub-pose that is being modeled<br/>Default: 0.5<br/></dd>
<dt><b>-just_min_after_mutation_frequency</b> \<Real\></dt>
<dd>After a mutation, how often to just minimize (without further sampling the mutated residue)<br/>Default: 0.5<br/></dd>
<dt><b>-local_redock_only</b> \<Boolean\></dt>
<dd>In ResampleMover, docking partners can change anywhere across connected chains. Force the new partners to be close to the old ones.<br/>Default: true<br/></dd>
<dt><b>-make_movie</b> \<Boolean\></dt>
<dd>create silent files in movie/ with all steps and accepted steps<br/>Default: false<br/></dd>
<dt><b>-recover_low</b> \<Boolean\></dt>
<dd>Output lowest energy model in monte carlo, not the last frame<br/>Default: true<br/></dd>
<dt><b>-use_precomputed_library</b> \<Boolean\></dt>
<dd>In from_scratch moves, do not sample dinucleotides explicitly, but instead use library saved to disk.<br/>Default: true<br/></dd>
<dt><b>-allow_submotif_split</b> \<Boolean\></dt>
<dd>for submotif moves, allow submotifs to be split. (inconsistent with detailed balance.)<br/>Default: false<br/></dd>
<dt><b>-force_submotif_without_intervening_bulge</b> \<Boolean\></dt>
<dd>for submotif moves, only add base pairs that have an attachment point and a cutpoint closed, with no intervening bulge<br/>Default: false<br/></dd>
<dt><b>-use_first_jump_for_submotif</b> \<Boolean\></dt>
<dd>for submotif moves, only use first jump from jump library -- does not change stepwise -lores (which resamples jump) except in balance of move selection.<br/>Default: false<br/></dd>
<dt><b>-exclude_submotifs</b> \<StringVector\></dt>
<dd>submotifs in database/sampling/rna/submotif/submotifs.txt to exclude<br/>Default: []<br/></dd>
<dt><b>-vary_loop_length_frequency</b> \<Real\></dt>
<dd>In design, allow loops ('n') to shorten from loop lengths defined in FASTA files.<br/>Default: 0.0<br/></dd>
<dt><b>-designing_with_noncanonicals</b> \<Boolean\></dt>
<dd>Are we designing with noncanonicals, meaning 'n' has to read from a set of possible symbols (instead of 4 canonical NAs)?<br/>Default: false<br/></dd>
<dt><b>-checkpointing_frequency</b> \<Integer\></dt>
<dd>How often should we output checkpoint files?<br/>Default: 100<br/></dd>
<dt><b>-continue_until_none_missing</b> \<Boolean\></dt>
<dd>If there are missing residues when we've reached n-cycles, just keep going! Suggested with checkpointing.<br/>Default: false<br/></dd>
<dt><b>-full_model_constraints</b> \<FileVector\></dt>
<dd>One or more files containing constraints to be applied in a 'full-model' setting, i.e., only in the Modeler and only once residues exist.<br/>Default: []<br/></dd>
</dl>
+ <h4>-stepwise:monte_carlo:csa</h4>
<dl>
<dt><b>-csa</b> \<Boolean\></dt>
<dd>csa option group<br/></dd>
<dt><b>-csa_bank_size</b> \<Integer\></dt>
<dd>Do conformational space annealing (population monte carlo) with this number of models in the bank<br/>Default: 0<br/></dd>
<dt><b>-csa_rmsd</b> \<Real\></dt>
<dd>RMSD cutoff for calling two poses different in conformational space annealing (population monte carlo)<br/>Default: 1.0<br/></dd>
<dt><b>-csa_output_rounds</b> \<Boolean\></dt>
<dd>output silent files at intermediate stages (at integral multiples of bank_size)<br/>Default: false<br/></dd>
<dt><b>-annealing</b> \<Boolean\></dt>
<dd>Actually anneal the RMSD from the half the average distance between first-bank models to one-fifth that distance<br/>Default: false<br/></dd>
</dl>
+ <h3>-stepwise:polar_hydrogens</h3>
<dl>
<dt><b>-polar_hydrogens</b> \<Boolean\></dt>
<dd>polar_hydrogens option group<br/></dd>
<dt><b>-vary_polar_hydrogen_geometry</b> \<Boolean\></dt>
<dd>Optimize hydrogens that form hydrogen bonds<br/>Default: false<br/></dd>
<dt><b>-bond_angle_sd_polar_hydrogen</b> \<Real\></dt>
<dd>Standard deviation for bond_geometry angle term with -vary_polar_hydrogen_geometry flag, in degrees<br/>Default: 60.0<br/></dd>
<dt><b>-bond_torsion_sd_polar_hydrogen</b> \<Real\></dt>
<dd>Standard deviation for bond_geometry torsion term with -vary_polar_hydrogen_geometry flag, in degrees<br/>Default: 30.0<br/></dd>
<dt><b>-fix_lengths</b> \<Boolean\></dt>
<dd>with -vary_geometry, disallow bond length change<br/>Default: false<br/></dd>
<dt><b>-fix_angles</b> \<Boolean\></dt>
<dd>with -vary_geometry, disallow  bond angle change<br/>Default: false<br/></dd>
<dt><b>-fix_torsions</b> \<Boolean\></dt>
<dd>with -vary_geometry, disallow bond torsion change beyond standard movemap<br/>Default: false<br/></dd>
<dt><b>-disallow_pack_polar_hydrogens</b> \<Boolean\></dt>
<dd>with -vary_polar_hydrogen_geometry, disallow polar hydrogen packing step before minimizing<br/>Default: false<br/></dd>
<dt><b>-disallow_vary_geometry_proton_chi</b> \<Boolean\></dt>
<dd>no packing/minimizing of 2'-OH or other hydrogens controlled by chi torsion<br/>Default: false<br/></dd>
</dl>
+ <h3>-stepwise:rna</h3>
<dl>
<dt><b>-rna</b> \<Boolean\></dt>
<dd>rna option group<br/></dd>
<dt><b>-sampler_num_pose_kept</b> \<Integer\></dt>
<dd>set_num_pose_kept by ResidueSampler )<br/>Default: 108<br/></dd>
<dt><b>-native_edensity_score_cutoff</b> \<Real\></dt>
<dd>native_edensity_score_cutoff<br/>Default: -1.0<br/></dd>
<dt><b>-o2prime_legacy_mode</b> \<Boolean\></dt>
<dd>complete virtualization of O2' hydrogen during sampling, and then complete restoration and packing<br/>Default: false<br/></dd>
<dt><b>-allow_virtual_o2prime_hydrogens</b> \<Boolean\></dt>
<dd>allow O2' hydrogen to be virtualized during packing.<br/>Default: false<br/></dd>
<dt><b>-sampler_perform_phosphate_pack</b> \<Boolean\></dt>
<dd>perform terminal phosphate packing inside StepWiseRNA_ResidueSampler<br/>Default: false<br/></dd>
<dt><b>-force_phosphate_instantiation</b> \<Boolean\></dt>
<dd>Require terminal phosphates to be instantiated.<br/>Default: false<br/></dd>
<dt><b>-distinguish_pucker</b> \<Boolean\></dt>
<dd>distinguish pucker when cluster:both in sampler and clusterer<br/>Default: true<br/></dd>
<dt><b>-finer_sampling_at_chain_closure</b> \<Boolean\></dt>
<dd>Sampler: finer_sampling_at_chain_closure<br/>Default: false<br/></dd>
<dt><b>-PBP_clustering_at_chain_closure</b> \<Boolean\></dt>
<dd>Sampler: PBP_clustering_at_chain_closure<br/>Default: false<br/></dd>
<dt><b>-sample_all_chi</b> \<Boolean\></dt>
<dd>Sample all chi angles (use for blind learning of chi potential)<br/>Default: false<br/></dd>
<dt><b>-sampler_allow_syn_pyrimidine</b> \<Boolean\></dt>
<dd>sampler_allow_syn_pyrimidine<br/>Default: false<br/></dd>
<dt><b>-sampler_extra_chi_rotamer</b> \<Boolean\></dt>
<dd>Sampler: extra_syn_chi_rotamer<br/>Default: false<br/></dd>
<dt><b>-sampler_extra_beta_rotamer</b> \<Boolean\></dt>
<dd>Sampler: extra_beta_rotamer<br/>Default: false<br/></dd>
<dt><b>-sampler_extra_epsilon_rotamer</b> \<Boolean\></dt>
<dd>Sampler: extra_epsilon_rotamer<br/>Default: true<br/></dd>
<dt><b>-force_centroid_interaction</b> \<Boolean\></dt>
<dd>Require base stack or pair even for single residue loop closed (which could also be bulges!)<br/>Default: false<br/></dd>
<dt><b>-virtual_sugar_legacy_mode</b> \<Boolean\></dt>
<dd>In virtual sugar sampling, use legacy protocol to match Parin's original workflow<br/>Default: false<br/></dd>
<dt><b>-VDW_rep_optimize_memory_usage</b> \<Boolean\></dt>
<dd>RNA_VDW_BinChecker, do not store vector of occupied xyz bins.<br/>Default: false<br/></dd>
<dt><b>-erraser</b> \<Boolean\></dt>
<dd>Use KIC sampling<br/>Default: false<br/></dd>
<dt><b>-centroid_screen</b> \<Boolean\></dt>
<dd>centroid_screen<br/>Default: true<br/></dd>
<dt><b>-VDW_atr_rep_screen</b> \<Boolean\></dt>
<dd>classic VDW_atr_rep_screen<br/>Default: true<br/></dd>
<dt><b>-minimize_and_score_native_pose</b> \<Boolean\></dt>
<dd>minimize_and_score_native_pose <br/>Default: false<br/></dd>
<dt><b>-rm_virt_phosphate</b> \<Boolean\></dt>
<dd>Remove virtual phosphate patches during minimization<br/>Default: false<br/></dd>
<dt><b>-VDW_rep_screen_info</b> \<StringVector\></dt>
<dd>VDW_rep_screen_info to create VDW_rep_screen_bin ( useful when building loop from large poses )<br/>Default: []<br/></dd>
<dt><b>-VDW_rep_alignment_RMSD_CUTOFF</b> \<Real\></dt>
<dd>use with VDW_rep_screen_info<br/>Default: 0.001<br/></dd>
<dt><b>-VDW_rep_delete_matching_res</b> \<StringVector\></dt>
<dd>delete residues in VDW_rep_pose that exist in the working_pose<br/>Default: []<br/></dd>
<dt><b>-VDW_rep_screen_physical_pose_clash_dist_cutoff</b> \<Real\></dt>
<dd>The distance cutoff for VDW_rep_screen_with_physical_pose<br/>Default: 1.2<br/></dd>
<dt><b>-integration_test</b> \<Boolean\></dt>
<dd> integration_test <br/>Default: false<br/></dd>
<dt><b>-allow_bulge_at_chainbreak</b> \<Boolean\></dt>
<dd>Allow sampler to replace chainbreak res with virtual_rna_variant if it looks have bad fa_atr score.<br/>Default: true<br/></dd>
<dt><b>-parin_favorite_output</b> \<Boolean\></dt>
<dd> parin_favorite_output <br/>Default: true<br/></dd>
<dt><b>-reinitialize_CCD_torsions</b> \<Boolean\></dt>
<dd>Sampler: reinitialize_CCD_torsions: Reinitialize_CCD_torsion to zero before every CCD chain closure<br/>Default: false<br/></dd>
<dt><b>-sample_both_sugar_base_rotamer</b> \<Boolean\></dt>
<dd>Sampler: Super hacky for SQUARE_RNA<br/>Default: false<br/></dd>
<dt><b>-sampler_include_torsion_value_in_tag</b> \<Boolean\></dt>
<dd>Sampler:include_torsion_value_in_tag<br/>Default: true<br/></dd>
<dt><b>-sampler_assert_no_virt_sugar_sampling</b> \<Boolean\></dt>
<dd>sampler_assert_no_virt_sugar_sampling<br/>Default: false<br/></dd>
<dt><b>-sampler_try_sugar_instantiation</b> \<Boolean\></dt>
<dd>for floating base sampling, try to instantiate sugar if it looks promising<br/>Default: false<br/></dd>
<dt><b>-do_not_sample_multiple_virtual_sugar</b> \<Boolean\></dt>
<dd> Sampler: do_not_sample_multiple_virtual_sugar <br/>Default: false<br/></dd>
<dt><b>-sample_ONLY_multiple_virtual_sugar</b> \<Boolean\></dt>
<dd> Sampler: sample_ONLY_multiple_virtual_sugar <br/>Default: false<br/></dd>
<dt><b>-allow_base_pair_only_centroid_screen</b> \<Boolean\></dt>
<dd>allow_base_pair_only_centroid_screen<br/>Default: false<br/></dd>
<dt><b>-minimizer_rename_tag</b> \<Boolean\></dt>
<dd>Reorder and rename the tag by the energy_score<br/>Default: true<br/></dd>
<dt><b>-minimize_res</b> \<IntegerVector\></dt>
<dd>alternative to fixed_res<br/>Default: []<br/></dd>
<dt><b>-alignment_res</b> \<StringVector\></dt>
<dd>align_res_list<br/>Default: []<br/></dd>
<dt><b>-native_alignment_res</b> \<IntegerVector\></dt>
<dd>optional: native_alignment_res <br/>Default: []<br/></dd>
<dt><b>-rmsd_res</b> \<IntegerVector\></dt>
<dd>residues that will be use to calculate rmsd ( for clustering as well as RMSD to native_pdb if specified )<br/>Default: []<br/></dd>
<dt><b>-missing_res</b> \<IntegerVector\></dt>
<dd>Residues missing in starting pose_1, alternative to input_res<br/>Default: []<br/></dd>
<dt><b>-missing_res2</b> \<IntegerVector\></dt>
<dd>Residues missing in starting pose_2, alternative to input_res2<br/>Default: []<br/></dd>
<dt><b>-job_queue_ID</b> \<Integer\></dt>
<dd>swa_rna_sample()/combine_long_loop mode: Specify the tag pair in filter_output_filename to be read in and imported ( start from 0! )<br/>Default: 0<br/></dd>
<dt><b>-minimize_and_score_sugar</b> \<Boolean\></dt>
<dd>minimize and sugar torsion + angle? and include the rna_sugar_close_score_term <br/>Default: true<br/></dd>
<dt><b>-global_sample_res_list</b> \<IntegerVector\></dt>
<dd>A list of all the nucleotide to be build/sample over the entire dag.<br/>Default: []<br/></dd>
<dt><b>-filter_output_filename</b> \<File\></dt>
<dd>CombineLongLoopFilterer: filter_output_filename<br/>Default: "filter_struct.txt"<br/></dd>
<dt><b>-combine_long_loop_mode</b> \<Boolean\></dt>
<dd> Sampler: combine_long_loop_mode <br/>Default: false<br/></dd>
<dt><b>-combine_helical_silent_file</b> \<Boolean\></dt>
<dd>CombineLongLoopFilterer: combine_helical_silent_file<br/>Default: false<br/></dd>
<dt><b>-output_extra_RMSDs</b> \<Boolean\></dt>
<dd>output_extra_RMSDs<br/>Default: false<br/></dd>
<dt><b>-protonated_H1_adenosine_list</b> \<IntegerVector\></dt>
<dd>optional: protonate_H1_adenosine_list<br/>Default: []<br/></dd>
<dt><b>-native_virtual_res</b> \<IntegerVector\></dt>
<dd> optional: native_virtual_res <br/>Default: []<br/></dd>
<dt><b>-simple_append_map</b> \<Boolean\></dt>
<dd>simple_append_map<br/>Default: false<br/></dd>
<dt><b>-allow_fixed_res_at_moving_res</b> \<Boolean\></dt>
<dd>mainly just to get Hermann Duplex modeling to work<br/>Default: false<br/></dd>
<dt><b>-force_user_defined_jumps</b> \<Boolean\></dt>
<dd>Trust and use user defined jumps<br/>Default: false<br/></dd>
<dt><b>-jump_point_pairs</b> \<StringVector\></dt>
<dd>optional: extra jump_points specified by the user for setting up the fold_tree <br/>Default: []<br/></dd>
<dt><b>-add_virt_root</b> \<Boolean\></dt>
<dd>add_virt_root<br/>Default: false<br/></dd>
<dt><b>-floating_base</b> \<Boolean\></dt>
<dd> floating_base <br/>Default: false<br/></dd>
<dt><b>-floating_base_anchor_res</b> \<Integer\></dt>
<dd>If we want floating base to be connected via a jump to an anchor res (with no intervening virtual residues), specify the anchor.<br/>Default: 0<br/></dd>
<dt><b>-allow_chain_boundary_jump_partner_right_at_fixed_BP</b> \<Boolean\></dt>
<dd>mainly just to get Hermann nano - square RNA modeling to work<br/>Default: false<br/></dd>
<dt><b>-rebuild_bulge_mode</b> \<Boolean\></dt>
<dd>rebuild_bulge_mode<br/>Default: false<br/></dd>
<dt><b>-virtual_sugar_keep_base_fixed</b> \<Boolean\></dt>
<dd>When instantiating virtual sugar, keep base fixed -- do not spend a lot of time to minimize!<br/>Default: true<br/></dd>
<dt><b>-virtual_sugar_do_minimize</b> \<Boolean\></dt>
<dd>When instantiating virtual sugar, minimize (as in original SWA code) -- takes extra time!<br/>Default: true<br/></dd>
<dt><b>-sampler_max_centroid_distance</b> \<Real\></dt>
<dd>max centroid distance of moving base to reference in floating base sampler<br/>Default: 0.0<br/></dd>
<dt><b>-filter_user_alignment_res</b> \<Boolean\></dt>
<dd> filter_user_alignment_res <br/>Default: true<br/></dd>
<dt><b>-tether_jump</b> \<Boolean\></dt>
<dd>In rigid body moves, keep moving residue close to (jump-connected) reference residue  (8.0 A) and force centroid interaction between them<br/>Default: true<br/></dd>
<dt><b>-turn_off_rna_chem_map_during_optimize</b> \<Boolean\></dt>
<dd>When using rna_chem_map, only score with this after minimizing (takes too long to compute during optimizing).<br/>Default: true<br/></dd>
</dl>
+ <h3>-stepwise:protein</h3>
<dl>
<dt><b>-protein</b> \<Boolean\></dt>
<dd>protein option group<br/></dd>
<dt><b>-global_optimize</b> \<Boolean\></dt>
<dd>In clustering, packing, minimizing, use all residues.<br/>Default: false<br/></dd>
<dt><b>-disable_sampling_of_loop_takeoff</b> \<Boolean\></dt>
<dd>For KIC protein loop closure, disallow sampling of psi at N-terminus and phi at C-terminus takeoff residues<br/>Default: false<br/></dd>
<dt><b>-sample_beta</b> \<Boolean\></dt>
<dd>sample beta strand pairing -- later need to specify parallel/antiparallel<br/>Default: false<br/></dd>
<dt><b>-ghost_loops</b> \<Boolean\></dt>
<dd>Virtualize loops in centroid screening<br/>Default: false<br/></dd>
<dt><b>-centroid_screen</b> \<Boolean\></dt>
<dd>Centroid Screen<br/>Default: false<br/></dd>
<dt><b>-centroid_score_diff_cut</b> \<Real\></dt>
<dd>If doing -centroid_screen, only keep poses whose energies are within this energy of reference..<br/>Default: 20.0<br/></dd>
<dt><b>-centroid_weights</b> \<String\></dt>
<dd>weights for centroid filter<br/>Default: "score3.wts"<br/></dd>
<dt><b>-score_diff_cut</b> \<Real\></dt>
<dd>score difference cut for clustering<br/>Default: 10.0<br/></dd>
<dt><b>-filter_native_big_bins</b> \<Boolean\></dt>
<dd>Figure out various terms for score12<br/>Default: false<br/></dd>
<dt><b>-cluster_by_all_atom_rmsd</b> \<Boolean\></dt>
<dd>cluster by all atom rmsd<br/>Default: false<br/></dd>
<dt><b>-centroid_output</b> \<Boolean\></dt>
<dd>output centroid structure during screening<br/>Default: false<br/></dd>
<dt><b>-n_sample</b> \<Integer\></dt>
<dd>number of samples per torsion angle<br/>Default: 18<br/></dd>
<dt><b>-nstruct_centroid</b> \<Integer\></dt>
<dd>Number of decoys to output from centroid screening<br/>Default: 0<br/></dd>
<dt><b>-ccd_close</b> \<Boolean\></dt>
<dd>Close loops with CCD<br/>Default: false<br/></dd>
<dt><b>-bridge_res</b> \<IntegerVector\></dt>
<dd>instead of enumerative sampling of backbone torsions, combine silent files that contains pieces of loops<br/>Default: []<br/></dd>
<dt><b>-cart_min</b> \<Boolean\></dt>
<dd>Use cartesian minimizer<br/>Default: false<br/></dd>
<dt><b>-move_jumps_between_chains</b> \<Boolean\></dt>
<dd>Move all jumps<br/>Default: false<br/></dd>
<dt><b>-use_packer_instead_of_rotamer_trials</b> \<Boolean\></dt>
<dd>Use packer instead of rotamer trials in residue sampling<br/>Default: false<br/></dd>
<dt><b>-expand_loop_takeoff</b> \<Boolean\></dt>
<dd>expand -sample_res loop to include connection to previous/next residues<br/>Default: false<br/></dd>
<dt><b>-skip_coord_constraints</b> \<Boolean\></dt>
<dd>Skip first stage of minimize with coordinate constraints<br/>Default: false<br/></dd>
<dt><b>-allow_virtual_side_chains</b> \<Boolean\></dt>
<dd>In packing, allow virtual side chains<br/>Default: true<br/></dd>
<dt><b>-protein_prepack</b> \<Boolean\></dt>
<dd>In packing, prepack separate partitions<br/>Default: true<br/></dd>
<dt><b>-disulfide_file</b> \<String\></dt>
<dd>File with pairs of numbers for desired disulfides.<br/>Default: ""<br/></dd>
</dl>
+ <h2>-full_model</h2>
<dl>
<dt><b>-full_model</b> \<Boolean\></dt>
<dd>full_model option group<br/></dd>
<dt><b>-global_seq_file</b> \<String\></dt>
<dd>File with global sequence and modeled sequence.<br/>Default: ""<br/></dd>
<dt><b>-cutpoint_open</b> \<ResidueChainVector\></dt>
<dd>open cutpoints in full model<br/>Default: []<br/></dd>
<dt><b>-cutpoint_closed</b> \<ResidueChainVector\></dt>
<dd>closed cutpoints in full model<br/>Default: []<br/></dd>
<dt><b>-cyclize</b> \<ResidueChainVector\></dt>
<dd>cyclize points in full model<br/>Default: []<br/></dd>
<dt><b>-twoprime</b> \<ResidueChainVector\></dt>
<dd>twoprime branch points in full model<br/>Default: []<br/></dd>
<dt><b>-fiveprime_cap</b> \<ResidueChainVector\></dt>
<dd>fiveprime capped residues and their corresponding 7MGs<br/>Default: []<br/></dd>
<dt><b>-other_poses</b> \<StringVector\></dt>
<dd>list of PDB files containing other poses<br/></dd>
<dt><b>-jump_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues for defining jumps -- please supply in pairs<br/>Default: []<br/></dd>
<dt><b>-disulfide_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues for defining disulfides -- please supply in pairs<br/>Default: []<br/></dd>
<dt><b>-extra_min_res</b> \<ResidueChainVector\></dt>
<dd>specify residues other than those being built that should be minimized<br/>Default: []<br/></dd>
<dt><b>-extra_min_jump_res</b> \<ResidueChainVector\></dt>
<dd>specify jump-connected pairs  other than those being built that should be minimized<br/>Default: []<br/></dd>
<dt><b>-root_res</b> \<ResidueChainVector\></dt>
<dd>optional: desired root res (used in SWM move testing)<br/>Default: []<br/></dd>
<dt><b>-virtual_sugar_res</b> \<ResidueChainVector\></dt>
<dd>optional: starting virtual sugars (used in SWM move testing)<br/>Default: []<br/></dd>
<dt><b>-virtual_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues for defining virtual residues<br/>Default: []<br/></dd>
<dt><b>-sample_res</b> \<ResidueChainVector\></dt>
<dd>residues to build (for SWA, the first element is the actual sample res while the other are the bulge residues)<br/>Default: []<br/></dd>
<dt><b>-calc_rms_res</b> \<ResidueChainVector\></dt>
<dd>residues over which to calculate rms for SWA. Not in wide use anymore.<br/>Default: []<br/></dd>
<dt><b>-working_res</b> \<ResidueChainVector\></dt>
<dd>residues that are being built [by default will be set from sample_res and any input pdbs]<br/>Default: []<br/></dd>
<dt><b>-motif_mode</b> \<Boolean\></dt>
<dd>in fixed PDB parts, minimize residues right next to loops & disallow pair/stacking in most distal residues<br/>Default: false<br/></dd>
<dt><b>-allow_jump_in_numbering</b> \<Boolean\></dt>
<dd>useful for design. if residue numbers jump from i to i+1 do *not* assume cutpoint.<br/>Default: false<br/></dd>
</dl>
+ <h3>-full_model:rna</h3>
<dl>
<dt><b>-rna</b> \<Boolean\></dt>
<dd>rna option group<br/></dd>
<dt><b>-terminal_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues that are not allowed to stack during sampling<br/>Default: []<br/></dd>
<dt><b>-block_stack_above_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues on which other residues cannot stack above (uses repulsion atoms)<br/>Default: []<br/></dd>
<dt><b>-block_stack_below_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues on which other residues cannot stack below (uses repulsion atoms)<br/>Default: []<br/></dd>
<dt><b>-force_syn_chi_res_list</b> \<ResidueChainVector\></dt>
<dd>optional: sample only syn chi for the res in sampler.<br/>Default: []<br/></dd>
<dt><b>-force_anti_chi_res_list</b> \<ResidueChainVector\></dt>
<dd>optional: sample only anti chi for the res in sampler.<br/>Default: []<br/></dd>
<dt><b>-force_north_sugar_list</b> \<ResidueChainVector\></dt>
<dd>optional: sample only north sugar for the res in sampler.<br/>Default: []<br/></dd>
<dt><b>-force_south_sugar_list</b> \<ResidueChainVector\></dt>
<dd>optional: sample only south sugar for the res in sampler.<br/>Default: []<br/></dd>
<dt><b>-bulge_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues to be turned into a bulge variant<br/>Default: []<br/></dd>
<dt><b>-sample_sugar_res</b> \<ResidueChainVector\></dt>
<dd>optional: residues in fixed input pose whose sugars can still move<br/>Default: []<br/></dd>
</dl>
+ <h2>-recces</h2>
<dl>
<dt><b>-seq1</b> \<String\></dt>
<dd>sequence 1 to model, 5' to 3' <br/>Default: ""<br/></dd>
<dt><b>-seq2</b> \<String\></dt>
<dd>sequence 2 to model, 5' to 3' <br/>Default: ""<br/></dd>
<dt><b>-n_cycle</b> \<Integer\></dt>
<dd>Number of cycles for random sampling Markov chain Monte Carlo<br/>Default: 10000<br/></dd>
<dt><b>-a_form_range</b> \<Real\></dt>
<dd>Range of sampling near A-form for duplexes in RECCES (turner)<br/>Default: 60.0<br/></dd>
<dt><b>-dump_pdb</b> \<Boolean\></dt>
<dd>Dump pdb files<br/>Default: false<br/></dd>
<dt><b>-dump_silent</b> \<Boolean\></dt>
<dd>Dump structures to a silent file<br/>Default: false<br/></dd>
<dt><b>-out_torsions</b> \<Boolean\></dt>
<dd>Print out torsion angles<br/>Default: false<br/></dd>
<dt><b>-temps</b> \<RealVector\></dt>
<dd>Simulated tempering temperatures<br/>Default: []<br/></dd>
<dt><b>-st_weights</b> \<RealVector\></dt>
<dd>Simulated tempering weights<br/>Default: []<br/></dd>
<dt><b>-save_score_terms</b> \<Boolean\></dt>
<dd>Save scores and individual score terms of all sampled conformers<br/>Default: false<br/></dd>
<dt><b>-out_prefix</b> \<String\></dt>
<dd>prefix for the out file<br/>Default: "recces"<br/></dd>
<dt><b>-dump_freq</b> \<Integer\></dt>
<dd>Frequency to dump pdb or silent files<br/>Default: 500<br/></dd>
<dt><b>-n_intermediate_dump</b> \<Integer\></dt>
<dd>Number of intermediate conformations to be dumped<br/>Default: 0<br/></dd>
<dt><b>-output_min_pose</b> \<Boolean\></dt>
<dd>Make last pose the minimum score pose ('recover low')<br/>Default: true<br/></dd>
<dt><b>-accept_no_op_moves</b> \<Boolean\></dt>
<dd>override behavior where no_ops (e.g. for moving jump out of range) are not accepts<br/>Default: false<br/></dd>
<dt><b>-histogram_min</b> \<Real\></dt>
<dd>Minimum energy for histogram<br/>Default: -100.05<br/></dd>
<dt><b>-histogram_max</b> \<Real\></dt>
<dd>Maximum energy for histogram<br/>Default: +800.05<br/></dd>
<dt><b>-histogram_spacing</b> \<Real\></dt>
<dd>Spacing for histogram<br/>Default: 0.1<br/></dd>
</dl>
+ <h3>-recces:base_pair</h3>
<dl>
<dt><b>-base_pair</b> \<Boolean\></dt>
<dd>base_pair option group<br/></dd>
<dt><b>-rmsd_cutoff</b> \<Real\></dt>
<dd>base pair RMSD cutoff for jump sampling<br/>Default: 2.0<br/></dd>
<dt><b>-translation_mag</b> \<Real\></dt>
<dd>magnitude of random translation moves<br/>Default: 0.01<br/></dd>
<dt><b>-rotation_mag</b> \<Real\></dt>
<dd>magnitude of random rotation moves (in degrees)<br/>Default: 1.0<br/></dd>
<dt><b>-recces</b> \<Boolean\></dt>
<dd>turn on RECCES in rb_entropy pilot app<br/>Default: false<br/></dd>
<dt><b>-block_stack</b> \<Boolean\></dt>
<dd>put block_stack atoms on test base pair<br/>Default: false<br/></dd>
<dt><b>-sample_jump</b> \<Boolean\></dt>
<dd>force base pair jump to be sampled when pose is setup vi -seq1, -seq2 (legacy turner mode)<br/>Default: false<br/></dd>
</dl>
+ <h3>-recces:thermal_sampling</h3>
<dl>
<dt><b>-thermal_sampling</b> \<Boolean\></dt>
<dd>thermal_sampling option group<br/></dd>
<dt><b>-sample_residues</b> \<IntegerVector\></dt>
<dd>residues to sample<br/>Default: []<br/></dd>
<dt><b>-free_residues</b> \<IntegerVector\></dt>
<dd>residues that are 'free,' affects stdev of chi sampler<br/>Default: []<br/></dd>
<dt><b>-loop_residues</b> \<IntegerVector\></dt>
<dd>residues that are in loops and merit total BB sampling<br/>Default: []<br/></dd>
<dt><b>-angle_range_bb</b> \<Real\></dt>
<dd>range bb torsions are allowed to move<br/>Default: 20<br/></dd>
<dt><b>-angle_range_free_bb</b> \<Real\></dt>
<dd>range free bb torsions are allowed to move<br/>Default: 180<br/></dd>
<dt><b>-angle_range_chi</b> \<Real\></dt>
<dd>range chi torsions are allowed to move<br/>Default: 20<br/></dd>
<dt><b>-angle_range_free_chi</b> \<Real\></dt>
<dd>range free chi torsions are allowed to move<br/>Default: 180<br/></dd>
<dt><b>-chi_stdev</b> \<Real\></dt>
<dd>standard deviation for chi sampler<br/>Default: 20<br/></dd>
<dt><b>-bb_stdev</b> \<Real\></dt>
<dd>standard deviation for backbone sampler<br/>Default: 1<br/></dd>
<dt><b>-standard_bb_stdev</b> \<Real\></dt>
<dd>standard deviation for standard backbone sampler<br/>Default: 1<br/></dd>
<dt><b>-setup_base_pair_constraints</b> \<Boolean\></dt>
<dd>Identify Watson/Crick pairs in input pose and put in constraints.<br/>Default: false<br/></dd>
</dl>
+ <h2>-strand_assembly</h2>
<dl>
<dt><b>-strand_assembly</b> \<Boolean\></dt>
<dd>strand_assembly option group<br/></dd>
<dt><b>-min_num_strands_to_deal</b> \<Integer\></dt>
<dd>Minimum number of strands to handle beta-sandwich<br/></dd>
<dt><b>-max_num_strands_to_deal</b> \<Integer\></dt>
<dd>Maximum number of strands to handle beta-sandwich<br/></dd>
<dt><b>-extract_native_only</b> \<Boolean\></dt>
<dd>if true, extract native full strands only<br/></dd>
<dt><b>-min_res_in_strand</b> \<Integer\></dt>
<dd>minimum number of residues in a strand, for edge strand definition & analysis<br/></dd>
<dt><b>-max_res_in_strand</b> \<Integer\></dt>
<dd>Maximum number of residues in a strand, for edge strand definition & analysis<br/></dd>
<dt><b>-min_O_N_dis</b> \<Real\></dt>
<dd>Minimum distance between backbone oxygen and backbone nitrogen<br/></dd>
<dt><b>-max_O_N_dis</b> \<Real\></dt>
<dd>Maximum distance between backbone oxygen and backbone nitrogen<br/></dd>
<dt><b>-min_sheet_dis</b> \<Real\></dt>
<dd>Minimum distance between sheets (CA and CA)<br/></dd>
<dt><b>-max_sheet_dis</b> \<Real\></dt>
<dd>Maximum distance between sheets (CA and CA)<br/></dd>
<dt><b>-min_sheet_torsion</b> \<Real\></dt>
<dd>Minimum torsion between sheets (CA and CA) with respect to terminal residues<br/></dd>
<dt><b>-max_sheet_torsion</b> \<Real\></dt>
<dd>Maximum torsion between sheets (CA and CA) with respect to terminal residues<br/></dd>
<dt><b>-min_sheet_angle</b> \<Real\></dt>
<dd>Minimum angle between sheets (CA and CA)<br/></dd>
<dt><b>-max_sheet_angle</b> \<Real\></dt>
<dd>Maximum angle between sheets (CA and CA)<br/></dd>
<dt><b>-min_shortest_dis_sidechain_inter_sheet</b> \<Real\></dt>
<dd>minimum distance between sidechains between sheets (pairs of strands)<br/></dd>
</dl>
+ <h2>-TailSegment</h2>
<dl>
<dt><b>-TailSegment</b> \<Boolean\></dt>
<dd>TailSegment option group<br/></dd>
<dt><b>-refine_cycles</b> \<Integer\></dt>
<dd>refinement phase runs for <input> cycles<br/>Default: 100<br/></dd>
<dt><b>-refine_repack_cycles</b> \<Integer\></dt>
<dd>refinement phase runs repack every <input> cycles<br/>Default: 10<br/></dd>
</dl>
+ <h2>-templates</h2>
<dl>
<dt><b>-templates</b> \<Boolean\></dt>
<dd>templates option group<br/></dd>
<dt><b>-config</b> \<File\></dt>
<dd>read a list of templates and alignments<br/>Default: "templates.dat"<br/></dd>
<dt><b>-fix_aligned_residues</b> \<Boolean\></dt>
<dd>pick only from template fragments and then keep these residues fixed<br/>Default: false<br/></dd>
<dt><b>-fix_frag_file</b> \<File\></dt>
<dd> fragments from this file are picked once in beginning and then kept fixed<br/>Default: ""<br/></dd>
<dt><b>-fix_margin</b> \<Integer\></dt>
<dd>keep n residues at edges of fixed fragments moveable<br/>Default: 1<br/></dd>
<dt><b>-min_nr_large_frags</b> \<Integer\></dt>
<dd>how many large fragments should be present<br/>Default: 100000<br/></dd>
<dt><b>-min_nr_small_frags</b> \<Integer\></dt>
<dd>how many small fragments should be present<br/>Default: 100000<br/></dd>
<dt><b>-no_pick_fragments</b> \<Boolean\></dt>
<dd>no further fragment picking from templates<br/>Default: false<br/></dd>
<dt><b>-nr_large_copies</b> \<Integer\></dt>
<dd>make N copies of each picked template fragment -- a hacky way to weight them<br/>Default: 4<br/></dd>
<dt><b>-nr_small_copies</b> \<Integer\></dt>
<dd>make N copies of each picked template fragment -- a hacky way to weight them<br/>Default: 20<br/></dd>
<dt><b>-pairings</b> \<Boolean\></dt>
<dd>use pairings from templates<br/>Default: false<br/></dd>
<dt><b>-pick_multiple_sizes</b> \<Boolean\></dt>
<dd>pick 9mers, 18mers and 27mers<br/>Default: false<br/></dd>
<dt><b>-strand_constraint</b> \<Boolean\></dt>
<dd>use the template-based strand-constraints<br/>Default: false<br/></dd>
<dt><b>-vary_frag_size</b> \<Boolean\></dt>
<dd>pick fragments as long as aligned regions<br/>Default: false<br/></dd>
<dt><b>-no_culling</b> \<Boolean\></dt>
<dd>dont throw out constraints that are violated by other templates<br/>Default: false<br/></dd>
<dt><b>-helix_pairings</b> \<File\></dt>
<dd>file with list of pairings that are enforced (pick jumps from templates with H)<br/>Default: ""<br/></dd>
<dt><b>-prefix</b> \<File\></dt>
<dd>path for config directory -- applied to all filenames in template_config_file<br/>Default: ""<br/></dd>
<dt><b>-change_movemap</b> \<Integer\></dt>
<dd>stage in which movemap is switched to allow all bb-residues to move, valid stages: 3..4 (HACK)<br/>Default: 3<br/></dd>
<dt><b>-force_native_topology</b> \<Boolean\></dt>
<dd>force the native toplogy (geometries from templates)<br/>Default: false<br/></dd>
<dt><b>-topology_rank_cutoff</b> \<Real\></dt>
<dd>select jumps from all topologies with a higher relative score than if 1.0 take top 5<br/>Default: 1.0<br/></dd>
<dt><b>-min_frag_size</b> \<Integer\></dt>
<dd>smallest fragment picked from aligned template regions<br/>Default: 6<br/></dd>
<dt><b>-max_shrink</b> \<Integer\></dt>
<dd>pick fragments up to max_shrink smaller than aligned regions<br/>Default: 0<br/></dd>
<dt><b>-shrink_step</b> \<Integer\></dt>
<dd>shrink_step 5 , eg., 27mer 22mer 17mer<br/>Default: 5<br/></dd>
<dt><b>-shrink_pos_step</b> \<Integer\></dt>
<dd>distance between start pos in shrinked fragments<br/>Default: 5<br/></dd>
<dt><b>-min_padding</b> \<Integer\></dt>
<dd>minimum space between fragment and gap<br/>Default: 0<br/></dd>
<dt><b>-min_align_pos</b> \<Integer\></dt>
<dd>ignore aligned residues before this position<br/>Default: 0<br/></dd>
<dt><b>-max_align_pos</b> \<Integer\></dt>
<dd>ignore aligned residues after this position<br/>Default: -1<br/></dd>
</dl>
+ <h3>-templates:cst</h3>
<dl>
<dt><b>-cst</b> \<Boolean\></dt>
<dd>cst option group<br/></dd>
<dt><b>-topN</b> \<Integer\></dt>
<dd>topN ranking models are used for constraints ( culling and source )<br/>Default: 0<br/></dd>
<dt><b>-wTopol</b> \<Real\></dt>
<dd>weight for beta-pairing topology score in ranking<br/>Default: 0.5<br/></dd>
<dt><b>-wExtern</b> \<Real\></dt>
<dd>weight for external score ( column in template_config_file, e.g, svn-score<br/>Default: 0.5<br/></dd>
</dl>
+ <h3>-templates:fragsteal</h3>
<dl>
<dt><b>-fragsteal</b> \<Boolean\></dt>
<dd>fragsteal option group<br/></dd>
<dt><b>-topN</b> \<Integer\></dt>
<dd>topN ranking models are used for fragment stealing<br/>Default: 0<br/></dd>
<dt><b>-wTopol</b> \<Real\></dt>
<dd>weight for beta-pairing topology score in ranking<br/>Default: 0.5<br/></dd>
<dt><b>-wExtern</b> \<Real\></dt>
<dd>weight for external score ( column in template_config_file, e.g, svn-score<br/>Default: 0.5<br/></dd>
</dl>
+ <h2>-unfolded_state</h2>
<dl>
<dt><b>-unfolded_state</b> \<Boolean\></dt>
<dd>unfolded_state option group<br/></dd>
<dt><b>-unfolded_energies_file</b> \<File\></dt>
<dd>path to an alternative unfolded state energies file<br/></dd>
<dt><b>-split_unfolded_energies_file</b> \<File\></dt>
<dd>path to an alternative split unfolded state energies file<br/></dd>
<dt><b>-split_unfolded_energies_atom_type</b> \<String\></dt>
<dd>name of the atom type specfied in the file defeined by the split_unfolded_energies_file option<br/></dd>
</dl>
+ <h2>-wum</h2>
<dl>
<dt><b>-wum</b> \<Boolean\></dt>
<dd>wum option group<br/></dd>
<dt><b>-n_slaves_per_master</b> \<Integer\></dt>
<dd>A value between 32 and 128 is usually recommended<br/>Default: 64<br/></dd>
<dt><b>-n_masters</b> \<Integer\></dt>
<dd>Manual override for -n_slaves_per_master. How many master nodes should be spawned ? 1 by default. generall 1 for eery 256-512 cores is recommended depending on master workload<br/>Default: 1<br/></dd>
<dt><b>-memory_limit</b> \<Integer\></dt>
<dd>Memory limit for queues (in kB) <br/>Default: 0<br/></dd>
<dt><b>-extra_scorefxn</b> \<String\></dt>
<dd>Extra score function for post-batchrelax-rescoring<br/></dd>
<dt><b>-extra_scorefxn_ref_structure</b> \<File\></dt>
<dd>Extra score function for post-batchrelax-rescoring reference structure for superimposition (for scorefunctions that depend on absolute coordinates such as electron denisty)<br/></dd>
<dt><b>-extra_scorefxn_relax</b> \<Integer\></dt>
<dd>After doing batch relax and adding any extra_scorefunction terms do another N fast relax rounds (defaut=0)<br/>Default: 0<br/></dd>
<dt><b>-trim_proportion</b> \<Real\></dt>
<dd>No description<br/>Default: 0.0<br/></dd>
</dl>
+ <h2>-blivens</h2>
<dl>
<dt><b>-blivens</b> \<Boolean\></dt>
<dd>blivens option group<br/></dd>
</dl>
+ <h3>-blivens:disulfide_scorer</h3>
<dl>
<dt><b>-disulfide_scorer</b> \<Boolean\></dt>
<dd>disulfide_scorer option group<br/></dd>
<dt><b>-nds_prob</b> \<Real\></dt>
<dd>The probability of scoring a non-disulfide pair<br/>Default: 0.0<br/></dd>
<dt><b>-cys_prob</b> \<Real\></dt>
<dd>The probability of outputing a pair of non-disulf cysteines. Default to nds_prob<br/>Default: -1.0<br/></dd>
</dl>
+ <h2>-blivens</h2>
<dl>
<dt><b>-score_type</b> \<String\></dt>
<dd>The scoring type to use, eg for a filter.<br/>Default: "total_score"<br/></dd>
</dl>
+ <h2>-cmiles</h2>
<dl>
<dt><b>-cmiles</b> \<Boolean\></dt>
<dd>cmiles option group<br/></dd>
</dl>
+ <h3>-cmiles:kcluster</h3>
<dl>
<dt><b>-kcluster</b> \<Boolean\></dt>
<dd>kcluster option group<br/></dd>
<dt><b>-num_clusters</b> \<Integer\></dt>
<dd>Number of clusters to use during k clustering<br/></dd>
</dl>
+ <h3>-cmiles:jumping</h3>
<dl>
<dt><b>-jumping</b> \<Boolean\></dt>
<dd>jumping option group<br/></dd>
<dt><b>-resi</b> \<Integer\></dt>
<dd>Residue i<br/></dd>
<dt><b>-resj</b> \<Integer\></dt>
<dd>Residue j<br/></dd>
</dl>
+ <h2>-crossmatch</h2>
<dl>
<dt><b>-crossmatch</b> \<Boolean\></dt>
<dd>crossmatch option group<br/></dd>
<dt><b>-clash_dis</b> \<Real\></dt>
<dd><br/>Default: 3.0<br/></dd>
</dl>
+ <h2>-dwkulp</h2>
<dl>
<dt><b>-dwkulp</b> \<Boolean\></dt>
<dd>dwkulp option group<br/></dd>
<dt><b>-forcePolyAAfragments</b> \<String\></dt>
<dd>a single amino acid that will be used for fragment picking,default is blank which means taking actual sequence from pose<br/>Default: ""<br/></dd>
</dl>
+ <h2>-evolution</h2>
<dl>
<dt><b>-evolution</b> \<Boolean\></dt>
<dd>evolution option group<br/></dd>
<dt><b>-parentlist</b> \<FileVector\></dt>
<dd>File(s) containing list(s) of Parent PDB files to process<br/></dd>
<dt><b>-childlist</b> \<FileVector\></dt>
<dd>File(s) containing list(s) of Parent PDB files to process<br/></dd>
<dt><b>-action</b> \<String\></dt>
<dd>One of the following:  diversify, intensify <br/>Default: "diversify"<br/></dd>
<dt><b>-rms_threshold</b> \<Real\></dt>
<dd>RMS Clustering threshold<br/>Default: 3.5<br/></dd>
<dt><b>-rms_topmargin</b> \<Real\></dt>
<dd>RMS Clustering threshold<br/>Default: 5.0<br/></dd>
<dt><b>-targetdir</b> \<String\></dt>
<dd>Write target new parent polulation to this directory ! <br/>Default: "./"<br/></dd>
<dt><b>-padding_score_filter</b> \<Real\></dt>
<dd>RMS Clustering threshold<br/>Default: 5.0<br/></dd>
<dt><b>-padding_stage2_filter</b> \<Real\></dt>
<dd>RMS Clustering threshold<br/>Default: 15.0<br/></dd>
</dl>
+ <h2>-james</h2>
<dl>
<dt><b>-james</b> \<Boolean\></dt>
<dd>james option group<br/></dd>
<dt><b>-min_seqsep</b> \<Integer\></dt>
<dd>No description<br/>Default: 0<br/></dd>
<dt><b>-atom_names</b> \<StringVector\></dt>
<dd>No description<br/>Default: utility::vector1<std::string>()<br/></dd>
<dt><b>-dist_thresholds</b> \<RealVector\></dt>
<dd>No description<br/>Default: utility::vector1<float>(1, 1.0)<br/></dd>
<dt><b>-torsion_thresholds</b> \<RealVector\></dt>
<dd>No description<br/>Default: utility::vector1<float>(1, 30.0)<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-real</b> \<Real\></dt>
<dd>Option for keeping things real.<br/>Default: 7.0<br/></dd>
<dt><b>-n_designs</b> \<Integer\></dt>
<dd>total number of designs that James should make.<br/>Default: 1<br/></dd>
<dt><b>-thread_unaligned</b> \<Boolean\></dt>
<dd>basic_threading without performing an alignment<br/>Default: false<br/></dd>
</dl>
+ <h2>-krassk</h2>
<dl>
<dt><b>-krassk</b> \<Boolean\></dt>
<dd>krassk option group<br/></dd>
<dt><b>-tail_mode</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-tail_mode_name</b> \<Integer\></dt>
<dd>No description<br/>Default: 1<br/></dd>
<dt><b>-tail_output_file_name</b> \<String\></dt>
<dd>No description<br/>Default: "tail_output"<br/></dd>
</dl>
+ <h2>-loodo</h2>
<dl>
<dt><b>-loodo</b> \<Boolean\></dt>
<dd>loodo option group<br/></dd>
<dt><b>-ins_begin</b> \<Integer\></dt>
<dd>insertion site (pose numbering)<br/></dd>
<dt><b>-cap</b> \<String\></dt>
<dd>cap pdb<br/>Default: ""<br/></dd>
<dt><b>-bot</b> \<String\></dt>
<dd>bot pdb<br/>Default: ""<br/></dd>
<dt><b>-fragAlength</b> \<IntegerVector\></dt>
<dd>lengths for loop A<br/></dd>
<dt><b>-fragBlength</b> \<IntegerVector\></dt>
<dd>lengths for loop B<br/></dd>
<dt><b>-known</b> \<Integer\></dt>
<dd>length of known interior region<br/></dd>
<dt><b>-fragAnative</b> \<String\></dt>
<dd>native loop A pdb file<br/>Default: ""<br/></dd>
<dt><b>-fragBnative</b> \<String\></dt>
<dd>native loop B pdb file<br/>Default: ""<br/></dd>
<dt><b>-gridligpath</b> \<String\></dt>
<dd>path to gridlig file<br/>Default: ""<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>dump CapHitB pdbs<br/>Default: false<br/></dd>
<dt><b>-ca_ratio</b> \<Real\></dt>
<dd>fraction of C-alphas required in active site grid<br/>Default: 0.5<br/></dd>
<dt><b>-distance_tolerance</b> \<Real\></dt>
<dd>distance cutoff for pairwise Real6 x,y,z comparisons<br/>Default: 5.0<br/></dd>
<dt><b>-euler_tolerance</b> \<Real\></dt>
<dd>angle cutoff for pairwise Real6 euler angle comparisons<br/>Default: 15.0<br/></dd>
<dt><b>-num_frags</b> \<Integer\></dt>
<dd>number fragments to pick per frame in library<br/>Default: 4500<br/></dd>
<dt><b>-use_fraglib</b> \<String\></dt>
<dd>fragment library to use instead of vall database<br/></dd>
<dt><b>-use_fraglibsc</b> \<String\></dt>
<dd>fragment library to use instead of vall database with sidechain torsions specified<br/></dd>
<dt><b>-com_in_grid</b> \<Boolean\></dt>
<dd>cap center-of-mass required to lie in placement grid<br/>Default: false<br/></dd>
<dt><b>-loud</b> \<Boolean\></dt>
<dd>loud output?<br/>Default: false<br/></dd>
<dt><b>-dump_all_As</b> \<Boolean\></dt>
<dd>dump passing As<br/>Default: false<br/></dd>
<dt><b>-dump_all_Bs</b> \<Boolean\></dt>
<dd>dump passing Bs<br/>Default: false<br/></dd>
<dt><b>-caphit_rt_file</b> \<String\></dt>
<dd>name of CapHit_RT or filtered CapHitRT file<br/></dd>
</dl>
+ <h2>-murphp</h2>
<dl>
<dt><b>-murphp</b> \<Boolean\></dt>
<dd>murphp option group<br/></dd>
<dt><b>-inv_kin_lig_loop_design_filename</b> \<String\></dt>
<dd>input filename to be used for inv_kin_lig_loop_design<br/></dd>
</dl>
+ <h2>-peptide_deriver</h2>
<dl>
<dt><b>-peptide_deriver</b> \<Boolean\></dt>
<dd>peptide_deriver option group<br/></dd>
<dt><b>-pep_lengths</b> \<IntegerVector\></dt>
<dd>Length(s) of derived peptides<br/>Default: ['10']<br/></dd>
<dt><b>-skip_zero_isc</b> \<Boolean\></dt>
<dd>Makes derivation go faster by skipping peptides with 0 interface score<br/>Default: true<br/></dd>
<dt><b>-dump_peptide_pose</b> \<Boolean\></dt>
<dd>Output pose with peptide cut out (best one for each chain pair)<br/>Default: false<br/></dd>
<dt><b>-dump_cyclic_poses</b> \<Boolean\></dt>
<dd>Output each cyclic peptide pose (those that are modeled; which is determined by -optimize_cyclic_threshold)<br/>Default: false<br/></dd>
<dt><b>-dump_prepared_pose</b> \<Boolean\></dt>
<dd>Output each receptor-partner pose as Peptiderive sees it, i.e. after preparation (minimization and disulfide detection)<br/>Default: false<br/></dd>
<dt><b>-dump_report_file</b> \<Boolean\></dt>
<dd>Send PeptideDeriver output to a file (<input_name>.peptiderive.txt)<br/>Default: true<br/></dd>
<dt><b>-restrict_receptors_to_chains</b> \<StringVector\></dt>
<dd>Only use chains listed here as receptors. When empty, consider all chains.<br/>Default: []<br/></dd>
<dt><b>-restrict_partners_to_chains</b> \<StringVector\></dt>
<dd>Only use chains listed here as partners. When empty, consider all chains. For each receptor-partner pair, a peptide is derived from the partner.<br/>Default: []<br/></dd>
<dt><b>-do_minimize</b> \<Boolean\></dt>
<dd>Perform minimization before everything.<br/>Default: true<br/></dd>
<dt><b>-optimize_cyclic_threshold</b> \<Real\></dt>
<dd>Choose value of peptide interface score percent of total isc from which to optimize cyclic peptide<br/>Default: 0.35<br/></dd>
<dt><b>-report_format</b> \<String\></dt>
<dd>The format of the report. Either 'basic' (easily parsable format) or 'markdown' (pretty, readable, but verbose format).<br/>Default: "markdown"<br/></dd>
<dt><b>-report_gzip</b> \<Boolean\></dt>
<dd>Gzip report file (only if -dump_report_file is enabled)<br/>Default: false<br/></dd>
</dl>
+ <h2>-phil</h2>
<dl>
<dt><b>-phil</b> \<Boolean\></dt>
<dd>phil option group<br/></dd>
<dt><b>-nloop</b> \<Integer\></dt>
<dd>No description<br/>Default: 10<br/></dd>
<dt><b>-vall_file</b> \<String\></dt>
<dd>No description<br/></dd>
</dl>
+ <h2>-ralford</h2>
<dl>
<dt><b>-ralford</b> \<Boolean\></dt>
<dd>ralford option group<br/></dd>
</dl>
+ <h3>-ralford:dump_rotamers</h3>
<dl>
<dt><b>-dump_rotamers</b> \<Boolean\></dt>
<dd>dump_rotamers option group<br/></dd>
<dt><b>-rsd_index</b> \<Integer\></dt>
<dd>Dump all of the rotamers for the amino acid at a user-specified position<br/>Default: 1<br/></dd>
<dt><b>-rotamer_info_prefix</b> \<String\></dt>
<dd>Prefix for output rotamer information file<br/>Default: "output"<br/></dd>
<dt><b>-write_rotamers_to_pdbs</b> \<Boolean\></dt>
<dd>Write all of the rotamer poses to pdb files<br/>Default: false<br/></dd>
<dt><b>-all_positions</b> \<Boolean\></dt>
<dd>Option to dump all rotamers at all positions - use with caution<br/>Default: false<br/></dd>
</dl>
+ <h2>-robert</h2>
<dl>
<dt><b>-robert</b> \<Boolean\></dt>
<dd>robert option group<br/></dd>
<dt><b>-pairdata_input_pdb_list</b> \<String\></dt>
<dd>Takes in a file containing a list of pdb locations paired with protocol specific data (eg: one disulfide pair)<br/>Default: ""<br/></dd>
<dt><b>-pcs_maxsub_filter</b> \<Real\></dt>
<dd>minimum normalized maxsub for PCS clustering protocol<br/>Default: 0.9<br/></dd>
<dt><b>-pcs_maxsub_rmsd</b> \<Real\></dt>
<dd>maxsub calculation's rmsd threshold<br/>Default: 4.0<br/></dd>
<dt><b>-pcs_dump_cluster</b> \<Boolean\></dt>
<dd>No description<br/>Default: false<br/></dd>
<dt><b>-pcs_cluster_coverage</b> \<Real\></dt>
<dd>cluster coverage required<br/>Default: 0.3<br/></dd>
<dt><b>-pcs_cluster_lowscoring</b> \<Boolean\></dt>
<dd>cluster lowest 20% against lowest 50%<br/>Default: true<br/></dd>
</dl>
+ <h2>-rot_anl</h2>
<dl>
<dt><b>-rot_anl</b> \<Boolean\></dt>
<dd>rot_anl option group<br/></dd>
<dt><b>-tag</b> \<String\></dt>
<dd>nametag<br/>Default: "."<br/></dd>
<dt><b>-min</b> \<Boolean\></dt>
<dd>do sc min<br/>Default: false<br/></dd>
<dt><b>-repack</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-rtmin</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-scmove</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-design</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-dump_pdb</b> \<Boolean\></dt>
<dd>dump_pdb when pass thresh<br/>Default: false<br/></dd>
<dt><b>-nloop_scmove</b> \<Integer\></dt>
<dd>base of scmover loop (total=nloop^n_chi)<br/>Default: 9<br/></dd>
</dl>
+ <h2>-smhybrid</h2>
<dl>
<dt><b>-smhybrid</b> \<Boolean\></dt>
<dd>smhybrid option group<br/></dd>
<dt><b>-add_cavities</b> \<Boolean\></dt>
<dd>output cavities in result pdbs<br/>Default: false<br/></dd>
<dt><b>-abinitio_design</b> \<Boolean\></dt>
<dd>do a design run in centroid mode<br/>Default: true<br/></dd>
<dt><b>-fa_refine</b> \<Boolean\></dt>
<dd>Do nobu's flxbb<br/>Default: true<br/></dd>
<dt><b>-virtual_nterm</b> \<Boolean\></dt>
<dd>remove Nterm<br/>Default: false<br/></dd>
<dt><b>-debug</b> \<Boolean\></dt>
<dd>debug<br/>Default: false<br/></dd>
<dt><b>-refine</b> \<Boolean\></dt>
<dd>don't do bit centroid moves<br/>Default: false<br/></dd>
<dt><b>-centroid_all_val</b> \<Boolean\></dt>
<dd>mutate all to VAL in centroid mode<br/>Default: false<br/></dd>
<dt><b>-subsubs_attract</b> \<Boolean\></dt>
<dd>attract subsubs togeher<br/>Default: false<br/></dd>
<dt><b>-linker_cst</b> \<Boolean\></dt>
<dd>attract N/C termini for linker<br/>Default: false<br/></dd>
<dt><b>-pseudosym</b> \<Boolean\></dt>
<dd>HACK pseudosymmetry<br/>Default: false<br/></dd>
<dt><b>-design_linker</b> \<Boolean\></dt>
<dd>allow design on added 'linker' residues<br/>Default: true<br/></dd>
<dt><b>-design</b> \<Boolean\></dt>
<dd>allow design on added 'linker' residues<br/>Default: true<br/></dd>
<dt><b>-restrict_design_to_interface</b> \<Boolean\></dt>
<dd>allow design on added 'linker' residues<br/>Default: false<br/></dd>
<dt><b>-restrict_design_to_subsub_interface</b> \<Boolean\></dt>
<dd>allow design on added 'linker' residues<br/>Default: false<br/></dd>
<dt><b>-design_hydrophobic</b> \<Boolean\></dt>
<dd>design all hydrophobic<br/>Default: false<br/></dd>
<dt><b>-add_metal_at_0</b> \<Boolean\></dt>
<dd>DEPRECATED<br/>Default: false<br/></dd>
<dt><b>-nres_mono</b> \<Integer\></dt>
<dd>target number of residues per monomer<br/>Default: 20<br/></dd>
<dt><b>-abinitio_cycles</b> \<Integer\></dt>
<dd>number of abinitio cycles<br/>Default: 10000<br/></dd>
<dt><b>-primary_subsubunit</b> \<Integer\></dt>
<dd>primary subunut<br/>Default: 1<br/></dd>
<dt><b>-minbb</b> \<Integer\></dt>
<dd>level of bb min 0=None 1=little 2=all<br/>Default: 1<br/></dd>
<dt><b>-switch_concert_sub</b> \<Integer\></dt>
<dd>assume prmary subsub is on this subunit for concerted RB moves<br/>Default: 1<br/></dd>
<dt><b>-temperature</b> \<Real\></dt>
<dd>MC temp for cen fold<br/>Default: 2.0<br/></dd>
<dt><b>-inter_subsub_cst</b> \<Boolean\></dt>
<dd>add dis csts inter-subsub<br/>Default: false<br/></dd>
<dt><b>-rb_mag</b> \<Real\></dt>
<dd>magnitude of rb moves<br/>Default: 1.0<br/></dd>
<dt><b>-symm_def_template</b> \<File\></dt>
<dd>template for symmetry definition file<br/></dd>
<dt><b>-symm_def_template_reduced</b> \<File\></dt>
<dd>template for reduced symmetry definition file<br/></dd>
<dt><b>-attach_as_sc</b> \<IntegerVector\></dt>
<dd>attach the group via side chain<br/></dd>
<dt><b>-attach_as_sc_sub</b> \<IntegerVector\></dt>
<dd>attach the group via side chain in this sub<br/></dd>
<dt><b>-chainbreaks</b> \<BooleanVector\></dt>
<dd>close chainbreak from this subsub to the next<br/></dd>
<dt><b>-design_res_files</b> \<StringVector\></dt>
<dd>files containing designable residues for each component pose<br/>Default: ""<br/></dd>
<dt><b>-fixed_res_files</b> \<StringVector\></dt>
<dd>files containing fixed residues (no repack even) for each component pose<br/>Default: ""<br/></dd>
<dt><b>-frag_res_files</b> \<StringVector\></dt>
<dd>files containing residues ok to insert frags into. will have starting ss<br/>Default: ""<br/></dd>
<dt><b>-scattach_res_files</b> \<StringVector\></dt>
<dd>files containing residues ok to scattach to.<br/>Default: ""<br/></dd>
<dt><b>-rep_edge_files</b> \<StringVector\></dt>
<dd>files containing residues which are edge strands.<br/>Default: ""<br/></dd>
<dt><b>-virtual_res_files</b> \<StringVector\></dt>
<dd>files containing residues that should be virtual<br/>Default: ""<br/></dd>
<dt><b>-jumpcut_files</b> \<StringVector\></dt>
<dd>file specifying jumps and cuts for subsubunits<br/>Default: ""<br/></dd>
<dt><b>-cst_sub_files</b> \<StringVector\></dt>
<dd>file specifying which subunits are part of a structural unit and shoudl be constrained<br/>Default: ""<br/></dd>
<dt><b>-symm_file_tag</b> \<StringVector\></dt>
<dd>label for each subunit<br/>Default: ""<br/></dd>
<dt><b>-attach_atom</b> \<StringVector\></dt>
<dd>attach atom on each subunit<br/>Default: ""<br/></dd>
<dt><b>-add_res_before</b> \<StringVector\></dt>
<dd>SS to add before each subunit region<br/>Default: ""<br/></dd>
<dt><b>-add_res_after</b> \<StringVector\></dt>
<dd>SS to add after each subunit region<br/>Default: ""<br/></dd>
<dt><b>-add_ss_before</b> \<StringVector\></dt>
<dd>residues to add<br/>Default: ""<br/></dd>
<dt><b>-add_ss_after</b> \<StringVector\></dt>
<dd>SS to add after each subunit region<br/>Default: ""<br/></dd>
<dt><b>-add_atom_at_cen</b> \<StringVector\></dt>
<dd>SS to add after each subunit region<br/>Default: ""<br/></dd>
<dt><b>-attach_rsd</b> \<StringVector\></dt>
<dd>attach rsd on each subunit<br/>Default: ""<br/></dd>
</dl>
+ <h2>-tcrmodel</h2>
<dl>
<dt><b>-tcrmodel</b> \<Boolean\></dt>
<dd>tcrmodel option group<br/></dd>
<dt><b>-ignore_list</b> \<File\></dt>
<dd>user provided template ignore list for tcrmodel<br/>Default: ""<br/></dd>
<dt><b>-blastp_identity_cutoff</b> \<Real\></dt>
<dd>Cutoff to ignore templates based on blast results<br/>Default: 100<br/></dd>
<dt><b>-template_identity_cutoff</b> \<Real\></dt>
<dd>Cutoff to ignore templates based on sequence identity score<br/>Default: 100<br/></dd>
<dt><b>-include_ab_templates</b> \<Boolean\></dt>
<dd>include antibody templates<br/>Default: false<br/></dd>
<dt><b>-dump_templates</b> \<Boolean\></dt>
<dd>dump all template pdb files<br/>Default: false<br/></dd>
<dt><b>-skip_modeling</b> \<Boolean\></dt>
<dd>skip the modeling part, used for testing seq and template info<br/>Default: false<br/></dd>
<dt><b>-ab_template_db_path</b> \<String\></dt>
<dd>antibody template database path<br/>Default: "./"<br/></dd>
<dt><b>-tcr_template_db_path</b> \<String\></dt>
<dd>tcr template database path<br/>Default: ""<br/></dd>
<dt><b>-minimize_model</b> \<Boolean\></dt>
<dd>minimize the tcr model<br/>Default: true<br/></dd>
<dt><b>-relax_model</b> \<Boolean\></dt>
<dd>relax the tcr model<br/>Default: false<br/></dd>
<dt><b>-remodel_loop_cdr3a</b> \<Boolean\></dt>
<dd>remodel the cdr3 loop of tcr alpha chain<br/>Default: false<br/></dd>
<dt><b>-remodel_loop_cdr3b</b> \<Boolean\></dt>
<dd>remodel the cdr3 loop of tcr beta chain<br/>Default: false<br/></dd>
<dt><b>-remodel_tcr_cdr3a_loop</b> \<Boolean\></dt>
<dd>remodel the cdr3 loop of tcr alpha chain<br/>Default: false<br/></dd>
<dt><b>-remodel_tcr_cdr3b_loop</b> \<Boolean\></dt>
<dd>remodel the cdr3 loop of tcr beta chain<br/>Default: false<br/></dd>
<dt><b>-refine_tcr_cdr3a_loop</b> \<Boolean\></dt>
<dd>refine the cdr3 loop of tcr alpha chain<br/>Default: false<br/></dd>
<dt><b>-refine_tcr_cdr3b_loop</b> \<Boolean\></dt>
<dd>refine the cdr3 loop of tcr beta chain<br/>Default: false<br/></dd>
<dt><b>-remodel_tcr_cdr3_loops</b> \<Boolean\></dt>
<dd>remodel the cdr3 loop of tcr alpha and beta chains<br/>Default: false<br/></dd>
<dt><b>-refine_tcr_cdr3_loops</b> \<Boolean\></dt>
<dd>refine the cdr3 loop of tcr alpha and beta chains<br/>Default: false<br/></dd>
<dt><b>-refine_all_tcr_cdr_loops</b> \<Boolean\></dt>
<dd>refine the cdr1, cdr2 and cdr3 loops of tcr alpha and beta chains<br/>Default: false<br/></dd>
<dt><b>-use_user_templates</b> \<Boolean\></dt>
<dd>use user provided templates for TCR segments, useful for testing and integrations tests<br/>Default: false<br/></dd>
<dt><b>-alpha_framework_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain framework segment, eg. 1kgc_D<br/>Default: ""<br/></dd>
<dt><b>-beta_framework_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain framework segment, eg. 1kgc_E<br/>Default: ""<br/></dd>
<dt><b>-alpha_germline_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain germline segment, eg. 1kgc_D<br/>Default: ""<br/></dd>
<dt><b>-beta_germline_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain germline segment, eg. 1kgc_E<br/>Default: ""<br/></dd>
<dt><b>-alpha_cdr1_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain CDR1 segment, eg. 1kgc_D<br/>Default: ""<br/></dd>
<dt><b>-beta_cdr1_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain CDR1 segment, eg. 1kgc_E<br/>Default: ""<br/></dd>
<dt><b>-alpha_cdr2_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain CDR2 segment, eg. 1kgc_D<br/>Default: ""<br/></dd>
<dt><b>-beta_cdr2_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain CDR2 segment, eg. 1kgc_E<br/>Default: ""<br/></dd>
<dt><b>-alpha_cdr3_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain CDR3 segment, eg. 1kgc_D<br/>Default: ""<br/></dd>
<dt><b>-beta_cdr3_template_id</b> \<String\></dt>
<dd>template PDB id with chain for alpha chain CDR3 segment, eg. 1kgc_E<br/>Default: ""<br/></dd>
<dt><b>-alpha_orientation_template_id</b> \<String\></dt>
<dd>template PDB id with chain for orientation of alpha chain, use along with beta_orientation_template_id, eg. 1kgc_D<br/>Default: ""<br/></dd>
<dt><b>-beta_orientation_template_id</b> \<String\></dt>
<dd>template PDB id with chain for orientation of beta chain, use along with -alpha_orientation_template_id, eg. 1kgc_E<br/>Default: ""<br/></dd>
<dt><b>-alpha_framework_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain framework segment<br/>Default: ""<br/></dd>
<dt><b>-beta_framework_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain framework segment<br/>Default: ""<br/></dd>
<dt><b>-alpha_germline_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain germline segment<br/>Default: ""<br/></dd>
<dt><b>-beta_germline_template_pdb</b> \<String\></dt>
<dd>template PDB file alpha chain germline segment<br/>Default: ""<br/></dd>
<dt><b>-alpha_cdr1_template_pdb</b> \<String\></dt>
<dd>template PDB file alpha chain CDR1 segment<br/>Default: ""<br/></dd>
<dt><b>-beta_cdr1_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain CDR1 segment<br/>Default: ""<br/></dd>
<dt><b>-alpha_cdr2_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain CDR2 segment<br/>Default: ""<br/></dd>
<dt><b>-beta_cdr2_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain CDR2 segment<br/>Default: ""<br/></dd>
<dt><b>-alpha_cdr3_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain CDR3 segment<br/>Default: ""<br/></dd>
<dt><b>-beta_cdr3_template_pdb</b> \<String\></dt>
<dd>template PDB file for alpha chain CDR3 segment<br/>Default: ""<br/></dd>
<dt><b>-alpha_orientation_template_pdb</b> \<String\></dt>
<dd>template PDB file for orientation of alpha chain<br/>Default: ""<br/></dd>
<dt><b>-beta_orientation_template_pdb</b> \<String\></dt>
<dd>template PDB file for orientation of beta chain<br/>Default: ""<br/></dd>
<dt><b>-use_alpha_germline_templates</b> \<Boolean\></dt>
<dd>use germline templates for alpha chain, by default germline or framework templates choosen by sequence match<br/>Default: false<br/></dd>
<dt><b>-use_beta_germline_templates</b> \<Boolean\></dt>
<dd>use germline templates for beta chain, by default germline or framework templates choosen by sequence match<br/>Default: false<br/></dd>
<dt><b>-assign_cdr</b> \<Boolean\></dt>
<dd>assign cdr positions using user provided positions<br/>Default: false<br/></dd>
<dt><b>-assign_cdr1a</b> \<String\></dt>
<dd>assign cdr1a sequence positions by start and end residue numbers, eg. 23:36<br/>Default: ""<br/></dd>
<dt><b>-assign_cdr2a</b> \<String\></dt>
<dd>assign cdr2a sequence positions by start and end residue numbers, eg. 48:74<br/>Default: ""<br/></dd>
<dt><b>-assign_cdr3a</b> \<String\></dt>
<dd>assign cdr3a sequence positions by start and end residue numbers, eg. 89:103<br/>Default: ""<br/></dd>
<dt><b>-assign_cdr1b</b> \<String\></dt>
<dd>assign cdr1b sequence positions by start and end residue numbers, eg. 23:36<br/>Default: ""<br/></dd>
<dt><b>-assign_cdr2b</b> \<String\></dt>
<dd>assign cdr2b sequence positions by start and end residue numbers, eg. 48:74<br/>Default: ""<br/></dd>
<dt><b>-assign_cdr3b</b> \<String\></dt>
<dd>assign cdr3b sequence positions by start and end residue numbers, eg. 89:103<br/>Default: ""<br/></dd>
<dt><b>-anarci_path</b> \<String\></dt>
<dd>path for the program ANARCI to assign CDR positions by aho numbers, eg. '/usr/local/bin/anarci' <br/>Default: ""<br/></dd>
</dl>
+ <h2>-threadsc</h2>
<dl>
<dt><b>-threadsc</b> \<Boolean\></dt>
<dd>threadsc option group<br/></dd>
<dt><b>-src_chain</b> \<String\></dt>
<dd>Chain of source pdb<br/></dd>
<dt><b>-trg_chain</b> \<String\></dt>
<dd>Chain of target pdb<br/></dd>
<dt><b>-src_first_resid</b> \<Integer\></dt>
<dd>Residue id of first residue in source pdb range<br/></dd>
<dt><b>-trg_first_resid</b> \<Integer\></dt>
<dd>Residue id of first residue in source pdb range<br/></dd>
<dt><b>-nres</b> \<Integer\></dt>
<dd>Number of residues to be threaded<br/></dd>
<dt><b>-trg_anchor</b> \<Integer\></dt>
<dd>anchor residue for backbone threading<br/></dd>
</dl>
+ <h2>-ufv</h2>
<dl>
<dt><b>-ufv</b> \<Boolean\></dt>
<dd>ufv option group<br/></dd>
<dt><b>-left</b> \<Integer\></dt>
<dd>left endpoint<br/></dd>
<dt><b>-right</b> \<Integer\></dt>
<dd>right endpoint<br/></dd>
<dt><b>-ss</b> \<String\></dt>
<dd>secondary structure string<br/></dd>
<dt><b>-aa_during_build</b> \<String\></dt>
<dd>amino acid string during centroid build<br/></dd>
<dt><b>-aa_during_design_refine</b> \<String\></dt>
<dd>amino acid string during design-refine<br/></dd>
<dt><b>-keep_junction_torsions</b> \<Boolean\></dt>
<dd>when rebuilding loops, keep (approx) the original torsions at the junctions of the loop endpoints<br/>Default: false<br/></dd>
<dt><b>-ufv_loops</b> \<File\></dt>
<dd>use this multiple loop file in place of specifying single loop options on command line<br/></dd>
<dt><b>-use_fullmer</b> \<Boolean\></dt>
<dd>use full-mer fragments when building loop<br/>Default: false<br/></dd>
<dt><b>-centroid_loop_mover</b> \<String\></dt>
<dd>the centroid loop mover to use<br/>Default: "RemodelLoopMover"<br/></dd>
<dt><b>-no_neighborhood_design</b> \<Boolean\></dt>
<dd>only repack the neighborhood of the loop, don't design<br/>Default: false<br/></dd>
<dt><b>-dr_cycles</b> \<Integer\></dt>
<dd>design-refine cycles<br/>Default: 3<br/></dd>
<dt><b>-centroid_sfx</b> \<String\></dt>
<dd>filename of the centroid score function to use,<br/></dd>
<dt><b>-centroid_sfx_patch</b> \<String\></dt>
<dd>filename of the centroid score function patch to use,<br/></dd>
<dt><b>-fullatom_sfx</b> \<String\></dt>
<dd>filename of the full-atom score function to use<br/></dd>
<dt><b>-fullatom_sfx_patch</b> \<String\></dt>
<dd>filename of the full-atom score function patch to use<br/></dd>
</dl>
+ <h3>-ufv:insert</h3>
<dl>
<dt><b>-insert</b> \<Boolean\></dt>
<dd>insert option group<br/></dd>
<dt><b>-insert_pdb</b> \<File\></dt>
<dd>pdb of insert structure<br/></dd>
<dt><b>-attached_pdb</b> \<File\></dt>
<dd>pdb of structure in rigid body relationship with insert structure<br/></dd>
<dt><b>-connection_scheme</b> \<String\></dt>
<dd>enforce type of insertion: choose either n2c or c2n<br/></dd>
</dl>
+ <h2>-willmatch</h2>
<dl>
<dt><b>-willmatch</b> \<Boolean\></dt>
<dd>willmatch option group<br/></dd>
<dt><b>-write_reduced_matchset</b> \<StringVector\></dt>
<dd><name> <pdb1> <pdb2> ...<br/></dd>
<dt><b>-interface_size</b> \<Real\></dt>
<dd>num CB-CB within 8A<br/>Default: 30<br/></dd>
<dt><b>-max_dis_any</b> \<Real\></dt>
<dd><br/>Default: 3.0<br/></dd>
<dt><b>-max_dis_all</b> \<Real\></dt>
<dd><br/>Default: 2.6<br/></dd>
<dt><b>-max_dis_hb</b> \<Real\></dt>
<dd><br/>Default: 3.2<br/></dd>
<dt><b>-min_dis_hb</b> \<Real\></dt>
<dd><br/>Default: 2.2<br/></dd>
<dt><b>-max_dis_hb_colinear</b> \<Real\></dt>
<dd><br/>Default: 0.7<br/></dd>
<dt><b>-max_dis_metal</b> \<Real\></dt>
<dd><br/>Default: 1.0<br/></dd>
<dt><b>-max_ang_metal</b> \<Real\></dt>
<dd><br/>Default: 5.0<br/></dd>
<dt><b>-clash_dis</b> \<Real\></dt>
<dd><br/>Default: 3.5<br/></dd>
<dt><b>-c2_linker_dist</b> \<Real\></dt>
<dd><br/>Default: 3.5<br/></dd>
<dt><b>-identical_match_dis</b> \<Real\></dt>
<dd><br/>Default: 0.0001<br/></dd>
<dt><b>-chi1_increment</b> \<Real\></dt>
<dd><br/>Default: 10.0<br/></dd>
<dt><b>-chi2_increment</b> \<Real\></dt>
<dd><br/>Default: 20.0<br/></dd>
<dt><b>-c2_symm_increment</b> \<Real\></dt>
<dd><br/>Default: 20.0<br/></dd>
<dt><b>-cb_sasa_thresh</b> \<Real\></dt>
<dd><br/>Default: 20.0<br/></dd>
<dt><b>-design_interface</b> \<Boolean\></dt>
<dd><br/>Default: true<br/></dd>
<dt><b>-chilist</b> \<File\></dt>
<dd><br/></dd>
<dt><b>-fixed_res</b> \<File\></dt>
<dd><br/></dd>
<dt><b>-native1</b> \<File\></dt>
<dd><br/></dd>
<dt><b>-native2</b> \<File\></dt>
<dd><br/></dd>
<dt><b>-exclude_res1</b> \<File\></dt>
<dd><br/>Default: ""<br/></dd>
<dt><b>-exclude_res2</b> \<File\></dt>
<dd><br/>Default: ""<br/></dd>
<dt><b>-taglist</b> \<File\></dt>
<dd><br/></dd>
<dt><b>-residues</b> \<IntegerVector\></dt>
<dd><br/></dd>
<dt><b>-symmetry_d2</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-symmetry_c2_dock</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-splitwork</b> \<IntegerVector\></dt>
<dd><br/></dd>
<dt><b>-exclude_ala</b> \<Boolean\></dt>
<dd><br/>Default: false<br/></dd>
<dt><b>-match_overlap_dis</b> \<Real\></dt>
<dd>distance under which to consider matches redundant<br/>Default: 00.20<br/></dd>
<dt><b>-match_overlap_ang</b> \<Real\></dt>
<dd>ang(deg) under which to consider matches redundant<br/>Default: 10.00<br/></dd>
<dt><b>-forbid_residues</b> \<IntegerVector\></dt>
<dd>disallow residues for matching<br/></dd>
<dt><b>-poi</b> \<RealVector\></dt>
<dd>xyz coords of some site of interest<br/></dd>
<dt><b>-poidis</b> \<Real\></dt>
<dd>poi distance threshold<br/></dd>
<dt><b>-homodimer</b> \<Boolean\></dt>
<dd>examine only homodimer configs<br/>Default: false<br/></dd>
<dt><b>-fa_dun_thresh</b> \<Real\></dt>
<dd><br/>Default: 6.0<br/></dd>
</dl>
+ <h2>-PDB_diagnostic</h2>
<dl>
<dt><b>-PDB_diagnostic</b> \<Boolean\></dt>
<dd>PDB_diagnostic option group<br/></dd>
<dt><b>-reading_only</b> \<Boolean\></dt>
<dd>if true, become a no-op (only structure reading is tested). Useful for not-mega-clusters where packing a virus/ribosome will crush memory.<br/>Default: false<br/></dd>
<dt><b>-skip_pack_and_min</b> \<Boolean\></dt>
<dd>Skip the packing and minimization steps (leaving in the scoring and ResidueType analyses). Good for speed, or for shallower tests.<br/>Default: false<br/></dd>
</dl>
+ <h2>-testing</h2>
<dl>
<dt><b>-testing</b> \<Boolean\></dt>
<dd>testing option group<br/></dd>
<dt><b>-HCF</b> \<Boolean\></dt>
<dd>Cause Rosetta to exit immediately with an error.<br/>Default: false<br/></dd>
<dt><b>-INTEGRATION_TEST</b> \<Boolean\></dt>
<dd>Meta flag for best-practices flags in integration tests. Don't use on actual runs.<br/>Default: false<br/></dd>
</dl>
