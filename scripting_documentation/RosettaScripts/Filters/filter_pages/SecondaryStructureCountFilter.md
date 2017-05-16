# SecondaryStructureCount
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SecondaryStructureCount

Counts total number of DSSP-defined secondary structure elements of a given type(s).
WARNING: This filter's report_sm (found in scorefile) is always a dummy "0" value regardless of secondary structure count. The total secstruct counts for each sectruct type are listed in the tracer output.

```
<SecondaryStructureCount name="(&string)" filter_helix_sheet="(1 &bool)" filter_helix="(0 &bool)" filter_sheet="(0 &bool)" filter_loop="(0 &bool)" num_helix=="(0 &int)" num_sheet=="(0 &int)" num_loop=="(0 &int)" min_helix_length="(4 &int)" min_sheet_length="(3 &int)" min_loop_length="(1 &int)" 
```

- filter_helix
- filter_sheet
- filter_loop
- filter_helix_sheet

- num_helix
- num_sheet
- num_loop
- num_helix_sheet

- min_helix_length
- max_helix_length
- min_sheet_length
- max_sheet_length
- min_loop_length
- max_loop_length

filter_helix
filter_sheet
filter_loop
filter_helix_sheet

- return_total
- residue_selector
- min_element_resis

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[HelixKinkFilter]]
* [[HelixPairingFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureHasResidueFilter]]
