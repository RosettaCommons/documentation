# MoveBeforeFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## MoveBeforeFilter

Apply a given mover to the pose before calculating the results from another filter

```
<MoveBeforeFilter name="(&string)" mover="(&string)" filter="(&string)"/>
```

Note that, like all filters, MoveBeforeFilter cannot change the input pose - the results of the submover will only be used for the subfilter calculation and then discarded.

Also note that caution must be exercised when using a computationally expensive mover or a mover/filter pair which yields stochastic results. The result of the mover is not cached, and will be recomputed for each call to apply(), report() or report\_sm().

## See also

* [[Movers|Movers-RosettaScripts]]
* [[CombinedValueFilter]]

