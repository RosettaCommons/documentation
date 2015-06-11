# SetupForSymmetry
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetupForSymmetry

Given a symmetry definition file that describes configuration and scoring of a symmetric system, this mover "symmetrizes" an asymmetric pose. For example, given the symmetry definition file 'C2.symm':

```
<SetupForSymmetry name=setup_symm definition=C2.symm/>
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
