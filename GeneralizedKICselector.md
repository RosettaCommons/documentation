# GeneralizedKIC Selectors

## Overview
GeneralizedKIC selectors (class protocols::GeneralizedKIC::GeneralizedKICselector) choose a single solution, based on some criterion, from the many solutions produced by GeneralizedKIC.

## Use within RosettaScripts
Each [[GeneralizedKIC mover|GeneralizedKIC]] has one and only one GeneralizedKIC selector assigned to it.  In RosettaScripts, this must be specified in the **<GeneralizedKIC>** block as follows:

```
<MOVERS>
...
     <GeneralizedKIC ... selector="&string" selector_scorefunction="&string" selector_kbt=(1.0 &real)>
          ...
     </GeneralizedKIC>
...
</MOVERS>
```

The **selector_scorefunction** and **selector_kbt** tags are optional, and are only used by certain selectors.

## Types of selectors
1.  Random ("random_selector")
     As the name implies, this selector randomly chooses a solution from those found.  No options are considered.

2.  