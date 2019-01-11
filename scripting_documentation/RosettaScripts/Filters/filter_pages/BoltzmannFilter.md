# Boltzmann
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Boltzmann

Returns the Boltzmann weighted sum of a set of positive and negative filters. The fitness is actually defined as -F with [-1-0] range (-1 most optimal, 0 least).

```xml
<Boltzmann name="(&string)" fitness_threshold="(0&real)" temperature="(0.6 &real)" positive_filters="(&comma delimited list)" negative_filters="(&comma delimited list)" anchors="(&comma delimited list of floats)" triage_threshold="(-9999 &int)" norm_neg="(false &bool)"/>
```

-   fitness\_threshold: below which fitness threshold to allow?
-   temperature: the Boltzmann weighting factor (in fact, kT rather than T).
-   positive\_filters: a list of predefined filters to use as the positive states. The filters' report\_sm methods will be invoked, so there's no need to fret about their thresholds.
-   negative\_filters: as above, only negative.
-   anchors: an anchor per positive state to cap the drift in its energy. Specifying no anchors is fine. A very high value for the anchor means, in practice, no anchor.
-   triage\_threshold: above which threshold (e.g. delta score/delta ddg) a negative state will be counted in the Boltzmann fitness calculation. This prevents the dilution of negative states.
-   norm\_neg: normalize the fitness of the mutation state in relative to the original state. When triage\_threshold is used the number of negative states is changed, therefore norm\_neg is needed in order to compare mutations in the same position.

Useful for balancing counteracting objectives.

## See also

* [[CompoundStatementFilter]]
* [[CombinedValueFilter]]
* [[CalculatorFilter]]
* [[OperatorFilter]]
* [[ReplicateFilter]]
* [[SigmoidFilter]]


