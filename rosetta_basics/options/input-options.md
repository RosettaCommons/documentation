<!-- --- title: Input Options -->

To understand basic input options, complete [this tutorial](https://www.rosettacommons.org/demos/latest/tutorials/input_and_output/input_and_output#controlling-input).

Here is a list of common used input options. For most of these options, the option groups (in:path etc) do not need to be given. The option groups need to be given only for options that have the same name as other options in other option groups.  Rosetta will warn you if this is the case.

Misc
====

```
-in:ignore_unrecognized_res     Do not abort if unknown residues are found in PDB file;  instead, ignore them.
                                default='false' [Boolean].
-ignore_zero_occupancy          By default, Rosetta will ignore atoms in input PDB files whose occupancy
                                is 0.  To read those atoms/residues anyway, pass false to this option. 
                                default='true' [Boolean].
-in:ignore_waters               Ignore only WAT water molecules. Default=false. [Boolean].
-in:path:database               Database file input search paths.
                                 If the database option is not given or the database is not found, 
                                 the ROSETTA3_DB environment variable is tried [PathVector]
-in:file:residue_type_set       ResidueTypeSet for input files', default = 'fa_standard. [String]
```

Common PDB Input File Flags
============================

```
-in:file:s                      Name(s) of single PDB file(s) to process. [FileVector]
-in:file:l                      File(s) containing list(s) of PDB files to process. [FileVector]
-in:path                        Paths to search for input files.
                                 Useful in combination with PDB lists that do not have full paths. [FileVector]
-in:file:native                 Native PDB filename. [File]
-in:file:native_exclude_res     Residue numbers to be excluded from RMS calculation. [IntegerVector]
-in:file:no_detect_pseudobonds  By default, Rosetta automatically detects pseudobonds on file import.
                                 If this is set to true, this auto-detection is disabled.  False by
                                 default. [Boolean]
-in:file:fullatom               Enable full-atom input of PDB or centroid structures. 
                                 Usually not needed for already full-atom PDB structures [Boolean]
-in:file:centroid_input         Enable centroid inputs of PDBs.  default = 'false' [Boolean]
-in:auto_setup_metals           Enable automatic setup of covalent bonds to metal ions and appropriate
                                constraints on PDB import.
-in:read_only_ATOM_entries      Read only the ATOM entries from the PDB.  Skip all others.  
                                Works for PDB and mmCIF, not silent files. 
```

Small Molecule Options
============================

See also [[Residue Params file]]
```
-in:file:extra_res_fa              Full atom "params" files for small molecules or non-standard residues
                                   [FileVector]                          
-in:file:extra_res_path            Directory containing non-standard residue params files. [PathVector]
-in:file:extra_res_cen             Centroid-mode "params" files for small molecules or non-standard
                                   residues [FileVector]
-in:file:remap_pdb_atom_names_for  When reading PDBs, use geometry to load atoms (instead of atom names)
                                   for the residues with the given three letter codes [StringVector]
```

Relational Database Input
============================
See [[here | Database-options ]] for more info
```
-in:use_database                          Indicate that structures should be read from the given database
-in:select_structures_from_database       An sql query to select which structures should be extracted. 
                                           ex:  "SELECT tag FROM structures WHERE tag = '7rsa';"
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
-in:file:silent                           Silent input filename(s). [FileVector]
-in:file:silent_list                      Silent input filename list(s) - like -l is to -s. [FileVector]
-in:file:tags                             Instead of using all the structures in the input silent file(s)
                                          use just the listed structures. [StringVector]
-in:file:tagfile                          Like -in:file:tags, but instead of listing the tags on the command line,
                                          read the tags from the specified file. [FileName]
-in:file:silent_optH                      Call optH when reading a silent file. [Boolean]
-in:file:silent_structure_type            Type of SilentStruct object to use in silent-file input'.
                                          Default='protein', [String]
-in:file:silent_read_through_errors       Try to salvage damaged silent files
-in:file:silent_score_prefix              Prefix that is appended to all scores read in from a silent-file',
                                          default='' [String]
```

Scoring
=======

```
-in:file:repair_sidechains  Attempt a repack/minmize to repair sidechain problems.
                            Such as proline geometry and his tautomerization' default = 'false'
                            [Boolean]
```

##Ensemble Job Inputter

An alternative Job Inputter in the framework of JD2( The current Job Distribution system) that is specifically for working with an ensemble of input structures.  Simple. Two modes.  Seed Ensemble and Grid Ensemble. 

Author - Jared Adolf-Bryfogle (jadolfbr@gmail.com); PI : William Schief

###Seed Ensemble

Randomly choose the starting files using the list of structures given by -s and -l

-jd2:seed_ensemble_weights (RealVector)

 - Will give weights to the input PDBs and trigger seed_ensemble mode and the JobInputter.  We then use the weighted sampler to choose the input pdb for each nstruct.  The weights could be the size of the cluster, the energy, that you like some structure better, etc. Must match number of inputs.

-jd2:seed_ensemble_weight_file (File)

 - A file specifying weights to use for each input structure.  Enables seed_ensemble mode and the JI. Two columns.  basename with extension (or relative path or full path), weight.  Any not given in file will be set to 0 by default.  Can give a line that is [ALL weight] to set all input pdbs to a given weight. Used for example, to upweight a specific structure:

```
#name weight
ALL 1
awesome_model.pdb 3

```

-jd2:seed_ensemble (Bool)

 - Enable seed ensemble mode, but simply randomly choose the input pdb for each nstruct.  For seed ensemble mode, the number of input pdbs can be larger than nstruct.


###Grid Ensemble
Use the input files given in -s and -l and nstruct to cover a grid.

-in:jd2:grid_ensemble (Bool)

 - Will enable the basic component of the JI.  Here, instead of sampling nstruct for every input pdb, we only sample nstruct no matter the number of input PDBs (with nstruct split as evenly as possible over the input PDBs).  

_NOTE: The Ensemble Job Inputter Does not currently work with silent files._

##See Also

* [Controlling Input and Output Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/input_and_output/input_and_output)
* [[Options overview]]: Description of options in Rosetta
* [[Output options]]
* [[Full options list]]
* [[File types list]]: Links to documentation for different file types used in Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications