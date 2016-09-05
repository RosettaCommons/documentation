# Release Notes

<!--- BEGIN_INTERNAL -->

## Rosetta 3.7 (internal notes)

(This section should remain hidden from the public wiki.)

3.7 will be Rosetta 2016.32, http://test.rosettacommons.org/revision?id=108&branch=release, https://github.com/RosettaCommons/main/commit/9005cc64587b4189882337bc87783ab96ead263f.  See also [https://wiki.rosettacommons.org/index.php/3.7_release_notes_workspace]

### Rosetta 3.7 NOT included in release notes
* These are items that will be omitted from the release notes as incomplete features, but should be listed once finished for 3.8 or whenever
* XML schema
* JD3

**!! when the notes go public, end_internal moves right here**

(this part will go public later)
## Rosetta 3.7

### New and updated applications
* [[ERRASER|erraser]] updated: improved support for residues that are not canonical RNA
* [[GlycanRelax]] (see also [[WorkingWithGlycans]])
* The RosettaAntibody protocol has been streamlined and is closer to being a single application instead of a constellation of scripts
    * Support for L4/H4 (DE loop)
    * Support for camelid antibodies
    * identify_cdr_clusters tool
    * packing_angle tool
* [[RosettaScripts]] now supports inclusion of script fragments in other scripts
* [[simple_cycpep_predict]] - design of cyclic peptides
* [[FlexPepDock|flex-pep-dock]] - ligand compatibility
* [[ddg-monomer]] - ligand compatibility
* [[torsional-potential-corrections]], for [Conway P, DiMaio F. Improving hybrid statistical and physical forcefields through local structure enumeration. Protein Sci. 2016 May 30.](http://www.ncbi.nlm.nih.gov/pubmed/27239808)
* [pH_protocol](http://www.ncbi.nlm.nih.gov/pubmed/25501663) (link to paper)

### New features and classes
* A new introductory tutorial system has been added under the demos/tutorial/ directory. These can also be found online at <https://www.rosettacommons.org/demos/latest/>
    * The introductory tutorials cover both basic concepts (packing, minimization, fullatom/centroid) as well as demonstrations on how to use some of the most commonly used Rosetta protocols (ab inito, comparative modeling, loop modeling, design, protein-protein docking and protein-ligand docking).
    * Additional demos are now listed [thematically](https://www.rosettacommons.org/demos/latest/demos-by-category), to assist in locating relevant demos.
* Many new [[ResidueSelectors]]
* PDB reading can handle LINK records in most cases
* "Spell checking" for options: suggestions for the desired option if the user's options are invalid
* [[AACompositionEnergy]] takes fractional compositions in addition to counted-out compositions
* New score term to penalize peptide sequences that form aspartimide
* New script for setting up the [[pyrosetta]] environment

### Bugfixes

* `loops::restrict_kic_sampling_to_torsion_string` repaired (for [[KIC|next-generation-KIC]] loop modeling)
* [[BridgeChainsMover]] repaired to match publication


<!--- END_INTERNAL -->

## Rosetta 3.6

After releasing Rosetta 3.5 in 2013, Rosetta transitioned to a weekly release system.  Rosetta 3.6 is weekly release v2016.13-dev58602.  We are marking it as 3.6 to meet the needs of users that require numbered releases instead of weeklies.  This large set of release notes collects changes released in weekly releases since their inception.

### New scorefunctions:

Since Rosetta 3.5, the default scorefunction was [updated](rosetta_basics/scoring/Scorefunction-History) two generations, to Talaris2013 and then to Talaris2014 .  
We’ve also updated the default minimizer to [LBGFS](https://en.wikipedia.org/wiki/Limited-memory_BFGS), which is expected to provide better performance on the average problem.

### New applications:
* [Remodel](application_documentation/design/rosettaremodel)
* [PeptiDerive](application_documentation/analysis/PeptiDerive)
* [Antibody suite](application_documentation/antibody/antibody-applications) (includes SnugDock, previously only in legacy Rosetta2) 
* New tools for Rosetta comparative modeling ([RosettaCM](application_documentation/structure_prediction/RosettaCM)) 
* (More) tools for crystallographic refinement using Rosetta and PHENIX
Updates to [DARC](application_documentation/docking/DARC) docking 
* Metal interface design:
    * Zinc homodimer design ([http://www.ncbi.nlm.nih.gov/pubmed/22092237](http://www.ncbi.nlm.nih.gov/pubmed/22092237), [http://www.ncbi.nlm.nih.gov/pubmed/22510088](http://www.ncbi.nlm.nih.gov/pubmed/22510088))
* [FARNA](farna-refactor), a refactor of Rosetta’s RNA code 
    *  [Mg_modeler](application_documentation/rna/mg-modeler), for including magnesium 2+ ions into structures 
* A new [framework](application_documentation/membrane_proteins/RosettaMP-GettingStarted-Overview) and suite of applications for modeling and designing membrane proteins (http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004398)
* Pocket docking (looks for druggable sites) ([make-exemplar](application_documentation/utilities/make-exemplar), [pocket-relax](application_documentation/utilities/pocket-relax), [pocket-suggest-targets](application_documentation/utilities/pocket-suggest-targets) )
* [SEWING](scripting_documentation/RosettaScripts/composite_protocols/sewing/SEWING) (http://www.ncbi.nlm.nih.gov/pubmed/27151863)
* [Simple_cycpep_predict](structure_prediction/simple_cycpep_predict): fragment-free peptide structure prediction for N-to-C cyclic peptides containing arbitrary mixtures of L- and D-amino acids (and glycine).  
* [Surface_docking](surface-docking) (Docking to mineral surfaces) 
Enzyme specificity re-design (using coupled_moves) ([http://www.ncbi.nlm.nih.gov/pubmed/26397464](http://www.ncbi.nlm.nih.gov/pubmed/26397464))
* Design with Oligooxypiperizines (OOPs), hydrogen bond surrogates (HBS), and peptoid foldamers ([http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0067051](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0067051), [http://pubs.acs.org/doi/abs/10.1021/ja502310r](http://pubs.acs.org/doi/abs/10.1021/ja502310r), [http://pubs.acs.org/doi/abs/10.1021/ja503776z](http://pubs.acs.org/doi/abs/10.1021/ja503776z))
	

### New tools:
* [Batch_distances](Batch-distances)
* [Residue_energy_breakdown](application_documentation/analysis/residue-energy-breakdown) 
* Reference poses: [store a pose “snapshot”](scripting_documentation/RosettaScripts/Movers/movers_pages/StorePoseSnapshotMover) at a particular point in a protocol, and use the residue numbering in that pose to control behavior of modules at a downstream point, even if the residue numbering has changed (due to loop insertion, etc.).
* [Energy function weight optimization](application_documentation/utilities/opt-e-parallel-doc) (not suggested for end-user use, but if you’re brave…) 
* A large number of RosettaScripts Movers, Filters, TaskOperations, etc. added.  These include:
    * [Disulfidize](scripting_documentation/RosettaScripts/Movers/movers_pages/DisulfidizeMover): Add disulfide bonds to a pose, trying all permutations to find best disulfide placement.
    * Perturb by torsion bins ([InitializeByBins](scripting_documentation/RosettaScripts/Movers/movers_pages/InitializeByBinsMover), [PerturbByBins](scripting_documentation/RosettaScripts/Movers/movers_pages/PerturbByBinsMover) movers): Perturb a conformation based on statistical probability of finding residue i in torsion bin B, and residue i+1 in bin B’. 
    * [GeneralizedKIC](scripting_documentation/RosettaScripts/composite_protocols/generalized_kic/GeneralizedKIC) mover: general kinematics-based loop closure for arbitrary chains of atoms that can include stretches of canonical or noncanonical backbone, side-chains, ligands, etc. 
    * Parametric design tools ([MakeBundle](scripting_documentation/RosettaScripts/Movers/movers_pages/MakeBundleMover), [PerturbBundle](scripting_documentation/RosettaScripts/Movers/movers_pages/PerturbBundleMover), and [BundleGridSampler](scripting_documentation/RosettaScripts/Movers/movers_pages/BundleGridSamplerMover) movers; [BundleReporter](scripting_documentation/RosettaScripts/Filters/filter_pages/BundleReporterFilter) filter): fragment-free sampling of coiled-coil tertiary structures.  Fully generalized for strands or helices made of canonical or noncanonical building-blocks.
    * LayerDesign and LayerSelector: design with different sets of residue types depending on burial and/or secondary structure.  [[LayerDesignOperation|scripting_documentation/RosettaScripts/TaskOperations/taskoperations_pages/LayerDesignOperation]], [[LayerSelector|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layers]]
* [FeaturesReporter](https://www.rosettacommons.org/docs/latest/scripting_documentation/RosettaScripts/FeaturesReporter/Features-reporter-overview) framework for structural analysis using Rosetta (was in 3.5, but is a more complete system now)


### Miscellaneous new features:
* Rosetta’s Boost version updated from 1.46 - > 1.55
* Internal smart pointer model altered to match C++11, along with other changes looking forward to C++11
* Major updates to MR-Rosetta
* Loop Modeling:
    * Extension of KIC loop modeling to non-canonical backbones (beta amino acids, etc) with GeneralizedKIC (see above).
    * Continued development of next-gen KIC, including compatibility with fragments-based modeling
* Multiple refactorings in the chemistry layers, allowing:
    * Poses with carbohydrates
    * Better support for ribonucleoprotein
    * Support for all ligands in the PDB’s chemical dictionary (note you must [install that dictionary separately](build_documentation/Build-Documentation#setting-up-rosetta-3_obtaining-additional-files_pdb-chemical-components-dictionary))
    * Support for runtime manipulation of chemistry (adding/removing atoms)
    * Support for rotamer libraries with arbitrary numbers of backbone torsion dependencies
    * Automatic setup of bonds to [metal ions](rosetta_basics/non_protein_residues/Metals).  
* Much better support for [D-amino acids](rosetta_basics/non_protein_residues/D-Amino-Acids).  Mirror-image conformations now score identically with the talaris2013 and talaris2014 scoring functions.  D-residues use rotamer and scoring databases for their L-counterparts.
* Support for [mirror-image symmetry operations](rosetta_basics/structural_concepts/symmetry#symmetry-definitions_symmetries-with-mirror-operations) in symmetric poses, with proper conversion between D- and L-amino acid residue types.
* Support for [non-pairwise-decomposable score terms](rosetta_basics/scoring/AACompositionEnergy) during packing
* New non-pairwise-decomposable score term to guide design that penalizes deviations from a desired residue type composition.  
    * New “[sequence constraints](scripting_documentation/RosettaScripts/Movers/movers_pages/AddCompositionConstraintMover)” to control the residue type composition of a sub-region of a structure (e.g. a protein interface) during design.
* New neighbor radii for canonical amino acids
* ResidueSelector hierarchy as a selection syntax
* FloppyTail now compatible with symmetry
* Much better support for noncanonical residue linkages, such as N-to-C cylization, sidechain-backbone linkages, etc.
* Full [Database support](rosetta_basics/file_types/sql/Database-IO) and documentation (SQLITE3, MySQL, etc) 

### Performance, usability improvements, bug fixes:
* 10% speed improvement in etable evaluation (faster scoring).  Reduced memory use.
* Automatic backtrace reporting upon crash, for better debugging
* Beautification: yes, we finally have a codebase-wide single style format, enforced by an external beautification script
* Repair of the longstanding “ResidueType explosion” malfeature, reducing memory use dramatically and improving Rosetta boot-up time
* SASA machinery completely overhauled.  Default SASA radii changed to the Reduce set, which include hydrogens by default.  It was previously using a radii set that was never published. SASA Calc settings can be changed through options system.
* New [documentation wiki](Home)


## Rosetta 3.5

Released Sunday, June 2, 2013

* Major updates to relational database support
* Many new Movers, Filters, TaskOperations, etc
* NGK "Next Generation" kinematic loop closure
* Updates to chemically_conjugated_docking apps UBQ_E2_thioester and neighbors (Saha A, Kleiger G, Lewis S, Kuhlman B, Deshaies RJ. Essential role for ubiquitin-ubiquitin-conjugating enzyme interaction in ubiquitin discharge from Cdc34 to substrate. Molecular Cell. In press.)
* LOOP_DEFINITIONS tag Loop specification within RosettaScripts
* OUTPUT tag Rescore-on-output option for RosettaScripts
* ERRASER package for RNA structure correction with or without experimental electron density (NOTE: collaboration with the PHENIX project; requires PHENIX liscenced and installed separately).
* ResourceManager allows for different command-line arguments and other centrally-managed resources with different jobs within one instantiation of Rosetta
* OpenCL support - notice only a very few algorithms feature GPU support; general GPU support is not yet present. previous CUDA support removed
* Updates to the FloppyTail app
* pmut_scan app upgraded to have support for Rosetta++ alter_spec mode - it scans for destabilizing rather than stabilizing mutations (particularly at protein-protein interfaces)
* Linear Memory Interaction Graph now works with symmetric poses
* Enzyme design at protein-protein interfaces
* Supercharge application (Lawrence MS, Phillips KJ, Liu DR. Supercharging proteins can impart unusual resilience. J Am Chem Soc. 2007 Aug 22;129(33):10110-2.)
* 3x1 metal-mediated interface design application (Der BS, Machius M, Miley MJ, Mills JL, Szyperski T, Kuhlman B. Metal-mediated affinity and orientation specificity in a computationally designed protein homodimer. J Am Chem Soc. 2012 Jan 11;134(1):375-85.)
* New demos ERRASER, favor_native_residue, Protocol captures
* Scoring
    * -use_bicubic_interpolation smooths issues with binned knowledge-based
    * phi-psi based terms (including Ramachandran, p_aa_pp, and Dunbrack (2002 only)
    * centroid radii bugfixes
    * New RNA scoring potentials, for use with ERRASER and PHENIX
    * -analytic_etable_evaluation (affects fa_rep, fa_atr, fa_sol, fa_intra_rep) offers a major memory reduction and removes a derivative discontinuity, at the cost of some speed
    * sasapack and avge scores from Rosetta++
    * Dunbrack 2010 (Dun10) library added. Dunbrack 2008 (Dun08) library deprecated and removed. Note that Dun10 is only available to academic users as part of the Rosetta download at this time; Dun10 must be separately liscenced for commercial users (LINKY). Feel free to contact us via the forums for assistance in installing the Dun10 library.
    * lbfgs minimizer - more efficient for minimization with many DOFs, especially Relax
    * cartesian minimizer - allows minimization of 3D coordinates instead of internal torsions, including minimization of bond lengths and angles
    * -bbdep_omega - backbone-dependent omega torsion scoring term
* Tools
    * Python scripts for Rosetta output processing (turning scorefiles into score v. RMSD plots, etc.)
    * pdb2vall package - generates a VALL fragment_picker template database from a specified PDB+chain
    * batch_molfile_to_params.py - used for creating large numbers of ligand paramter files (for virtual screening, etc.), script to load silent files directly into PyMOL.

## Rosetta 3.4

Released Sunday, March 25, 2012

* Point mutant scan application: The purpose of this protocol is to increase the stability of a protein of interest with only single or double point mutants.
* Non canonical amino acid utilities: This feature includes 2 applications: 
    1. MakeRotLib - This application creates a noncanonical amino acid rotamer library 
    2. UnfoldedStateEnergyCalculator - This application calculates the explicit unfolded state energies.
* RNA assembly with experimental pair-wise constraints: This code is intended to take an RNA sequence and secondary structure and then give three-dimensional de novo models of the helices and inter-helical motifs, and then build up the complete model from these parts.
* RNA 3D structure modeling: Added the applications: rna_cluster, rna_minimize and rna_helix
* RNA loop modeling with stepwise assembly: This method builds single-stranded RNA loops using a deterministic, enumerative sampling method called Stepwise Assembly.
* Remodeling RNA crystallographic models with electron density constraint: This code is used for improving a given RNA crystallographic model and reduce the number of potential errors in the model (which can evaluated by Molprobity), under the constraint of experimental electron density map.
* Chemically conjugated docking : These extensions of the UBQ_E2_thioester protocol allow modeling of chemically conjugated proteins (such as ubiquitin tagged to a target) via isopeptide, thioester, and disulfide linkages.
* RosettaVIP void identification and packing application: This code is intended to take a pdb file with the coordinates for a structural model of a protein with poor hydrophobic packing, and to return a list of mutations that are predicted to fill cavities in the protein core.
* Relax pdb with allatom constraints: hese scripts relax a pdb (minimize rosetta score) while keeping atoms as close as possible to the original positions in the crystal. It is designed to be used to prepare a structure for subsequent design in rosetta.
* Beta strand homodimer design: This code was written for a relatively singular application: finding proteins with surface exposed beta-strands, then trying to make and design a homodimer that will form via that beta-strand.
* DougsDockDesignMinimizeInterface: This protocol was used in the accompanying manuscript to redesign the protein/peptide interface of Calpain and a fragment of its inhibitory peptide calpastatin.

## Rosetta 3.3

Released Wednesday, August 31, 2011

* Includes comprehensive online documentation for users and for developers
* A library based object-oriented software suite
* Easy-to-use applications
* Flexible to incorporate your own protocols
* New Applications - Rosetta Antibody, Interface Analyzer, DDG Monomer, Multistate Design, Sequence Recovery, Fragment Picker, Interface Design, RosettaRNA, Pepspec Application.
* Includes the revolutionary new computer game Foldit in stand-alone version

## Rosetta 3.2.1

Released Friday, March 11, 2011

* New feature in Rosetta - RosettaDNA

## Rosetta 3.2

Released Friday, March 11, 2011

* Includes comprehensive online documentation for users and for developers
* A library based object-oriented software suite
* Easy-to-use applications
* Flexible to incorporate your own protocols
New Applications - Comparative Modeling, Flexible Peptide Docking, Symmetry Docking, RosettaMatch, Molecular Replacement, Boinc Minirosetta, Cluster Application.
* Includes the revolutionary new computer game Foldit in stand-alone version