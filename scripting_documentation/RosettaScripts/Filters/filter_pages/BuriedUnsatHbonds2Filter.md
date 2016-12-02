# BuriedUnsatHbonds2 
*Back to [[Filters|Filters-RosettaScripts]] page.*
## BuriedUnsatHbonds2 

(This is a devel filter and not available in the released version.)

<!--- BEGIN_INTERNAL -->

Calculate the number of buried unsatisfied H-bonds across a given interface. (Specifically, the difference in the number of buried unsatisfied hydrogen bonds in the bound state versus the bound state. This uses a different algorithm than the BuriedUnsatHbonds filter above. Specifically (*** fill in details from Kevin's presentation ***)

```
<BuriedUnsatHbonds2 name="(&string)" scorefxn="(&string)" jump_number="(1 &Size)" cutoff="(20 &Size)" layered_sasa="(1 &bool)" generous_hbonds="(1 &bool)" sasa_burial_cutoff="(0.01 &Real)" AHD_cutoff="(120.0 &Real)" dist_cutoff="(3.0 &Real)" hxl_dist_cutoff="(3.5 &Real)" sulph_dist_cutoff="(3.3 &Real)" metal_dist_cutoff="(2.7 &Real)" task_operations="(&string)" />
```

* scorefxn - The scorefunction to use to evaluate hydrogen bonding energy.
* task_operations - If set, will calculate hydrogen just for residues set to be designable or packable in the task operations.
* jump_number - The jump which describes the interface across which to calculate the number of hydrogen bonds. If jump_number=0, will compute the total number of unburied hbonds for entire structure.
* cutoff - Filter is true if the number of unsatisfied hbonds is less than or equal to cutoff.
* layered_sasa - ??? 
* generous_hbonds - If true, use a generous definition of hydrogen bonds. (Includes more bb-involved hydrogen bonds, and turns off environmental dependent scoring.) 
* sasa_burial_cutoff - ???
* AHD_cutoff - Minimum accpetor-hydrogen-donor angle needed for regular hydrogen bonds.
* dist_cutoff - Distance cutoff for regular hydrogen bonds
* hxl_dist_cutoff - The distance cutoff for hydrogen bonds to hydroxyls.
* sulph_dist_cutoff - The distance cutoff for hydrogen bonds to sulfur.
* metal_dist_cutoff - The distance cutoff for "hydrogen bonds" to metals.

## See Also

* [[BuriedUnsatHbondsFilter]]

<!--- END_INTERNAL -->

