# RandomMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RandomMover

Randomly apply a mover from a list given probability weights. The **movers** tag takes a comma separated list of mover names. The **weights** tag takes a comma separate list of weights that sum to 1. The lengths of the movers and weights lists should must match.

```xml
<RandomMover name="( &string)" movers="(&string)" weights="(&string)" repeats="(null &string)"/>
```


##See Also

* [[GenericMonteCarloMover]]
* [[LoopOverMover]]
* [[SubroutineMover]]
* [[I want to do x]]: Guide to choosing a mover
