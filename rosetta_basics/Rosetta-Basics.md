#Rosetta Basics

####Fundamental Rosetta Concepts
- [[Score Types]] - Description of common Rosetta score terms
- [[Minimization Overview]] - Backbone and/or side chain degrees of freedom
- [[Packer Task]] - Controlling which side chains can vary during rotamer optimization 
- [[Foldtree Overview]]
- [[AtomTree Overview]]
- [[Symmetry]]


####Preparing structures to be used by Rosetta
- [[Preparing structures]]
- [[Preparing structures with relax|prepare-pdb-for-rosetta-with-relax]]
- [[Preparing ligands]]
- [[Making rosetta robust for running on large number of inputs|robust]]

####Controlling Rosetta Execution
- [[Database]] - The Rosetta database
- [[Running Rosetta|Command options]] - Controlling Rosetta with command line options
    * [[Input options]]
    * [[Output options]]
    * [[Relational Database options | Database-options]]
    * [[Run options]]
    * [[Score options]]
    * [[Packing options]]
- [[JD2]]
- [[RNA-protein-changes]] - Changes to get Rosetta to read RNA & protein simultaneously (I don't think these are needed anymore.)


####Common File Formats
- [[Fasta file]] - Input protein sequences
- [[Silent file]] - Rosetta-specific compact output representation
- [[Resfiles]] - Which residue sidechains can move and mutate
- [[Movemap file]] - Which sidechains and backbones can move
- [[Constraint file]] - Add energy restraints to scoring
- [[Matcher (Enzdes) Constraint Files|match-cstfile-format]] - A constraint file specialized for protein-ligand interactions
- [[Fragment file]] - Database of backbone fragment conformations
- [[Loops file]] - Which regions of the protein should be rebuilt
- [[Chemical shift file]] - NMR chemical shifts
- [[Residue Params file]] - Residue chemical information
- [[Symmetry file|Symmetry#Symmetry-definitions]] - Dealing with symmetric proteins.

####Working with Non-Protein Residues and Molecules
- General Guidance:
    *  [[Enabling Params Files]]
    *  [[Ignore Unrecognized]]
    *  [[Scorefunction and Scoreterm Info | NC-scorefunction-info]]
- [[DNA]]
- [[RNA]]
- [[Ligands]]
- [[Water]]
- [[Metals]]
- [[Carbohydrates]]
- [[Mineral Surfaces]]
- [[Noncanonical Amino Acids]]

####Misc
- [[Database support]] - Relational database support in Rosetta.
    *  [[Sqlite3-interface]] - More information on the sqlite database interface.
- [[Full options list|full-options-list]] - A (mostly) complete list of availible Rosetta options.

