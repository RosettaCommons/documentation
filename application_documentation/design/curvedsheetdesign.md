#Curved Sheet Design

Overview
========

The code used to generate curved sheets following the principles described in (1) is fully implemented in rosetta_scripts XMLs, with assisting python code to generate key input files: blueprints describing sheet register shifts and ABEGO bins, and constraint files dictating strand-strand hydrogen-bond pairing, curvature and twist. We have made working code for the folds described in (1) publicly available at the https://github.com/basantab/DeNovoCurvedSheetDesign Git repository. The BPB_functions and Blueprint libraries contain a number of short functions used in the construction of all folds, while the code specific to each fold, used to prepare all the rosetta_script files, is located in each of the Fold_\* folders, named PrepareFilesFold\*.py. Each fold folder also comes with its own XML protocol, with the small variations necessary for each case.

**Use example from the Git repo folder:**

cd Fold_D

./PrepareFoldD.sh

./run.sh \</your/rosetta/exec/folder/rosetta_scripts.os.release\> \<runtime_in_sec\>

General details of PrepareFilesFold\*.py and Fold\*_SheetGenerationProtocolTemplate.xml files
===========================================================================================

In each of the folders named after the folds designed in (1), there is a PrepareFilesFold\*.py and a Fold*_SheetGenerationProtocolTemplate.xml file. PrepareFilesFold\*.py generates blueprint and constraint files that direct the assembly process encoded in the Fold*_SheetGenerationProtocolTemplate.xml file. The backbone construction process is divided in at least four stages: 1) Construction of the two central strands of the main sheet. 2) Construction of the N-terminal flanking bulged strand. 3) Construction of the C-terminal flanking bulged strand. 4) Construction of the N-terminal helix/helices that pack agains the sheet. Step 4 is further divided in smaller steps for construction of more complex folds.

Each of the backbone construction steps is encoded by the same basic set of Rosetta movers and filters (see Fold\*_SheetGenerationProtocolTemplate.xml), but uses different input files and values. This basic set is structured as a single mover that loops over constrain-guided fragment assembly followed by requirements checking, until all requirements are met or a number of attempts is reached. The constrain-guided fragment assembly is done in "centroid mode", which is basically a representation where side chains are approximated to a single soft sphere, with valine being the closest to the average size. This step also contains additional minimization steps to "pull" the structure together. The requirements checking step (or filtering step) contains a number of filters that change based on the step, but checks at least for Ramachandran outliers or unfavorable peptide bond geometry (e.g., cis peptide bonds). For specific documentation on movers and filtes, see the rosetta_scripts wiki.

Output
======

The outputs are poly-alanine models from proteins belonging to each of the six folds designed in (1). Glycine and proline residues are placed in positions where the torsion angles require this (e.g. glycine in G ABEGO bin), or they are favored by the ConsensusLoopDesign task operation.

Fold A: Similarly to cystatin, this fold has an elongated curved sheet and a long helix that packs in diagonal the strand direction. Because of beta-bulge placement the sheet has three semi-flat sections.

Fold B: This fold is similar to a small subset of proteins from the NTF2-like superfamily, but lacks the short hairpin that is paired parallel to strand 6.

Fold C: Like folds D, E and F, this folds belongs to the NTF2-like superfamily. In fold C, the region circumscribed by the bulges is particularly narrow for a protein from the NTF2-like superfamily.

Fold D: This folds belongs to the NTF2-like superfamily. The region circumscribed by the bulges is average for proteins from the NTF2-like superfamily.

Fold E: Similar to Fold D, but has a C-terminal helix that would extend a hypothetical pocket outwards

Fold F: Similar to Fold E, but the sheet arm that packs against the C-terminal helix is longer.

Additional files
================

Blueprint.py: Library by Javier Castellanos for Blueprint object handling.

BPB_functions.py: Library of functions for working with curved sheet protein backbones.

Rama_XPG_3level.txt: A "general" map from phi/psi coordinate to energy - more populated Ramachandran space is more favorable. Author: Hahnbeom Park. All amino acids, except for proline and glycine, have the same values, hence the "general" qualifier.

References
==========

(1) Marcos\*, Enrique, Basanta\*, Benjamin, Tamuka M. Chidyausiku, Yuefeng Tang, Gustav Oberdorfer, Gaohua Liu, G.V.T. Swapna, Rongjin Guan, Daniel-Adriano Silva, Jiayi Dou, Jose Henrique Pereira, Rong Xiao, Banumathi Sankaran, Peter H. Zwart, Gaetano T. Montelione, David Baker "Principles for designing proteins with cavities formed by curved beta-sheets." Science 355.6321 (2017): 201-206.

*: Indicates co-first authorship