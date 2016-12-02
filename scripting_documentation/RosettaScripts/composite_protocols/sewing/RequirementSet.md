#RequirementSet

The RequirementSet is used by the various AssemblyMover implementation to restrict constructed Assemblies to have specific features. Requirements can currently take two forms: Global requirements, which are requirements place on the entire assembly; and Intra-Segment requirements, which are requirements placed on individual segments (usually secondary structure elements) that make up the Assembly. Below is a list of currently implemented requirements.

For an example of using a RequirementSet, see the [[MonteCarloAssemblyMover]] page.

[[_TOC_]]

##Global Requirements

#### GlobalLengthRequirement
A requirement that restricts the length of various secondary structure elements in the Assembly. This requirement takes three options: dssp_code, min_length, and max_length. For instance, the following requirement tag would force all alpha-helical segments in the assembly to be between 4 and 10 residues long.

```xml
<GlobalLengthRequirement dssp='H' min_length="4" max_length="10" />
```

##IntraSegment Requirements
Note that all IntraSegment Requirement tags *must* be nested inside of an IntraSegmentRequirements tag. This tag takes one option, an 'index' which is used to dictate which segment to apply the requirement to in the final Assembly. For example, the tag below will apply all requirement sub-tags on the first (N-terminal) segment in the generated Assemblies.

```xml
<IntraSegmentRequirements index="1">
    #Put Requirement tags here!
    #for example,
    <SegmentDsspRequirement dssp="H" />
    <SegmentLengthRequirement min_length="11" />
</IntraSegmentRequirements>
```

#### SegmentDsspRequirement 
Require that the specified segment is a particular secondary structure

```xml
<SegmentDsspRequirement dssp="H" />
```

####SegmentLengthRequirement 
Require that the specified segment is between a given min and max length (# of residues)

```xml
<SegmentLengthRequirement min_length="8" max_length="21" />
```
 
####ResidueRetentionRequirement
A special requirement used by the [[AppendAssemblyMover|SEWING#AppendAssemblyMover]] class to force the retention of certain residues during the generation of chimeric segments (for instance, if you are building an Assembly off of a helical peptide and want to ensure that the chimera segment built off of this peptide doesn't remove the terminal residue). It is rare to use the tag-setup of this requirement as it is set up automatically by the `keep_model_residues` flag used by the AppendAssemblyMover.

```xml
<ResidueRetentionRequirement model_id="1" required_resnums="1 2 3" />
```

##See Also
* [[SEWING]]
* [[Assembly of models]]
* [[MonteCarloAssemblyMover]]
* [[AppendAssemblyMover]]
