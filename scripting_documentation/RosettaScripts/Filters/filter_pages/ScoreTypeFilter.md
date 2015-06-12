# ScoreType
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ScoreType

Computes the energy of a particular score type for the entire pose and if that energy is lower than threshold, returns true.

```
<ScoreType name=(score_type_filter &string) scorefxn=(score12 &string) score_type=(total_score &string) threshold=(&float)/>
```

## See also:

* [[TaskAwareScoreType]]
* [[EnergyPerResidue]]
* [[rosetta_basics/scoring/score-types]]

