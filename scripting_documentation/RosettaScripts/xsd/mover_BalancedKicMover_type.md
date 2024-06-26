<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Performs kinematic closure moves with detailed balance along two pivot atoms

```xml
<BalancedKicMover name="(&string;)" pivot_residues="(&string;)"
        preserve_detailed_balance="(false &bool;)" residue_selector="(&string;)" >
    <MoveMap name="(&string;)" bb="(&bool;)" chi="(&bool;)" jump="(&bool;)" >
        <Jump number="(&non_negative_integer;)" setting="(&bool;)" />
        <Chain number="(&non_negative_integer;)" chi="(&bool;)" bb="(&bool;)" />
        <Span begin="(&non_negative_integer;)" end="(&non_negative_integer;)"
                chi="(&bool;)" bb="(&bool;)" bondangle="(&bool;)" bondlength="(&bool;)" />
        <ResidueSelector selector="(&string;)" chi="(&bool;)" bb="(&bool;)"
                bondangle="(&bool;)" bondlength="(&bool;)" />
    </MoveMap>
</BalancedKicMover>
```

-   **pivot_residues**: residues for which contiguous stretches can contain segments (comma separated) can use PDB numbers ([resnum][chain]) or absolute Rosetta numbers (integer). Note that this feature has not been implemented yet.
-   **preserve_detailed_balance**: if set to true, does not change branching atom angles during apply and sets ideal branch angles during initialization if used with MetropolisHastings. Note that this feature has not been implemented yet.
-   **residue_selector**: Pre-defined residue_selector. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.


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
