# MonteCarloRecover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MonteCarloRecover

Associated with GenericMonteCarlo and MonteCarloTest. Recover a pose from a GenericMonteCarloMover.

```xml
<MonteCarloRecover name="(&string)" MC_name="(&string)" recover_low="(1 &bool)"/>
```

-   MC\_name: name of a previously defined GenericMonteCarloMover
-   recover\_low: recover the lowest-energy pose, or the last pose.

Useful in conjunction with MonteCarloRecover (below) if you're running a trajectory consisting of many different sorts of movers, and would like at each point to decide whether the pose has made an improvement.


##See Also

* [[GenericMonteCarloMover]]
* [[MonteCarloTestMover]]
* [[MonteCarloUtilMover]]
* [[SubroutineMover]]
* [[GenericSimulatedAnnealerMover]]
* [[LoopOverMover]]
* [[MultiplePoseMover]]
* [[MultipleOutputWrapperMover]]
* [[I want to do x]]: Guide to choosing a mover
