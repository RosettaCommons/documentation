#AnchoredPDBCreator application

#####Metadata

Author: Steven Lewis (smlewi -- at -- gmail.com)

Code and documentation by Steven Lewis (smlewi -- at -- gmail.com).
The PI was Brian Kuhlman, (bkuhlman -- at -- email.unc.edu).

Example runs and code location
============

The code is at `Rosetta/main/source/src/apps/public/interface_design/anchored_design/AnchoredPDBCreator.cc` ; there's an integration test at `Rosetta/main/tests/integration/tests/AnchoredDesign/` . There is a more extensive demo with more documentation at `Rosetta/demo/protocol_capture/anchored_design` and  `Rosetta/demo/public/anchored_design`, which are online at TODO these links to the online demos.

References
==========

-   [Lewis SM, Kuhlman BA. Anchored design of protein-protein interfaces. PLoS One. 2011;6(6):e20872. Epub 2011 Jun 17.](http://www.ncbi.nlm.nih.gov/pubmed/21698112) (pubmed link)

Purpose and Algorithm
=====================

AnchoredPDBCreator exists to create starting files for AnchoredDesign - it will take a scaffold, target, and the anchor and brew a starting structure for AnchoredDesign. It is implemented separately so that the user can look at the input structure for AnchoredDesign.cc to design its resfile, etc. with the right numbering.

This app assumes you have three structures: an anchor and target in separate PDBs, which are bound to each other relative to the same coordinate origin, and a scaffold PDB (origin unimportant). Generally your anchor and target will be from the same crystal structure. The protocol inserts the anchor's sequence AND COORDINATES into a loop of the scaffold, and runs a fast dirty minimization to try to keep the scaffold and target from crashing into each other. It is not intended to produce low-energy structures...just structures good enough to look at their numbering while designing a resfile, etc. It tries to ensure that the modified loop has at most ONE chainbreak or bad omega angle (which can be fixed in later loop modeling). It does NOT try to prevent eclipsing of the loop onto the scaffold or the target - again, AnchoredDesign will deal with that.

The workhorse is protocols::pose_manipulation::insert_pose_into_pose. This code inserts the anchor into the scaffold and attempts loop closure (this is effectively a domain insertion problem). Interfacing with the target occurs inside AnchoredPDBCreator proper.

Input Files
===========

See test/integration/tests/AnchoredDesign/ for example usage.

AnchoredPDBCreator needs three PDBs (scaffold for design, target for binding, and an anchor that was derived from the target's old binding partner) and a description of where to insert the anchor into the target. You should prepare the scaffold PDB by deleting any residues you want replaced by the anchor.

The scaffold loop specification is a one-line file with four whitespace-delimited values: the chain letter of the scaffold chain you want to insert into, the start of the loop you want to insert into, the residue you want the anchor to be inserted immediately after, and the end of the loop you want to insert into. For example:

`       B 18 23 30      `

This will treat the scaffold loop from 18-30 flexibly, except the anchor. The anchor will be inserted after 23. Let's say the anchor is 4 residues long, and residues 24-27 are deleted from the scaffold. In this case, PDB residues 18-23 and 28-30 will be treated as one flexible loop with a constant portion in the middle (the anchor). If 24-27 existed in the scaffold then their numbering would be bumped up and the eventual flexible loop would number 18-34.

Tips
====

You will need healthy amounts of sampling. I use 50 nstruct and 100,000 cycles.

Limitations
===========

At this time, the anchor PDB must be a minimum of three residues (2 or 1 will cause a crash or bizzarre other errors). If you ultimately want an shorter anchor, that is fine - use a length of 3 here, then tell AnchoredDesign that it's only 2, and it will happily mutate/move the residue you didn't want as part of the anchor. I intend to fix this bug eventually...

Options
=======

AnchoredPDBCreator defines a small handful of options:

-   scaffold_loop - string - scaffold anchor loop location file
-   scaffold_pdb - string - scaffold pdb file
-   anchor_pdb - string - anchor pdb file
-   target_pdb - string - target pdb file
-   APDBC_cycles - unsigned integer - number of cycles in insert_pose_into_pose

Standard job distributor options like nstruct are obeyed as well.

Expected Outputs
================

The protocol will produce nstruct result structures with the anchor inserted into the scaffold, and the anchor aligned against the target. You should expect the scaffold loop newly containing the anchor to be closed and in a reasonable conformation. You should not expect the scaffold/target interface to be reasonable (or even not clashing; they may overlap). Generating the interface is the job of AnchoredDesign instead.

The scorefile will report LAM_total, which is the score from Loop Analyzer Mover. This sums the scores for he ramachandran, omega, chainbreak, and peptide bond scores for the residues in the loops.

Post Processing
===============

Essentially the only quality of the results that matters is the quality of loop closure; everything else is meant to be handled by AnchoredDesign. To pick a model for AnchoredDesign, sort by LAM_total, examine the lowest scoring handful of models to see which you like best, and move on.

New things since last release
=============================

Rosetta 3.3 is the first release.

##See Also

* [[AnchorFinder | anchor-finder ]]: Locates plausible anchors at protein-protein interfaces (inputs for this protocol).
* [[AnchoredDesign | anchored-design ]]: Actually designing anchored interfaces instantiated by this application

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
