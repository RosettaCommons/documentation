# ReplicateFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ReplicateFilter

```xml
<ReplicateFilter name="(&string)" filter_name="(&string)" replicates="(&integer 1)" upper_cut="(&real 0)" lower_cut="(&real 0)" median="(&bool 0)" threshold="(&real 0)" />
```

Repeats a given filter the given number of times. It then trims off the highest and lowest values given by upper\_cut and lower\_cut, respectively. If upper/lower cut are less than one, they are interpreted as a fraction to remove, rounded down, and if greater than one as an absolute number of replicates to remove. It then averages the remaining values. By default it uses the mean of the values, although if median is true it will use the median. In truth contexts it will evaluate to true if the resultant value is less than given threshold.

## See also

* [[BoltzmannFilter]]
* [[CompoundStatementFilter]]
* [[CombinedValueFilter]]
* [[CalculatorFilter]]
* [[OperatorFilter]]
* [[SigmoidFilter]]

