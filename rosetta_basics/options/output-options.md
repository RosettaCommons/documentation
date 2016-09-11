<!-- --- title: Output Options -->

[Here](https://www.rosettacommons.org/demos/latest/tutorials/input_and_output/input_and_output#controlling-output) is a tutorial on basic output control.

Here is a list of common used output options.

General Output Options
====

```
-out:overwrite             Ignore 'CHECKPOINT' file and the overwrite the PDB file(s).
                           [Boolean]
-out:nstruct               Number of times to process each input PDB", default="1"
                           [Integer]
-out:prefix                Prefix for output structure names, like old -series code",
                           Default="". [String]
-out:suffix                Suffix for output structure names
                           Default="". [String]
-out:pdb_gz                Compress (gzip) output pdbs", default="false". [Boolean]
-out:pdb                   Output PDBs", default="false". [Boolean]
-out:nooutput              Surpress outputfiles. Default="false". [Boolean]
-out:output                Force outputfiles. Default="false". [Boolean]
-out:show_accessed_options At the end of the run show options that has been accessed
                           Default="false". [Boolean]
-out:user_tag              Add this tag to structure tags: e.g., a process id.
                           Default="". [String]
-out:no_nstruct_label      Do not append _#### to tag for output structures
```

Relational Databases
====================
See [[here | Database-options ]] for more info
```
-out:use_database          Write out structures to database.
                            Specify database via -inout:dbms:database_name and wanted structures with
                            -in:file:tags [Boolean]
-out:database_filter       Filter to use with database output.  Arguments for filter follow filter name [StringVector]
-out:resume_batch          Specify 1 or more batch ids to finish an incomplete protocol.
                            Only works with the DatabaseJobOutputter.
                            The new jobs will be generated under a new protocol and batch ID
```

Tracer related options.
=======================

User can dynamically, in run time specify command line options to mute/unmute specific/all channels and to change level of output.

```
-mute                      Mute specified chanels, specify 'all' to mute all chanels.
                           Defaule="false" [StringVector]
-unmute                    UnMute specified chanels. Default="false" [StringVector]
```

Controlling Tracer output from command line. For Example:

```
# unmute all channels - default behavior, the same as just './a.out'
./a.out -unmute all

# mute all channels, unmute ChannelA and ChannelB
./a.out -mute all -unmute ChannelA ChannelB

# mute ChannelA and  ChannelB
./a.out -mute ChannelA ChannelB

# Set priority of output messages to be between 0 and 10
./a.out -out:level 10

# disable output of channels names
./a.out -chname off
```

Files related output options
============================

```
-out:file:o               Output file name. [String]
-out:file:silent          Use silent file output, use filename after this flag.
                          Default="default.out" [String]
-out:file:scorefile       Write a scorefile to the provided filename.
                          Default = "default.sc [String]
-out:file:fullatom        Enable full-atom output of PDB or centroid structures.
                          Default = "false" [Boolean]
```

Path related output options
===========================

```
-out:path:all             All Files output Path. Default = '.' [Path]
-out:path:pdb             PDB file output path. [Path]
-out:path:score           Score file output path. [Path]

```

Handy output options for debugging a protocol
=============================================

```
-inout:write_all_connect_info    Writes explicit CONECT records in the PDB file,
                                 for all bonded atoms, so that bonds are drawn for
                                 anything that's bonded when the structure is viewed
                                 in a program like PyMOL.  (By default, only CONECT
                                 records for noncanonical entities are written.)
                                 Default = "false".  [Boolean]
-inout:connect_info_cutoff       Sets the threshold for writing CONECT records.
                                 Bonded atoms separated by more than this
                                 distance (in Angstroms) have a CONECT record
                                 written.  Set this to 0.0 to write all bonds.
                                 Default = 0.0. [Real]
-inout:skip_connect_info         Prevents the writing of CONECT records in the PDB file.
                                 In the absence of this flag, CONECT records are written
                                 for anything that isn't a canonical L-alpha amino acid or
                                 a canonical nucleic acid.  Default = "false".  [Boolean]
```

##See Also

* [Tutorial on Controlling Input and Output](https://www.rosettacommons.org/demos/latest/tutorials/input_and_output/input_and_output#controlling-output)
* [[Options overview]]: Description of options in Rosetta
* [[Input options]]
* [[Full options list]]
* [[File types list]]: Links to documentation for different file types used in Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Analyzing Results]]: Information on analyzing output generated using Rosetta