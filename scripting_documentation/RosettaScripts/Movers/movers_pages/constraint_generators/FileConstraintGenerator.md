# FileConstraintGenerator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FileConstraintGenerator

Generates constraints from a Rosetta constraint file. Constraints generated using this Constraint Generator can be added to the pose using the [[AddConstraintsMover]] and removed using the [[RemoveConstraintsMover]].

```xml
<FileConstraintGenerator name="(&string)" filename="(&string)" />
```

filename: the file containing the constraint data. e.g.,:

    ...
    CoordinateConstraint CA 380 CA 1   27.514  34.934  50.283 HARMONIC 0 1
    CoordinateConstraint CA 381 CA 1   24.211  36.849  50.154 HARMONIC 0 1
    ...

The format for Coordinate constraint files is:
CoordinateConstraint target_res anchor_res x y z function

### Example

This example adds and removes constraints from "my_csts.cst" to the pose using the FileConstraintGenerator.

```xml
<MOVERS>
    <AddConstraints name="add_csts" >
        <FileConstraintGenerator name="gen_my_csts" filename="my_csts.cst" />
    </AddConstraints>
    <RemoveConstraints name="rm_csts" constraint_generators="gen_my_csts" />
</MOVERS>
<PROTOCOLS>
    <Add mover="add_csts" />
    <!-- do things with constraints -->
    <Add mover="rm_csts" />
</PROTOCOLS>
```


##See Also

* [[AddConstraintsMover]]
* [[RemoveConstraintsMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]

