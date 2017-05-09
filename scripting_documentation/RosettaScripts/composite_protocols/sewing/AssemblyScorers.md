#AssemblyScorers

AssemblyScorers are used by the various AssemblyMovers to evaluate constructed Assemblies. Below is a list of currently implemented scorers. AssemblyScorers are a subtag to AssemblyMovers and are listed inside a AssemblyRequirements tag.

For an example of using a AssemblyScorers, see the [[AssemblyMover]] page.

[[_TOC_]]

###MotifScorer
A fast, light weight scorer which uses the MotifScore developed by Will Scheffler, to compare every residue in the generated assembly. While the motif hasher requires several [[command line options|AssemblyMover#command-line-flags]], the MotifScorer tag only requires a ```weight``` option.

```xml
<MotifScorer weight="1" />
```

###InterModelMotifScorer
This scorer is very similar to the MotifScorer, however, rather than comparing all residues to each other it only scores each residue to the residues not in the same substructure. Up-weighting this score helps to increase packing between substructures within the assembly. The InterModelMotifScorer tag only requires a ```weight``` option.

```xml
<InterModelMotifScorer weight="10" />
```

###StartingNodeMotifScorer
This scorer is only used in Append Assembly runs to score the residues of the starting structure to those of the generated assembly. Similar to the InterModelMotifScorer, this scorer helps to increase packing between the starting structure and the rest of the assembly. The StartingNodeMotifScorer tag only requires a ```weight``` option.

```xml
<StartingNodeMotifScorer weight='1' />
```

###PartnerMotifScorer
This scorer will only be used in certain Append Assembly runs and calculates the motif score between the residues in the provided partner pdb and those in the generated assembly. This Scorer only requires a ```weight``` option:

```xml
<PartnerMotifScorer weight="1" />
```

###LigandScorer
This scorer evaluates the packing between the assembly residues and its ligands. For each atom within the ligand, it finds every residue within a given distance and scores the orientation of the side chain relative to the ligand atom. Residues where the C-beta C-alpha ligand angle is less than or equal to 45 degrees are favored and given a score of -1. Residues with larger angles are scored with an [[Amber Periodic Function|constraint-file#function-types]], where residues with an angle of 180 degrees are given a score of 0. The scores for each interacting residue are summed and normalized by the number of ligand atoms.

This scorer requires two options: ```weight``` and ```ligand_interaction_cutoff_distance```. A LigandScorer which evaluates all residues within 7 Angstroms of a ligand atom would have the following tag:

```xml
<LigandScorer weight="1" ligand_interaction_cutoff_distance="7" />
```

##See Also
* [[SEWING]] The SEWING home page
* [[AssemblyMover]]
* [[AppendAssemblyMover]]
* [[AssemblyRequirements]]