#ResidueDisorder: Predicting order/disorder of residues in a protein.
Metadata
========
Method developed by Stephanie Kim (kim.6088@osu.edu) and Justin Seffernick (seffernick.9@osu.edu).

Code and documentation by Justin Seffernick.

The PI was Steffen Lindert (lindert.1@osu.edu).

Last updated August 2021 by Justin Seffernick. 

Code
====

Application resides at `Rosetta/main/source/src/apps/public/analysis/ResidueDisorder.cc`.

There is a demo for disorder prediction using _ab initio_ structures at `Rosetta/demos/public/ResidueDisorder`.

Note that to run ResidueDisorder for intrinsic disorder prediction from sequence, structure prediction must first be performed prior. This can be done using Rosetta ab initio, RoseTTAFold, or AlphaFold. Structures must be relaxed prior to input. To run ResidueDisorder for measuring disorder from structure, each input structure must also be relaxed.

References
==========
Kim, S.S.; Seffernick, J.T.; Lindert,S., Accurately Predicting Disordered Regions of Proteins Using Rosetta ResidueDisorder Application. _J. Phys. Chem. B._ **2018**;122,3029-30930.

Seffernick, J.T.; Ren, H.; Kim, S.S.; Lindert, S., Measuring Intrinsic Disorder and Tracking Conformational Transitions Using Rosetta ResidueDisorder. _J. Phys. Chem. B._ **2019**;123 (33), 7103–7112.

Purpose
=======

Rosetta ResidueDisorder is a method to predict intrinsically disordered regions of proteins from the primary sequence. While proteins are often represented as well-folded, rigid structures, many proteins contain regions that are unlikely to form stable structures. The ResidueDisorder app (to be used after running structure prediction prior) can be used to predict order/disorder at a residue-resolved level. Structure prediction can be performed using Rosetta _ab initio_, RoseTTAFold, or AlphaFold. 

Additionally, ResidueDisorder can measure disorder of different conformations of the same system directly from the coordinates from an MD simulation for example (or any ensemble of structures). Using this methodology, ResidueDisorder can also predict folding/unfolding events from a trajectory based on changes in disorder.

Algorithm
=========

To predict intrinsic disorder from sequence, relaxed models are first generated (Rosetta ab initio, RoseTTAFold, or AlphaFold, performed prior to the input into the ResidueDisorder application), the average score for each residue is calculated. To measure disorder directly from a single structure, the structure is relaxed and residue scores are calculated. Both methods proceed with the following steps. 

For each residue, the average score is smoothed over a window size (WS), resulting in the residue-resolved order score (OS). For example, when calculating OS for residue N with WS of 5, the OS is defined as the average residue score of N and the 10 (WS*2) adjacent residues (N-5, N-4, N-3, N-2, N-1, N, N+1, N+2, N+3, N+4, N+5). If N is within 5 residues of either the N- or C- terminus, only residues that exist were included. For example, the order score of residue 2 would result in averaging the scores of residues 1, 2, 3, 4, 5, 6, and 7. Next, each residue is predicted as either ordered or disordered, depending on whether the order score is below or above the cutoff value (CV), respectively.

If the protein is more than terminal percentage cutoff (TPC) percent disordered (percent of residues predicted as disordered) or if AlphaFold was used for modeling, the algorithm is complete. However, if the protein is less than TPC percent disordered, a terminal residue optimization is applied. The terminal optimization step changes the cutoff for residues within terminal size (TS) percent of either terminal residue. For these residues, a linear cutoff line is applied such that the N- and C- terminal residues have a cutoff of terminal cutoff value (TCV) and the TPC percent residues have a cutoff of CV (along with all other inner residues) with a linear extrapolation. Again, each residue is predicted as ordered or disordered depending on whether the order score is below or above the new cutoff.

The algorithm contains parameters for modeling using the Talaris2014 and REF2015 scoring functions, as shown in the table below. AlphaFold with REF2015 is recommended for best prediction results.

Model generation method | Rosetta scoring function | WS | CV | TPC | TS | TCV
------------ | ------------- | ------------ | ------------ | ------------ | ------------ | ------------
Rosetta ab initio or RoseTTAFold | Talaris2014 | 5 | -1.0 | 60% | 13% | -0.3
Rosetta ab initio or RoseTTAFold | REF2015 | 10 | -1.5 | 40% | 34% | -0.8
AlphaFold | Talaris2014 | 5 | -1.2 | NA | NA | NA
AlphaFold | REF2015 | 10 | -1.8 | NA | NA | NA

If event prediction is performed (from frames of an MD trajectory), the difference in the average disorder for 25 steps before that timepoint and 25 steps after that timepoint is calculated. A cutoff line for the absolute value of the difference is instituted, above which an event is defined, representing a significant change in disorder at that timepoint. This cutoff line is defined as 60% of the largest difference for the system. If the disorder increases during the event, it is defined as an unfolding event and if the disorder decreases during an event, it is defined as a folding event. If events are detected in adjacent timesteps, they are combined to form a single event in the center of the range.


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


