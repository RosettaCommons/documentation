# SetTorsion
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetTorsion

Sets a given torsion to a specified value.  This mover can also be used to randomize a torsion (set it to an entirely random value), to randomize mainchain torsions of alpha-amino acids biased by the Ramachandran map, or to perturb a torsion (add a small random value to its initial value).

```xml
<SetTorsion name="&string" foldtree_root="(&int)">
     <Torsion residue="(&pdb/rosetta numbering)" torsion_name="(&string)" angle="(&string)" perturbation_type="(&string)" perturbation_magnitude="(&real)" />
     <Torsion residue="pick_atoms" torsion_name="(&string)" angle="(&string)" perturbation_type="(&string)" perturbation_magnitude="(&real)" >
          <Atom1 residue="(pdb/rosetta numbering)" atom="(&string)" />
          <Atom2 residue="(pdb/rosetta numbering)" atom="(&string)" />
          <Atom3 residue="(pdb/rosetta numbering)" atom="(&string)" />
          <Atom4 residue="(pdb/rosetta numbering)" atom="(&string)" />
     </Torsion>
</SetTorsion>
```
One or more torsions can be specified with ```<Torsion>``` blocks.  Torsions can be identified by name or by specifying four atoms in sub-tags.  Options include:

- **foldtree_root**: If specified, the chain is temporarily rerooted on the given residue.  This is convenient for preventing unwanted chain motions.  The FoldTree is reset to that of the input pose after altering torsions.  Optional.
-   **torsion_name**: "phi","psi", "omega", or "rama" (which sets both phi and psi) for alpha-amino acids; "phi", "theta", "psi", or "omega" for beta-amino acids.  Must be specified, unless picking by atoms.
-  **residue**: A residue number.  If ```"pick_atoms"``` is specified within a ```<Torsion>``` block, the torsion can be selected using ```<Atom#.../>``` sub-tags.  Alternatively, this may be set to "ALL", in which case the selected torsion is set in all residues.
- **angle**: The value (in degrees) to which the torsion will be set, if a number is provided as input here.  Alternatively, the user may specify "random", in which case the torsion is randomized completely, or "perturb", in which case a small random value is added to the current value of the torsion.  Finally, if ```torsion_name="rama"``` is used with an alpha-amino acid, the user may specify ```angle="rama_biased"```, in which case both phi and psi are randomized biased by the Ramachandran map for that amino acid type.  If the ```angle="rama_biased"``` option is used, the user may optionally specify a custom Ramachandran map to use for sampling with the ```custom_rama_table=\<string\>``` option.  Currently-supported Ramachandran maps include flat_l_aa_ramatable, flat_d_aa_ramatable, flat_symm_dl_aa_ramatable, flat_symm_gly_ramatable, flat_symm_pro_ramatable, flat_l_aa_ramatable_stringent, flat_d_aa_ramatable_stringent, flat_symm_dl_aa_ramatable_stringent, flat_symm_gly_ramatable_stringent, and flat_symm_pro_ramatable_stringent.
- **perturbation_type**:  If ```angle="perturb"``` is used, this determines how the small random value that's added to the current angle is chosen.  The current options are ```"uniform"``` and ```"gaussian"```.  Defaults to ```"gaussian"``` if not specified.
- **perturbation_magnitude**: If ```angle="perturb"``` is used, this determines the size of the perturbation.  Defaults to 1.0 if not specified.


##See Also

* [[SmallMover]]
* [[ShearMover]]
* [[SetTemperatureFactorMover]]
* [[SetSecStructEnergiesMover]]
* [[I want to do x]]: Guide to choosing a mover
