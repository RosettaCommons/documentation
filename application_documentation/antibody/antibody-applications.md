#Antibody applications

This set of applications and tools is specifically designed to work with antibodies. Before using these applications, you may want to check the [[General Antibody Options and Tips]] page.

###Antibody Modeling

- [[Antibody protocol]] (RosettaAntibody3): Overview of the antibody modeling protocol.  
    * [[Antibody Python script]]: The setup script.  
    * [[Grafting CDR loops|antibody-assemble-cdrs]]: Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]]: Determine antibody structures by combining VL-VH docking and H3 loop modeling.

###Antibody Docking
- [[Camelid antibody docking|antibody-mode-camelid]]: Dock camelid antibodies to their antigens.
- [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking


###Antibody Utilities
* [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.

* [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.

* [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.



##See Also

* [[General Antibody Options and Tips]]
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Getting Started]]: A page for people new to Rosetta
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[RosettaScripts]]: The RosettaScripts home page
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[TACC]]: Information for running Rosetta on the TACC/Stampede cluster.