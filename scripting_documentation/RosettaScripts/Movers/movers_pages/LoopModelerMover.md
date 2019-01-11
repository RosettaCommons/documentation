# LoopModeler
*Back to [[Mover|Movers-RosettaScripts]] page.*
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
<LoopModeler name="(&string)" config="('' &string)" loops_file="(&string)" fast="(no &bool)" 
scorefxn_cen="(&string)" scorefxn_fa="(&string)" task_operations="(&string)" auto_refine="(yes &bool)" loophash_perturb_sequence="(false &bool)" loophash_seqposes_no_mutate="('' &string)">

    <Loop start="(&int)" stop="(&int)" cut="(&int)" skip_rate="(0.0 &real)" rebuild="(no &bool)"/>

    <(Any LoopMover tags)/>...

    <Build skip="(no &bool)" (any LoopBuilder option or subtag)/>

    <Centroid skip="(no &bool)" (any LoopProtocol option or subtag)/>

    <Fullatom skip="(no &bool)" (any LoopProtocol option or subtag)/>

</LoopModeler>
```

Options:

* config: Set the base configuration to use.  The base configurations provide
  default values for every parameter of the simulation, but in practice they 
  mostly differ in how they configure the local backbone move used in the 
  refinement steps.  Currently, this option must be either "kic", "kic_with_frags"
  or "loophash_kic".  "kic" is the default and carries out the algorithm as 
  described above.  "kic_with_frags" is similar to "kic", but uses fragments 
  instead of Ramachandran samples to make backbone moves. "loophash_kic" uses loophash
  to find an existing fragment that can approximately close the gap and use it
  as a guess for the kinematic closure.  If you use "kic_with_frags", you must 
  also specify fragment files on the command line using the `-loops:frag_sizes` 
  and `-loops:frag_files` options. If you use "loophash_kic", you must also specify
  the path to the loophash database with the command line option `-lh:db_path` and
  the sizes of loophash fragments with the command line option `-lh:loopsizes`. You can
  use multiple loophash fragment sizes, but the minimum size is 6 and the maximum
  size is `2 + (length of the loop to be modeled)`.

* loops_file: The path to a loops file specifying which regions of backbone to 
  model.  Note that this option will be silently ignored if one or more Loop 
  subtags are given.

* fast: If enabled, the simulation will use a severely reduced number of 
  cycles.  Only meant to be used for debugging.

* scorefxn_cen: The score function to use for the centroid refinement step.

* scorefxn_fa: The score function to use for the fullatom refinement step.

* task_operations: The task operation(s) to use for sidechain packing in the 
  fullatom refinement step.  By default, all residues within 10A of the loop 
  will be packed.  If you specify your own task operations, only the residues 
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

* loophash_perturb_sequence: If set to true, the sequence of the fragment from
  loophash will replace the loop sequence.

* loophash_seqposes_no_mutate: Sequence positions that should not be mutated by
  LoopHashKIC. 

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

Examples:

Run the standard loop modeling algorithm described at the top of this section:

```xml
<LoopModeler name="modeler"/>
```

Use a fragment library to sample loop conformations:

```xml
<LoopModeler name="modeler" config="kic_with_frags"/>
```

Use loop hash to sample loop conformations as well as the loop sequence:

```xml
<LoopModeler name="modeler" config="loophash_kic" loophash_perturb_sequence="true" loophash_seqposes_no_mutate="17,32,69" />
```

Run a quick test simulation with a vastly reduced number of iterations:

```xml
<LoopModeler name="modeler" fast="yes"/>
```

Generate a backbone ensemble by skipping the initial build step:

```xml
<LoopModeler name="modeler">
    <Build skip="yes"/>
</LoopModeler>
```

Caveats:

* Only canonical protein backbones can be modeled by LoopModeler.  Noncanonical 
  polymers and ligands can be present in the pose; they just can't be part of 
  the regions being modeled.

* LoopModeler ignores the [[fold tree|foldtree-overview]] in the input pose and creates its own based 
  on the needs of the backbone moves that will be carried out.  The original 
  fold tree is restored just before LoopModeler returns.


##See Also

* [[RosettaScriptsLoopModeling]]
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[Fragments file format|fragment-file]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopLengthChangeMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
