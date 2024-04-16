# ExtractAsymmetricUnit
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ExtractAsymmetricUnit

The inverse of SetupForSymmetry: given a symmetric pose, make a nonsymmetric pose that contains only the asymmetric unit.

For historical reasons, the pose returned by this mover will include virtual atoms that are added by the SetupForSymmetry mover, and will not include amino acids of type aa_unk (e.g. non-canonical amino acids, ligands, etc).  This behavior can be controlled using the options below.

####Usage
```xml
<ExtractAsymmetricUnit name="(&string)"
    keep_virtual="(&bool, true)"
    keep_unknown_aas="(&bool, false)" />
```

####Options

[[include:mover_ExtractAsymmetricUnit_type]]

##See Also

* [[ExtractAsymmetricPoseMover]]
* [[ExtractSubposeMover]]
* [[ExtractAsymmetricUnitMover]]
* [[CutOutDomainMover]]
* [[Symmetry]]: Using symmetry in Rosetta
* [[SymmetryAndRosettaScripts]]
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
