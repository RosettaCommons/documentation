# NeighborType
*Back to [[Filters|Filters-RosettaScripts]] page.*
## NeighborType

Filter for poses that place a neighbour of the types specified around a target residue in the partner protein.

```xml
<NeighborType name="(neighbor_filter &string)" res_num/pdb_num="(&string)" distance="(8.0 &Real)">
        <Neighbor type="(&3-letter aa code)"/>
</NeighborType>
```

-   pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]

## See also:

* [[Docking applications|docking-applications]]
* [[Task Operations|TaskOperations-RosettaScripts]]
* [[ResidueDistanceFilter]]
* [[AtomicContactFilter]]
* [[AtomicContactCountFilter]]
* [[AtomicDistanceFilter]]
* [[TerminusDistanceFilter]]
