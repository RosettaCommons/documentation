# SpinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SpinMover

Allows random spin around an axis that is defined by the jump. Works preferentially good in combination with a loopOver or best a GenericMonteCarlo and other movers together. Use SetAtomTree to define the jump atoms.

```xml
<SpinMover name="(&string)" jump_num="(1 &integer)"/>
```


##See Also

* [[FoldTree Overview]]
* [[GenericMonteCarloMover]]
* [[LoopOverMover]]
* [[AtomTreeMover]]
* [[I want to do x]]: Guide to choosing a mover
