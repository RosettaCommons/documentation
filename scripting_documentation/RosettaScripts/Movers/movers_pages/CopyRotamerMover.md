# CopyRotamerMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
Mover and documentation created 17 October 2016 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).

## CopyRotamerMover
This is a very simple mover that copies the residue identity and/or sidechain conformation from one position (the _template_) to another (the _target_).

```
<CopyRotamer name=(&string) template_res_index=(&int) target_res_index=(&int) copy_identity=(true &bool) copy_torsions=(true &bool) />
```

## Options
|*Option* | *Required input?* | *Description* |
|----|---|---|
| *template_res_index* | YES | The index, in Rosetta pose numbering, of the residue from which the side-chain will be copied. This residue is not altered by this operation. |
| *target_res_index* | YES | The index, in Rosetta pose numbering, of the residue to which the side-chain will be copied.  The identity and/or conformation of this residue's sidechain is altered by this operation. |
| *copy_identity* | NO | Should the identity of the template residue by copied to the target?  Default true.  If false, only side-chain torsion values will be copied.  This can create strange results if the template and target residues have different numbers of side-chain chi angles, or if they have significantly different side-chain structures. |
| *copy_torsions* | NO | Should the side-chain dihedral values of the template residue be copied to the target?  Default true. |

##See Also

* [[MutateResidue mover|MutateResidueMover]]
* [[I want to do x]]: Guide to choosing a mover