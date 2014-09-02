# GeneralizedKIC Filters

## Overview
[[GeneralizedKIC]] filters are evaluations performed rapidly, at low computational cost, on closed solutions found by the kinematic closure algorithm so that poor solutions may be discarded rapidly before computationally-expensive selectors are applied.

## Use within RosettaScripts
Fully manual invocation of a filter within RosettaScripts is accomplished according to the following template.  In most cases, however, shorthands exist for specific filters.  These are described in the [[shorthands|GeneralizedKICfilter#Shorthands]] section.

```
<GeneralizedKIC ...>
     ...
     <AddFilter type="&string">
          <AddFilterParameterString value="&string" name="&string" />
          <AddFilterParameterInteger value=(&int) name="&string" />
          <AddFilterParameterBoolean value=(&bool) name="&string" />
          <AddFilterParameterReal value=(&Real) name="&string" />
     </AddFilter>
     ...
</GeneralizedKIC>
```

## Types of filters


## Shorthands

