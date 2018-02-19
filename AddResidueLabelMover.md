# AddResidueLabelMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddResidueLabelMover

Adds PDBInfoLabel to your pose based on a residue_selector selection.

Notes:
* Certain Movers such as symmetrizing via [[SymDofMover|SymDofMover]] will wipe all labels from your pose.

```xml
<AddResidueLabel name="&string" residue_selector="&string" label="&string" />
```
Usage:

**residue_selector** - a residue_selector selection of residues to label

**label** - string label that will be attached

##See Also
* [[I want to do x]]: Guide to choosing a mover
