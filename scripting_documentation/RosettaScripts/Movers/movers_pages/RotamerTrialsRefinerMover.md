# RotamerTrialsRefiner
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RotamerTrialsRefiner

Use rotamer trials to quickly optimize the sidechains in and around the loop 
being sampled.  Rotamer trials is a greedy algorithm for packing sidechains.
Each residue is considered only once, and is placed in its optimal rotamer 
given the present conformations of all its neighbors.  This mover is one of the 
default refiners in LoopModeler's fullatom step.

```xml
<RotamerTrialsRefiner name="(&string)" task_operations="(&string)" scorefxn="(&string)" loop_file="(&string)"/>
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

##See Also

* [[Fixbb]]: Application to pack rotamers
* [[PackRotamersMover]]
* [[SymPackRotamersMover]]: Symmetric version of this mover
* [[PackRotamersMoverPartGreedyMover]]
* [[TryRotamersMover]]
* [[RotamerTrialsMover]]
* [[RotamerTrialsMinMover]]
* [[PrepackMover]]
* [[RepackMinimizeMover]]
* [[MinPackMover]]
* [[I want to do x]]: Guide to choosing a mover

