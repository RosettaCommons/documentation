<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Prohibit designing to residue identities that aren't found at that position in any of the listed structures:

```xml
<JointSequence name="(&string;)" use_current="(true &bool;)"
        use_natro="(false &bool;)" chain="(0 &non_negative_integer;)"
        use_chain="(0 &non_negative_integer;)" use_native="(false &bool;)"
        use_starting_as_native="(false &bool;)" filename="(&string;)"
        native="(&string;)" use_fasta="(false &bool;)" />
```

-   **use_current**: Use residue identities from the current structure (input pose to apply() of the taskoperation)
-   **use_natro**: the task operation also adds the rotamers from the native structures (use_native/native) in the rotamer library.
-   **chain**: to which chain to apply, 0 is all chains
-   **use_chain**: given an additional input pdb, such as through in:file:native, which chain should the sequence be derived from. 0 is all chains.
-   **use_native**: Use residue identities from the structure listed with -in:file:native
-   **use_starting_as_native**: use starting pose as native pose
-   **filename**: Use residue identities from the listed file
-   **native**: use this file path as the native pdb
-   **use_fasta**: Use residue identities from a native sequence given by a FASTA file (specify the path to the FASTA file with the -in:file:fasta flag at the command line)

---
