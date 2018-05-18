# designminimizehbonds
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DesignMinimizeHBonds

Same as for RepackMinimize with the addition that a list of target residues to be hbonded can be defined. Within a sphere of 'interface\_cutoff\_distance' of the target residues,the residues will be set to be designed.The residues that are allowed for design are restricted to hbonding residues according to whether donors (STRKWYQN) or acceptors (EDQNSTY) or both are defined. If residues have been designed that do not, after design, form hbonds to the target residues with energies lower than the hbond\_energy, then those are turned to Ala.

```xml
<DesignMinimizeHbonds name="(design_minimize_hbonds &string)" hbond_weight="(3.0 &float)" scorefxn_design="(score12 &string)" scorefxn_minimize="score12)" donors="design donors? &bool" acceptors="design acceptors? &bool" bb_hbond="(0 &bool)" sc_hbond="(1 &bool)" hbond_energy="(-0.5 &float)" interface_cutoff_distance="(8.0 &float)" repack_partner1="(1 &bool)" repack_partner2="(1 &bool)" design_partner1="(0 &bool)" design_partner2="(1 &bool)" repack_non_ala="(1 &bool)" min_rigid_body="(1 &bool)" task_operations="('' &string)">
        <residue pdb_num/res_num="(&string)" />
</DesignMinimizeHbonds>
```

-   hbond\_weight: sets the increase (in folds) of the hbonding terms in each of the scorefunctions that are defined.
-   bb\_hbond: do backbone-backbone hbonds count?
-   sc\_hbond: do backbone-sidechain and sidechain-sidechain hbonds count?
-   hbond\_energy: what is the energy threshold below which an hbond is counted as such.
-   repack\_non\_ala,task\_operations:see RepackMinimize
-   optimize\_fold\_tree: see DockingProtocol
-   pdb\_num/res\_num: see the [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more.


##See Also

* [[RepackMinimizeMover]]
* [[MinPackMover]]
* [[PackRotamersMover]]
* [[I want to do x]]: Guide to choosing a mover
