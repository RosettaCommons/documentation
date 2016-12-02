# LoopOver
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopOver

Allows looping over a mover using either iterations or a filter as a stopping condition (the first turns true). By using ParsedProtocol mover (formerly named the DockDesign mover) above with loop can be useful, e.g., if making certain moves is expensive and then we want to exhaust other, shorter moves.

```
<LoopOver name="(&string)" mover_name="(&string)" filter_name="( false_filter &string)" iterations="(10 &Integer)" drift="(true &bool)"/>
```

drift: true- the state of the pose at the end of the previous iteration will be the starting state for the next iteration. false- the state of the pose at the start of each iteration will be reset to the state when the mover is first called. Note that "falling off the end" of the iteration will revert to the original input pose, even if drift is set to true.

This mover is somewhat deprecated in favor of the more general GenericMonteCarlo mover.


##See Also

* [[GenericMonteCarloMover]]
* [[RandomMover]]
* [[MonteCarloTestMover]]
* [[MonteCarloUtilMover]]
* [[MonteCarloRecoverMover]]
* [[GenericSimulatedAnnealerMover]]
* [[SubroutineMover]]
* [[MultiplePoseMover]]
* [[MultipleOutputWrapperMover]]
* [[I want to do x]]: Guide to choosing a mover
