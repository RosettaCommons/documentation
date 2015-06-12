#Applications

This is a list of every application in Rosetta that is compiled with weekly releases as of June 15, 2015.

### performance_benchmark
Runs the performance benchmarks, which determine whether recent changes to the Rosetta codebase have substantially altered its performance.
Users do not, generally speaking, benefit from running this application unless they are attempting to make major modifications to Rosetta.

###ddg_benchmark
Runs a scientific test that computes the delta-delta-G of mutation to alanine for a number of residues with known experimental values.
Similar to the performance benchmark, it is very unlikely that any user modifications to the codebase of a protocol could propagate backward to affect this benchmark.

###design_contrast_and_statistic
Runs fixbb design on several PDBs to test the overall amino acid type distribution returned by that algorithm.

###rotamer_recovery
Repacks a PDB and reports how many rotamers were preserved by the packer: this statistic of scoring function quality is intended to be run on very high quality PDBs because recapitulation of native good rotamers would be good.

###AbinitioRelax
Performs _ab initio_ structure determination using fragments files and secondary structure predictions.

###backrub
Performs the backrub mover, which involves a particular type of backbone sampling intended to maintain consistent sidechain interactions and orientations

###cluster
Selects the first 400 models for creating clusters based on CA distance according to cluster radius. Assign remaining structures one at a time by computing distance to prior created clusters; outside the cluster radius, a new cluster is created.

###combine_silent
Combines multiple silent files into one.

###extract_pdbs
Extracts the models with provided tags from a silent file into a PDB file.

###fragment_picker
Given a protein sequence and optionally secondary structure or other information, produces fragments file of the desired length(s) by drawing on the "vall," the Rosetta fragment library.

###idealize_jd2
Replace each residue in a pose with the idealized coordinates drawn from the database.

###minimize
Locally minimize a structure using a given scoring function and minimization type.

###minimize_ppi
Minimize a ligand at an interface and dump a lot of analysis information.

###packstat
Computes advanced cavity detection statistics on PDB structures to analyze packing quality.

###relax
Perform cycles of all-atom minimization and sidechain repacking with a ramping repulsive term. Responds to a provided relaxation script.

###remodel
Massively versatile application for expanding and contracting structures; it essentially brings the sampling framework of loop modeling to scenarios that require design.

###sequence_tolerance
This application uses a genetic algorithm and repeated backrub sampling with a resfile to optimize the sequence of a protein and explore the range of residue identities that that structure permits.

###SymDock
Dock a set of symmetric oligomers.

###vip
Locate buried voids using an early version of RosettaHoles and attempt point mutants that might reduce void volume.

###contactMap
Detemine what residues contact each other.

###ensemble_analysis
Obtain weighted RMSD of a set of decoys, align them, and write them out.

###fast_clustering
Obtain weighted RMSD of a set of decoys and then cluster them, using a more traditional clustering algorithm than cluster.

###InterfaceAnalyzer
Performs extensive analysis on the residues present at the interface, generating a wide variety of metrics.

###PeptideDeriver
Form a peptide macrocycle from a conformation of a peptide in a binding pocket.

###per_residue_energies, residue_energy_breakdown
Prints out the per residue energy breakdown for every residue in a pose.

###score, score_jd2
Scores a given PDB with the requested scoring function. Can also be used to extract models with a given tag from a silent file into a PDB. score_jd2 takes advantage of the modern job distributor.

###antibody_legacy
Legacy code to perform antibody structure determination.

###antibody_graft
Graft new loop onto an existing antibody framework.

###antibody_H3
Models the CDR H3 loop of an antibody in conjunction with optimizing surrounding loops and VH/VL orientation.

###minirosetta
A catchall app that, in versions of Rosetta before three, did just about everything. It is distributed with BOINC to perform Rosetta@Home tasks. You probably don't need to run this application.

###minirosetta_graphics
Minirosetta, but with a graphics viewer.

###cluster_alns
Cluster components of multiple sequence alignments based on sequence similarity.

###fix_alignment_to_match_pdb
Set up numbering of alignments so that they match provided PDBs.

###full_length_model
Obtain full length model of a protein from an alignment.

###partial_thread
Thread each input pose onto the template pose. 

###score_aln, score_aln2
Score alignments using a provided PSSM; score_aln2 uses machinery specialized for comparative modeling and is preferred.

###super_aln
Superimpose two given poses either by provided target residues or by all residues.

###validate_silent
Manually remove any sequence mismatches or failed simulations from the silent structure provided.

###coupled_moves
Perform coupled moves, in which the Boltzmann rotamer mover (which, in contrast to the packer, makes a concerted effort to achieve _sequence diversity_) repacks and small backbone moves are made at the same time.

###DARC
Employs ray casting algorithms (optimized for execution on GPUs) to achieve ligand docking.

###make_ray_files
Creates input files for using ray casting for alignment. This application is separate in large part because DARC benefits from GPU acceleration and this would not.

###ddg_monomer
Finds the energy of mutation for point mutations (or multiple mutations) of a given PDB.
Samples ensembles of wild type and mutant and gives the energies of each as either the average of the lowest three energies, the lowest energy, or the average energy.

###ensemble_generator_score12_sidechain_ver2
Creates an ensemble of structures using minimization with all-CA-pair constraints, optionally small and shear moves, and rotamer trials.
Notionally, scoring and computing statistics on wild type and mutant ensembles generated by this function would be another mode of ddG prediction; importantly for interface ddG, it would not explicitly be modeling the bound and unbound states.

###minimize_with_cst
Minimize with constraints on all pairs of CA atoms. I

###fixbb
Repacks a pose using a resfile.
Naturally, fixbb's iconic use is for fixed-backbone design; this is identical internally to repacking a pose using a resfile and merely allowing rotamers of other amino acids at one or more positions.

###mpi_msd
Perform multistate design using a genetic algorithm with a structure ensuring that corresponding residues in different states are packed to the same rotamer, using MPI.

###pmut_scan_parallel
Scan for stabilizing mutations in a protein.
This application can run in a double mutant mode that requires the mutated residues in question to have at least one atom in contact with each other.
It can also take only a given list of mutations, output structures, accept a ddg cutoff, and instead try to destabilize an interface. 

###sequence_recovery
Performs fixed backbone design and analyzes the resulting produced sequences for a statistic called sequence recovery: how often was the native sequence recapitulated for different residue types (polar, aliphatic, ...) and environments (core, surface, ...).

###beta_peptide_modeling
Repacks, redesigns, or minimizes a complex comprising one or more beta-peptide chains. (Importantly, a beta-peptide here does not refer to a conformation, but rather being composed of beta amino acids.)

###rna_design
Perform design on RNA poses. This application may be preferred for RNA design because it can process critical options such as whether to sample a particular proton chi on O2' and dump useful information, such as whether residues are in particular environments (single stranded, double stranded, or tertiary contact).

###supercharge
Intended to mutate exposed residues to predominantly have positive or negative charge due to useful resulting biological properties.
Can set a target charge or not; can be run in a deterministic AvNAPSA mode or  a stochastic pack_rotamers mode.
By default, only mutates to lysine for positive mode or glutamate (except starting from asparagine) in negative mode; can accept custom reference energies in Rosetta mode.

###zinc_heterodimer_design
Designs three residues of a zinc binding site on ankyrin, then use a residue from the other protein to define the interface orientation, sample rigid body space, then design.

###zinc2_homodimer_setup
Set up a homodimeric interface mediated by coordinating two zinc atoms: grafts in two two-residue zinc binding matches onto the protein surface, rotates around the zinc-zinc axis and the perpendicular axis.
Grid searches zinc-zinc axis rotations and dumps uneclipsed poses with good metal geometry.

###zinc2_homodimer_design
Symmetric design on a zinc-mediated homodimer, with minimization of sidechains, backbones, and the jump.

###docking_prepack_protocol
Prepacks the interface between a pair of chains to prepare for a docking simulation.

###docking_protocol
The main workhorse of classical rigid body docking, which can perform both the low resolution global centroid protocol and the high resolution refinement protocol.

###loops_from_density
Given a structure and electron density data to which it has a poor fit, generate loops files that would make Rosetta remodel up to the given fraction of the starting structure.

###mr_protocols
Uses fragments to perform a molecular replacement protocol into electron density data.

###CstfileToTheozymePDB
Given an enzyme constraint file, produces an inverse rotamer tree of the residues in question (which form a geometrically ideal "theoretical enzyme") and dump it as a multimodel PDB.
As "stealth functionality," can take a PDB using -s that will be aligned to the theozyme created.

###enzyme_design
Performs fixed or flexible backbone enzyme design with ligand rotamer sampling.

###rna_cluster
Clustering algorithm specialized for working with RNA

###rna_database
Turns provided RNA containing PDB files into the RNA equivalent of a "vall" fragments file, which instead just stores torsions.
Similarly, stores rigid body orientations

###rna_denovo
De novo design of RNA structures; this differs from ab initio in the protein context by using "fragments files" that are actually just torsions and relative rigid body orientations.

###rna_extract
Extracts RNA structures from silent files

###rna_minimize
Minimizes RNA structures using the RNAMinimizer (preferred); can vary bond geometry and skip trials on the O2' chi.

###rna_score
Scores RNA structures.

###cs_rosetta_rna
Solves RNA structures using RNA constraints.

###FiberDiffractionFreeSet
Employs iber diffraction data to refine protein structures.

###BuildPeptide
Builds a peptide of a given sequence in extended conformation.

###FlexPepDocking
Dock a peptide in a binding pocket with full peptide backbone flexibility. A starting pose with the peptide near its putative binding pocket is preferred, though in the ab initio mode, no knowledge about the peptide's final conformation is needed.

###AnchoredDesign
Design a protein-protein interface anchored by a portion grafted from a native interface.

###AnchoredPDBCreator
Grafts an "anchor" region from one protein onto another to help the latter protein successfully bind the former's native partner.

###AnchorFinder
Locate interfaces in the PDB that have "anchor" regions of high loopiness and excellent interface binding energies, to be grafted onto other proteins to aid in dimerization.

###validate_database
Ensure that the Rosetta database is internally consistent (for example, the Dunbrack libraries produce correct binaries).

###extract_atomtree_diffs
Atomtree_diff silent files are a particular format of silent file; this application converts them into many PDB files.

###ligand_dock
Dock ligands to proteins. DEPRECATED BY RosettaScripts movers. Use is not supported and is only relevant for consistency with legacy workflows.

###ligand_rpkmin
Minimize and repack sidechains, for preparing structures prior to ligand docking; thus, analogous to docking_prepack_protocol.

###select_best_unique_ligand_poses
Take top 5% of poses by total score, sorted by interface energy.
Work through one by one and keep poses that are at least min_rmsd away from the poses kept thus far.

###loopmodel
Model flexible protein loops with one of many algorithms, including CCD (cyclic coordinate descent) and KIC (kinematic closure).

###gen_apo_grids
Generate grids for the _apo_ (unliganded) form of the protein by searching the chemistry around the pocket. 

###gen_lig_grids
Generate grids for the _holo_ protein-ligand structure.

###match
Orient residues around a ligand to match particular scaffold atoms.

###membrane_abinitio2
Ab initio fold a membrane protein. Functionally, this is just a wrapper around Abrelax that is responsive to to to membrane-specific options.

###extract_motifs
Extract and score key motifs from residue side chains from a given PDB and output them.

###incorporate_motifs
Identify flexible regions in a pose using the loops framework and use a collection of inverse rotamers drawn from the motif library to attempt to close the loop. 

###MakeRotLib
Calculates a rotamer library for a given set of backbone angles for a given ResidueType.

###UnfoldedStateEnergyCalculator
Calculates the unfolded state energy (a type of reference energy used by the mm_std energy function) for a ResidueType.

###r_noe_assign
Generate constraint files based on a provided file of well-formatted NOEs and write assignments based on the structure of the native pose provided.

###hbs_design
Design a fixed complex of protein and hydrogen bond surrogate scaffold. HBS are constrained helix mimetics made of canonical or noncanonical amino acids with a macrocycle constraining the first several residues of the backbone.

###oop_design
Design a fixed complex of protein and oligooxopiperazine scaffold. Oligooxopiperazines are helix surface mimetics made of canonical or noncanonical amino acids with six-membered rings constraining the backbone

###peptoid_design
Design a fixed complex of protein and peptoid scaffold. Peptoids are N-alkyl or N-aryl glycine residues; many peptoid-specific side chains are incorporated into Rosetta.

###pepspec
Optionally extend a peptide a number of residues; perform design and minimization to massage it into the binding pocket. Has both low and high resolution phases. 

###pepspec_anchor_dock
Anchored, flexible backbone peptide docking to set up structures for pepspec.

###pocket_relax
Relax a shell of pocket residues around a target exemplar residue.

###pocket_suggest_target_residues_by_ddg
Obtain target pocket by analyzing a ddg file and evaluating individual residue pockets therein.

###pocket_measure
Measure statistics and grid data for a desired pocket.

###make_exemplar
Evaluates a pocket around a desired residue intended to form an "exemplar." See documentation for the series of applications: pocket_relax, pocket_suggest_target_residues_by_ddg, pocket_measure, and make_exemplar.

###nucleobase_sample_around
Sample probe atoms or molecules of desired size around a nucleobase. 

###recces_turner
Extensive RNA structural sampling and analysis.

###rna_features
Much as the [FeaturesReporter] framework exports a variety of protein features to databases, this applicatoin will extract critical features from RNA structures.

###rna_graft
Graft multiple RNA sequences together.

###rna_helix
Produce an idealized RNA helix from a sequence, for use in subsequent grafting.

###rna_predict_chem_map
Predict what the chem map (a common piece of data used for experimental RNA structure determination) would be for a given structural model.

###rna_suitename

###rna_thread

###erraser_minimizer

###surface_docking

###swa_protein_main
Performs stepwise Monte Carlo algorithms to build protein loops.

###swa_rna_main
Performs stepwise assembly on RNA structures.

###swa_rna_util

###stepwise
Legacy code supporting the original version of the stepwise assembly framework.

###revert_design_to_native
If a design is sufficiently comparable to the native score, we revert 

###rosetta_scripts
Runs an XML-specified protocol composed of particular Movers, Filters, and TaskOperations that have been made compatible with RosettaScripts.

###rosettaDNA
Runs the DockDesignParser, allows access to protein-DNA information and code, and uses a customized PDB output to add protein-DNA specific information.

###exposed_strand_finder
Locates exposed beta strands within the provided PDB as a potential target for homodimerization with a designed beta strand.

###homodimer_design
Actually performs homodimer design on a fixed beta strand scaffold.

###homodimer_maker
Orients two copies of one chain so that a previously exposed beta strand became aligned to each other to form a homodimer.

###ca_to_allatom  
Given a low resolution structure that therefore only contains a trace of the alpha carbons, expand the CA atoms to full residues and perform extensive sampling.

###doug_dock_design_min_mod2_cal_cal
A dock-design application originally written to exemplify the wonders of what the new job distributor and object-oriented Rosetta 3.0+ can do for you.
Docks and designs and minimizes a peptide in a binding pocket with minimal flexibility.

###FloppyTail  
Explores large swaths of conformational space to enumerate possible conformations for a disordered tail of a protein. 
_Does not_ provide positive information; there is not a fixed conformation for this tail in any event, but it can provide information about whether a region of conformational space is accessible or inaccessible.

###UBQ_E2_thioester
Given a starting PDB with a cysteine and a PDB of ubiquitin (though truly applicable to any protein), conjugate the C-terminus of the ubiquitin PDB to the cysteine indicated and then dock the two proteins together subject to that constraint.

###UBQ_Gp_CYD-CYD 
Given a starting PDB with a cysteine and a PDB of ubiquitin (though truly applicable to any protein containing a cysteine), form a disulfide from the two cysteines indicated and then dock the two proteins together subject to that constraint.

###UBQ_Gp_LYX-Cterm
Given a starting PDB with a lysine and a PDB of ubiquitin (though truly applicable to any protein), conjugate the C-terminus of the ubiquitin PDB to the lysine indicated and then dock the two proteins together subject to that constraint.

###optE_parallel
Optimize the weights of a provided energy functions to produce excellent sequence recovery and rotamer recovery.