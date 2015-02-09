The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure.

##Basic concepts
SEWING stands for **S**tructure **E**xtension **WI**th **N**ative-fragment **G**raphs. SEWING functions by identifying relatively large sub-structures, called models (2-5 pieces of secondary structure, called segments) from native PDBs, and then assembling these models based on structural similarity. SEWING can be broken down into three basic steps:

1. [[Model Generation|SEWING#Model-Generation]] - Extraction of 'models' from native structures
2. [[Model Comparison|SEWING#Model-comparison-with-geometric-hashing]] - Structurally compare models to one another using a geometric hashing algorithm
3. [[Assembly|SEWING#Assembly-of-models]] - Stitch models together based on structural superimposition to form novel backbones

##Model Generation
First we need to generate a set of models. The only currently supported mechanism for model generation is through the use of a [[Features database|FeaturesTutorials]]. The following set ReportToDB tag contains the minimal set of features.

```
<ReportToDB name=features database_name=scores.db3>
    <feature name=ResidueFeatures />
    <feature name=PoseConformationFeatures />
    <feature name=ResidueConformationFeatures />
    <feature name=ProteinResidueConformationFeatures />
    <feature name=ResidueSecondaryStructureFeatures />
    <feature name=SecondaryStructureSegmentFeatures />
    <feature name=SmotifFeatures />
</ReportToDB>
```

SewingHasher model generation flags
```
-sewing:mode generate           Set to SewingHasher mode to 'generate' for model generation
-inout:dbms:database_name       The SQL database file to generate models from
-sewing:model_file_name         The name of the model file to be generated
```

An example command line for generation of model files:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode generate \
-database_name pdb.db3 \
-sewing:model_file_name pdb.models
```

##Model comparison with geometric hashing
Once a Model file has been generated, the models need to be structurally compared to one another using a geometric hashing algorithm implemented in the SewingHasher.

SewingHasher hashing flags
```
-sewing:mode hash               Set the sewing mode to 'hash' for geometric hashing
-sewing:model_file_name         The name of the file to read models from
-sewing:score_file_name         The name of the score file to output (used in later stages of SEWING)
-sewing:num_segments_to_match   The exact of model segments to look for structural matches for. Any matches with less than, or more than, this number of segment matches will fail. For continuous SEWING, only a value of 1 is supported
-sewing:min_hash_score          The minimum number over overlapping atoms **per segment** that is considered a structure match (recommended value: >=10)
-sewing:max_clash_score         The tolerance for number of atoms/segment of different atom types that end up in the same quarter-angstrom bin during geometric hashing (recommended value: 0)
```

An example command line for comparison of model files:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode hash \
-sewing:model_file_name pdb.models \
-sewing:score_file_name pdb.scores \
-sewing:num_segments_to_match 1 \
-sewing:min_hash_score 20 \
-sewing:max_clash_score 0
```

Due to the computational expense, it is recommended to run the above command using a large number of processors using MPI. The result will be one score plain-text file per MPI process (e.g. pdb.scores.0, pdb.scores.1, etc). For most production-size databases, the resultant score files will be very large. To increase speed during assembly, it is required that the entire set of plain-text score files be converted into a single, binary score file. To accomplish this conversion, first combine the plain text score files:
```
cat pdb.scores.* > pdb.scores
```

Then, use the SewingHasher executable to convert this plain-text file to binary:
```
/path/to/rosetta/bin/SewingHasher.linuxgccrelease \
-sewing:mode convert \
-sewing:model_file_name pdb.models \
-sewing:score_file_name pdb.scores
```

The final result should be a score file named pdb.scores.bin, this is the score file that will be used during the Assembly of SEWING backbones.

##Assembly of models

Generating de novo backbones (or Assemblys) in the SEWING framework is accomplished by a simple graph traversal. The nodes in this graph, called the SewGraph, are the Models extracted in [[Step 1|SEWING#Model-Generation]] of the protocol. The edges are the structural matches found in [[Step 2|SEWING#Model-comparison-with-geometric-hashing]]] of SEWING.

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
The AssemblyMover is the abstract base class from which all other AssemblyMovers derive (not necessarily directly). In essence, this class has some basic methods implemented that make it easier to build Assemblies from the SewGraph, and to then create Poses from those Assemblies. A few of the relevant functions are outline below:

* **generate_assembly** - A pure virtual function. This is the function that child movers will overwrite to actually create Assemblies
* **add_starting_model** - Add a random starting model to the Assembly
* **follow_random_edge_from_node** - Append a new model to the Assembly by following an edge from the given node
* **get_fullatom_pose** - Generate a full-atom pose from the Assembly
* **get_centroid_pose** - Generate a centroid pose from the Assembly
* **refine_assembly** - Refine a pose using information from the Assembly. By default, this will use a FastRelax based design strategy. Residue-type constraints are used to give a bonus to 'native' residues at each position (due to structural superimposition during assembly creation, this can result in favoring multiple residue types at a given position).

----------------------

###MonteCarloAssemblyMover

**Subclass of AssemblyMover**

The MonteCarloAssemblyMover is the standard mover for the SEWING framework. This mover will randomly add Models to build up an Assembly that satisfies a given set of requirements. The evaluation of requirements is handled by the [[Requirement Set|SEWING#RequirementSet]], which is outlined in more detail below. The decision to add/reject a model during the creation of an Assembly is based on a Monte-Carlo algorithm that uses a fast Assembly-specific score function for evaluation. Currently, the Assembly score function simply penalizes backbone clashes, and rewards designable contacts using the MotifHash framework.

Currently, this mover is only accessible via RosettaScripts. The below script will generate a 7-segment Assembly, in which the first segment must be an alpha-helix between 8 and 21 residues long.
**Note that due to the fact that RosettaScripts uses the standard Rosetta Job Distributor, an input PDB is required (using the standard -s/-l flags). This PDB will be ignored.** 

An example RosettaScripts tag is below:

```
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

----------------------

###AppendAssemblyMover

**Subclass of MonteCarloAssemblyMover**

The SewingAppendMover is a Mover that allows the addition of residues to a PDB that is not incorporated into the SewGraph. Therefore, the first step in the SewingAppendMover is the addition of the new Model to the SewGraph, and the identification of any edges (structural matches) to this new node (The PDB Model). 

The complete set of additional flags respected by the SewingAppendMover
```
-s                              The input PDB to be appended to
-sewing:partner_pdb             The 'partner' of the PDB being used as the starting model (usually a binding partner)
-sewing:pose_segment_starts     A vector of integers representing the starting residue (in Rosetta residue numbering) of each segment in the Model PDB (passed with the -s/-l flags)
-sewing:pose_segment_ends       A vector of integers representing the end residue (in Rosetta residue numbering) of each segment in the Model PDB (passed with the -s/-l flags)
-sewing:keep_model_residues     A vector of integers representing residues (in Rosetta residue numbering) that should not be allowed to change from their starting amino acid identity.
-sewing:num_segments_to_match   The exact of model segments to look for structural matches for. Any matches with less than, or more than, this number of segment matches will fail. For continuous SEWING, only a value of 1 is supported
-sewing:min_hash_score          The minimum number over overlapping atoms **per segment** that is considered a structure match (recommended value: >=10)
-sewing:max_clash_score         The tolerance for number of atoms/segment of different atom types that end up in the same quarter-angstrom bin during geometric hashing
```

----------------------


###RepeatAssemblyMover

**Subclass of AssemblyMover**

The RepeatAssemblyMover is intended for the design of repeat proteins using the SEWING framework. Due to the graph-traversal based generation of backbones used by SEWING, repeat protein generation is relatively easy; one needs only to find cycles in the graph. This mover is currently under active development, and as such many of the features expected in a SEWING mover may not be implemented (for instance, this mover currently does not respect the RequirementSet)

----------------------

###RequirementSet

The RequirementSet is used by the various AssemblyMover implementation to restrict constructed Assemblies to have specific features. Requirements can currently take two forms: Global requirements, which are requirements place on the entire assembly; and Intra-Segment requirements, which are requirements placed on individual segments (usually secondary structure elements) that make up the Assembly. Below is a list of currently implemented requirements.

####Global Requirements
* GlobalLengthRequirement - A requirement that restricts the length of various secondary structure elements in the Assembly. This requirement takes three options: dssp_code, min_length, and max_length. For instance, the following requirement tag would force all alpha-helical segments in the assembly to be between 4 and 10 residues long.

```
<GlobalLengthRequirement dssp='H' min_length=4 max_length=10 />
```
 

 