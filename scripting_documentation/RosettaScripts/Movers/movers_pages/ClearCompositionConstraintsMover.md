# ClearCompositionConstraintsMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ClearCompositionConstraintsMover

Remove any sequence constraints from the pose.

```
<ClearCompositionConstraintsMover name="(&string)" />
```

Note that this will remove sequence constraints (e.g. amino acid composition constraints) but **not** geometric constraints (e.g. atom pair constraints, coordinate constraints) from the pose.


##See Also

* [[AddCompositionConstraintMover]]
* [[AACompositionEnergy]]
* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]