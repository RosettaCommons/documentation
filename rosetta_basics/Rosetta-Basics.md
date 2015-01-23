#Rosetta Basics

####Controlling Rosetta Execution
- [[Running Rosetta|running-rosetta-with-options]]
- [[Running Rosetta via MPI | running-rosetta-with-options#Running-Rosetta-via-MPI ]]
- Common/Useful Rosetta Options
    * [[Input options]]
    * [[Output options]]
    * [[Relational Database options | Database-options]]
    * [[Run options]]
    * [[Score options]]
    * [[Packing options]]
- [[Renamed and Deprecated Options]]
- Scripting Rosetta
    * [[RosettaScripts]]
    * [[PyRosetta]]
- [[Graphics output and GUIs | graphics-and-guis]]
- [[JD2]]

####Preparing structures to be used by Rosetta
- [[Preparing structures]]
- [[Preparing structures with relax|prepare-pdb-for-rosetta-with-relax]]
- [[Preparing ligands]]

####Help
- [RosettaCommons Forums](http://rosettacommons.org/forum)
- [RosettaCommons Bug Tracker](http://bugs.rosettacommons.org)

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
    *  [[General Control | Ignore Unrecognized]]
    *  [[How to turn on residue types that are off by default]]
    *  [[Scorefunction and Scoreterm Info | NC-scorefunction-info]]
- [[DNA]]
- [[RNA]]
- [[Ligands]]
- [[Water]]
- [[Metals]]
- [[Carbohydrates]]
- [[Mineral Surfaces]]
- [[Noncanonical Amino Acids]]
    *  [[D-Amino Acids]]
    *  [[Alpha-Amino Acids with Nonstandard Side-Chains]]
    *  [[Beta-Amino Acids]]

####Fundamental Rosetta Concepts
- [[Units in Rosetta]]

- [[Scorefunctions and Score types | Score Types]] - Description of the default Rosetta Scorefunction and common score types.
    *  [[MM Std Scorefunction | NC-scorefunction-info#MM-Standard-Scorefunction]]
    *  [[Orbitals Scorefunction | NC-scorefunction-info#Partial-Covalent-Interactions-Energy-Function-(Orbitals)]]
    *  [[Additional score types | score-types-additional]]
- [[Symmetry]]
- [[Minimization | Minimization Overview]] - Backbone and/or side chain degrees of freedom
- Advanced Topics
    * [Rosetta3 Architecture](http://www.ncbi.nlm.nih.gov/pubmed/21187238)
    * [[Foldtree Overview]]
    * [[AtomTree Overview]]
    * [[Loop modeling styles and algorithms]]

####Misc
- [[Database support]] - Relational database support in Rosetta.
    *  [[Sqlite3-interface]] - More information on the sqlite database interface.
- [[Full options list|full-options-list]] - A (mostly) complete list of availible Rosetta options.
