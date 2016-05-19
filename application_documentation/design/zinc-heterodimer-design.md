#Zinc\_heterodimer\_design application

Metadata
========

Last updated on 19 May 2016 by Steven Lewis.  Author Bryan Der (bder@email.unc.edu), Kuhlman lab (bkuhlman@email.unc.edu).

Code and Demo
=============

Code for this application is in src/apps/public/design/zinc\_heterodimer\_design (setup and driver) and src/protocols/metal\_interface/ZincHeterodimerMover (mover). The integration test is called zinc\_heterodimer.

References
==========

[http://www.ncbi.nlm.nih.gov/pubmed/23504819] 
Der BS, Jha RK, Lewis SM, Thompson PM, Guntas G, Kuhlman B. Combined
computational design of a zinc-binding site and a protein-protein interaction:
one open zinc coordination site was not a robust hotspot for de novo ubiquitin
binding. Proteins. 2013 Jul;81(7):1245-55. doi: 10.1002/prot.24280. Epub 2013 Apr
20. Erratum in: Proteins. 2013 Sep;81(9):1678. Jha, Raamesh K [corrected to Jha, 
Ramesh K]. PubMed PMID: 23504819; PubMed Central PMCID: PMC4084500.

Purpose
===========================================

This protocol designs zinc-mediated heterodimers. One partner contains a three-residue zinc binding site, the second partner contains one surface zinc-coordinating residue. In the example given, partner 2 is ubiquitin, which contains a surface histidine.

Algorithm
=========

Prior to running this protocol, RosettaMatch is used to design three-residue zinc sites on a protein surface. Next, the target protein containing a surface histidine (Ubq-H68) is docked to the open coordination site of zinc. The ubiquitin rigid-body orientation to the designed zinc-binding scaffold is sampled as if the ubiquitin were a giant protein-sized rotamer. This is done using inverse-rotamer sampling of Ubq-H68 chi1 and chi2 angles (SidechainMover), as well as free rotation about the His68-zinc coordination axis (RotateJumpAxisMover). There is a centroid phase that evaluates overall shape complementarity of the target and scaffold, this phase is coupled to a full-atom pose to remember the conformation of the zinc coordinating residues.

Limitations
===========

The lowest-scoring centroid pose is the only pose that enters into full-atom interface design. Perhaps a better way to do it would be to design every non-clashing backbone orientation. There is no backbone minimization or sampling in this protocol. The zinc site remains fixed during interface design.

Modes
=====

The biggest difference in 'mode' is whether or not you want to output all of the rigid-body perturbed structures for viewing/debugging. See command-line options.

Input Files
===========

Just PDBs.

-   Common file types (loop file, fragment files, etc) will be described in a common place; link to those documents with the ATref command.
-   Target PDB (wild-type)
-   Scaffold PDB (wild-type)
-   match PDB from RosettaMatch of the scaffold. Contains three zinc-coordinating residues and a 'transition state' histidine that will be replaced by the target histidine.

Options
=======

These values are for production runs.

-resfile resfile \#the resfile default is NATAA, this will prevent mutation of the wild-type target. For the scaffold, all residues should be NOTAA HC. 

-nstruct 100 

-partner1 2D4X.pdb 

-partner2 1UBQ.pdb 

-partner2\_residue 68 

-match\_pdb 2D4X.C135-C137-H192\_match\_00161.pdb 

-skip\_sitegraft\_repack false \#the local region surrounding the zinc match residues is repacked by default. \#-AnchoredDesign::perturb\_temp 

-AnchoredDesign::perturb\_cycles 500 \#how many times to perturb the rigid-body orientation 

-AnchoredDesign::perturb\_show false \#true for debugging/visualization of rigid-body sampling 

-AnchoredDesign::refine\_cycles 10 \#how many times to run PackRotamersMover

Tips
====

Expected Outputs
================

The expected output is a heterocomplex containing: target protein, zinc, zinc binding site, designed scaffold. If the pertub\_show option is used, you'll see PDBs from each rigid-body sampling step. The log file will show you how many times SidechainMover or RotateJumpAxisMover were called, and whether the MonteCarlo move was accepted or rejected. The end of the log file prints a table of energies.

Post Processing
===============

After running the protocol, the best way to evaluate designs is by computed binding energy using InterfaceAnalyzer (specify a jumpnum of 2). Take a look at the zinc site to make sure that 4-residue coordination (3-by-1) is intact.

New things since last release
=============================

If you've made improvements, note them here.

##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
