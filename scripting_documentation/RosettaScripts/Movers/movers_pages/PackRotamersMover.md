# PackRotamersMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PackRotamersMover

Repacks sidechains with user-supplied options, including TaskOperations (and, for noncanonical design, PackerPalettes).

## Usage

[[include:mover_PackRotamersMover_type]]

**NOTE:** By default, packing includes sampling *all sidechains in the current PackerPalette*, i.e. **it performs sequence design!**
The way to prevent this, if you only want to pack existing side-chains without changing side-chain identity, is to pass a [[RestrictToRepacking|RestrictToRepackingOperation]] task operation:
```xml
<TASKOPERATIONS>
   <RestrictToRepacking name="repackonly" />
</TASKOPERATIONS>

[...]

<PackRotamersMover name="&string" scorefxn="(score12 &string)" task_operations="repackonly"/>

```

##See Also

* [[Fixbb]]: Application to pack rotamers and do sequence design (not a mover)
* [[SymPackRotamersMover]]: Symmetric version of this mover
* [[PackRotamersMoverPartGreedyMover]]
* [[RestrictRegionMover]]
* [[TryRotamersMover]]
* [[RotamerTrialsMover]]
* [[RotamerTrialsMinMover]]
* [[RotamerTrialsRefinerMover]]
* [[MinPackMover]]
* [[PrepackMover]]
* [[RepackMinimizeMover]]
* [[I want to do x]]: Guide to choosing a mover
