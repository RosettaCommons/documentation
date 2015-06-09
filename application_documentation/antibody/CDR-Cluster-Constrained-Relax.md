Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
PI: Roland Dunbrack

Last Doc Update: 2/15/2014

# Overview:
This application aims to relax cdrs using circular harmonic constraints for each identified cluster.  CDR definitions are North/Dunbrack.

# Requirements:
Antibodies must be renumbered in some numbering scheme.  See below for acceptable options.  To renumber to AHO, as used in the original paper, please use this site: http://dunbrack2.fccc.edu/PyIgClassify/

# Algorithm:
The application will first identify each CDR of your antibody to one of the canonical North/Dunbrack CDR clusters.  Dihedral constraints based on a recent high-resolution dataset of PDB antibodies are then added to the CDRs and all CDRs are relaxed.  THis will be expanded for greater flexibility.

# App: relax_cdrs

# Options:
Follows typical Rosetta options including relax and minimization-based options.  Be sure to pass -numbering_scheme if using something other than Chothia.  Options are: Chothia_Scheme, Enhanced_Chothia_Scheme, AHO_Scheme, IMGT_Scheme. Kabat_Scheme is also accepted, but not fully supported due to H1 numbering conventions.  Use Kabat_Scheme with caution.