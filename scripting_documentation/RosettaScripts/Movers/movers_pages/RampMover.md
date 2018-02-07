# RampMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RampMover

Repeatedly applies a given mover while ramping the score from a low value to a high value.

```xml
<RampingMover name="(&string)" start_weight="(&real)" end_weight="(&real)" outer_cycles="(&real)" inner_cycles="(&real)" score_type="(&string)" ramp_func="(&string)" montecarlo="(&string)" mover="(&string)"/>
```

-   start\_weight - starting weight for ramp
-   end\_weight - ending weight for ramp
-   outer\_cycles - number of increments to ramp score in
-   inner\_cycles - number of times to call inner mover in each score ramp increment
-   score\_type - name of the score term to ramp
-   ramp func - the ramp funct to use, valid options are linear, geometric, or inverse\_geometric
-   montecarlo - the name of the montecarlo object to use
-   mover - name of the inner mover to use.


##See Also

* [[GenericSimulatedAnnealerMover]]
* [[GenericMonteCarloMover]]
* [[LoopOverMover]]
* [[I want to do x]]: Guide to choosing a mover
