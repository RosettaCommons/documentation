# RotamerTrialsMinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RotamerTrialsMinMover

This mover goes through each repackable/redesignable position in the pose, taking every permitted rotamer in turn, minimizing it in the context of the current pose, and evaluating the energy. Each position is then updated to the lowest energy minimized rotamer. It does not consider coordinated changes at multiple residues, and may need several invocations to reach convergence.

In addition to the score function, the mover takes a list of task operations to specify which residues to consider. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]] .)

```xml
<RotamerTrialsMinMover name="&string" scorefxn="(&string)" task_operations="(&string,&string,&string)" nonideal="(&bool)"/>
```
##See Also

* [[Fixbb]]: Application to pack rotamers
* [[MinPackMover]]
* [[PrepackMover]]
* [[RepackMinimizeMover]]
* [[Minimization overview]]
* [[PackRotamersMover]]
* [[SymPackRotamersMover]]: Symmetric version of this mover
* [[PackRotamersMoverPartGreedyMover]]
* [[TryRotamersMover]]
* [[RotamerTrialsMover]]
* [[RotamerTrialsRefinerMover]]
* [[I want to do x]]: Guide to choosing a mover
