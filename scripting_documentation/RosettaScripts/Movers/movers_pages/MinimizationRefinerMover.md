# MinimizationRefiner
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MinimizationRefiner

Perform gradient minimization on the loop being sampled.  Both the sidechain 
and backbone atoms are allowed to move, and no restraints are used.  This mover 
a default refiner in LoopModeler's centroid and fullatom steps, and often 
accounts for a majority of LoopModeler's runtime.

```xml
<MinimizationRefiner name="(&string)" scorefxn="(&string)" loops_file="(&string)"/>
```

Options:

* scorefxn: The score function used for rotamer trials.  Required if not being 
  used as a subtag within some other LoopMover.

* loop_file: See LoopModeler.

Subtags:

* Loop: See LoopModeler.

Caveats:

* See LoopModeler.


##See Also

* [[LoopModelerMover]]
* [[RosettaScriptsLoopModeling]]
* [[MinMover]]
* [[I want to do x]]: Guide to choosing a mover