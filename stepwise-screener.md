#StepWiseScreener
`StepWiseScreener` objects are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose.

#Functionalities

## void StepWiseScreener::add_mover( moves::CompositionMoverOP update_mover, moves::CompositionMoverOP restore_mover )
A `CompositionMover` is basically a `vector1` of movers (actually, mover pointers). If the mover pointer is null, that means do nothing. This function is in charge of communicating to later screeners any things to apply to their poses.

Go back to [[StepWise Overview|stepwise-classes-overview]].