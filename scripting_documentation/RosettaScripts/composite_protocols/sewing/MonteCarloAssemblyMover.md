#AssemblyMover


The AssemblyMover is the standard mover for the SEWING framework. This mover will randomly add substructures to build up an Assembly that satisfies a given set of requirements. The evaluation of requirements is handled by providing [[AssemblyRequirements]]. The decision to add/reject a model during the creation of an Assembly is based on a Monte-Carlo algorithm that uses the provided [[AssemblyScorers]] for evaluation.

##Command-line Flags

This will soon be updated, but for now, refer to the command line options listed in the [[Assembly of models]] page.

##RosettaScripts options

###Generic Options
* ```hashed``` : Setting to true will use a geometric hashing algorithm to determine segment matches. This requires an input edge file.
* ```start_temperature``` : Temperature at start of simulated annealing
* ```end_temperature``` : Temperature at end of simulated annealing
* ```add_probability``` : The probability of adding a substructure to the assembly during any given cycle
* ```delete_probability``` : The probability that a substructure will be removed from the assembly during any given cycle
* ```minimum_cycles``` : The minimum number of cycles required by the assembly before completion requirements are checked
* ```maximum_cycles``` : The maximum number of cycles before assembly generation is terminated, regardless of whether completion requirements are met
* ```model_file_name``` : Path to segment file ( See [[SegmentFileGeneration|segment-file-generation]] )
* ```output_pose_per_move``` : Used for visualization, setting this option to true will output a pose after each move/revert

###Hashed SEWING Options
These options should be used only if the ```hashed``` option is set to true.
* ```edge_file_name``` : Path to edge file to use during assembly generation (See [[EdgeFileGeneration|edge-file-generation]] )

###Hashless SEWING Options
These options should be used only if the ```hashed``` option is set to false. Hashless SEWING determines structural compatibility on-the-fly during assembly generation and therefore requires no additional input files. We only recommend using this option with helical substructures, where a certain level of structural compatibility between segments can be reasonably assumed.

* ```window_width``` : Required number of overlapping residues for two segments to be considered a match

###Deprecated Options
While technically still listed as options, these are not guaranteed to be supported and should be set via the [[AssemblyRequirements]] subtag to ensure proper enforcement.
* ```max_segments``` : The maximum number of segments to include in the final assembly. See SizeInSegmentsRequirement
* ```max_segment_length``` : The maximum number of residues to include in a segment. See DsspSpecificLengthRequirement, [[SegmentFileGeneration|segment-file-generation]]

##Subtags

The AssemblyMover (like other SEWING movers) can be given [[AssemblyRequirements]], [[AssemblyScorer]], and [[Ligands]] subtags.

##Example
Currently, this mover is only accessible via RosettaScripts. The below script will generate a 5 to 7-segment long Assembly at constant temperature where all helices are a minimum of 4 helical turns.
**Note that due to the fact that RosettaScripts uses the standard Rosetta Job Distributor, an input PDB is required (using the standard -s/-l flags). This PDB will be ignored.** 

An example RosettaScripts tag is below:

```xml
<AssemblyMover
    name="assemble"
    minimum_cycles="10000"
    maximum_cycles="100000"
    start_temperature="0.6"
    end_temperature="0.6"
    hashed="false"
    window_width="4"
    model_file_name="smotifs_H_1_100_L_1_100_H_1_100.segments"
>
    <AssemblyScorers>
        <MotifScorer weight="1" />
        <InterModelMotifScorer weight="10" />
    </AssemblyScorers>
    <AssemblyRequirements>
        <ClashRequirement maximum_clashes_allowed="0" clash_radius="5" />
        <SizeInSegmentsRequirement minimum_size="5" maximum_size="7" />
        <DsspSpecificLengthRequirement dssp_code="H" minimum_length="12" maximum_length="1000" />
    </AssemblyRequirements>
</AssemblyMover>
```

##See Also
* [[RequirementSet]]
* [[SEWING]] The SEWING home page
* [[AppendAssemblyMover]]
* [[RepeatAssemblyMover]]
* [[EnumerateAssemblyMover]]