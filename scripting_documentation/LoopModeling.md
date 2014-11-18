# Loop Modeling

The goal of loop modeling is to predict the conformation of a relatively short 
stretch of protein backbone and sidechain.  As one example, it's not uncommon 
for crystal structures to be missing density in some regions.  Loop modeling 
can be used to predict structures for these regions.  As another, homology 
models often need to account for short insertions or deletions.  Loop modeling 
can be used to predict how these sequence changes affect structure.

Loop modeling in Rosetta is very configurable, but the basic algorithm goes 
like this:

* Inputs:
 
  The inputs are a protein structure and a set of indices specifying where one 
  or more regions to model (i.e. the loop or loops) start and stop.

* Step 1: Initial build
 
  The algorithm starts by building an initial backbone for each loop being 
  sampled.  This backbone is just a starting point for the rest of the 
  algorithm, so it's only realistic in the sense of having reasonable bond 
  lengths and not completely clashing with anything.  Note that by skipping 
  this step, you can use the loop modeling algorithm for ensemble generation.

* Step 2: Centroid refinement

  The algorithm continues by refining the loop conformation in the context of 
  the centroid score function.  The centroid score function represents the 
  backbone atoms in full detail, but abstracts the sidechains into spherical 
  blobs.  This creates a smoother energy landscape that is easier to explore 
  broadly.  The landscape is sampled using Monte Carlo "local backbone moves", 
  i.e. moves that perturb the backbone within the region being sampled but not 
  outside of it.
  
* Step 3: Fullatom refinement

  The algorithm finishes by refining the loop conformation in the context of 
  the fullatom score function.  This is conceptually very similar to the 
  centroid refinement discussed above, except now all the atoms are 
  represented in full detail and both sidechain and local backbone Monte Carlo 
  moves are employed.

* Outputs:

  Each loop modeling simulation takes about 30 minutes and produces one model 
  structure as output.  Typically, to predict a structure for a single loop, 
  you would generate at least 500 such models and take whichever has the lowest 
  energy.  You might also calculate an RMSD for each model relative to the 
  lowest scoring one and look for funnels in score vs. RMSD space.
  
## LoopModeler

LoopModeler carries out an entire loop modeling simulation, including the 
build, centroid, and fullatom steps described above.  Each of these steps can 
be enabled, disabled, and otherwise configured.  By default, nothing needs to 
be specified and a standard loop modeling simulation will be performed.

For the loop building step, the default algorithm makes 10K attempts to create 
an initial closed backbone using kinematic closure (KIC).  For both refinement 
steps, the default algorithm uses a simulated annealing Monte Carlo algorithm
with no score function ramping (ramping of the rama and repulsive terms can be 
enabled).  In centroid mode, there are 5 annealing cycles, and in each the 
temperature drops from 2.0 to 1.0 over 20 steps times the length of the loop(s) 
being sampled.  The Monte Carlo moves are KIC followed by gradient 
minimization.  In fullatom mode, there are 5 annealing cycles, and in each the 
temperature drops from 1.5 to 0.5 over 20 steps times the length of the loop. 
The Monte Carlo moves are KIC followed by sidechain repacking (once every 20 
moves) or rotamer trials (otherwise) followed by gradient minimization of both 
backbone and sidechain DOFs.

Note that LoopModeler is really just a wrapper around the movers described in 
the rest of this section.  It's role is to provide sensible defaults and to 
make it easy to override some of those defaults without affecting others.  If 
you're willing to manually specify the default parameters, you could run the 
exact same simulation by composing other movers.  This approach would be more 
verbose, but in some ways it would also be more flexible.

```xml
<LoopModeler name=(&string) config=("" &string) loops_file=(&string) fast=(no &bool) 
scorefxn_cen=(&string) scorefxn_fa=(&string) task_operation=(&string) auto_refine=(yes &bool) >

    <Loop start=(&int) stop=(&int) cut=(&int) skip_rate=(0.0 &real) rebuild=(no &bool) />

    <(Any LoopMover tags) />...

    <Build skip=(no &bool) (any LoopBuilder option or subtag) />

    <Centroid skip=(no &bool) (any LoopProtocol option or subtag) />

    <Fullatom skip=(no &bool) (any LoopProtocol option or subtag) />

</LoopModeler>
```

Options:

* config: Set the base configuration to use.  The base configurations provide
  default values for every parameter of the simulation, but in practice they 
  mostly differ in how they configure the local backbone move used in the 
  refinement steps.  Currently, this option must be either "kic" or 
  "kic_with_frags".  "kic" is the default and carries out the algorithm as 
  described above.  "kic_with_frags" is similar to "kic", but uses fragments 
  instead of Ramachandran samples to make backbone moves.  If you use 
  "kic_with_frags", you must also specify fragment files on the command line 
  using the '-loops:frag_sizes' and '-loops:frag_files' options.

* loops_file: The path to a loops file specifying which regions of backbone to 
  model.  Note that this option will be silently ignored if one or more Loop 
  subtags are given.

* fast: If enabled, the simulation will use a severely reduced number of 
  cycles.  Only meant to be used for debugging.

* scorefxn_cen: The score function to use for the centroid refinement step.

* scorefxn_fa: The score function to use for the fullatom refinement step.

* task_operation: The task operation to use for sidechain packing in the 
  fullatom refinement step.  By default, all residues within 10A of the loop 
  will be packed.  If you specify your own task operation, only the residues 
  you specify will be packed or designed, so you are responsible for choosing a 
  reasonable packing shell.

* auto_refine: By default, both the centroid and fullatom steps automatically 
  run a refinement move after each backbone move.  In centroid mode, the 
  refinement move is just gradient minimization.  In fullatom mode, the 
  refinement move is sidechain repacking/rotamer trials followed by gradient 
  minimization.  These automatic refinement moves are normally convenient, 
  because they allow you to change the real sampling move (e.g. KIC, CCD, 
  backrub, etc.) without having to worry about things loop modeling normally 
  does behind the scenes.  But if you may want to manually specify your own 
  refinement moves, you have to disable auto_refine.  Also note that this 
  option can be specified either for the whole LoopModeler or individually in 
  the Centroid or Fullatom subtags.

Subtags:

* Loop: Specify a loop to model.  This tag may be specified multiple times to 
  sample multiple loops.  The skip rate controls how often that loop is 
  skipped when picking a random loop to sample.  The rebuild flag controls 
  whether or not the build step is skipped for that loop.  These are the same 
  fields that can be specified in a loops file.

* Any LoopMover: LoopMover subtags given within a LoopModeler tag control the 
  local backbone Monte Carlo moves used in the centroid and fullatom refinement 
  stages.  For example, this could be used to use backrub instead of KIC in an 
  otherwise default loop modeling simulation.  The technical definition of a 
  LoopMover is anything in C++ that inherits from LoopMover, but the practical 
  definition is any Mover described on this page.  You may specify LoopMover 
  tags before, after and/or within the Centroid and Fullatom tags.  If you 
  specify more than one LoopMover, they will be executed in the order given.  
  If you specify a LoopMover within the Centroid or Fullatom tags, it will only 
  apply to that mode.

* Build: Configure the build step.  If "skip" is enabled, none of the loops 
  will be rebuilt.  You may also provide this tag with any option or subtag 
  that would be understood by LoopBuilder.

* Centroid: Configure the centroid refinement step.  If "skip" is enabled, this 
  step will be skipped.  You may also provide this tag with any option or 
  subtag that would be understood by LoopProtocol.  This includes options to 
  control how many moves to make and how annealing should work.

* Fullatom: Configure the fullatom refinement step.  If "skip" is enabled, this 
  step will be skipped.  You may also provide this tag with any option or 
  subtag that would be understood by LoopProtocol.  This includes options to 
  control how many moves to make and how annealing should work.

Caveats:

* Only canonical protein backbones can be modeled by LoopModeler.  Noncanonical 
  polymers and ligands can be present in the pose; they just can't be part of 
  the regions being modeled.

* LoopModeler ignores the fold tree in the input pose and creates its own based 
  on the needs of the backbone moves that will be carried out.  The original 
  fold tree is restored just before LoopModeler returns.

## LoopBuilder

LoopBuilder builds in backbone atoms for loop regions where they are missing. 
The backbones created by LoopBuilder will have ideal bond lengths, ideal bond 
angles, and torsions picked from a Ramachandran distribution.  They should also 
not clash too badly with the surrounding protein.  Other than that, these 
backbones are not optimized at all.  But they are ready to be optimized by 
other movers.  Under the hood, LoopBuilder uses KIC to build backbones.  

Note that LoopModeler calls LoopBuilder, and that it's more common to use 
LoopModeler than it is to use LoopBuilder directly.

```xml
<LoopBuilder name=(&string) max_attempts=(10000 &int) loop_file=(&string)>

    <Loop start=(&int) stop=(&int) cut=(&int) skip_rate=(0.0 &real) rebuild=(no &bool) />

</LoopBuilder>

```

Options:

* max_attempts: Building a backbone can take many attempts, because on each 
  attempt KIC may fail to find a solution or may find a solution that clashes
  with the surrounding protein.  That said, the default number of attempts is 
  two or three orders of magnitude more than are usually needed, so I can't 
  think of any situation in which you'd have to change this.

* loop_file: See LoopModeler.

Subtags:

* Loop: See LoopModeler.

Caveats:

* See LoopModeler.

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
<LoopProtocol sfxn_cycles=(1 &int) temp_cycles=(1 &int ['x']) mover_cycles=(1 &int)
ramp_rep=(no &bool) ramp_rama=(no &bool) ramp_temp=(yes &bool) initial_temp=(1.5 &real) final_temp=(0.5 &real)
loop_file=(&string) scorefxn=(&string) auto_refine=(yes &bool) fast=(no &bool)>

    <Loop start=(&int) stop=(&int) cut=(&int) skip_rate=(0.0 &real) rebuild=(no &bool) />

    <AcceptanceCheck />

    <(Any LoopMover tags) />...

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

## KicMover

Generate new backbone conformations for the loop being sampled.  Conformations 
are generated using the kinematic closure (KIC) algorithm.  The idea behind KIC 
is that every time a new conformation is generated, all but 6 of the torsions 
can be picked however the user likes, e.g. from Ramachandran space (the most 
common choice), from a fragment library, according to some custom algorithm, 
etc.  The remaining 6 torsions are solved for analytically to ensure that the 
backbone stays closed and that all bond lengths and angles maintain ideal 
values.  KIC is a very general algorithm, good for building loops from 
scratch, modeling big conformational changes, modeling small conformational 
changes, and generating backbone ensembles.

```xml
<KicMover name(&string) loop_file=(&string) />
```

Right now KicMover is not really customizable at all, but I'm hoping to change 
this in the near-ish future (current date: November 2014).  In particular, I want to 
add a general way to specify different algorithms for perturbing the torsions, 
picking the pivots residues, and filtering the solutions.  In the meantime 
though, this mover is pretty static.

Options:

* loop_file: See LoopModeler.

Subtags:

* Loop: See LoopModeler.

Caveats:

* See LoopModeler.

References:

* Mandell DJ, Coutsias EA, Kortemme T. (2009). Sub-angstrom accuracy in protein loop reconstruction by robotics-inspired conformational sampling. Nature Methods 6(8):551-2.

* Coutsias EA, Seok C, Wester MJ, Dill KA. (2005). Resultants and loop closure. International Journal of Quantum Chemistry . 106(1), 176–189.

## RepackingRefiner

Repack the sidechains in and around the loop being sampled.  This mover uses 
the standard repacking algorithm in rosetta, which runs a Monte Carlo search 
for the lowest scoring arrangement of sidechains on a fixed backbone scaffold.
This mover is one of the default refiners in LoopModeler's fullatom step.

```xml
<RepackingRefiner name=(&string) task_operations=(&string) scorefxn=(&string) loop_file=(&string) />
```

Options:

* task_operations: The residues to pack and/or design.  By default, any residue 
  within 10A of the loop will be repacked and no residues will be designed.  If 
  you specify your own task operations, nothing will be repacked by default, so 
  make sure to let residues within some reasonable shell of the loop repack.

* scorefxn: The score function used for packing.  Required if not being used as 
  a subtag within some other LoopMover.

* loop_file: See LoopModeler.

Subtags:

* Loop: See LoopModeler.

Caveats:

* The input pose must have sidechains, i.e. it must be in fullatom mode.

* See LoopModeler.

## RotamerTrialsRefiner

Use rotamer trials to quickly optimize the sidechains in and around the loop 
being sampled.  Rotamer trials is a greedy algorithm for packing sidechains.
Each residue is considered only once, and is placed in its optimal rotamer 
given the present conformations of all its neighbors.  This mover is one of the 
default refiners in LoopModeler's fullatom step.

```xml
<RotamerTrialsRefiner name=(&string) task_operations=(&string) scorefxn=(&string) loop_file=(&string) />
```

Options:

* task_operations: The residues to optimize.  By default, any residue 
  within 10A of the loop will be subjected to rotamer trials.  If you specify 
  your own task operations, nothing will be repacked by default, so make sure 
  to let residues within some reasonable shell of the loop repack.

* scorefxn: The score function used for rotamer trials.  Required if not being 
  used as a subtag within some other LoopMover.

* loop_file: See LoopModeler.

Subtags:

* Loop: See LoopModeler.

Caveats:

* The input pose must have sidechains, i.e. it must be in fullatom mode.

* See LoopModeler.

## MinimizationRefiner

Perform gradient minimization on the loop being sampled.  Both the sidechain 
and backbone atoms are allowed to move, and no restraints are used.  This mover 
a default refiner in LoopModeler's centroid and fullatom steps, and often 
accounts for a majority of LoopModeler's runtime.

```xml
<MinimizationRefiner name=(&string) scorefxn=(&string) loops_file=(&string) />
```

Options:

* scorefxn: The score function used for rotamer trials.  Required if not being 
  used as a subtag within some other LoopMover.

* loop_file: See LoopModeler.

Subtags:

* Loop: See LoopModeler.

Caveats:

* See LoopModeler.

## PrepareForCentroid

Convert a pose into centroid mode in preparation for low-resolution loop 
modeling.  This is used internally by LoopModeler.

```xml
<PrepareForCentroid name=(&string) />
```

## PrepareForFullatom

Convert a pose into fullatom mode in preparation for high-resolution loop 
modeling.  This is used internally by LoopModeler.

```xml
<PrepareForFullatom name=(&string) force_repack=(no &bool) scorefxn=(&string) />
```

Options:

* force_repack: By default, only sidechains that are part of the loop and 
  sidechains that couldn't be recovered from the input structure are repacked 
  when converting to fullatom mode.  If the input pose is already in fullatom 
  mode, most positions may be left unchanged.  Enabling this option forces the 
  entire protein to be repacked regardless.

* scorefxn: The name of the score function to use for repacking.  Required.
