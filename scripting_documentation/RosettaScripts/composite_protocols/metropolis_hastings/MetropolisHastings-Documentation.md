#MetropolisHastings Documentation

[[Return to RosettaScripts|RosettaScripts]]

### MetropolisHastings (Overview)

The Metropolis-Hastings mover is the core of the canonical sampling framework in Rosetta. A call to apply of this mover performs a trajectory of a (canonical) Monte Carlo simulation. This can be used to estimate the thermodynamic distribution of conformational states for a given score function. See [the Metropolis–Hastings algorithm page on Wikipedia](http://en.wikipedia.org/wiki/Metropolis–Hastings_algorithm) for more information.

#### ThermodynamicMovers

The move set for the monte-carlo simulation is defined by adding instances of various ThermodynamicMovers (a special case of the general Mover) to the MetropolisHastingsMover before the simulation commences. The probability that any given move will be chosen during the simulation can be controlled using the sampling\_weight parameter. The sampling weights for all movers are automatically normalized to 1. ThermodynamicMovers specify additional behavior on top of normal movers:

-   Movers must have an option to obey detailed balance, which is automatically turned on by MetropolisHastings when they are added.
-   Movers must return the ratio of the probability of making the previous move and reversing the previous move.
-   Movers may have initialization and finalization functions, which are called before and after the Monte Carlo loop.
-   Movers may have a callback that is used to gather statistics about performance after the Metropolis criterion is evaluated.
-   Multi-trial movers, which have an internal Monte Carlo loop with a potentially different score function and temperature, must return the overall change in internal score function during the move divided by the internal temperature.

Only a limited subset of movers currently fulfill these requirements and are subclasses of ThermodynamicMover. They include:

-   [[Small|Movers-RosettaScripts#Small]]
-   [[Shear|Movers-RosettaScripts#Shear]]
-   [[Backrub|Movers-RosettaScripts#Backrub]]
-   BackrubSidechain (experimental)
-   [[Sidechain|Movers-RosettaScripts#Sidechain]]
-   [[SidechainMC|Movers-RosettaScripts#SidechainMC]] (a multi-trial mover)

#### TemperatureControllers

A set of Plug-ins (TemperatureController) allow to access various types of sampling schemes:

-   [[SimulatedAnnealing|SimulatedAnnealing-MetropolisHastings]] --- (not implemented) allow ramping of temperature during the trajectory following a preset schedule
-   [[Tempering|Tempering-MetropolisHastings]]
    -   [[SimulatedTempering|Tempering-MetropolisHastings#SimulatedTempering]] --- stochastic switching of temperatures in a serial trajectory [\[1\]](http://arxiv.org/abs/hep-lat/9205018)
    -   [[ParallelTempering|Tempering-MetropolisHastings#ParallelTempering]] --- (aka replica exchange) switching of temperatures between parallel replicas [\[2\]](http://en.wikipedia.org/wiki/Parallel_tempering)
    -   [[HamiltonianExchange|Tempering-MetropolisHastings#HamiltonianExchange]] --- (soon to be implemented) switching of score-weights and temperature between parallel replicas

#### ThermodynamicObservers

ThermodynamicObservers are plug-ins that support recording of trajectories and other statistics over the course of a simulation. ThermodynamicObservers are Mover subclasses, and have a subset of the additional behaviors:

-   Movers may have initialization and finalization functions, which are called before and after the Monte Carlo loop.
-   Movers may have a callback that is used to gather statistics about performance after the Metropolis criterion is evaluated.

There are a number of ThermodynamicObservers:

-   [[TrajectoryRecorder|Movers-RosettaScripts#PDBTrajectoryRecorder]] --- write snapshots to file
    -   [[PDBTrajectoryRecorder|Movers-RosettaScripts#PDBTrajectoryRecorder]] --- write snapshots to a multi-model PDB file
    -   [[SilentTrajectoryRecorder|Movers-RosettaScripts#SilentTrajectoryRecorder]] --- write snapshots using the job distributor

-   [[MetricRecorder|Movers-RosettaScripts#MetricRecorder]] -- record selected torsion angles (currently) and other numerical features (in the future) to a tab delimited text file
-   [[TrialCounterObserver]] --- observe acceptance rates of various moves at different temperatures

