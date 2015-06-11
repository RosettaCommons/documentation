# RestrictIdentitiesAtAlignedPositions
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictIdentitiesAtAlignedPositions

Restricts user-specified positions, which are aligned with positions in a source-pdb, to the identities observed in the source pdb. Can be used to revert pre-specified residues to their identities in a wild-type progenitor. Can also be used to modify a task factory to only consider the identities in the source pdb for the target positions (while not changing the packer task for other positions). Note that the pose and the source pose must be aligned for this to work. Residues that have no aligned residue on the target pdb are ignored.

-   source\_pdb: the pdb from which the identities will be derived
-   resnums: the residue numbers in the source\_pdb(!) that need to be derived
-   chain (default 1 &integer): which chain on the target pdb are we looking for aligned residues?
-   design\_only\_target\_residues (default 0 &bool): if true, designs the target residues to the identities in source while repacking a 6A shell around each residue. If false, only restricts the allowed identities at the target residues, not impacting other residues.
-   prevent\_repacking
* repack_shell - change the repack shell, default is 6.0
* design_shell - change the design shell, default is 0.01

