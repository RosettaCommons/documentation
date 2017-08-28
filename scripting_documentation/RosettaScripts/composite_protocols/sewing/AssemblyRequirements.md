#AssemblyRequirements

AssemblyRequirements are used by the various AssemblyMovers to restrict constructed Assemblies to have specific features. Below is a list of currently implemented requirements. AssemblyRequirements are a subtag to AssemblyMovers and are listed inside a AssemblyRequirements tag.

For an example of using AssemblyRequirements, see the [[AssemblyMover]] page.

[[_TOC_]]

###ClashRequirement
A requirement that checks the residues of the assembly against one another to make sure there are no clashes. ClashRequirement also checks for clashes between the assembly and its partner pdb when applicable. This requirement takes two options: ```maximum_clashes_allowed```, and ```clash_radius```. To disallow all clashes within 5 Angstroms, the tag would look like:

```xml
<ClashRequirement maximum_clashes_allowed="0" clash_radius="5" />
```

###DsspSpecificLengthRequirement
A requirement that restricts the length of various secondary structure elements in the Assembly. This requirement takes three options: ```dssp_code```, ```minimum_length```, and ```maximum_length```. For instance, the following requirement tag would force all alpha-helical segments in the assembly to be between 4 and 10 residues long.

```xml
<DsspSpecificLengthRequirement dssp_code="H" minimum_length="4" maximum_length="10" />
```
###KeepLigandContactsRequirement
A requirement that ensures that the distance between atoms participating in a ligand contact does not exceed a user-specified value. It is typically used if and only if conformer sampling is enabled. This requirement takes only one attribute, contact_distance_cutoff, which indicates the distance in Angstroms beyond which a contact will be considered broken (default 2.5). The following requirement would fail if a contact atom was more than 3 Angstroms from its corresponding ligand atom:

```xml
<KeepLigandContactsRequirement contact_distance_cutoff="3.0" />
```

###SizeInSegmentsRequirement
A requirement that restricts the size of the generated Assembly. This requirement takes two arguments: ```minimum_size``` and ```maximum_size```. To generate an Assembly with at least 5 segments and at most 7, the following tag would be used:

```xml
<SizeInSegmentsRequirement minimum_size="5" maximum_size="7" />
```

###LengthInResiduesRequirement
A requirement that restricts the length (in residues) of the generated Assembly. This requirement takes two arguments: ```minimum_length``` and ```maximum_length```. To generate an Assembly with a maximum of 1200 residues, the following tag would be used:

```xml
<LengthInResiduesRequirement minimum_length="0" maximum_length="1200" />
```

###LigandClashRequirement
A requirement that checks ligand atoms against the Assembly to check for clashes. This requirement takes two options: ```maximum_clashes_allowed```, and ```clash_radius```. To disallow all clashes within 4 Angstroms of the ligand, the tag would look like:

```xml
<LigandClashRequirement maximum_clashes_allowed="0" clash_radius="4" />
```

###NonTerminalStartingSegmentRequirement
This requirement ensures that any starting segment will be non-terminal in the final assembly. This requirement is typically used in AppendAssemblyMover runs in which you want segments to be added to both the N- and C- terminal ends of the starting segment(s). This requirement does not take any options, and uses a basic tag:

```xml
<NonTerminalStartingSegmentRequirement />
```

##See Also
* [[SEWING]] The SEWING home page
* [[AssemblyMover]]
* [[AppendAssemblyMover]]
* [[AssemblyScorers]]