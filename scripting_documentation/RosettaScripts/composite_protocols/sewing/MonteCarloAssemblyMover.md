#MonteCarloAssemblyMover


The MonteCarloAssemblyMover is the standard mover for the SEWING framework. This mover will randomly add Models to build up an Assembly that satisfies a given set of requirements. The evaluation of requirements is handled by providing [[AssemblyRequirements]]. The decision to add/reject a model during the creation of an Assembly is based on a Monte-Carlo algorithm that uses a fast Assembly-specific score function for evaluation. Currently, the Assembly score function simply penalizes backbone clashes, and rewards designable contacts using the MotifHash framework.

##Command-line Flags

As a subclass of AssemblyMover, MonteCarloAssemblyMover requires the command-line flags listed in [[Assembly of models]].

##RosettaScripts options

* cycles: The number of times to add/delete/switch an edge during the protocol. Not truly the number of Monte Carlo steps, as rejected steps are not counted toward the total number of cycles.
* min_segments: Minimum number of segments (helices, loops, and/or strands) for the final model.
* max_segments: Maximum number of segments (helices, loops, and/or strands) for the final model.
* add_probability: Probability that the mover will attempt to add a new substructure in a given cycle. Does not apply when the assembly has reached max_segments.
* delete_probability: Probability that the mover will attempt to delete one of the outermost substructures in a given cycle.
* switch_probability: Probability that the mover will attempt to switch out one of the outermost substructures for a new substructure in a given cycle.

##Subtags

The MonteCarloAssemblyMover (like other SEWING movers) can be given [[RequirementSet]] subtags.

##Example
Currently, this mover is only accessible via RosettaScripts. The below script will generate a 7-segment Assembly, in which the first segment must be an alpha-helix between 8 and 21 residues long.
**Note that due to the fact that RosettaScripts uses the standard Rosetta Job Distributor, an input PDB is required (using the standard -s/-l flags). This PDB will be ignored.** 

An example RosettaScripts tag is below:

```xml
<MonteCarloAssemblyMover
    name="assemble"
    cycles="5000"
    min_segments="7"
    max_segments="7"
    add_probability="0.4"
    delete_probability="0.1"
    switch_probability="0.5"
>
    <IntraSegmentRequirements index="1">
        <SegmentDsspRequirement dssp="H" />
        <SegmentLengthRequirement min_length="8" max_length="21" />
    </IntraSegmentRequirements>
</MonteCarloAssemblyMover>
```

##See Also
* [[RequirementSet]]
* [[SEWING]] The SEWING home page
* [[AppendAssemblyMover]]
* [[RepeatAssemblyMover]]
* [[EnumerateAssemblyMover]]
