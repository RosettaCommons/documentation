# MutateResidue
## MutateResidue

Change a single residue to a different type. For instance, mutate Arg31 to an Asp.

```
<MutateResidue name=(&string) target=(&string) new_res=(&string) preserve_atom_coords=(false &bool) />
```

-   target: The location to mutate (eg 31A (pdb number) or 177 (rosetta index)). *Required*
-   new\_res: The name of the residue to introduce. This string should correspond to the ResidueType::name() function (eg ASP). *Required*
-   preserve\_atom\_coords: If true, then atoms in the new residue that have names matching atoms in the old residue will be placed at the coordinates of the atoms in the old residue, with other atoms rebuilt based on ideal coordinates.  If false, then only the mainchain heavyatoms are placed based on the old atom's mainchain heavyatoms; the sidechain is built from ideal coordinates, and sidechain torsion values are then set to the sidechain torsion values from the old residue.  False if unspecified.


