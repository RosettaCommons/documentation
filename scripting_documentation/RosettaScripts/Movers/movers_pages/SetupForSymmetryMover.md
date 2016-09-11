# SetupForSymmetry
*Back to [[Mover|Movers-RosettaScripts]] page.*
Page last updated 19 August 2016.

## SetupForSymmetry

Given a symmetry definition file that describes configuration and scoring of a symmetric system, this mover "symmetrizes" an asymmetric pose.

####Usage
```
<SetupForSymmetry name=(&string) definition=(&string) preserve_datacache=(&bool, false) />
```

####Options
**definition** - The filename for a symmetry definition file.
**preserve_datacache** - If true, the datacache from the input asymmetric pose will be copied into the new symmetric pose. If false, the pose datacache will be cleared.  Default is false for historical reasons.

####Example
Given the symmetry definition file 'C2.symm':
```
<SetupForSymmetry name="setup_symm" definition="C2.symm" preserve_datacache="0" />
```

##See Also

* [[Symmetry]]: Using symmetry in Rosetta
* [[SymmetryAndRosettaScripts]]
* [[SetupNCSMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[DetectSymmetryMover]]
* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
