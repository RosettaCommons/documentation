# RepackMinimize
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RepackMinimize

RepackMinimize does the design/repack and minimization steps using different score functions as defined by the protocol. For most purposes, the combination of [[PackRotamersMover|PackRotamersMover]] with [[MinMover|MinMover]] provide more flexibility and transparency than RepackMinimize, and are advised.

repack\_partner1 (and 2) defines which of the partners to design. If no particular residues are defined, the interface is repacked/designs. If specific residues are defined, then a shell of residues around those target residues are repacked/designed and minimized. repack\_non\_ala decides whether or not to change positions that are not ala. Useful for designing an ala\_pose so that positions that have been changed in previous steps are not redesigned. min\_rigid\_body minimize rigid body orientation. (as in docking)

```xml
<RepackMinimize name="&string" scorefxn_repack="(score12 &string)" scorefxn_minimize="(score12 &string)" repack_partner1="(1 &bool)" repack_partner2="(1 &bool)" design_partner1="(0 &bool)" design_partner2="(1 &bool)" interface_cutoff_distance="(8.0 &Real)" repack_non_ala="(1 &bool)" minimize_bb="(1 &bool * see below for more details)" minimize_rb="(1 &bool)" minimize_sc="(1 &bool)" optimize_fold_tree="(1 & bool)" task_operations="('' &string)">
    <residue pdb_num/res_num="(&string)" />
</RepackMinimize>
```

-   scorefxn\_repack
-   scorefxn\_minimize
-   interface\_cutoff\_distance: Residues farther away from the interface than this cutoff will not be designed or minimized.
-   repack\_non\_ala: if true, change positions that are not ala. if false, leave non-ala positions alone. Useful for designing an ala\_pose so that positions that have been changed in previous steps are not redesigned.
-   minimize\_bb\*: minimize back bone conformation? (\*see line below)
-   minimize\_bb\_ch1 and/or minimize\_bb\_ch2: allows to specify which chain(s)' backbone will be minimized
-   minimize\_rb: minimize rigid body orientation? (as in docking)
-   optimize\_fold\_tree: see above
-   task\_operations: comma-separated list of task operations. This is a safer way of working with user-defined restrictions than automatic\_repacking=false.
-   pdb\_num/res\_num: see the main [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more.

If no repack\_partner1/2 options are set, you can specify repack=0/1 to control both. Similarly with design\_partner1/2 and design=0/1


##See Also

* [[DesignMinimizeHbondsMover]]
* [[PackRotamersMover]]
* [[MinMover]]
* [[MinPackMover]]
* [[PrepackMover]]
* [[Minimization overview]]
* [[Fixbb]]: Application to pack rotamers
* [[SymPackRotamersMover]]: Symmetric version of this mover
* [[PackRotamersMoverPartGreedyMover]]
* [[TryRotamersMover]]
* [[RotamerTrialsMover]]
* [[RotamerTrialsMinMover]]
* [[RotamerTrialsRefinerMover]]
* [[I want to do x]]: Guide to choosing a mover
