# SecondaryStructureCount
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SecondaryStructureCount

Counts total number of DSSP-defined secondary structure elements of a given type(s).
WARNING: This filter's report_sm (found in scorefile) is always a dummy "0" value regardless of secondary structure count. The total secstruct counts for each sectruct type are listed in the tracer output.

```
<SecondaryStructureCount name="(&string)" filter_helix_sheet="(1 &bool)" filter_helix="(0 &bool)" filter_sheet="(0 &bool)" filter_loop="(0 &bool)" num_helix=="(0 &int)" num_sheet=="(0 &int)" num_loop=="(0 &int)" min_helix_length="(4 &int)" min_sheet_length="(3 &int)" min_loop_length="(1 &int)" 
```

- filter_helix_sheet: filter on sum of helix and sheet?
- (the rest are pretty self-explanatory)

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[HelixKinkFilter]]
* [[HelixPairingFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureHasResidueFilter]]
