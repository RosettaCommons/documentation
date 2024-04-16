# Subroutine
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Subroutine

Calling another RosettaScript from within a RosettaScript.

```xml
<Subroutine name="(&string)" xml_fname="(&string)"/>
```

-   xml\_fname: the name of the RosettaScript to call.

This definition in effect generates a Mover that can then be incorporated into the RosettaScripts PROTOCOLS section. This allows a simplification and modularization of RosettaScripts.  Note that the `<xi:include href=(string) />` syntax allows more general inclusion of pieces of RosettaScripts XML anywhere in a script, with full variable substitution.

Recursions are allowed but will cause havoc.

[[include:mover_Subroutine_type]]

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
