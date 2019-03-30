# LoopOver
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopOver

Allows looping over a mover using either iterations or a filter as a stopping condition (the first turns true). By using ParsedProtocol mover (formerly named the DockDesign mover) above with loop can be useful, e.g., if making certain moves is expensive and then we want to exhaust other, shorter moves.

```xml
<LoopOver name=(&string) mover_name=(&string) filter_name=( false_filter &string) iterations=(10 &Integer) drift=(true &bool) ms_whenfail=("MS_SUCCESS" &string) />
```

* drift:

    * true- the state of the pose at the end of the previous iteration will be the starting state for the next iteration. 
    * false- the state of the pose at the start of each iteration will be reset to the state when the mover is first called. 

Note that "falling off the end" of the iteration will revert to the original input pose, even if drift is set to true.

* ms_whenfail: Short for "Mover state when fail", will set the status of the LoopOver mover when iterations run out and the filter returns false. Setting this option to "MS_SUCCESS" (which is the defaut) can have two outcomes: If the option "drift" is active, LoopOver will return the pose after applying the inner mover; If "drift" is not active, it will return the input pose. If ms_whenfail="FAIL_DO_NOT_RETRY", Rosetta will exit with error unless filter returns True. For more ms_whenfail values see src/protocols/moves/MoverStatus.cc.

Code lives in src/protocols/protein_interface_design/movers/LoopOver.cc

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
