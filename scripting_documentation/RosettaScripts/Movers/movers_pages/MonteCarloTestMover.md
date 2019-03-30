# MonteCarloTest
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MonteCarloTest

Associated with GenericMonteCarlo. Simply test the MC criterion of the specified GenericMonteCarloMover and save the current pose if accept.

```xml
<MonteCarloTest name="(&string)" MC_name="(&string)"/>
```

-   MC\_name: name of a previously defined GenericMonteCarloMover

Useful in conjunction with MonteCarloRecover (below) if you're running a trajectory consisting of many different sorts of movers, and would like at each point to decide whether the pose has made an improvement.


##See Also

* [[GenericMonteCarloMover]]
* [[SubroutineMover]]
* [[MonteCarloUtilMover]]
* [[MonteCarloRecoverMover]]
* [[GenericSimulatedAnnealerMover]]
* [[LoopOverMover]]
* [[MultiplePoseMover]]
* [[MultipleOutputWrapperMover]]
* [[I want to do x]]: Guide to choosing a mover
