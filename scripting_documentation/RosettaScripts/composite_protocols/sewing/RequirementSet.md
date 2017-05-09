#AssemblyRequirements

AssemblyRequirements are used by the various AssemblyMovers to restrict constructed Assemblies to have specific features. Below is a list of currently implemented requirements. AssemblyRequirements are a subtag to AssemblyMovers and are listed inside a AssemblyRequirements tag.

For an example of using a RequirementSet, see the [[MonteCarloAssemblyMover]] page.

[[_TOC_]]

#### ClashRequirement
A requirement that checks the residues of the assembly against one another to make sure there are no clashes. This requirement takes two options: ```maximum_clashes_allowed```, and ```clash_radius```. To disallow all clashes within 5 Angstroms, the tag would look like:

```xml
<ClashRequirement maximum_clashes_allowed="0" clash_radius="5" />
```

#### DsspSpecificLengthRequirement
A requirement that restricts the length of various secondary structure elements in the Assembly. This requirement takes three options: ```dssp_code```, ```minimum_length```, and ```maximum_length```. For instance, the following requirement tag would force all alpha-helical segments in the assembly to be between 4 and 10 residues long.

```xml
<DsspSpecificLengthRequirement dssp_code="H" minimum_length="4" maximum_length="10" />
```

#### SizeInSegmentsRequirement
A requirement that restricts the size of the generated Assembly. This requirement takes two arguments: ```minimum_size``` and ```maximum_size```. To generate an Assembly with at least 5 segments and at most 7, the following tag would be used:

```xml
<SizeInSegmentsRequirement minimum_size="5" maximum_size="7" />
```

#### LengthInResiduesRequirement
A requirement that restricts the length (in residues) of the generated Assembly. This requirement takes two arguments: ```minimum_length``` and ```maximum_length```. To generate an Assembly with a maximum of 1200 residues, the following tag would be used:

```xml
<LengthInResiduesRequirement minimum_length="0" maximum_length="1200" />
```

#### LigandClashRequirement
A requirement that checks ligand atoms against the Assembly to check for clashes. This requirement takes two options: ```maximum_clashes_allowed```, and ```clash_radius```. To disallow all clashes within 4 Angstroms of the ligand, the tag would look like:

```xml
<LigandClashRequirement maximum_clashes_allowed="0" clash_radius="4" />
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