#StepWiseScreener
`StepWiseScreener` objects are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. The base class is in `src/protocols/stepwise/sampler/StepWiseSampler/`

# Important functions that you should set.

###`bool check_screen()`
Return true/false if a filter.
Return true if the job of this screener is to always pass, but to carry out an action -- and run the action (e.g., packing or loop closure) in this function.

### bool name()
Required for output of final cut_table

### bool type()
Register your `StepWiseScreener` in the enum in `StepWiseScreenerType.hh`.

### void add_mover( moves::CompositionMoverOP update_mover, moves::CompositionMoverOP restore_mover )
How this screener can communicate to later screeners any things to apply to their poses.
A `CompositionMover` is basically a `vector1` of movers (actually, mover pointers). If the mover pointer is null, that means do nothing. 

### void apply_mover( moves::CompositionMoverOP, Size const, Size const )
How this `StepWiseScreener` receives communication from prior screeners.

### void fast_forward( StepWiseSamplerBaseOP )
If this `StepWiseScreener` fails `check_screen`, this function can tell the sampler to skip ahead. For example, in docking, if the rigid body arrangement of two partitions does not allow for chain closure, it may make sense to skip any fine-grained sampling of residue alternatives.

# Useful sub-classes
## SampleApplier
Holds a `pose_` as a private variable. Automatically knows what to do when handed movers through `apply_mover()`. This sub-class is a better choice than the base `StepWiseScreener` class for actions that require working on a 'scratch' pose, e.g., `ProteinCCD_ClosureScreener`, or `SugarInstantiator`. 

Go back to [[StepWise Overview|stepwise-classes-overview]].