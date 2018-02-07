# NtoCConstraintGenerator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## NtoCConstraintGenerator

Generates, adds, or replaces constraints in the pose between the N- and C- terminal residues.

```xml
<NtoCConstraintGenerator name="(&string)" dist="(&float 11.0)" weight="(&float 1.0)" />
```

dist: Distance to be used for atom pair constraints
weight: Scalar weight used in atom pair constraints

Constraints generated using this mover can be removed from the pose using the RemoveCsts mover.

##See Also

* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]
* [[FileConstraintGenerator]]
