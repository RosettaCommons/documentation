#Rosetta Basics

####Controlling Rosetta Execution
- [[Running Rosetta|running-rosetta-with-options]]
- [[Running Rosetta Parallel via MPI | running-rosetta-with-options#mpi ]]
- [[Graphics output and GUIs | graphics-and-guis]]
- [[Scripting Rosetta|Scripting-Documentation]]
    * [[RosettaScripts]]
    * [[PyRosetta]]
    * [[Topology Broker|BrokeredEnvironment]]

####[[Fundamental Rosetta Concepts|Rosetta-overview]]

- [[Units in Rosetta]]

- [[Scoring|scoring-explained]]

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
    * [[Loop modeling styles and algorithms|loopmodel-algorithms]]

####Preparing structures to be used by Rosetta
- [[Preparing structures]]
    * [[Preparing PDB files for non-peptide polymers]]
    * [[Preparing ligands]]

#####[[Common/Useful Rosetta Options|options-overview]]
- [[Input options]]
- [[Output options]]
- [[Relational Database options | Database-options]]
- [[Run options]]
- [[Score options]]
- [[Packing options]]
- [[Renamed and Deprecated Options]]

####Common File Formats
- [[Fasta file]] - Input protein sequences
- [[Silent file]] - Rosetta-specific compact output representation
- [[Resfiles]] - Which residue sidechains can move and mutate
- [[Movemap file]] - Which sidechains and backbones can move
- [[Constraint file]] - Add energy restraints to scoring
- [[Fragment file]] - Database of backbone fragment conformations
- [[Loops file]] - Which regions of the protein should be rebuilt
- [[Residue Params file]] - Residue chemical information
- [[Symmetry file|Symmetry#Symmetry-definitions]] - Dealing with symmetric proteins.

####Protocol-specific file formats
- [[Matcher (Enzdes) Constraint Files|match-cstfile-format]] - A constraint file specialized for protein-ligand interactions
- [[Chemical shift file]] - NMR chemical shifts
- [[Bin transition probabilities file]] - Probabilities of transitioning from one mainchain torsion bin to another, used by some sampling schemes

####[[Working with Non-Protein Residues and Molecules|non-protein-residues]]
- General Guidance:
    * [[General Control | Ignore Unrecognized]]
    * [[Preparing PDB files for non-peptide polymers]]
    * [[How to turn on residue types that are off by default]]
    * [[Scorefunction and Scoreterm Info | NC-scorefunction-info]]
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

####Misc
- [[Database support]] - Relational database support in Rosetta.
    *  [[Sqlite3-interface]] - More information on the sqlite database interface.
- [[Full options list|full-options-list]] - A (mostly) complete list of availible Rosetta options.
- [[ Rosetta Job Distribution Discussion | JD2]]

####Help
- [RosettaCommons Forums](http://rosettacommons.org/forum)
- [RosettaCommons Bug Tracker](http://bugs.rosettacommons.org)

##Documentation Quick Links

|[[Build Documentation]]|[[Application Documentation]]|[[Development Documentation]]|
|:---------------------:|:------------------------:|:---------------------------:|:---------------------------:|
|[[/images/hammer.png|align=center]] |[[/images/power.png|align=center]]        |[[/images/wrench.png|align=center]]       |

<!--- BEGIN_INTERNAL -->
|[[Internal Documentation]]|
|:------------------------:|
|[[/images/logo.png|align=center]]      |
<!--- END_INTERNAL --> 