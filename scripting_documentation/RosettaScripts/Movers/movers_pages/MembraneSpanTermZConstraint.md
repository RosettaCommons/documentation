# MembraneSpanTermZConstraint
*Back to [[Filters|Filters-RosettaScripts]] page.*
## MembraneSpanTermZConstraint

sets a constraint where the termini of all TM spans edges (last residue) need to be close on the Z (membrane depth) axis. 
useful for hetero fold & dock simulations, to force the TM spans from shifting on the Z axis compared to eachother.
```xml
<MembraneSpanTermZConstraint name="(& string)"/>
```
## See also

* [[MembraneSpanConstraint]]
