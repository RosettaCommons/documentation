# LoopMoverFromCommandLine
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopMoverFromCommandLine

Perturbs and/or refines a set of loops from a loop file. Also takes in fragment libraries from command line (-loops:frag\_sizes , -loops:frag\_files). Has kinematic, ccd and automatic protocols.

```xml
<LoopMoverFromCommandLine name="&string" loop_file="('loop.loops' &string)" protocol="(ccd &string)" perturb_score="(score4L &string)" refine_score="(score12 &string)" perturb="(0 &bool)" refine="(1 &bool)"/>
```

-   protocol: Only activated if hurry=0. Choose "automatic", "kinematic" or "ccd".If you set automatic, this mover becomes a wrapper around the 'modern' version of LoopRemodelMover which has all of the loop options defined within it. This is the recommended way of activating this mover. If you do that, then you get access to the following string options: relax (no,&string), refine (ccd is best), intermedrelax (no is default and is best), remodel (quick\_ccd is best).
-   perturb\_score: scorefunction to use for loop perturbation
-   refine\_score: scorefunction to use for loop refinement
-   perturb: perturb loops for greater diversity?
-   refine: refine loops?
-   loop\_file: loop file that should be in current working directory using minirosetta loop format.

For protocol="automatic" (Based on [[Loop Modeling Application|loopmodel]] and [[LoopRemodel|LoopRemodelMover]]):

```xml
<LoopMoverFromCommandLine name="&string" loop_file="('loop.loops' &string)" protocol="automatic" perturb_score="(score4L &string)" refine_score="(score12 &string)" perturb="(0 &bool)" refine="(no &string)" remodel="(quick_ccd &string)" relax="(no, &string)" intermedrelax="(no &string)"/>
```

-   refine:'no','refine\_ccd','refine\_kic'. This option controls the fullatom refinement stage of loop modeling.
-   remodel:'no','perturb\_ccd','perturb\_kic','quick\_ccd','quick\_ccd\_moves','old\_loop\_relax'.
-   relax:'no','fastrelax','shortrelax','full relax'. Controls whether a full-structure relax occurs after loop modeling.
-   intermedrelax: Currently not used; eventually may provide for a full-pose relax between centroid and full atom modeling.


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
