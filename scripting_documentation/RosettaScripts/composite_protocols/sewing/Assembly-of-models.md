#Assembly of models
##NOTE: This page is for LegacySEWING.
**This is an outdated page. For the current Assembly documentation visit the [[AssemblyMover]] page**

Generating de novo backbones (or Assemblys) in the SEWING framework is accomplished by a simple graph traversal. The nodes in this graph, called the SewGraph, are the Models extracted in [[Step 1|model-generation]] of the protocol. The edges are the structural matches found in [[Step 2|model-comparison-with-geometric-hashing]] of SEWING.
Assembly of backbones is implemented within a Mover, and thus can be accessed via the [[RosettaScripts]] interface. There are currently several Movers implemented, each designed to accomplish different design goals. The base AssemblyMover has a handful of core methods which are selectively implemented or overwritten by the various sub-movers.

----------------------
[[_TOC_]]

##AssemblyMover
The AssemblyMover is the abstract base class from which all other AssemblyMovers derive (not necessarily directly). In essence, this class has some basic methods implemented that make it easier to build Assemblies from the SewGraph, and to then create Poses from those Assemblies. A few of the relevant functions are outlined below:


* **generate_assembly** - A pure virtual function. This is the function that child movers will overwrite to actually create Assemblies
* **add_starting_model** - Add a random starting model to the Assembly
* **follow_random_edge_from_node** - Append a new model to the Assembly by following an edge from the given node
* **get_fullatom_pose** - Generate a full-atom pose from the Assembly
* **get_centroid_pose** - Generate a centroid pose from the Assembly
* **refine_assembly** - Refine a pose using information from the Assembly. By default, this will use a FastRelax based design strategy. Residue-type constraints are used to give a bonus to 'native' residues at each position (due to structural superimposition during assembly creation, this can result in favoring multiple residue types at a given position).

----------------------
###RosettaScripts-Accessible SEWING Movers:
**NOTE: This is a list of legacy SEWING movers. For documentation of refactored SEWING movers, see the [[AssemblyMover]] page.**

* [[LegacyMonteCarloAssemblyMover]]
* [[LegacyAppendAssemblyMover]]
* [[LegacyRepeatAssemblyMover]]
* [[LegacyEnumerateAssemblyMover]] (???)


----------------------

##Command-line options

The following flags apply to all SEWING movers (see below) except when noted. Mover-specific flags are documented on the individual Mover pages.

###Required flags
```
-s                              The input PDB (ignored, but still required,
                                for many SEWING Movers)
-legacy_sewing:model_file_name         The name of the SEWING model file
-legacy_sewing:score_file_name         The name of the SEWING edge file

```

In the current implementation, the following flags are also required for scoring SEWING Assemblies using the MotifScore and are shown with their recommended values:

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

###Optional flags

```
-legacy_sewing:assembly_type generate  The type of Assembly to generate 
                                (allows 'continuous' and 'discontinuous')
                                (Default=continuous)
-legacy_sewing:base_native_bonus       The bonus in Rosetta energy units to give 
                                'native' residues during design (default 1)
-legacy_sewing:neighbor_cutoff         The cutoff for favoring natives. Any residue
                                with fewer neighbors in the Assembly will not
                                be favored (default: 16)
-legacy_sewing:skip_refinement         If true, no full-atom refinement will be run on the 
                                completed Assembly (Default = false)
-legacy_sewing:skip_filters            If true, all filters will be skipped during Assembly 
                                generation (Default = false)
-legacy_sewing:dump_every_model        Dump all models regardless of whether they
                                pass score filters; useful for debugging
                                (Default false)
```

###Unused/experimental flags

```

-legacy_sewing:max_ss_num      Maximum number of secondary structure 
                        elements and loops that compose
                        a substructure. For instance, this
                        number would be 3 for a helix-turn-helix
                        motif. (still under development)
-legacy_sewing:num_edges_to_follow     The maximum number of edges from the SewGraph 
                                that will be followed. For instance, following  
                                4 edges in a graph of helix-loop-helix motifs 
                                will produce a 5-helix bundle. Currently not in  
                                use, and applies only to NodeConstraintAssemblyMover.
```

----------------------
##Subtags

Most SEWING movers (except [[RepeatAssemblyMover]]) accept subtags imposing restrictions on the assembly and/or individual segments. These subtags are described on the [[RequirementSet]] page.


##See Also
* [[SEWING]]: The SEWING homepage.
* [[Model Generation]]: Generating a model file (node file) for use with SEWING applications
* [[Model comparison with geometric hashing]]: Generating an edge file for use with SEWING applications
* [[SEWING Dictionary]]: Defines key SEWING terms.