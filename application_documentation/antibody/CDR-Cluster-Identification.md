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
     * [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.
* [[Application Documentation]]: Application documentation home page
* [[Options overview]]: Overview of options in Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs

