# DockingProtocol
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DockingProtocol

Runs the full (post refactoring) docking protocol with the defaults currently in trunk. This mover is not currently sensitive to symmetry.

```xml
<DockingProtocol name="&string" docking_score_low="(interchain_cen &string)" docking_score_high="(docking &string)" low_res_protocol_only="(0 &bool)" docking_local_refine(0 &bool) dock_min="(0 &bool)" ignore_default_docking_task="(0 &bool)" task_operations="('' comma-separated list)" partners="(&string)"/>
```

-   docking\_score\_low: score function used in centroid mode of the docking steps
-   docking\_score\_high: score function used in full atom mode of docking
-   low\_res\_protocol\_only: if true, only do centroid level docking
-   docking\_local\_refine: if true skip the centroid level and only do full atom docking
-   dock\_min: if true minimize the final full atom structure
-   partners: allows fold tree modifications to dock across multiple chains (example: docking chains L+H with A is partners="LH\_A")
-   ignore\_default\_docking\_task: allows you to ignore the default DockingTaskFactory set by docking and give it your own definition of an interface. Not suggested.
-   task\_operations: comma separated list of TaskOperations, these will be appended onto that defined by DockingTaskFactory, unless ignore\_default\_docking\_task is turned on.
-   partners: \_ separated list of chains to dock.


##See Also

* [Protein-protein docking tutorial](https://www.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking)
* [[DockingMover]]
* [[DockWithHotspotMover]]
* [[FlexPepDockMover]]
* [[HighResDockerMover]]
* [[Docking applications]]: Command line applications for docking
* [[I want to do x]]: Choosing a mover
