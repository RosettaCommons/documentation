# AddResidueLabelMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddResidueLabelMover

Adds PDBInfoLabel to your pose based on a residue_selector selection.

The mover will print out verbose the residues it labeled. Also includes a Pymol compatible string selection; it can be used to troubleshoot which residues your residue_selector is selecting.

Notes:
* Certain Movers such as symmetrizing via [[SymDofMover|SymDofMover]] will wipe all labels from your pose. If you need to use PDBInfoLabel, make sure you label them after you symmetrize.
* If your pose is symmetric, it will only label the asymmetric unit (asu). If you want to label all symmetrical copies, you can use [[SymmetricalResidueSelector|ResidueSelectors]] to symmetrize your selection.

```xml
<AddResidueLabel name="&string" residue_selector="&string" label="&string" />
```
Usage:

**residue_selector** - a residue_selector selection of residues to label

**label** - string label that will be attached

##See Also
* [[I want to do x]]: Guide to choosing a mover
