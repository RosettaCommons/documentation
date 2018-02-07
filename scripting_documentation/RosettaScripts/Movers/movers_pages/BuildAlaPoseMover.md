# build\_Ala\_pose
*Back to [[Mover|Movers-RosettaScripts]] page.*
## build\_Ala\_pose

Turns either or both sides of an interface to Alanines (except for prolines and glycines that are left as in input) in a sphere of 'interface\_distance\_cutoff' around the interface. Useful as a step before design steps that try to optimize a particular part of the interface. The alanines are less likely to 'get in the way' of really good rotamers.

```xml
<build_Ala_pose name="(ala_pose &string)" partner1="(0 &bool)" partner2="(1 &bool)" interface_cutoff_distance="(8.0 &float)" task_operations="('' &string)"/>
```

-   task\_operations: see [RepackMinimize](#RepackMinimize)


##See Also

* [[MakePolyXMover]]
* [[SaveAndRetrieveSidechainsMover]]
* [[PackRotamersMoverPartGreedyMover]]
* [[PredesignPerturbMover]]
* [[EnzRepackMinimizeMover]]
* [[I want to do x]]: Guide to choosing a mover
