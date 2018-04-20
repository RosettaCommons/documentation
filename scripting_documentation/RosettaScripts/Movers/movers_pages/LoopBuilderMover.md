# LoopBuilder
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopBuilder

LoopBuilder builds in backbone atoms for loop regions where they are missing.  However, these need to somehow be in the original PDB - this mover DOES NOT create the atoms and residues themselves! 
The backbones created by LoopBuilder will have ideal bond lengths, ideal bond 
angles, and torsions picked from a Ramachandran distribution.  They should also 
not clash too badly with the surrounding protein.  Other than that, these 
backbones are not optimized at all.  But they are ready to be optimized by 
other movers.  Under the hood, LoopBuilder uses KIC to build backbones.  

Note that LoopModeler calls LoopBuilder, and that it's more common to use 
LoopModeler than it is to use LoopBuilder directly.

```xml
<LoopBuilder name="(&string)" max_attempts="(10000 &int)" loop_file="(&string)">

    <Loop start="(&int)" stop="(&int)" cut="(&int)" skip_rate="(0.0 &real)" rebuild="(no &bool)"/>

</LoopBuilder>

```

Options:

* max_attempts: Building a backbone can take many attempts, because on each 
  attempt KIC may fail to find a solution or may find a solution that clashes
  with the surrounding protein.  That said, the default number of attempts is 
  two or three orders of magnitude more than are usually needed, so I can't 
  think of any situation in which you'd have to change this.

* [[loop_file|loops-file]]: See [[LoopModeler|LoopModelerMover]].

Subtags:

* Loop: See [[LoopModeler|LoopModelerMover]].

Caveats:

* See LoopModeler.

##See Also

* [[RosettaScriptsLoopModeling]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopLengthChangeMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
