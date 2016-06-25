#List of file types in Rosetta

* **[[Flags files|namespace-utility-options#flagsfile]]**: File used to specify multiple options on the command line using the syntax @flags_file.

##Protein structure input/output formats
* **[[PDB file]]**: Standard file format for input/output of single protein structures. See information on PDB file requirements [[here|preparing-structures]].
* **[[Silent file|silent-file]]**: Useful for input/output of large numbers of structures.

##Commonly used input files
* **[[Fasta files|fasta-file]]**: File to provide sequence information.
* **[[Fragment files|fragment-file]]**: Commonly used in structure prediction.
* **[[Resfiles|resfiles]]**: File to specify residues allowed to design and repack.
* **[[Movemap files|movemap-file]]**: File (supported by some protocols, see page for details) to specify which torsion angles and rigid body degrees of freedom will be allowed to change.
* **[[Residue params files|Residue-Params-file]]**: Stores chemical and geometric information for a residue or ligand. Useful when running Rosetta with [[non-protein residues|non-protein-residues]].
* **[[Loops files|loops-file]]**: Specifies loop definitions used in loop modeling.
* **[[Symmetry file|Symmetry#Symmetry-definition]]**: Dealing with symmetric proteins.
* **[[Constraint file]]**: Provide information about constraints (restraints) for use in a Rosetta protocol

##Protocol-specific input files
* **[["Grishin" alignment format|Grishan-format-alignment]]**: A protein sequence alignment format used by comparative modeling.
* **[[Match constraint files|match-cstfile-format]]**: File specifying geometric constraints for the [[match application|match]].
* **[[Chemical shift files|chemical-shift-file]]**: NMR chemical shift information used with [[CS-Rosetta|CS-Rosetta]].
* **[[Bin transition probabilities files|Bin-transition-probabilities-file]]**: Probabilities of transitioning from one mainchain torsion bin to another, used by some sampling schemes.
* [[SEWING]]-specific files:
  * **[[Model files|SEWING model files]]**: Specify substructures (nodes) to be used when generating structures
  * **Edge files**: Specify edges to be used when generating structures
  * **Rot files**: Store information about native residue identities in SEWING assemblies. Used with the AssemblyConstraintsMover.
<!--- BEGIN_INTERNAL -->
  * **Alignment files**: Store pre-calculated alignments near a given starting node. Optional for use with [[AppendAssemblyMover]]. 
<!--- END_INTERNAL -->


##Database input/output
Rosetta supports input/output of databases in SQLite3, MySQL, and PostgreSQL. 
More information on input/output with these formats can be found [[here|Database-IO]]. 
A tutorial on how to output information to a database in Rosetta can be found [[here|Rosetta-Database-Output-Tutorial]].
Specific information on interfacing with SQLite3 can be found [[here|sqlite3-interface]], and advanced details on Rosetta's interface with databases is found [[here|database-support]]. 

##See Also

* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
