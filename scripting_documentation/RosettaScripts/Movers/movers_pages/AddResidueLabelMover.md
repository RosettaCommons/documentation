# AddResidueLabelMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddResidueLabelMover

[[include:mover_AddResidueLabel_type]]

Adds PDBInfoLabel to your pose based on a residue_selector selection.

The mover will print out verbose the residues it labeled. Also includes a Pymol compatible string selection; it can be used to troubleshoot which residues your residue_selector is selecting.

Notes:
* Certain Movers such as symmetrizing via [[SymDofMover|SymDofMover]] will wipe all labels from your pose. If you need to use PDBInfoLabel, make sure you label them after you symmetrize. However [[SetupForSymmetryMover|SetupForSymmetryMover]] and [[ExtractAsymmetricUnitMover|ExtractAsymmetricUnitMover]] preserve PDB info labels.
* If your pose is symmetric, it will only label the asymmetric unit (asu). If you want to label all symmetrical copies, you can use [[SymmetricalResidueSelector|ResidueSelectors]] to symmetrize your selection.


##See Also

* [[LabelPoseFromResidueSelectorMover]]: A mover to add labels as remarks
* [[I want to do x]]: Guide to choosing a mover
