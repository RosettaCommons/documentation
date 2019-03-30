# ScoreType
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ScoreType

Computes the energy of a particular score type for the entire pose and if that energy is lower than threshold, returns true.  If no `score_type` is set, it filters on the entire `scorefxn`.

```xml
<ScoreType name="(score_type_filter &string)" scorefxn="(score12 &string)" score_type="(total_score &string)" threshold="(&float)"/>
```

## See also:

* [[Score Types|rosetta_basics/scoring/score-types]]
* [[TaskAwareScoreTypeFilter]]
* [[EnergyPerResidueFilter]]

