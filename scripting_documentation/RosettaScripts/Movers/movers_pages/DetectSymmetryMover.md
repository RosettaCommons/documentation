# DetectSymmetry
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DetectSymmetry

This mover takes a non-symmetric pose composed of symmetric chains and transforms it into a symmetric system. It only works with cyclic symmetries from C2 to C99.

```xml
<DetectSymmetry name="detect" subunit_tolerance"(&real 0.01)" plane_tolerance="(&real 0.001)"/>
```

subunit\_tolerance: maximum tolerated CA-rmsd between the chains. plane\_tolerance: maximum accepted displacement(angstroms) of the center of mass of the whole pose from the xy-plane.


##See Also

* [[Symmetry]]: Using symmetry in Rosetta
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
* [[SymmetryAndRosettaScripts]]
