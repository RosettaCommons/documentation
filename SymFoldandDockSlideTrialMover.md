# SymFoldandDockSlideTrialMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SymFoldandDockSlideTrialMover

[[include:mover_SymFoldandDockSlideTrialMover_type]]

Will slide the symmetric subunits into contact based on the slide type set in the pose's symmetry info, similar to the [[SymDockingInitialPerturbation]] mover with sliding enabled:


* ORDERED_SEQUENTIAL -- Will slide along each symmetric jump, one after each other, in standard order.
* SEQUENTIAL -- Will slide along each symmetric jump, one after each other, in random order.
* RANDOM -- Picks the symmetric jump along which to slide randomly.