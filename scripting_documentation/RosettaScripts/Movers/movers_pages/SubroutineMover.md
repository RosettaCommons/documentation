# Subroutine
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Subroutine

Calling another RosettaScript from within a RosettaScript

```xml
<Subroutine name="(&string)" xml_fname="(&string)"/>
```

-   xml\_fname: the name of the RosettaScript to call.

This definition in effect generates a Mover that can then be incorporated into the RosettaScripts PROTOCOLS section. This allows a simplification and modularization of RosettaScripts.

Recursions are allowed but will cause havoc.

##See Also

* [[GenericMonteCarloMover]]
* [[RandomMover]]
* [[MonteCarloTestMover]]
* [[MonteCarloUtilMover]]
* [[MonteCarloRecoverMover]]
* [[GenericSimulatedAnnealerMover]]
* [[LoopOverMover]]
* [[MultiplePoseMover]]
* [[MultipleOutputWrapperMover]]
* [[I want to do x]]: Guide to choosing a mover
