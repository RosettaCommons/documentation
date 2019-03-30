# ConstraintSetMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ConstraintSetMover

Adds or replaces constraints in the pose using the constraints' read-from-file functionality.

```xml
<ConstraintSetMover name="(&string)" add_constraints="(false &bool)" cst_file="(&string)"/>
```

cst\_file: the file containing the constraint data. e.g.,:

    ...
    CoordinateConstraint CA 380 CA 1   27.514  34.934  50.283 HARMONIC 0 1
    CoordinateConstraint CA 381 CA 1   24.211  36.849  50.154 HARMONIC 0 1
    ...
The format for Coordinate constraint files is:
CoordinateConstraint target_res anchor_res x y z function

To remove constraints from the pose create a mover with cst\_file=none.

-  add_constraints: if set to true, the constraints will be added to the current pose, otherwise, the constraints read from the disk will replace the current constraints in the pose. (this is tricky and confusing so beware!)


##See Also

* [[TaskAwareCstsMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[ClearConstraintsMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
