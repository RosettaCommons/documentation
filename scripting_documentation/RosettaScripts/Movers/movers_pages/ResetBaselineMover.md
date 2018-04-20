# ResetBaseline
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ResetBaseline

Use this mover to call the reset_baseline method in filters Operator and CompoundStatement. Monte Carlo mover takes care of
resetting independently, so no need to reset if you use MC.

```xml
<ResetBaseline name="(&string)" filter="(&filter)"/>
```
- filter: the name of the Operator or CompoundStatement filter.


##See Also

* [[OperatorFilter]]
* [[CompoundStatementFilter]]
* [[GenericMonteCarloMover]]
* [[I want to do x]]: Guide to choosing a mover
