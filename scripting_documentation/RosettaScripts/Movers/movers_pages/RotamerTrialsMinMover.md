# RotamerTrialsMinMover
## RotamerTrialsMinMover

This mover goes through each repackable/redesignable position in the pose, taking every permitted rotamer in turn, minimizing it in the context of the current pose, and evaluating the energy. Each position is then updated to the lowest energy minimized rotamer. It does not consider coordinated changes at multiple residues, and may need several invocations to reach convergence.

In addition to the score function, the mover takes a list of task operations to specify which residues to consider. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]] .)

```
<RotamerTrialsMinMover name="&string" scorefxn=(&string) task_operations=(&string,&string,&string) nonideal=(&bool)/>
```


