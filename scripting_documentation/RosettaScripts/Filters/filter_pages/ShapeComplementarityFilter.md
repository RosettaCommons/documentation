# ShapeComplementarity
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ShapeComplementarity

Calculates the Lawrence & Coleman shape complementarity using a port of the original Fortran code from CCP4's sc. Symmetry aware. Can be calculated across a jump (default behavior) or the two surfaces can be specified by explicitly providing lists of the residues making up each surface.

Should work with *most* ligands via Lucas Nivon's recent commit.

Set write\_int\_area to add the SC interface area to the scorefile. Use sym\_dof\_name instead of jump for multicomponent symmetries.

```xml
<ShapeComplementarity name="(&string)" min_sc="(0.5 &Real)" min_interface="(0 &Real)" verbose="(0 &bool)" quick="(0 &bool)" jump="(1 &int)" sym_dof_name="('' &string)" residues1="(comma-separated list)" residues2="(comma-separated list)" residue_selector1="('' &string)" residue_selector2="('' &string)" write_int_area="(1 &bool)" write_median_dist="(0 &bool)" max_median_dist="(1000 &Real)"/>
```

* min_sc - The filter fails if the calculated sc is less than the given value.
* min_interface - The filter fails is the calculated interface area is less than the given value
* verbose - If true, print extra calculation details to the tracer
* quick - If true, do a quicker, less accurate calculation by reducing the density. 
* jump - For non-symmetric poses, which jump over which to calculate the interface.
* sym_dof_name - For symmetric poses, which dof over which to calculate the interface.
* residues1 & residues2 - Explicitly set which residues are on each side of the interface (both symmetric and non-symmetric poses.)
* residue_selector1 & residue_selector2 - Explicitly set which residues are on each side of the interface using residue_selectors.
* write_int_area - If true, write interface area to scorefile.
* write_median_dist - If true, write interface median distance to scorefile.
* max_median_dist - The filter fails is the calculated median distance between the molecular surfaces is greater than the given value.

## See Also:

* [[Protein-protein docking|docking-protocol]]
* [[CavityVolumeFilter]]
* [[InterfaceHolesFilter]]
* [[SSShapeComplementarityFilter]]
* [[ExposedHydrophobicsFilter]]
* [[ResInInterfaceFilter]]
* [[SpecificResiduesNearInterfaceFilter]]

