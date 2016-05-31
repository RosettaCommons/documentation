# Change Log

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
    ### Scoring
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
    ### Tools
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