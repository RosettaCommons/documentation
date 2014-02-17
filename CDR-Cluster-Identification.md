Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
PI: Roland Dunbrack

Last Doc Update: 2/16/14 JAB


# Overview:

This application matches each CDR of an antibody to North/Dunbrack CDR clusters (See North, B., A. Lehmann, et al. (2011). JMB 406(2): 228-256.) based on the lowest dihedral distance to each 'center' member of the cluster.  Identifications with distances will be echoed in the output PDB file and printed to the screen. 

# Setup
Antibodies need to be numbered in any numbering scheme accepted by Rosetta. These include: Chothia_Scheme, Enhanced_Chothia_Scheme, AHO_Scheme, IMGT_Scheme. Kabat_Scheme is also accepted, but not fully supported due to H1 numbering conventions.  Use Kabat_Scheme with caution.

Antibodies can be renumbered to the AHO_Scheme at http://dunbrack2.fccc.edu/PyIgClassify/

# Run
## App: identify_cdr_clusters

## Options:
Typical Rosetta options are followed.  Use -no_output to not have pdb files echoed.  Make sure to pass -numbering_scheme with your antibody's numbering scheme if it is not renumbered in Chothia.