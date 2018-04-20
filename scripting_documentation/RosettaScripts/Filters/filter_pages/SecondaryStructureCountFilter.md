# SecondaryStructureCount
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SecondaryStructureCount

Counts total number of DSSP-defined secondary structure elements of a given type(s).

**WARNING**: This filter's report_sm (found in scorefile) is always a dummy "0" value regardless of secondary structure count. The total SS counts for each SS type are listed in the tracer output. See option 'return_total'.

```xml
<SecondaryStructureCount name="(&string)"
    filter_helix_sheet="(1 &bool)" filter_helix="(0 &bool)" filter_sheet="(0 &bool)" filter_loop="(0 &bool)"
    num_helix_sheet="(0 &int)" num_helix="(0 &int)" num_sheet="(0 &int)" num_loop="(0 &int)"
    min_helix_length="(4 &int)" max_helix_length="(9999 &)"
    min_sheet_length="(3 &int)" max_sheet_length="(9999 &)"
    min_loop_length="(1 &int) " max_loop_length="(9999 &)"
    return_total="(false &bool)"
    residue_selector="("" &string)" min_element_resis="(1 &int)" />
```

- **filter_helix**: If true, filters on helices. This also determines the number returned by the option 'return_total'.
- **filter_sheet**: ""
- **filter_loop**: ""
- **filter_helix_sheet**: If true, filters on the sum of helix + sheet.

- **num_helix**: Number of helices to for the filter to filter on.
- **num_sheet**: ""
- **num_loop**: ""
- **num_helix_sheet**: ""

- **min_helix_length**: Min number of AAs for a helix to be considered a helix. Default: 4
- **max_helix_length**: Max number of AAs for a helix to be considered a helix. Default: 9999
- **min_sheet_length**: Min number of AAs for a sheet to be considered a helix. Default: 3
- **max_sheet_length**: Max number of AAs for a sheet to be considered a helix. Default: 9999
- **min_loop_length**: Min number of AAs for a loop to be considered a helix. Default: 1
- **max_loop_length**: Max number of AAs for a loop to be considered a helix. Default: 9999

- **return_total**: If true, returns the total number of SS elements filtered on to the score file. By default the filter will always return "0" to the score file.
- **residue_selector**: Pass a single residue_selector to only count SS elements of a subset of residues.
- **min_element_resis**: Minimum number of residues on a SS element for it to be counted (for use with residue_selector). Default: 1

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[HelixKinkFilter]]
* [[HelixPairingFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureHasResidueFilter]]
