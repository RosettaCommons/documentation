##Assembly of models


##Note: The individual movers on this page should be moved onto their own RosettaScripts pages. This page should list the movers and give the flags common to all movers. SEWING requirements should probably also have their own page.
Generating de novo backbones (or Assemblys) in the SEWING framework is accomplished by a simple graph traversal. The nodes in this graph, called the SewGraph, are the Models extracted in [[Step 1|model-generation]] of the protocol. The edges are the structural matches found in [[Step 2|model-comparison-with-geometric-hashing]] of SEWING.

Assembly of backbones is implemented within a Mover, and thus can be accessed via the [[RosettaScripts]] interface. There are currently several Movers implemented, each designed to accomplish different design goals. The base AssemblyMover has a handful of core methods which are selectively implemented or overwritten by the various sub-movers.

###Flags common to all SEWING movers
```
-s                              The input PDB (ignored, but still required, for many SEWING Movers)
-sewing:model_file_name         The name of the file to read models from
-sewing:score_file_name         The name of the file to read scores (edges) from
-sewing:assembly_type generate  The type of Assembly to generate (allows 'continuous' and 'discontinuous')
-sewing:num_edges_to_follow     The number of edges from the SewGraph that will be followed. Each edge adds more to the structure
-sewing:base_native_bonus       The bonus in Rosetta energy units to give 'native' residues during design (default 1)
-sewing:neighbor_cutoff         The cutoff for favoring natives. Any residue with fewer natives in the Assembly will not be favored (default: 16)
-sewing:skip_refinement         If true, no full-atom refinement will be run on the completed Assembly
-sewing:skip_filters            If true, all filters will be skipped during Assembly generation
```

----------------------

###AssemblyMover
The AssemblyMover is the abstract base class from which all other AssemblyMovers derive (not necessarily directly). In essence, this class has some basic methods implemented that make it easier to build Assemblies from the SewGraph, and to then create Poses from those Assemblies. A few of the relevant functions are outlined below:

* **generate_assembly** - A pure virtual function. This is the function that child movers will overwrite to actually create Assemblies
* **add_starting_model** - Add a random starting model to the Assembly
* **follow_random_edge_from_node** - Append a new model to the Assembly by following an edge from the given node
* **get_fullatom_pose** - Generate a full-atom pose from the Assembly
* **get_centroid_pose** - Generate a centroid pose from the Assembly
* **refine_assembly** - Refine a pose using information from the Assembly. By default, this will use a FastRelax based design strategy. Residue-type constraints are used to give a bonus to 'native' residues at each position (due to structural superimposition during assembly creation, this can result in favoring multiple residue types at a given position).

##Required Command-line options <a name="required-flags" />


```xml


-sewing:model_file_name Path to SEWING model file
-sewing:score_file_name Path to SEWING edge file
-sewing:max_ss_num      Number of secondary structure elements and loops that compose
                        a substructure. For instance, this number would be 3 for a helix-turn-helix motif.
```
###Optional flags

```
-sewing:dump_every_model_for_devel_purpose

----------------------
###RosettaScripts-Accessible SEWING Movers:

* [[EnumerateAssemblyMover]]
* [[AppendAssemblyMover]]



----------------------

###MonteCarloAssemblyMover

**Subclass of AssemblyMover**

The MonteCarloAssemblyMover is the standard mover for the SEWING framework. This mover will randomly add Models to build up an Assembly that satisfies a given set of requirements. The evaluation of requirements is handled by the [[Requirement Set|SEWING#assembly-of-models_requirementset]], which is outlined in more detail below. The decision to add/reject a model during the creation of an Assembly is based on a Monte-Carlo algorithm that uses a fast Assembly-specific score function for evaluation. Currently, the Assembly score function simply penalizes backbone clashes, and rewards designable contacts using the MotifHash framework.

Currently, this mover is only accessible via RosettaScripts. The below script will generate a 7-segment Assembly, in which the first segment must be an alpha-helix between 8 and 21 residues long.
**Note that due to the fact that RosettaScripts uses the standard Rosetta Job Distributor, an input PDB is required (using the standard -s/-l flags). This PDB will be ignored.** 

An example RosettaScripts tag is below:

```xml
<MonteCarloAssemblyMover
    name=assemble
    cycles=5000
    min_segments=7
    max_segments=7
    add_probability=0.4
    delete_probability=0.1
    switch_probability=0.5
>
    <IntraSegmentRequirements index=1>
        <SegmentDsspRequirement dssp="H" />
        <SegmentLengthRequirement min_length=8 max_length=21 />
    </IntraSegmentRequirements>
</MonteCarloAssemblyMover>
```


An example of motif.flags (MonteCarloAssemblyMover requires this as well) is below:

```xml
-mh:match:ss1 true    # for "explicit" motifs that get dumped at the end, match target SS
-mh:match:ss2 true    # for "explicit" motifs that get dumped at the end, match binder SS
-mh:match:aa1 false   # for "explicit" motifs that get dumped at the end, match target AA
-mh:match:aa2 false   # for "explicit" motifs that get dumped at the end, match binder AA

-mh:score:use_ss1 true         # applicable only to "BB_BB motifs, match secondary structure on first (target) res"
-mh:score:use_ss2 true         # applicable only to "BB_BB motifs, match secondary structure on second (binder) res"
-mh:score:use_aa1 false        # applicable only to "BB_BB motifs, match AA identity on first (target) res"
-mh:score:use_aa2 false        # applicable only to "BB_BB motifs, match AA identity on second (binder) res"

-mh:path:motifs       /home/kimdn/db/motifhash_data/xsmax_bb_ss_AILV_resl0.8_msc0.3/xsmax_bb_ss_AILV_resl0.8_msc0.3.rpm.bin.gz
-mh:path:scores_BB_BB /home/kimdn/db/motifhash_data/xsmax_bb_ss_AILV_resl0.8_msc0.3/xsmax_bb_ss_AILV_resl0.8_msc0.3

-mh:gen_reverse_motifs_on_load false     # I think the inverse motifs are already in the datafiles

-mh::dump::max_rms 0.4
-mh::dump::max_per_res 20
```


----------------------

----------------------


###RepeatAssemblyMover

**Subclass of AssemblyMover**

The RepeatAssemblyMover is intended for the design of repeat proteins using the SEWING framework. Due to the graph-traversal based generation of backbones used by SEWING, repeat protein generation is relatively easy; one needs only to find cycles in the graph. This mover is currently under active development, and as such many of the features expected in a SEWING mover may not be implemented (for instance, this mover currently does not respect the RequirementSet)


**WARNING: Currently the num_repeating_segments options of this tag is misleading. The below tag will actually generate an assembly with 4 repeating segments (e.g. helix-loop-helix-loop). The final repeat in the created assembly will be missing the last segment (e.g. helix-loop-helix). This should be fixed soon and the documentation will be updated to reflet this change**
```xml
<RepeatAssemblyMover name="assemble" num_repeating_segments=2 />
```

----------------------

###RequirementSet

The RequirementSet is used by the various AssemblyMover implementation to restrict constructed Assemblies to have specific features. Requirements can currently take two forms: Global requirements, which are requirements place on the entire assembly; and Intra-Segment requirements, which are requirements placed on individual segments (usually secondary structure elements) that make up the Assembly. Below is a list of currently implemented requirements.

####Global Requirements
* GlobalLengthRequirement - A requirement that restricts the length of various secondary structure elements in the Assembly. This requirement takes three options: dssp_code, min_length, and max_length. For instance, the following requirement tag would force all alpha-helical segments in the assembly to be between 4 and 10 residues long.

```xml
<GlobalLengthRequirement dssp='H' min_length=4 max_length=10 />
```

####IntraSegment Requirements
Note that all IntraSegment Requirement tags *must* be nested inside of an IntraSegmentRequirements tag. This tag takes one option, an 'index' which is used to dictate which segment to apply the requirement to in the final Assembly. For example, the tag below will apply all requirement sub-tags on the first (N-terminal) segment in the generated Assemblies.

```xml
<IntraSegmentRequirements index=1>
    #Put Requirement tags here!
    #for example,
    <SegmentDsspRequirement dssp="H" />
    <SegmentLengthRequirement min_length=11 />
</IntraSegmentRequirements>
```

* SegmentDsspRequirement - Require that the specified segment is a particular secondary structure

```xml
<SegmentDsspRequirement dssp="H" />
```

* SegmentLengthRequirement - Require that the specified segment is between a given min and max length

```xml
<SegmentLengthRequirement min_length=8 max_length=21 />
```
 
* ResidueRetentionRequirement - A special requirement used by the [[AppendAssemblyMover|SEWING#AppendAssemblyMover]] class to force the retention of certain residues during the generation of chimeric segments. For instance, if you are building an Assembly off of a helical peptide and want to ensure that the chimera segment build off of this peptide doesn't remove the terminal residue. It is rare to use the tag-setup of this requirement as it is set up automatically by the `keep_model_residues` flag used by the AppendAssemblyMover.

```xml
<ResidueRetentionRequirement model_id=1 required_resnums="1 2 3" />
```

##See Also
* [[SEWING]]: The SEWING homepage.
* [[Model Generation]]: Generating a model file (node file) for use with SEWING applications
* [[Model comparison with geometric hashing]]: Generating an edge file for use with SEWING applications
* [[SEWING Dictionary]]: Defines key SEWING terms.