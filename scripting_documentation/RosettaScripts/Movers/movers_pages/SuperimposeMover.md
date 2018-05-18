# Superimpose
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Superimpose

Superimpose current pose on a pose from disk. Useful for returning to a common coordinate system after, e.g., torsion moves.

```xml
<Superimpose name="(&string)" ref_start="(1 &Integer)" ref_end="(0 &Integer)" target_start="(1 &Integer)" target_end="(0 &Integer)" ref_pose="(see below &string)" CA_only="(1 &integer)"/> 
```
-   CA\_only, Superimpose CA only or BB atoms (N,C,CA,O).  Defaults True.
-   ref\_start, target\_start: start of segment to align. Accepts only rosetta numbering.
-   ref\_end, target\_end: end of segment to align. If 0, defaults to number of residues in the pose.
-   ref\_pose: the file name of the reference structure to align to. Defaults to the commandline option -in:file:native, if no pose is specified.
-   Requires all PDB files to have the same chain id. On ``bash``, the ``sed`` command can be used to quickly alter all chain IDs: ``$ sed -i 's/ B / A /'`` Changes all B chains to A chains and overwrites original PDB file. Remove ``-i`` and pipe into a new PDB file if you do not wish to overwrite.  


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[AlignChainMover]]
* [[ExtractSubposeMover]]
