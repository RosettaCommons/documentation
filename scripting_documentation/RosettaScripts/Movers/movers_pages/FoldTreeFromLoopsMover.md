# FoldTreeFromLoops
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FoldTreeFromLoops

Wrapper for utility function fold\_tree\_from\_loops. Defines a fold tree based on loop definitions with the fold tree going up to the loop n-term, and the c-term and jumping between. Cutpoints define the kinematics within the loop

```xml
<FoldTreeFromLoops name="(&string)" loops="(&string)"/>
```

the format for loops is: Start:End:Cut,Start:End:Cut...

and either pdb or rosetta numbering are allowed. The start, end and cut points are computed at apply time so would respect loop length changes.



##See Also

* [[FoldTree overview]]
* [[VirtualRootMover]]
* [[HotspotDisjointedFoldTreeMover]]
* [[Loop file format|loops-file]]
* [[LoopModelerMover]]
* [[Loopmodel application|loopmodel]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopLengthChangeMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
