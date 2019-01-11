# AddOrRemoveMatchCsts
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddOrRemoveMatchCsts

Add or remove enzyme-design style pairwise (residue-residue) geometric constraints to/from the pose. A cstfile specifies these geometric constraints, which can be supplied in the flags file (-enzdes:cstfile) or in the mover tag (see below).

The "-run:preserve\_header" option should be supplied on the command line to allow the parser to read constraint specifications in the pdb's REMARK lines. (The "-enzdes:parser\_read\_cloud\_pdb" also needs to be specified for the parser to read the matcher's CloudPDB default output format.)

```xml
<AddOrRemoveMatchCsts name="&string" cst_instruction="( 'void', '&string')" cstfile="&string" keep_covalent="(0 &bool)" accept_blocks_missing_header="(0 &bool)" fail_on_constraints_missing="(1 &bool)"/>
```

-   cst\_instruction: 1 of 3 choices - "add\_new" (read from file), "remove", or "add\_pregenerated" (i.e. if enz csts existed at any point previosuly in the protocol add them back)
-   cstfile: name of file to get csts from (can be specified here if one wants to change the constraints, e.g. tighten or relax them, as the pose progresses down a protocol.)
-   keep\_covalent: during removal, keep constraints corresponding to covalent bonds between protein and ligand intact (default=0).
-   accept\_blocks\_missing\_header: allow more blocks in the cstfile than specified in header REMARKs (see enzdes documentation for details, default=0)
-   fail\_on\_constraints\_missing: When removing constraints, raise an error if the constraint blocks do not exist in the pose (default=1).


##See Also

* [[Match constraints file format|match-cstfile-format]]
* [[EnzRepackMinimizeMover]]
* [[Match]]: The match command line application
* [[ConstraintSetMover]] (not for match constraints)
* [[ClearConstraintsMover]] (not for match constraints)
