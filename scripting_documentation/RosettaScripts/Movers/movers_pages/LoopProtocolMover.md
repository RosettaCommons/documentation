# LoopProtocol
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopProtocol

LoopProtocol optimizes a region of protein backbone using a simulated annealing 
MonteCarlo simulation.  The simulation is composed of three loops (now I'm 
speaking of loops in the algorithmic sense, not the protein sense).  The 
outermost loop is the "sfxn", or "score function", loop.  The repulsive and 
rama terms of the score function are ramped up in this loop, if such ramping is 
enabled.  Inside the sfxn loop is the "temp", or "temperature" loop.  The 
temperature is gradually ramped down in this loop.  Because the temp loop is 
within the sfxn loop, the temperature jumps back to its highest value and 
starts ramping again at the beginning of each sfxn iteration.  Inside the temp 
loop is the "mover" loop.  Monte Carlo moves are made in this loop, but nothing 
is ramped.  You can specify what kinds the Monte Carlo moves to use with 
subtags.

Any LoopMover may be used as a subtag, although it usually makes more sense to 
use simple ones like KicMover or RepackingRefiner than complicated ones like 
LoopModeler or LoopProtocol.  The movers will be invoked in the order they are 
specified.  In addition, a default set of movers may automatically be invoked 
after the specified mover.  These default movers are called "refiners".  Their 
role is to allow you to change the sampling algorithm without having to worry 
about refinement steps that normally happen behind the scenes, but if necessary 
they can be disabled.

Note that LoopModeler calls LoopProtocol twice, once for centroid mode and once 
for fullatom mode.  It's more common to use LoopModeler than it is to use 
LoopProtocol directly.

```xml
<LoopProtocol sfxn_cycles="(1 &int)" temp_cycles="(1 &int ['x'])" mover_cycles="(1 &int)"
ramp_rep="(no &bool)" ramp_rama="(no &bool)" ramp_temp="(yes &bool)" initial_temp="(1.5 &real)" final_temp="(0.5 &real)"
loop_file="(&string)" scorefxn="(&string)" auto_refine="(yes &bool)" fast="(no &bool)">

    <Loop start="(&int)" stop="(&int)" cut="(&int)" skip_rate="(0.0 &real)" rebuild="(no &bool)"/>

    <AcceptanceCheck name="(loop_mover &string)"/>

    <(Any LoopMover tags)/>...

</LoopProtocol>
```

Options:

* sfxn_cycles: The number of iterations to make in the sfxn loop.

* temp_cycles: The number of iterations to make in the temp loop.  This number 
  may optionally be followed by an "x", in which case the number of iterations 
  will be the given number times the length of the loop being sampled.  So if 
  you were sampling a 12 residue loop, you could specify temp_cycles="10x" to 
  iterate the temperature loop 120 times.

* mover_cycles: The number of iterations to make in the mover loop.

* ramp_rep: Whether or not to ramp the repulsive term of the score function 
  during the sfxn loop.  If enabled, the repulsive weight will start near zero 
  and will finish at whatever it was in the original score function.

* ramp_rama: Whether or not to ramp the Ramachandran term of the score function 
  during the sfxn loop.  If enabled, the Ramachandran weight will start near 
  zero and will finish at whatever it was in the original score function.

* ramp_temp: Whether or not to ramp the temperature during the temp loop.  The 
  initial and final values are controlled by the initial_temp and final_temp 
  options.

* initial_temp: The initial temperature.  Ignored if temperature ramping is 
  disabled.

* final_temp: The final temperature.  Ignored if temperature ramping is 
  disabled.

* loop_file: See LoopModeler
 
* scorefxn: The name of the score function to use for the Monte Carlo 
  simulation.  This is required when using LoopProtocol on its own, but 
  optional in the context of the LoopModeler's Centroid and Fullatom subtags.

* auto_refine: If enabled, the built-in refiners will be automatically 
  invoked after any user-specified movers.  This typically is useful, because 
  it makes it easier to change the sampling move (e.g. KIC, CCD, backrub, etc.) 
  without having to worry about things that normally happen behind the scenes.  
  But if you may want to manually specify your own refinement moves, you have 
  to disable auto_refine.

* fast: If enabled, the simulation will use a severely reduced number of 
  cycles. Only meant to be used for debugging.

Subtags:

* Loop: See LoopModeler

* AcceptanceCheck: Add a Monte Carlo score function evaluation and acceptance 
  check between any of your movers.  An acceptance check is always made after 
  all of your movers (and the built-in refiners) have been invoked, but this 
  allows you to add additional acceptance checks in between your moves.

* Any LoopMover: Control how the backbone is sampled in the Monte Carlo 
  simulation of the loop.   For example, you might want to use backrub instead 
  of KIC (the default) for certain application.  The technical definition of a 
  LoopMover is anything in C++ that inherits from LoopMover, but the practical 
  definition is any Mover described on this page.  If you specify more than one 
  LoopMover, they will be executed in the order given.

Caveats:

* See LoopModeler.


##See Also

* [[RosettaScriptsLoopModeling]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[Fragments file format|fragment-file]]
* [[Resource Manager documentation|ResourceManager]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopLengthChangeMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
