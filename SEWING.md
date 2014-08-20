The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure.

##Basic concepts
SEWING stands for **S**tructure **E**xtension **WI**th **N**ative-fragment **G**raphs. SEWING functions by identifying relatively large sub-structures, called models (2-5 pieces of secondary structure) from native PDBs, and then assembling these models based on structural similarity. SEWING can be broken down into three basic steps:

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
-sewing:min_hash_score          The minimum number over overlapping atoms **per segment** that is considered a structure match
-sewing:max_clash_score         The tolerance for number of atoms/segment of different atom types that end up in the same bin (default: 0)
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

Due to the computational expense of is recommended to run the above command using a large number of processors using MPI. The result will be one score plain-text file per MPI process (e.g. pdb.scores.0, pdb.scores.1, etc). For most production-size databases, the resultant score files will be very large. To increase speed during assembly it is required that the entire set of plain-text score files be converted into a single, binary score file. To accomplish this conversion, first combine the plain text score files:
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

Assembly of backbones is implemented within a Mover, and thus can be accessed via the [[RosettaScripts]] interface. There are currently several Movers implemented, each designed to accomplish different design goals. The base AssemblyMover has a handful of core methods which are overwritten by the various sub-movers. A flow chart for how all these methods relate to one another is below:

```
+-----------------------+    +----------------------+    +--------------------+    +-----------+
| 1. Get starting Model +--->| 2. Generate Assembly +--->| 3. Complete filter +--->| 4. Refine |
+-----------------------+    +----------------------+    +--------------------+    +-----------+
                                        |
       ---------------------------------+----------------------------------------------------
      /                                                                                      \
      +-------------------+   +----------------+   +-----------------+   +--------------------+  
      | 2A. Get next edge +-->| 2B. Check edge +-->| 2C. Follow edge +-->| 2D. Partial filter |
      +-------------------+   +----------------+   +-----------------+   +--------------------+         
```

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

###RandomAssemblyMover
The RandomAssemblyMover is the base class from which all other AssemblyMovers derive (not necessarily directly). In essence, this class simply traverses the SewGraph in a random fashion until the required number of edges has been satisfied. A slightly more detailed description of each of the base AssemblyMover methods is:

1. **Get starting model** - Get a random model from the SewGraph
2. **Generate Assembly** - The following steps are repeated until the desired number of edges have been added, or until the max number of attempts is reached
    - **Get next edge** - Follow a random edge from the current node
    - **Check edge** - Check the edge for any backbone clashes it may introduce. If found, go back to step 1.
    - **Follow edge** - Add the target model from the current edge to the Assembly
    - **Partial filter** - Generate a centroid pose from the Assembly and run user defined partial filters. If any fail, go back to step 1. Skipped if skip_filters is set to true.
3. **Complete filter** - Generate a centroid pose from the Assembly and run user defined complete filters. If any fail, go back to step 1. Skipped if skip_filters is set to true.
4. **Refine** - Generate a full-atom pose from the Assembly and do a refinement step. Refinement is carried out by running a FastRelax mover with coordinate constraints and centroid minimization (in the future, this may change to a allow use of a sub-mover for refinement).

Currently, this mover is only accessible via RosettaScripts. 
**Note that due to the fact that RosettaScripts uses the standard Rosetta Job Distributor, an input PDB is required (using the standard -s/-l flags). This PDB will be ignored.** 

An example RosettaScripts tag is below:

```
<RandomAssemblyMover
    partial_filter=(&string)
    complete_filter=(&string)
    num_edges_to_follow=(&int)
    max_attempts=(&int)
    max_edges_per_node=(&int)
    base_native_bonus=(&real)
    neighbor_cutoff=(&int)
/>
```

###MotifDirectedAssemblyMover

**Subclass of RandomAssemblyMover**

The MotifDirectedAssemblyMover modifies the 'Generate Assembly' step of the RandomAssemblyMover by including scores generated by Will Scheffler's MotifScoring algorithm. Currently, this is implemented by evaluation the motif score of 250 random edges from the current node. The edge that produces a partial Assembly with the lowest normalized MotifScore (MotifScore is normalized simply by dividing the score by the number of residues in the Assembly). This implementation is subject to change in the very near future.

###SewingAppendMover

**Subclass of MotifDirectedAssemblyMover**

The SewingAppendMover is a Mover that allows the addition of residues to a PDB that is not incorporated into the SewGraph. Therefore, the first step in the SewingAppendMover is the addition of the new Model to the SewGraph, and the identification of any edges (structural matches) to this new node (The PDB Model). Aside from this change, the SewingAppendMover simply overwrites the following parent class methods:

* **Get starting model** - The SewingAppendMover starts every Assembly with the Model generated from the input PDB (using the standard -s/-l flags)

* **Partial filter** - The partial filter step is extended to also check for any backbone clashes with the PDB supplied through the option sewing:partner_pdb flag.

The complete set of additional flags respected by the SewingAppendMover
```
-sewing:partner_pdb           The 'partner' of the PDB being used as the starting model (usually a binding partner)
-sewing:pose_segment_starts   A vector of integers representing the starting residue (in Rosetta residue numbering) of each segment in the Model PDB (passed with the -s/-l flags)
-sewing:pose_segment_ends     A vector of integers representing the end residue (in Rosetta residue numbering) of each segment in the Model PDB (passed with the -s/-l flags)
-sewing:keep_model_residues   A vector of integers representing residues (in Rosetta residue numbering) that should not be allowed to change from their starting amino acid identity.
```

###RepeatAssemblyMover

###NodeConstraintAssemblyMover

    **Subclass of MotifDirectedAssemblyMover**

The NodeConstraintAssemblyMover is SEWING mover that aims to 'mimic' a pdb that is given as input. An input PDB (passed using the in:file:native flag) is broken up into its corresponding models (currently only 3-element models are supported, e.g. Helix->loop->Helix). Then, during traversal of the SewGraph, only models that fall within some similarity metric of the corresponding model in the native will be added. Similarity to natives is currently judges using four geometric features generated by the [[Smotif Feature Reporter|MultiBodyFeaturesReporters#SmotifFeatures]]. The allowable deviations from the native are currently hard-coded, but a NodeConstraint file is planned to replace this restriction.

The complete set of additional flags respected by the NodeConstraintAssemblyMover
```
-in:file:native           The PDB that should be used as a template for constraining nodes
```
