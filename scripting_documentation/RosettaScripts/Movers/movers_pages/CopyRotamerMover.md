# CopyRotamerMover
*Back to [[Mover|Movers-RosettaScripts]] page.*<br/>
Mover and documentation created 17 October 2016 by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu).

## CopyRotamerMover
### Description and Example
This is a very simple mover that copies the residue identity and/or sidechain conformation from one residue in a pose (the _template_) to another (the _target_).

```xml
<CopyRotamer name="(&string)" template_res_index="(&int)" target_res_index="(&int)" copy_identity="(true &bool)" copy_torsions="(true &bool)" />
```

For example, the following script copies both the side-chain identity and conformation from position 32 to position 45:

```xml
<ROSETTASCRIPTS>
	<MOVERS>
		<CopyRotamer name="copy_rot" template_res_index="32" target_res_index="45" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover="copy_rot" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

Currently, the mover can only copy side-chain torsional degrees of freedom.  Side-chains with non-ideal bond angles and bond lengths do not necessarily have their geometry copied exactly.  If necessary, support can be added for copying bond angle and bond length degrees of freedom.

### Options
|**Option** | **Required input?** | **Description** |
|----|---|---|
| **template_res_index** | YES | The index, in Rosetta pose numbering, of the residue from which the side-chain will be copied. This residue is not altered by this operation. |
| **target_res_index** | YES | The index, in Rosetta pose numbering, of the residue to which the side-chain will be copied.  The identity and/or conformation of this residue's sidechain is altered by this operation. |
| **copy_identity** | NO (defaults to true) | Should the identity of the template residue by copied to the target?  Default true.  If false, only side-chain torsion values will be copied.  This can create strange results if the template and target residues have different numbers of side-chain chi angles, or if they have significantly different side-chain structures. |
| **copy_torsions** | NO (defaults to true) | Should the side-chain dihedral values of the template residue be copied to the target?  Default true. |

##See Also

* [[MutateResidue mover|MutateResidueMover]]
* [[I want to do x]]: Guide to choosing a mover