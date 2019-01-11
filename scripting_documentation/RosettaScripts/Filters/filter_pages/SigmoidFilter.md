# Sigmoid
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Sigmoid

Part of the fuzzy-logic design algorithm:
Warszawski S, Netzer R, Tawfik DS, Fleishman SJ. A 'fuzzy'-logic language for encoding multiple physical traits in biomolecules. J Mol Biol 2014. 

See Operator filter for more details.

Transform a filter's value according to a sigmoid: $$f(x) = 1 / ( 1 + (steepness)e^{ (x - offset - baseline) } ) )$$

The midpoint for the filter is at offset and steepness determines how steeply it climbs at the midpoint.

```xml
<Sigmoid name="(&string)" filter="(&string)" threshold="(0 &Real)" steepness="(1.0 &Real)" offset="(0.0 &Real)" negate="(0 &bool)" baseline_checkpoint="(''&string)"/>
```

-   threshold: values above this threshold pass as true
-   negate: substitute x for 1-x in evaluation (as the Boolean operator NOT).
-   baseline\_checkpoint: file name to keep track of the baseline value. 
-   baseline: the filter's value when a method called reset\_baseline is called. This allows the user to have a dynamic setting of the offset used in computing the transform (see more details below).

The function above asymptotically reaches 0 at high x and 1 at low x. The offset can be modified during run time using the reset\_baseline function, but this is only available to Operator filter at this time.

Baseline can only be set within the Rosetta code and is triggered by Operator filter's reset\_baseline. Operator filter's reset\_baseline, in turn, is triggered by GenericMonteCarloMover at the first iteration through the mover. Subsequent calls to Operator (and through it to Sigmoid) are evaluated with this baseline. In this way, the offset can be determined apriori by the user to a threshold above or below the starting value of the filter at the start of GenericMonteCarlo. For instance, say that you're optimizing binding energy, but are not sure what the binding energy will be at the start of GenericMonteCarlo. You set the offset to 2, and if the binding energy is evaluated to -10 at the start of the Monte Carlo simulation, the offset is made as -8.

By setting baseline\_checkpoint to a file name, the baseline will be saved to a file, and will be read from it in case of failure/recovery. This is useful in case a long MC trajectory has been pre-empted and needs to be restarted. Reading the baseline from the checkpointing file is only triggered if the MC trial is greater than 1. If it's 1, the baseline is instead computed and written to the checkpointing file.

## See also

* [[BoltzmannFilter]]
* [[CompoundStatementFilter]]
* [[CombinedValueFilter]]
* [[CalculatorFilter]]
* [[IfThenFilter]]
* [[OperatorFilter]]
* [[ReplicateFilter]]

