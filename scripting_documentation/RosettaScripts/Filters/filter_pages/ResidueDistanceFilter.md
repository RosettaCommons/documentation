# ResidueDistance
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ResidueDistance

What is the distance between two residues? Based on each residue's neighbor atom (usually Cbeta)

```xml
<ResidueDistance name="(&string)" res1_res_num="(&string)" res1_pdb_num="(&string)" res2_res_num="(&string)" res2_pdb_num="(&string)" distance="(8.0 &Real)"/>
```

Either \*res\_num or \*pdb\_num may be specified for res1 and res2. See [[RosettaScripts#rosettascripts-conventions_specifying-residues]] .

## See Also

* [[AtomicContactCountFilter]]
* [[AtomicContactFilter]]
* [[AtomicDistanceFilter]]
* [[EnergyPerResidueFilter]]
* [[HbondsToResidueFilter]]
* [[ResidueBurialFilter]]
* [[ResidueCountFilter]]
* [[ResidueIEFilter]]
* [[TerminusDistanceFilter]]

