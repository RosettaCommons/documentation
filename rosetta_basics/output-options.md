<!-- --- title: Output Options -->

Here is a list of common used output options.

Misc
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
-out:no_nstruct_label      Do not append _#### to tag for output structures
-out:output                Force outputfiles. Default="false". [Boolean]
-out:show_accessed_options At the end of the run show options that has been accessed
                           Default="false". [Boolean]
-out:user_tag              Add this tag to structure tags: e.g., a process id.
                           Default="". [String]
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
                          Default = "fault" [Boolean]
```

Path related output options
===========================

```
-out:path:pdb             PDB file output path. [Path]
-out:path:score           Score file output path. [Path]
```
