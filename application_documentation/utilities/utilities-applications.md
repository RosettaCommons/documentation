#Utilities Applications

These applications serve mainly to support other Rosetta applications, or to assist in setting up or analyzing Rosetta runs.

### General
- [[Build peptide]]: Build extended peptides or protein structures from sequences. 

- [[CA to allatom]]: Build fullatom models from C-alpha-only traces.  

- [[Cluster]]: Cluster structures by structural similarity.  

- [[Create symmetry definition|make-symmdef-file-denovo]]: Create Rosetta symmetry definition files for a point group.  
    * [[Create symmetry definition from structure|make-symmdef-file]]: Create Rosetta symmetry definition files from template PDBs. 

- [[Fragment picker|app-fragment-picker]]: Pick fragments to be used in conjunction with other fragment-aware Rosetta applications.  
    * [[Old fragment picker|fragment-picking-old]]: The older version of the fragment picker.  
    * [[Structure Set Fragment Picker|Structure-Set-Fragment-Picker]]: Pick fragments from a defined set of structures. 
- [[Loops from density]]: Create Rosetta loop files for regions of a protein with poor local fit to electron density.

- [[Make exemplars|make-exemplar]]: Create an exemplar for surface pockets on a protein that touch a target residue.

- [[OptE|opt-e-parallel-doc]]: Refit reference weights in a scorefunction to optimize given metrics.  

- [[Pocket target residue suggestion|pocket-suggest-targets]]: Suggest the best pair of target residues for pocket optimization for the purpose of inhibiting a protein-protein interaction.

- [[PyMol server]]: Observe what a running Rosetta program is doing by using PyMol.

- [[Sequence recovery]]: Calculate the mutations and native recovery from Rosetta design runs.

- [[Pocket relax|pocket-relax]]: Relax followed by full atom minimization and scoring with no PocketConstraint. Useful when performing pocket optimization.

###Non-canonical amino acids
* [[Make rotamer library|make-rot-lib]]: Generate rotamer libraries for non-canonical amino acids.  
* [[Unfolded state energy calculator]]: Determine the baseline energy of non-canonical amino acids in the unfolded state.  

###Antibody Utilities
* [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.

* [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.

* [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.

##See Also

* [[Tools]]: Python-based tools for use with Rosetta
* [[Rosetta Servers]]: Servers that provide access to some Rosetta applications
* [[Application Documentation]]: List of Rosetta applications
* [[RosettaScripts]]
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files