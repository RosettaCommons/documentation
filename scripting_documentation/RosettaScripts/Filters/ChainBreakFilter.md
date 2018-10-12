#ChainBreakFilter

Documentation by Christoffer Norn (ch.norn@gmail.com).  Page created 17 August 2017.

*Back to [[Filters|Filters-RosettaScripts]] page.*

##ChainBreakFilter

This filter counts the number of chain break in the pose. A chain break is here defined as a bond length that deviates from the mean bond length (1.33) +/- tolerance (default: 0.13). 

## Options and Usage

```xml
< ChainBreak name="(&string)" 
    chain_num="(1 &int)" 
    tolerance="(0.13 &float)"
    threshold="(1 &int)" 
/>
```

**chain_num** -- Which chain to apply the filter to. 

**tolerance** -- How many angstrom may the bond length deviate from the ideal (1.33 AA)

**threshold** -- How many chain breaks needed for the filter to report failure
