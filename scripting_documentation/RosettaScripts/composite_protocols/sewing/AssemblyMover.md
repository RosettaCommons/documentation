#AssemblyMover

Generating de novo backbones (or Assemblys) in the SEWING framework is accomplished by combining substructures extracted from native structures in [[Step 1|segment-file-generation]] of the protocol. In Hashed SEWING these substructures are combined based on the structural matches found in [[Step 1b|structural-comparison-of-substructures]] of SEWING. In Hashless SEWING, these structural matches are calculated on-the-fly during assembly generation.

Assembly of backbones is implemented within a Mover, and thus can be accessed via the [[RosettaScripts]] interface. There are currently several Movers implemented, each created to accomplish different design goals.

The AssemblyMover is the base class and standard mover for the SEWING framework. This mover will randomly add substructures to build up an Assembly that satisfies a given set of requirements. The evaluation of requirements is handled by providing [[AssemblyRequirements]]. The decision to add/reject a substructure during the creation of an Assembly is based on a Monte-Carlo algorithm that uses the provided [[AssemblyScorers]] for evaluation.


----------------------
[[_TOC_]]

##Other SEWING Assembly Movers
* [[AppendAssemblyMover]] - Used to build a SEWING backbone onto an already existing protein structure
* [[LigandBindingAssemblyMover]] - Currently under development, this mover will allow you to build assemblies which create new ligand binding residues

##Command-line Flags

*This information is currently outdated, but provides enough information to successfully run SEWING. For information on command-line flags needed in previous versions of SEWING, please see the [[Assembly-of-models]] page* 

The following flags apply to all SEWING movers (see below) except when noted. Mover-specific flags are documented on the individual Mover pages.

###Required flags
```
-s                              The input PDB (ignored, but still required,
                                for many SEWING Movers)
```

In the current implementation, the following flags are also required for scoring SEWING Assemblies using the MotifScore and are shown with their recommended values ( See [[AssemblyScorers]] ):

```xml

-mh:match:ss1 true    # for "explicit" motifs that get dumped at the end,
                      match target SS
-mh:match:ss2 true    # for "explicit" motifs that get dumped at the end,
                      match binder SS
-mh:match:aa1 false   # for "explicit" motifs that get dumped at the end, 
                      match target AA
-mh:match:aa2 false   # for "explicit" motifs that get dumped at the end, 
                      match binder AA

-mh:score:use_ss1 true         # applicable only to BB_BB motifs; match
                               secondary structure on first (target) res
-mh:score:use_ss2 true         # applicable only to BB_BB motifs; match
                               secondary structure on second (binder) res
-mh:score:use_aa1 false        # applicable only to BB_BB motifs; match AA
                               identity on first (target) res
-mh:score:use_aa2 false        # applicable only to BB_BB motifs; match AA
                               identity on second (binder) res"

-mh:path:motifs            Path to .gz file containing motifs used in motifscore
-mh:path:scores_BB_BB      Path to directory containing database used
                           for generating MotifScores

-mh:gen_reverse_motifs_on_load false     # I think the inverse motifs are already in the datafiles

-mh::dump::max_rms 0.4
-mh::dump::max_per_res 20
```

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
* ```edge_file_name``` : Path to edge file to use during assembly generation ( See [[EdgeFileGeneration|structural-comparison-of-substructures#edge-file]] )

###Hashless SEWING Options
These options should be used only if the ```hashed``` option is set to false. Hashless SEWING determines structural compatibility on-the-fly during assembly generation and therefore requires no additional input files. We only recommend using this option with helical substructures, where a certain level of structural compatibility between segments can be reasonably assumed.

* ```window_width``` : Required number of overlapping residues for two segments to be considered a match

###Deprecated Options
While technically still listed as options, these are not guaranteed to be supported and should be set via the [[AssemblyRequirements]] subtag to ensure proper enforcement.
* ```max_segments``` : The maximum number of segments to include in the final assembly. ( See [[SizeInSegmentsRequirement|AssemblyRequirements#sizeinsegmentsrequirement]] )
* ```max_segment_length``` : The maximum number of residues to include in a segment. ( See [[DsspSpecificLengthRequirement|AssemblyRequirements#dsspspecificlengthrequirement]] , [[SegmentFileGeneration|segment-file-generation]] )

##Subtags

The AssemblyMover (like other SEWING movers) can be given [[AssemblyRequirements]], [[AssemblyScorers]], and [[Ligands|SEWING-with-Ligands]] subtags.

##Example
Currently, this mover is only accessible via RosettaScripts. The below script will generate a 5 to 7-segment long Assembly at constant temperature where all helices are a minimum of 4 helical turns.

*Note that due to the fact that RosettaScripts uses the standard Rosetta Job Distributor, an input PDB is required (using the standard -s/-l flags). This PDB will be ignored. If you would like to provide an input PDB as a starting structure for your SEWING run, see the [[AppendAssemblyMover]] page*

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
* [[SEWING]] The SEWING home page
* [[AssemblyRequirements]]
* [[AssemblyScorers]]
* [[AppendAssemblyMover]]
* [[LigandBindingAssemblyMover]]