# RotamerTrialsMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RotamerTrialsMover

This mover goes through each repackable/redesignable position in the pose, taking every permitted rotamer in turn, and evaluating the energy. Each position is then updated to the lowest energy rotamer. It does not consider coordinated changes at multiple residues, and may need several invocations to reach convergence.

In addition to the score function, the mover takes a list of task operations to specify which residues to consider. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]] .)

```xml
<RotamerTrialsMover name="&string" scorefxn="(&string)" task_operations="(&string,&string,&string)" show_packer_task="(0 &bool)" />
```


##See Also

* [[Fixbb]]: Application to pack rotamers
* [[SymPackRotamersMover]]: Symmetric version of this mover
* [[PackRotamersMover]]
* [[PackRotamersMoverPartGreedyMover]]
* [[TryRotamersMover]]
* [[PrepackMover]]
* [[RepackMinimizeMover]]
* [[RotamerTrialsMover]]
* [[RotamerTrialsMinMover]]
* [[RotamerTrialsRefinerMover]]
* [[MinPackMover]]
* [[I want to do x]]: Guide to choosing a mover
