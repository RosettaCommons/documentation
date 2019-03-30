# RepackingRefiner
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RepackingRefiner

Repack the sidechains in and around the loop being sampled.  This mover uses 
the standard repacking algorithm in rosetta, which runs a Monte Carlo search 
for the lowest scoring arrangement of sidechains on a fixed backbone scaffold.
This mover is one of the default refiners in LoopModeler's fullatom step.

```xml
<RepackingRefiner name="(&string)" task_operations="(&string)" scorefxn="(&string)" loop_file="(&string)"/>
```

Options:

* [[task_operations|TaskOperations-RosettaScripts]]: The residues to pack and/or design.  By default, any residue 
  within 10A of the loop will be repacked and no residues will be designed.  If 
  you specify your own task operations, nothing will be repacked by default, so 
  make sure to let residues within some reasonable shell of the loop repack.

* scorefxn: The score function used for packing.  Required if not being used as 
  a subtag within some other LoopMover.

* [[loop_file|loops-file]]: See [[LoopModelerMover]].

Subtags:

* Loop: See [[LoopModelerMover]].

Caveats:

* The input pose must have sidechains, i.e. it must be in fullatom mode.

* See [[LoopModelerMover]].


##See Also

* [[LoopModelerMover]]
* [[RosettaScriptsLoopModeling]]
* [[Loop file format|loops-file]]
* [[Loopmodel application|loopmodel]]
* [[LoopRemodelMover]]
* [[PackRotamersMover]]