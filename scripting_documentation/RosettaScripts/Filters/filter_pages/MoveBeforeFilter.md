# MoveBeforeFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## MoveBeforeFilter

[[include:filter_MoveBeforeFilter_type]]

Also note that caution must be exercised when using a computationally expensive mover or a mover/filter pair which yields stochastic results. The result of the mover is not cached, and will be recomputed for each call to apply(), report() or report\_sm().

## See also

* [[Movers|Movers-RosettaScripts]]
* [[CombinedValueFilter]]

