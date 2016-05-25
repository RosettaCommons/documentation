#CDR Cluster Identification

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)

PI: Roland Dunbrack

# Overview

This application matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each 'center' member of the cluster.  Identifications with distances will be echoed in the output PDB file and printed to the screen. 

# References

Adolf-Bryfogle J,  Xu Q,  North B, Lehmann A,  Roland L. Dunbrack Jr, [PyIgClassify: a database of antibody CDR structural classifications](http://nar.oxfordjournals.org/cgi/reprint/gku1106?ijkey=mLgOMi7GHwYPx77&keytype=ref) , Nucleic Acids Research 2014

North B, Lehmann A, Dunbrack R, [A new clustering of antibody CDR loop conformations](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3065967/pdf/nihms-249534.pdf) (2011). JMB 406(2): 228-256.

RosettaAntibody Framework.
# Setup

Antibodies need to be numbered in any numbering scheme accepted by Rosetta. These include: 

 * <code> Chothia_Scheme </code>
 * <code> Enhanced_Chothia_Scheme </code>
 * <code> AHO_Scheme </code>
 * <code> IMGT_Scheme </code>

Kabat_Scheme is also accepted, but not fully supported due to H1 numbering conventions.  Use Kabat_Scheme with caution.

Antibodies can be renumbered to the AHO_Scheme through [PyIgClassify](http://dunbrack2.fccc.edu/PyIgClassify/)

# Running the Application
App: identify_cdr_clusters

## Options:
Typical Rosetta input/output options are followed. MPI is supported, pass the <code>-l</code> option to identify a list of PDBs.  Use <code>-no_output</code> to not have pdb files echoed.  Make sure to pass <code>-numbering_scheme</code> with your antibody's numbering scheme if it is not renumbered in Chothia.

## Example Command Line:
_identify_cdr_clusters.macosclangrelease -numbering_scheme AHO_Scheme -ignore_unrecognized_res -no_output -s 2J88.pdb_

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

