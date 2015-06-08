#List of file types used in Rosetta
##Protein structure input/output formats
* **PDB**: Standard file format for input/output of single protein structures. See information on PDB file requirements [[here|preparing-structures]].
* **[[Silent file|silent-file]]**: Useful for input/output of large numbers of structures.

##Commonly used input files
* **[[Fasta files|fasta-file]]**: File used in certain protocols that provides only sequence information.
* **[[Fragment files|fragment-file]]**: Commonly used in structure prediction.
* **[[Resfiles|resfiles]]**: File to specify residues allowed to design and repack.
* **[[Movemap files|movemap-file]]**: File (supported by some protocols, see page for details) to specify which torsion angles and rigid body degrees of freedom will be allowed to change.
* **[[Residue params files|Residue-Params-file]]**: Stores chemical and geometric information for a residue or ligand. Useful when running Rosetta with [[non-protein residues|non-protein-residues]].

##Protocol-specific input files
* **[[Match constraint files|match-cstfile-format]]**: File type specifying geometric constraints for the [[match application|match]].
* **[[Chemical shift files|chemical-shift-file]]**: Chemical shift information used with [[CS-Rosetta|CS-Rosetta]].
* **[[Bin transition probabilities files|Bin-transition-probabilities-file]]**
* **[[Loops files|loops-file]]**: Specifies loop definitions used in loop modeling.

##Database input/output
Rosetta supports input/output of databases in SQLite3, MySQL, and PostgreSQL. More information on input/output with these formats can be found [[here|Database-IO]]. Specific information on interfacing with SQLite3 can be found [[here|sqlite3-interface]], and advanced details on Rosetta's interface with databases is found [[here|database-support]].
