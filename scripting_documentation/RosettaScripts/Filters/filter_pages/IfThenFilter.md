# IfThenFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## IfThenFilter

```xml
<IfThenFilter name="(&string)" threshold="(&Real 0)" lower_threshold="(&bool False)">
    <IF testfilter="(&string)" inverttest="(&bool False)" valuefilter="(&string)" value="(&Real)" weight="(&Real 1)"/>
    <IF testfilter="(&string)" inverttest="(&bool False)" valuefilter="(&string)" value="(&Real)" weight="(&Real 1)"/>
    ....
    <ELSE valuefilter="(&string)" value="(&Real 0)" weight="(&Real 1)"/>
</IfThenFilter>
```

Evaluate to a value contingent on the true/false value of other filters. Each of the IF clauses are evaluated in order. If the testfilter evaluates to true, the real-valued result of the IfThenFilter is the real-valued return value of the valuefilter, multiplied by the corresponding weight. (If inverttest is true, a false testfilter will cause valuefilter evaluation.) Alternatively, you can omit the valuefilter, and give a literal value with the value parameter (which will also be multiplied by the given weight). If none of the IF clauses return true for their testfilters, then the real-valued result of the ELSE clause valuefilter (or the corresponding literal value) multiplied by the weight is used as the value instead.

For truth value testing, the default is to return true if the value is less than or equal to the given threshold. If lower\_threshold is true, then IfThenFilter returns true if the value is greater than or equal to the threshold.

## See also

* [[CompoundStatementFilter]]
* [[CombinedValueFilter]]
* [[CalculatorFilter]]
* [[BoltzmannFilter]]
* [[OperatorFilter]]
* [[SigmoidFilter]]
* [[ContingentFilter]]

