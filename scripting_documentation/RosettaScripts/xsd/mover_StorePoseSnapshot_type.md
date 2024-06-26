<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Rosetta's sequential residue numbering can create headaches in protocols in which residues are to be inserted or deleted, and in which one wishes subsequently to refer to residues past the insertion or deletion point. The StorePoseSnapshot mover is intended as a means of permitting a user to store a named snapshot or "reference pose" at a particular point in a protocol, then use the residue numbering of the pose at that point in the protocol for movers and filters that might be applied sometime later, after pose indices may have been altered by insertions or deletions.

```xml
<StorePoseSnapshot name="(&string;)" reference_pose_name="(&string;)"
        override_current="(&bool;)" />
```

-   **reference_pose_name**: (REQUIRED) The name of the snapshot or reference pose object. Many different snapshots may be stored (by applying different StorePoseSnapshot movers at different points in the protocol), and may subsequently be referred to by different names
-   **override_current**: If there already exists a reference pose, overwrite it.

---
