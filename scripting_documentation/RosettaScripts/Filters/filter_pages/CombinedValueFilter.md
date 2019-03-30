# CombinedValue filter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## CombinedValue filter

This is a special filter that calculates a weighted sum based on previously defined filters.

```xml
<CombinedValue name="(&string)" threshold="(0.0 &Real)">
    <Add filter_name="(&string)" factor="(1.0 &Real)" temp="(&Real)"/>
    <Add
</CombinedValue>
```

By default, the value is a straight sum of the calculated values (not the logical results) of the listed filters. A multiplicative weighting factor for each filter can be specified with the `     factor    ` parameter. (As a convenience, `     temp    ` can be given instead of `     factor    ` , which will divide the filter value, rather than multiply it.)

For truth value contexts, the filter evaluates to true if the weighted sum if less than or equal to the given `     threshold    ` .

## See also

* [[BoltzmannFilter]]
* [[CompoundStatementFilter]]
* [[CalculatorFilter]]
* [[IfThenFilter]]
* [[OperatorFilter]]
* [[ReplicateFilter]]
* [[SigmoidFilter]]

