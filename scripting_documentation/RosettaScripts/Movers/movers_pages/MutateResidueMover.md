# MutateResidue
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MutateResidue

Change a single residue to a different type. For instance, mutate Arg31 to an Asp.

```
<MutateResidue name=(&string) target=(&string) new_res=(&string) preserve_atom_coords=(false &bool) />
```

-   target: The location to mutate.  This can be a PDB number (<i>e.g.</i> ```31A```), a Rosetta index (<i>e.g.</i> ```177```), or an index in a reference pose or snapshot stored at a point in a protocol before residue numbering changed in some way (<i>e.g.</i> ```refpose(snapshot1,23)```).  See the convention on residue indices in the **[[RosettaScripts Conventions]]** documentation for details.
-   new\_res: The name of the residue to introduce. This string should correspond to the ResidueType::name() function (eg ASP). *Required*
-   preserve\_atom\_coords: If true, then atoms in the new residue that have names matching atoms in the old residue will be placed at the coordinates of the atoms in the old residue, with other atoms rebuilt based on ideal coordinates.  If false, then only the mainchain heavyatoms are placed based on the old atom's mainchain heavyatoms; the sidechain is built from ideal coordinates, and sidechain torsion values are then set to the sidechain torsion values from the old residue.  False if unspecified.


