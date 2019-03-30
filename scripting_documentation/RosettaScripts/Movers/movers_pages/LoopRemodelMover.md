# LoopRemodel
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopRemodel

Perturbs and/or refines a set of user-defined loops. Useful to sample a variety of loop conformations.

```xml
<LoopRemodel name="&string" auto_loops="(0 &bool)" loop_start_(pdb_num/res_num) loop_end_(pdb_num/res_num) hurry="(0 &bool)" cycles="(10 &Size)" protocol="(ccd &string)" perturb_score="(score4L &string)" refine_score="(score12 &string)" perturb="(0 &bool)" refine="(1 &bool)" design="(0 &bool)"/>
```

-   pdb\_num/res\_num: see the main [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more.
-   auto\_loops: use loops defined by previous LoopFinder mover? (overrides loop\_start/end)
-   loop\_start\_pdb\_num: start of the loop
-   loop\_end\_pdb\_num: end of the loop
-   hurry: 1 = fast sampling and minimization. 0 = Use full-blown loop remodeling.
-   cycles: if hurry=1, number of modeling cycles to perform. Each cycle is 50 steps of mc-accepted kinematic loop modeling, followed by a repack of the surrounding area. if hurry=0 and protocol=remodel, this controls the max number of times to attempt closure with the remodel protocol (low cycles might leave chain breaks!)
-   protocol: Only activated if hurry=0. Choose "kinematic", "ccd", or "remodel". ccd appears to work best at the moment.
-   perturb\_score: scorefunction to use for loop perturbation
-   refine\_score: scorefunction to use for loop refinement
-   perturb: perturb loops for greater diversity?
-   refine: refine loops?
-   design: perform design during loop modeling?

##See Also

* [[RosettaScriptsLoopModeling]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[Fragments file format|fragment-file]]
* [[Resource Manager documentation|ResourceManager]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopLengthChangeMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
