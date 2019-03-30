# ExtractAsymmetricPose
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ExtractAsymmetricPose

Similar to ExtractAsymmetricUnit: given a symmetric pose, make a nonsymmetric pose that contains the entire system (all monomers). Can be used to run symmetric and asymmetric moves in the same trajectory.

####Usage
```xml
<ExtractAsymmetricPose name="extract_asp" clear_sym_def="(&bool, false)"/>
```

####Options
**clear_sym_def** - If true, the option tag symmetry_definition will be cleared. This is required usually for downstream repacking/minimization after a symmetry is removed.

##See Also

* [[ExtractAsymmetricUnitMover]]
* [[ExtractSubposeMover]]
* [[CutOutDomainMover]]
* [[SetupForSymmetryMover]]
* [[Symmetry]]: Using symmetry in Rosetta
* [[SymmetryAndRosettaScripts]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
