# ParsedProtocol (formerly DockDesign)
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ParsedProtocol (formerly DockDesign)

This is a special mover that allows making a single compound mover and filter vector (just like protocols). The optional option mode changes the order of operations within the protocol, as defined by the option. If undefined, mode defaults to the historical functionality, which is operation of the Mover/Filter pairs in the defined order.

```xml
<ParsedProtocol name="( &string)" mode="( &string)">
    <Add mover_name="( null &string)" filter_name="( true_filter &string)" apply_probabilities="(see below &Real)"/>
    ...
</ParsedProtocol>
```

-   mode: "sequence" - (default) perform the Mover/Filter pair in the specified sequence; "random\_order" - perform EACH of the defined Mover/Filter pairs one time in a random order; "single\_random" - randomly pick a SINGLE Mover/Filter pair from the list.
-   apply\_probabilities: This only works in mode single\_random. You can set the probability that an individual submover will be called 0-1. The probabilities must sum to 1.0, or you'll get an error message. Notice that this is used by GenericMonteCarlo in its adaptive\_movers mode to adjust the probabilities of movers dynamically during a sampling trajectory.

##See Also

* [[ContingentAcceptMover]]
* [[IfMover]]
* [[GenericMonteCarloMover]]
* [[LoopOverMover]]
* [[Home page for RosettaScripts filters|Filters-RosettaScripts]]
* [[I want to do x]]: Guide for choosing a mover
