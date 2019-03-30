# StubScore
*Back to [[Filters|Filters-RosettaScripts]] page.*
## StubScore

A special filter that is associated with [[PlaceSimultaneouslyMover]]. It checks whether in the current configuration the scaffold is 'feeling' any of the hotspot stub constraints. This is useful for quick triaging of hopeless configuration.

```xml
<StubScore name="(&string)" chain_to_design="(2 &integer)" cb_force="(0.5 &Real)">
  <StubSets>
     <Add stubfile="(&string)"/>
  </StubSets>
</StubScore>
```

Note that none of the flags of this filter need to be set if PlaceSimultaneously is notified of it. In that case, PlaceSimultaneously will set this StubScore filter's internal data to match its own.


## See also

* [[PlaceSimultaneouslyMover]]

