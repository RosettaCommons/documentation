# ResidueBurial
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ResidueBurial

How many residues are within an interaction distance of target\_residue across the interface. When used with neighbors=1 this degenerates to just checking whether or not a residue is at the interface.

```xml
<ResidueBurial name="(&string)" res_num/pdb_num="(&string)" distance="(8.0 &Real)" neighbors="(1 &Integer)" task_operations="(&comma-delimited list of taskoperations)" residue_fraction_buried="(0.0001 &Real)"/>
```

-   task\_operations: the task factory will be used to determine what residues are designable. If any of these residues pass the burial threshold, the filter will return true; o/w false. Allows setting the burial filter dynamically at runtime.
-   residue\_fraction\_buried: what fraction of the total residues defined as designable by the taskfactory should actually be buried in order to return false. The default (0.0001) effectively means that 1 suffices. Set to 1.0 if you want all residues to be buried.
-   pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]

## See also

* [[EnergyPerResidueFilter]]
* [[HbondsToResidueFilter]]
* [[ResidueDistanceFilter]]
* [[ResidueIEFilter]]

