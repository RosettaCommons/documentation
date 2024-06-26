<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<Prepack name="(&string;)" scorefxn="(&string;)"
        jump_number="(1 &non_negative_integer;)"
        task_operations="(&task_operation_comma_separated_list;)"
        packer_palette="(&named_packer_palette;)" min_bb="(0 &bool;)" >
    <MoveMap name="(&string;)" bb="(&bool;)" chi="(&bool;)" jump="(&bool;)" >
        <Jump number="(&non_negative_integer;)" setting="(&bool;)" />
        <Chain number="(&non_negative_integer;)" chi="(&bool;)" bb="(&bool;)" />
        <Span begin="(&non_negative_integer;)" end="(&non_negative_integer;)"
                chi="(&bool;)" bb="(&bool;)" bondangle="(&bool;)" bondlength="(&bool;)" />
        <ResidueSelector selector="(&string;)" chi="(&bool;)" bb="(&bool;)"
                bondangle="(&bool;)" bondlength="(&bool;)" />
    </MoveMap>
</Prepack>
```

-   **scorefxn**: Name of score function to use
-   **jump_number**: Number of the jump interface to prepack
-   **task_operations**: A comma-separated list of TaskOperations to use.
-   **packer_palette**: A previously-defined PackerPalette to use, which specifies the set of residue types with which to design (to be pruned with TaskOperations).
-   **min_bb**: Minimize the backbone


Subtag **MoveMap**:   MoveMap specification

-   **bb**: move backbone torsions?
-   **chi**: move sidechain chi torsions?
-   **jump**: move all jumps?


Subtag **Jump**:   jumps are the not-chemistry internal coordinate connections between separate parts of your pose

-   **number**: (REQUIRED) Which jump number (in the FoldTree)
-   **setting**: (REQUIRED) true for move, false for don't move

Subtag **Chain**:   this controls a kinematically contiguous chain (think protein chains)

-   **number**: (REQUIRED) which chain?
-   **chi**: (REQUIRED) move sidechain chi torsions?
-   **bb**: (REQUIRED) move backbone torsions?

Subtag **Span**:   XRW TO DO, probably a user-defined region of the Pose

-   **begin**: (REQUIRED) beginning of span
-   **end**: (REQUIRED) end of span
-   **chi**: (REQUIRED) move sidechain chi torsions?
-   **bb**: (REQUIRED) move backbone torsions?
-   **bondangle**: move 3-body angles?
-   **bondlength**: move 2-body lengths?

Subtag **ResidueSelector**:   Residue selector defined region of the Pose.

-   **selector**: (REQUIRED) Residue selector
-   **chi**: (REQUIRED) move sidechain chi torsions?
-   **bb**: (REQUIRED) move backbone torsions?
-   **bondangle**: move 3-body angles?
-   **bondlength**: move 2-body lengths?

---
