# Docking
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Docking

Does both centroid and full-atom docking

```xml
<Docking name="&string" score_low="(score_docking_low &string)" score_high="(score12 &string)" fullatom="(0 &bool)" local_refine="(0 &bool)" jumps="(1 &Integer vector)" optimize_fold_tree="(1 &bool)" conserve_foldtree="(0 &bool)" design="(0 &bool)" ignore_default_docking_task="(0 &bool)" task_operations="('' comma-separated list)"/>
```

-   score\_low is the scorefxn to be used for centroid-level docking
-   score\_high is the scorefxn to be used for full atom docking
-   fullatom: if true, do full atom docking
-   local\_refine: if true, skip centroid. Note that fullatom=0 and local\_refine=1 together will result in NO DOCKING!
-   jumps is a comma-separated list of jump numbers over which to carry out rb motions
-   optimize\_fold\_tree: should DockingProtocol make the fold tree for this pose? This should be turned to 0 only if AtomTree is used
-   conserve\_foldtree: should DockingProtocol reset the fold tree to the input one after it is done
-   design: Enable interface design for all chains downstream of the rb\_jump
-   ignore\_default\_docking\_task: allows you to ignore the default docking task and only use the ones defined in your task\_operations section


##See Also

* [[DockingProtocolMover]]
* [[DockWithHotspotMover]]
* [[FlexPepDockMover]]
* [[HighResDockerMover]]
* [[Docking applications]]: Command line applications for docking
* [[I want to do x]]: Choosing a mover
