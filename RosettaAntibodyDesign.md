Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
PI: Roland Dunbrack

Last Doc Update: 2/15/2014

# Overview:
This app aims to design antibodies.  It has been tested for redesigns and affinity maturation, but is also actively being used for de-novo design. 

# Setup:
This app requires the Antibody Database.  A database of antibodies from the original paper is included in the paper.  A weekly updated database can be downloaded here: http://dunbrack2.fccc.edu/PyIgClassify/.  It should be placed in Rosetta/main/database/sampling/antibodies/

Designs should start with an antibody bound to a target antigen.  The antibody to start with can be a model of the framework required for a denovo design, or an antibody that is being affinity matured.  An antigen should also be included in the starting PDB file at a target epitope.  The program CAN computationally design an antibody to anywhere on the target protein, but a target epitope will increase the probability that the final design will work.  It is beyond the scope of this program to determine potential epitopes for binding, however servers and programs exist to predict these.  Site Constraints can be used to further limit the design.

# Algorithm:

# Instruction File:

# App: antibody_designer


# Options: 
## -numbering_scheme 
Chothia_Scheme default: Acceptable options are: Options are: Chothia_Scheme, Enhanced_Chothia_Scheme, AHO_Scheme, IMGT_Scheme. Kabat_Scheme is also accepted, but not fully supported due to H1 numbering conventions.  Use Kabat_Scheme with caution.',

# Post-analysis: