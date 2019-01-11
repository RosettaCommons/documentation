# Operator
## Operator

Part of the fuzzy-logic design algorithm:

* Warszawski S, Netzer R, Tawfik DS, Fleishman SJ. A "fuzzy"-logic language for encoding multiple physical traits in biomolecules. J Mol Biol 2014. 

Values from the Sigmoid filters are combined into a fuzzy-logic statement using the Operator filter, which
defines the operators (AND and OR) to be applied to the combined Sigmoid values.
Operator filters can be combined hierarchically within other Operator filters, providing a complete framework to define any combination of Boolean operators acting on computed fractional occupancies. Finally, the Operator filter is fed into the GenericMonteCarlo mover. At each iteration, GenericMonteCarlo invokes the RandomMutation mover, which defines the set of allowed positions and the amino acid identities allowed at each position. When RandomMutation Mover is invoked a random point mutation is introduced according to the user-defined definitions for allowed positions and identities and side chains with 6Å of the mutation are subjected to combinatorial repacking. GenericMonteCarlo then calls the Operator filter, and compares the value obtained from Operator filter with the value of the currently accepted pose. GenericMonteCarlo also keeps in memory the pose with the best
Operator evaluation and at the end of the trajectory returns this best pose. To implement a simulated annealing policy we break the Monte Carlo simulation into three separate Monte Carlo steps starting with high temperature and ending with zero temperature.


sum, multiply, find the max or min of a list of filters

```xml
<Operator name="(&string)" filters="(comma-separated list of filters&string)" threshold="(0&Real)" operation="(one of: SUM/NORMALIZED_SUM/PRODUCT/MIN/MAX/SUBTRACT/ABS/BOOLEAN_OR &string)" negate="(0&bool)" logarithm="(0&bool)"/>
```

Evaluate the list of filters with the operator, and return whether or not they pass the threshold. NORMALIZED\_SUM returns the sum divided by the number of filters. SUBTRACT accepts only two filters, and returns the first - the second. ABS accepts only one filter and returns the absolute value of that filter's report\_sm. BOOLEAN\_OR(x,y) = x + y - x\*y

Operators of operators are allowed, providing a way to generate any statement.

-   filters: list of previously defined filters on which to carry out the operation
-   negate: multiply return value by -1. Useful in optimization
-   logarithm: take the log(x) value of the resulting operator. We recommend to use this option in the 'fuzzy'-logic design framework with the PRODUCT operator since this transforms the operator value into an energy term, which is suitable for the following GenericMonteCarlo mover. 

## See also:

* [[BoltzmannFilter]]
* [[CompoundStatementFilter]]
* [[CombinedValueFilter]]
* [[CalculatorFilter]]
* [[IfThenFilter]]
* [[SigmoidFilter]]
* [[ReplicateFilter]]

