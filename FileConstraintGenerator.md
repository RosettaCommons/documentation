# FileConstraintGenerator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FileConstraintGenerator

Generates, adds, or replaces constraints in the pose using a Rosetta constraint file.

```
<FileConstraintGenerator name=(&string) filename=(&string) />
```

filename: the file containing the constraint data. e.g.,:

    ...
    CoordinateConstraint CA 380 CA 1   27.514  34.934  50.283 HARMONIC 0 1
    CoordinateConstraint CA 381 CA 1   24.211  36.849  50.154 HARMONIC 0 1
    ...

The format for Coordinate constraint files is:
CoordinateConstraint target_res anchor_res x y z function

Constraints generated using this mover can be removed from the pose using the RemoveCsts mover.

##See Also

* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]

