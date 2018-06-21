# SetupForSymmetry
*Back to [[Mover|Movers-RosettaScripts]] page.*
Page last updated 9 April 2018.

[[include:mover_SetupForSymmetry_type]]

####The `set_global_symmetry_at_parsetime` option
For historical reasons, many protocols require symmetry to be set as a global option during script parsing.  This is potentially dangerous, because symmetry is set throughout the protocol regardless of when `SetupForSymmetry` mover is applied.

If your protocol is producing unexpected results or symmetry-related error messages, try setting `set_global_symmetry_at_parsetime=0`, which disables setting the global option.  If you have set `set_global_symmetry_at_parsetime=0` and Rosetta complains that you are dealing with an asymmetric pose or similar error, try setting `set_global_symmetry_at_parsetime=1` to enable setting the global option.

For backwards compatibility, `set_global_symmetry_at_parsetime=1` is currently the default.

A best practice could be to `set_global_symmetry_at_parsetime=0` and see if your protocols runs as expected without errors.  If so, great.  If not, `set_global_symmetry_at_parsetime=1` and see if that fixes it (in which case something is relying on the global setting).

####Example
Given the symmetry definition file 'C2.symm':
```xml
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
