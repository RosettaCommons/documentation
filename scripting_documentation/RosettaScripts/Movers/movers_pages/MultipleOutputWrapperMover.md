# MultipleOutputWrapper
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MultipleOutputWrapper

This is a simple wrapper that will execute the mover or ROSETTASCRIPTS protocol it contains to generate additional (derived) output poses from the original pose.
This mover is designed to work with the MultiplePoseMover.
"MoverName" is a placeholder for the actual name of the mover to be used.
Use this wrapper if the mover you want to use does cannot provided more than one output pose (yet).

```xml
<MultipleOutputWrapper name="(&string)" max_output_poses="(&integer)">
    <MoverName .../>
</MultipleOutputWrapper>
```

or

<MultipleOutputWrapper name=(&string) max_output_poses=(&integer)>
<ROSETTASCRIPTS>        ...
    </ROSETTASCRIPTS>
</MultipleOutputWrapper>

-   max\_output\_poses: Maximum number of output poses this wrapper should generate (i.e. how many times the inner mover is executed).

##See Also

* [[MultiplePoseMover]]
* [[GenericMonteCarloMover]]
* [[MonteCarloTestMover]]
* [[MonteCarloUtilMover]]
* [[MonteCarloRecoverMover]]
* [[GenericSimulatedAnnealerMover]]
* [[LoopOverMover]]
* [[SubroutineMover]]
* [[MultiplePoseMover]]
* [[I want to do x]]: Guide to choosing a mover
