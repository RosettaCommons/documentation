# LoopLengthChange
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopLengthChange

Changes a loop length without closing it.

```xml
<LoopLengthChange name="(&string)" loop_start="(&resnum)" loop_end="(&resnum)" delta="(&int)"/>
```

-   loop\_start, loop\_end: where the loop starts and ends.
-   delta: by how much to change. Negative values mean cutting the loop.

##See Also

* [[RosettaScriptsLoopModeling]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
