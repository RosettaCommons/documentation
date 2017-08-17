#LegacyAppendAssemblyMover
##Note: This page is for LegacySEWING.
**This is an outdated page. For information on the current version of sewing, please visit the [[AssemblyMover]] and [[AppendAssemblyMover]] pages.**

The LegacyAppendAssemblyMover is a Mover that allows the addition of residues to a PDB that is not incorporated into the SewGraph. Therefore, the first step in the LegacyAppendAssemblyMover is the addition of the new Model to the SewGraph, and the identification of any edges (structural matches) to this new node (The PDB Model). 

##Command-line options

###Required command-line options
The LegacyAppendAssemblyMover requires all required flags of the [[AssemblyMover|Assembly-of-models#required-flags]] in addition to the following flags:

```
-s                              The input PDB to be appended to
-legacy_sewing:pose_segment_starts     A vector of integers representing the
                                starting residue (in Rosetta residue numbering)
                                of each segment in the Model PDB (passed with the -s/-l flags)
-legacy_sewing:pose_segment_ends       A vector of integers representing the end residue (in
                                Rosetta residue numbering) of each segment in the Model
                                PDB (passed with the -s/-l flags)
-legacy_sewing:keep_model_residues     A vector of integers representing residues (in
                                Rosetta residue numbering) that should not be
                                allowed to change from their starting amino acid identity.
-legacy_sewing:num_segments_to_match   The exact of model segments to look for structural
                                matches for. Any matches with less than, or more than,
                                this number of segment matches will fail. For continuous
                                SEWING, only a value of 1 is supported
-legacy_sewing:min_hash_score          The minimum number over overlapping atoms **per segment**
                                that is considered a structure match (recommended value: >=10)
-legacy_sewing:max_clash_score         The tolerance for number of atoms/segment of different
                                atom types that end up in the same quarter-angstrom bin
                                during geometric hashing
```

###Optional Flags

```
-legacy_sewing:partner_pdb             An additional PDB file used when finding clashes
                                and in scoring (InterfaceMotifScore).
                                Normally a binding partner for the input PDB.


```

##RosettaScripts options

As a subclass of the [[LegacyMonteCarloAssemblyMover]], the AppendAssemblyMover takes the same RosettaScripts options.

##Sample

The following is an actual RosettaScript used to run AppendAssemblyMover for multiple inputs; each input takes a different value for the command-line options -in:file:s, -sewing:keep_model_residues, -sewing:pose_segment_starts, and -sewing:pose_segment_ends.
```xml
<ROSETTASCRIPTS>
  <SCOREFXNS>
  </SCOREFXNS>
  <FILTERS>
  </FILTERS>
  <MOVERS>
    <AppendAssemblyMover name="assemble" min_segments="7" max_segments="9" 
     cycles="10000" />
  </MOVERS>
  <APPLY_TO_POSE>
  </APPLY_TO_POSE>
  <PROTOCOLS>
    <Add mover_name="assemble" />
  </PROTOCOLS>
</ROSETTASCRIPTS>
```

##See Also
* [[LegacyMonteCarloAssemblyMover]]
* [[Sewing Hasher Application] Application to generate legacy SEWING model and score files
* [[Assembly of models]]
* [[SEWING]]: The SEWING home page
* [[SEWING Dictionary]] Clarifies terms for legacy and new SEWING protocols

