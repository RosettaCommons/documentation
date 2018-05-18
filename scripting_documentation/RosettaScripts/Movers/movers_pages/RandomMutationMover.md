# RandomMutation
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RandomMutation

Introduce a random mutation in a position allowed to redesign to an allowed residue identity. Control the residues and the target identities through `     task_operations    ` . The protein will be repacked according to `     task_operations    ` and `     scorefxn    ` to accommodate the mutated amino acid. The mover can work with symmetry poses; simply use [[SetupForSymmetryMover]] and run. It will figure out that it needs to do symmetric packing for itself.

This can be used in conjunction with GenericMonteCarlo to generate trajectories of affinity maturation.

```xml
<RandomMutation name="(&string)" task_operations="(&string comma-separated taskoperations)" scorefxn="(score12 &string)"/>
```


##See Also

* [[GreedyOptMutationMover]]
* [[GenericMonteCarloMover]]
* [[RotamerTrialsMover]]
* [[PackRotamersMover]]
* [[Point mutant scan application|pmut-scan-parallel]]
* [[I want to do x]]: Guide to choosing a mover
