# CycpepSymmetryFilter
Created by Vikram K. Mulligan (vmullig@uw.edu) on 2 December 2016.<br/>
*Back to [[Filters|Filters-RosettaScripts]] page.*

## CycpepSymmetryFilter

[[_TOC_]]

### Description

This filter examines a cyclic peptide backbone and determines whether it has cyclic symmetry matching a user-specified symmetry (within some threshold of error -- the backbone needn't be _perfectly_ symmetric).  It works with c2, c3, c4, _etc._ symmetries, as well as with c2/m, c4/m, c6/m, _etc._ symmetries.  Failure indicates that the peptide does _not_ have the desired symmetry.  The peptide in question can be built from any combination fo L- and D-alpha , beta, or gamma amino acids, L- and D-oligoureas, or peptoids.

### Algorithm

The filter first checks that the pose, or the selected residues, are truly a cyclic peptide.  It then loops through the first 1/Nth of the peptide (where N is the number of symmetry repeats specified by the user in the cN symmetry) and compares each residue with the corresponding residues in subsequent repeats, checking each mainchain torsion value to see whether it matches, within a threshold.  In the case of mirror symmetry, it inverts torsion values in every second symmetry repeat before carrying out the check.  Note that only backbone symmetry is considered; side-chains are disregarded.

### Example script

The following script imports an eight-residue cyclic peptide, uses the [[DeclareBond mover|DeclareBond]] to set up a terminal peptide bond linking the ends, and filters based on whether the peptide has c2/m symmetry:

```xml
<ROSETTASCRIPTS>
	<FILTERS>
		<CycpepSymmetryFilter name="symmfilter" symmetry_repeats="2" mirror_symmetry="true" />
	</FILTERS>
	<MOVERS>
		<DeclareBond name="bond1" res1="8" atom1="C" res2="1" atom2="N" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover="bond1" />
		<Add filter="symmfilter" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

### Full options list

```xml
<CycpepSymmetryFilter name=(&string) symmetry_repeats=(2 &int) mirror_symmetry=(false &bool) angle_threshold=(10.0 &float) residue_selector=(&string) />
```

|Option|Type|Required?|Description|
|---|---|---|---|
|name|string|YES|A unique identifier given to this filter, used to refer to it later in the script.|
|symmetry_repeats|integer|No|The number of repeats in this type of symmetry.  For example, for c3 symmetry, one would provide "3" as input.  Defaults to 2 (for c2 symmetry).|
|mirror_symmetry|boolean|No|Is this a type of cyclic symmetry with mirror operations, such as c2/m, c4/m, or c6/m symmetry?  If true, symmetry_repeats must be a multiple of 2.  Defaults to false (for c2 symmetry -- i.e. not c2/m symmetry).|
|angle_threshold|float|No|The cutoff, in degrees, for the difference between two dihedral angles before they are considered \"different\" angles.  This is used when comparing mainchain torsion values of differet residues.  Defaults to 10.0 degrees.|
|residue_selector|string|No|An optional residue selector set to select the residues of the cyclic peptide in poses containing more geometry than just the cyclic peptide.  If not provided, the whole pose is used.|

### See also
- [[GeneralizedKIC|GeneralizedKICMover]]
