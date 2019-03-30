#ResidueDisorder: Predicting order/disorder of residues in a protein.
Metadata
========
Method developed by Stephanie Kim (kim.6088@osu.edu).

Code and documentation by Justin Seffernick (seffernick.9@osu.edu).

The PI was Steffen Lindert (lindert.1@osu.edu).

Last updated March 2018 by Justin Seffernick. 

Code
====

Application resides at `Rosetta/main/source/src/apps/public/analysis/ResidueDisorder.cc`.

There is a demo at `Rosetta/demos/public/ResidueDisorder`.

Note that to run ResidueDisorder, _ab initio_ structure prediction must first be performed (more details in demo).

References
==========
Kim, S.S.; Seffernick, J.T.; Lindert,S., Accurately Predicting Disordered Regions of Proteins Using Rosetta ResidueDidorder Application. _J. Phys. Chem. B._: **2018**;122,3029-30930.

Purpose
=======

Rosetta ResidueDisorder is a method to predict disordered regions of proteins. While proteins are often represented as well-folded, rigid structures, many proteins contain regions that are unlikely to form stable structures. The ResidueDisorder app (to be used after running _ab initio_ structure prediction) can be used to predict order/disorder at a residue-resolved level.

Algorithm
=========

After 100 _de novo_ models are generated (using Rosetta _ab initio_ folding), the average score for each residue is calculated. For each residue, the average score is smoothed over a window length of 11, resulting in the residue-resolved order score. For example, when calculating the order score for residue N, the order score is defined as the average residue score of N and the 10 adjacent residues (N-5, N-4, N-3, N-2, N-1, N, N+1, N+2, N+3, N+4, N+5). If N is within 5 residues of either the N- or C- terminus, only residues that exist were included. For example, the order score of residue 2 would result in averaging the scores of residues 1, 2, 3, 4, 5, 6, and 7. Next, each residue is predicted as either ordered or disordered, depending on whether the order score is below or above the cutoff of -1.0 REU, respectively.

If the protein is more than 60% disordered (percent of residues predicted as disordered), the algorithm is complete. However, if the protein is less than 60% disordered, a terminal residue optimization is applied. The terminal optimization step changes the cutoff for residues within 13% of either terminus. For these residues, a linear cutoff line is applied such that the N- and C- terminal residues have a cutoff of -0.3 REU and the 13% residues have a cutoff of -1.0 REU with a linear extrapolation. Again, each residue is predicted as ordered or disordered depending on whether the order score is below or above the cutoff.

Input Files
===========

Before using the ResidueDisorder application, 100 de novo models must be generated using Rosetta _ab initio_ folding (see the demo or paper for flags used). The only input needed to run the application is the 100 generated structures (using the `in:file:l` flag is recommended).

Tips
====

While ResidueDisorder can be run with any number of folded structures, 100 is highly recommended. 

The current implementation is calibrated to be used with talaris2014, so the flag `-restore_talaris_behavior` must be given.

Also, make sure that all input structures are of the same sequence (and length) and contain only a single chain.

Limitations
===========

Currently, Rosetta ResidueDisorder can only predict order for monomers. Input structures must be of a single chain.

Expected Outputs
================

ResidueDisorder will output (on screen) the calculated per-residue scores for each pose and the average per-residue scores (over all 100 poses). For the initial prediction, ResidueDisorder will output the order score and prediction (order or disorder) for each residue. If terminal optimization is necessary (less that 60% disordered), ResidueDisorder will output the terminal optimization order scores, predictions, and final cutoffs. Finally, ResidueDisorder outputs the final predictions in tabular format to an output file (name is `ResidueDisorder_default.out` by default, but output file name can be specified using the `-out:file:o` flag). The tabulated final results contain the prediction, order score, and raw average residue score.

New things since last release
=============================

This is the first release.


