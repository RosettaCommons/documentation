# Modeling structures of RNA-protein complexes

##Metadata

Author: Kalli Kappel (kappel at stanford dot edu)  
Last updated: April 2018

##Application purpose
Model 3D structures of RNA-protein complexes using a fold-and-dock method.

##Code and demo
Code is available through `rna_denovo`. 


##Required inputs
1. Complete structures of all proteins that are part of the RNA-protein complex you want to model. (If an experimental structure is not available, you can use other Rosetta protocols to build a model.)
2. A fasta file containing the full sequence of the RNA-protein complex that you’re modeling.
3. A secondary structure file for your RNA-protein complex. Secondary structure for the protein should be specified by dots. The secondary structure should be the same length as the sequence found in the fasta file.

##Optional inputs
1. Additional PDB files specifying parts of the RNA structure, e.g. ideal A-form RNA helices. **Note**: if you want to enforce a specific rigid body orientation between your protein and an RNA structure, they must both be specified in the same PDB file!
2. A constraint file, which can be used to incorporate experimental data (such as specific contacts, distance restraints, etc.) into the modeling.
3. A density map: see the [[DRRAFTER]] pipeline for more information about building models into density maps.

##Running the code
Models are built with the Rosetta fold-and-dock method for RNA-protein complexes, which combines FARNA RNA folding with RNA-protein docking. An example command line is below:

```
rna_denovo –f fasta.txt –secstruct_file secstruct.txt –s protein_structure.pdb –minimize_rna false –nstruct 100 
```

##Options for modeling RNA-protein complexes


##See Also
* [[DRRAFTER]]: Build RNA coordinates into cryoEM maps of RNA-protein assemblies
* [[rnp ddg]]: Calculate relative binding affinities for RNA-protein complexes with the Rosetta-Vienna ΔΔG method
* [[Application Documentation]]: Home page for application documentation
* [[RNA applications]]: The RNA applications home page
* [[Tools]]: Python-based tools for use in Rosetta
* [RiboKit](http://ribokit.github.io/): RNA modeling & analysis packages maintained by the Das Lab