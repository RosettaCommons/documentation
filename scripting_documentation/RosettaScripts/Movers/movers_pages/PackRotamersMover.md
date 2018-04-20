# PackRotamersMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PackRotamersMover

Repacks sidechains with user-supplied options, including TaskOperations


 
```xml
<PackRotamersMover name="&string" scorefxn="(score12 &string)" task_operations="(&string,&string,&string)"/>
```

-   scorefxn: scorefunction to use for repacking (NOTE: the error "Scorefunction not set up for nonideal/Cartesian scoring" can be fixed by adding 'Reweight scoretype="pro_close" weight="0.0"' under the talaris2013_cart scorefxn in the SCOREFXNS section)
-   taskoperations: comma-separated list of task operations. These must have been previously defined in the TaskOperations section.

**NOTE:** By default, packing includes sampling *all possible sidechains*, i.e. **it performs sequence design!**
The way to prevent this is to pass a [[RestrictToRepacking|RestrictToRepackingOperation]] task operation:
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
