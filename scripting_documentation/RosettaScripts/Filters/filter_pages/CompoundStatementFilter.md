# CompoundStatement filter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## CompoundStatement filter

This is a special filter that uses previously defined filters to construct a compound logical statement with NOT, AND, OR, XOR, NAND, NOR, ANDNOT, and ORNOT operations. By making compound statements of compound statements, esssentially all logical statements can be defined.

```xml
<CompoundStatement name="(&string)" invert="(false &bool)">
    <(&OPERATION) filter_name="(true_filter &string)"/>
    ....
</CompoundStatement>
```

where (&OPERATION) is any of the operations defined in CAPS above.Note that the operations are performed in the order that they are defined. No precedence rules are enforced, so that any precedence has to be explicitly written by making compound statements of compound statements. Setting invert=true will cause the final boolean value to be inverted. If, for instance multiple AND statements are evaluated and each evaluates to true, then the filter will return false.

Note that the first OPERATION specified in the compound statement treated as a negation if NOT, ANDNOT, or ORNOT is specified.

## See also

* [[BoltzmannFilter]]
* [[CombinedValueFilter]]
* [[CalculatorFilter]]
* [[IfThenFilter]]
* [[OperatorFilter]]
* [[ReplicateFilter]]
* [[SigmoidFilter]]

