# ParsedProtocol (formerly DockDesign)
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ParsedProtocol (formerly DockDesign)

[[include:mover_ParsedProtocol_type]]

-   apply\_probabilities: This only works in mode single\_random. You can set the probability that an individual submover will be called 0-1. The probabilities must sum to 1.0, or you'll get an error message. Notice that this is used by GenericMonteCarlo in its adaptive\_movers mode to adjust the probabilities of movers dynamically during a sampling trajectory.

##See Also

* [[ContingentAcceptMover]]
* [[IfMover]]
* [[GenericMonteCarloMover]]
* [[LoopOverMover]]
* [[Home page for RosettaScripts filters|Filters-RosettaScripts]]
* [[I want to do x]]: Guide for choosing a mover
