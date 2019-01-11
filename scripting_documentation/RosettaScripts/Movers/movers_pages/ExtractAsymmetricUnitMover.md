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
**keep_virtual** - If true, virtual atoms will be left in the pose.  If false, the extracted asymmetric unit will not contain virtual atoms.

**keep_unknown_aas** - If true, amino acids in the input symmetric pose with aa type aa_unk will be included in the asymmetric unit.  If false, amino acids with type aa_unk will be ignored and will not be included in the resulting asymmetric unit.

####Example
This example extracts the asymmetric unit from a symmetric pose, including non-canonical amino acids.
```xml
<ExtractAsymmetricUnit name="extract_asu" keep_unknown_aas="1" />
```

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
