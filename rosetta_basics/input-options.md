<!-- --- title: Input Options -->

Here is a list of common used input options. For most of these options, the option groups (in:path etc) do not need to be given. 

Misc
====

```
-in:ignore_unrecognized_res     Do not abort if unknown residues are found in PDB file;  instead, ignore them.
                                default='false' [Boolean].
-in:path:database               Database file input search paths.
                                 If the database option is not given or the database is not found, 
                                 the ROSETTA3_DB environment variable is tried [PathVector]
-in:file:residue_type_set       ResidueTypeSet for input files', default = 'fa_standard. [String]
```

Commons PDB Input File Flags
============================

```
-in:file:s                      Name(s) of single PDB file(s) to process. [FileVector]
-in:file:l                      File(s) containing list(s) of PDB files to process. [FileVector]
-in:path                        Paths to search for input files.
                                 Useful in combination with PDB lists that do not have full paths. [FileVector]
-in:file:native                 Native PDB filename. [File]
-in:file:native_exclude_res     Residue numbers to be excluded from RMS calculation. [IntegerVector]
-in:file:fullatom               Enable full-atom input of PDB or centroid structures. 
                                 Usually not needed for already full-atom PDB structures [Boolean]
-in:file:centroid_input         Enable centroid inputs of PDBs.  default = 'false' [Boolean]
-in:auto_setup_metals           Enable automatic setup of covalent bonds to metal ions and appropriate
                                constraints on PDB import.
```

Fragment and Sequence Input File Flags
======================================

```
-in:file:fasta          Fasta-formatted sequence file. [FileVector]
-in:file:frag3          Fragments file with residue length of 3 [String]
-in:file:frag9          Fragments file with residue length of 9 [String]
```

Silent Input File Flags
=======================

```
-in:file:silent                 Silent input filename(s). [FileVector]
-in:file:silent_list            Silent input filename list(s) - like -l is to -s. [FileVector]
-in:file:silent_optH            Call optH when reading a silent file. [Boolean]
-in:file:silent_structure_type  Type of SilentStruct object to use in silent-file input'.
                                Default='protein', [String]
-in:file:silent_score_prefix    Prefix that is appended to all scores read in from a silent-file',
                                default='' [String]
```

Scoring
=======

```
-in:file:repair_sidechains  Attempt a repack/minmize to repair sidechain problems.
                            Such as proline geometry and his tautomerization' default = 'false'
                            [Boolean]
```
