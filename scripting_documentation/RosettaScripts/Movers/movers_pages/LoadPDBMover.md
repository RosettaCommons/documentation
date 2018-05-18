# LoadPDB
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoadPDB

Replaces current PDB with one from disk. This is probably only useful in checkpointing, since this mover deletes all information gained so far in the trajectory.

```xml
<LoadPDB name="(&string)" filename="(&string)"/>
```

-   filename: what filename to load?


##See Also

* [[DumpPDBMover]]
* [[SavePoseMover]]
* [[I want to do x]]: Guide to choosing a mover
