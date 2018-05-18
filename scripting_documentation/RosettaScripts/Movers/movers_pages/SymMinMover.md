# SymMinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SymMinMover

The symmetric version of min mover (they take the same tags as asymmetric version). Notice that to refine symmetric degrees of freedom, all jumps must be allowed to move with the tag 'jump=ALL'.

```xml
<SymMinMover name="min1" scorefxn="ramp_rep1" bb="1" chi="1" jump="ALL"/>
```


##See Also

* [[TaskAwareSymMinMover]]: The task-aware version of this mover
* [[MinMover]]: Non-symmetric version of this mover
* [[Symmetry]]: Using symmetry in Rosetta
* [[SymmetryAndRosettaScripts]]
* [[Minimization overview]]
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[DetectSymmetryMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
* [[I want to do x]]: Guide to choosing a mover
