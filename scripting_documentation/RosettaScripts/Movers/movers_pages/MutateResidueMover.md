# MutateResidue
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MutateResidue
Updated by Parisa Hosseinzadeh (parisah@uw.edu) 30 November 2016.
Updated by Vikram K. Mulligan (vmullig@uw.edu) 6 April 2017.

Change a single residue or a subset of residues to a different type. For instance, mutate Arg31 to an Asp or mutate all Pro to Ala.

```xml
<MutateResidue name="(&string)" target="(&string)" new_res="(&string)" preserve_atom_coords="(false &bool)" mutate_self="(false &bool)" update_polymer_bond_dependent="(false &bool)" />
```

or

```xml
<MutateResidue name="(&string)" residue_selector="(&string)" new_res="(&string)" preserve_atom_coords="(false &bool)" mutate_self="(false &bool)" />
```

-   target: The location to mutate.  This can be a PDB number (<i>e.g.</i> ```31A```), a Rosetta index (<i>e.g.</i> ```177```), or an index in a reference pose or snapshot stored at a point in a protocol before residue numbering changed in some way (<i>e.g.</i> ```refpose(snapshot1,23)```).  See the convention on residue indices in the **[[RosettaScripts Conventions]]** documentation for details.
- residue_selector: Defines the subset of residues that should be mutated. See the **[[ResidueSelectors]]** section for more info.
-   new\_res: The name of the residue to introduce. This string should correspond to the ResidueType::name() function (eg ASP). *Required*
-   preserve\_atom\_coords: If true, then atoms in the new residue that have names matching atoms in the old residue will be placed at the coordinates of the atoms in the old residue, with other atoms rebuilt based on ideal coordinates.  If false, then only the mainchain heavyatoms are placed based on the old atom's mainchain heavyatoms; the sidechain is built from ideal coordinates, and sidechain torsion values are then set to the sidechain torsion values from the old residue.  False if unspecified.
-   mutate\_self: If true, will mutate the selected residue to itself, regardless of what new\_res is set to (although new\_res is still required). This is useful to "clean" residues when there are Rosetta residue incompatibilities (such as terminal residues) with movers and filters.
-   update_polymer_bond_dependent:  If true, this will update the coordinates of atoms that depend on polymer bonds (like the carbonyl oxygen, the amide proton, or the methyl group in N-methyl amino acids).  False by default (atom coordinates are preserved if possible through the mutation).

*NOTE:* you can use either a target option or a residue_selector option but not both.
