(This application is unreleased)
<!--- BEGIN_INTERNAL -->

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
<!--- END_INTERNAL -->
##See Also

* [[General Antibody Options and Tips]]
* [[Antibody Applications]]: Homepage for antibody applications
    * [[Antibody protocol]]: The main antibody modeling application
    * [[Antibody Python script]]: Setup script for this application
    * [[Grafting CDR loops|antibody-assemble-cdrs]]: Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]]: Determine antibody structures by combining VL-VH docking and H3 loop modeling.
    - [[Camelid antibody docking|antibody-mode-camelid]]: Dock camelid antibodies to their antigens.
    - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
    * [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.
    * [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs