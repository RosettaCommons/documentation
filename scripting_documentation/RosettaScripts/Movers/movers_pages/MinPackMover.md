# MinPackMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MinPackMover

Packs then minimizes a sidechain before calling MonteCarlo on the change. It can be modified with user supplied ScoreFunction or TaskOperation. It does not do backbone, ridged body minimization.

```xml
<MinPackMover name="&string" scorefxn="('score12' &string)" task_operations="(&string,&string,&string)" nonideal="(0 &bool)" cartesian="(0 &bool)" off_rotamer_pack="(0 &bool)"/>
```

It is reccomended to change the weights you are using to the **score12minpack** weights. These are the standard score12 weights with the reference energies refit for sequence recovery profile when using the MinPackMover. Without these weights you will see a lot of Tryptophan residues on the surface of a protein.

-   Tags:
-   **scorefxn** : scorefunction to use for packing and minimization, default is score12. It is reccomended to change this to **score12minpack** .
-   **task\_operations** : comma-separated list of task operations. These must have been previously defined in the TaskOperations section. Default is to design all residues.
-   **nonideal** : open up the bond-angle- and bond-length DOFs to minimization
-   **cartesian** : use cartesian minimization
-   **off_rotamer_pack** : instead of using core::pack::min_pack, use core::pack::off_rotamer_pack
-   What is the input FoldTree, what is the output FoldTree.
    -   The mover itself is not FoldTree sensitive, however the TaskOperations might be. This mover does not modify the fold tree.
    -   Does it take and output a default FoldTree or does it need/output a modified fold tree.
-   Does it take a pose with a certain chemical or topological property?
    -   Does not require a special type of Pose.
-   Does it change the length of the Pose?
    -   No.
-   Does it change the ConstraintSet?
    -   No.
-   When given some particular piece of data (mover? fragment set? scorefunction), does it keep a copy of it or a pointer to it?
    -   It does not modify the ScoreFunction.


##See Also

* [[RepackMinimizeMover]]
* [[PrepackMover]]
* [[Fixbb]]: Application to pack rotamers
* [[PackRotamersMover]]
* [[Minimization overview]]
* [[RestrictRegionMover]]
* [[SymPackRotamersMover]]
* [[PackRotamersMoverPartGreedyMover]]
* [[TryRotamersMover]]
* [[MinPackMover]]
* [[I want to do x]]: Guide to choosing a mover
