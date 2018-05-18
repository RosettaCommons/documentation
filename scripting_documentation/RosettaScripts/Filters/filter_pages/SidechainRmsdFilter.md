# SidechainRmsd
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SidechainRmsd

Calculates the all atom RMSD for a single residue, either with or without the backbone atoms. The RMSD calculated is the automorphic RMSD, so it will compensate for symmetric rearrangments. (For example, Phe ring flips.) No superposition is performed prior to rmsd calculation.

```xml
<SidechainRmsd name="(&string)" res1_(res/pdb)_num="(&string)" res2_(res/pdb)_num="(&string)" reference_name="(&string)" include_backbone="(0 &bool)" threshold="(1.0 &real)" />
```

-   res1\_(pdb/res)\_num: The residue number for the active pose. see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]
-   res2\_(pdb/res)\_num: The residue number for the reference pose. see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]
-   reference\_name: The name of the reference pose as saved with the [[SavePoseMover|Movers-RosettaScripts#SavePoseMover]] . If not given, will default to the structure passed to -in:file:native if it set, or the input structure, if not.
-   include\_backbone: Whether to include the backbone in the RMSD calculation. (It is recommended to set this to "true" for ligands and other residues which don't have a backbone.)
-   threshold: In a truth value context, what's the maximum RMSD value which is considered to be passing.

## See also

* [[RmsdFilter]]
* [[IRmsdFilter]]
