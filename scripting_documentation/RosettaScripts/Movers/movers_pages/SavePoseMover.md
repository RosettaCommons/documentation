# SavePoseMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SavePoseMover

This mover allows one to save a pose at any time point through out a trajectory or from disk, and recall it any time point again to replace a current pose or pass it to a mover or SimpleMetric. Can also just be used with filter, eg. delta filters.

```xml
<SavePoseMover name="native" restore_pose="(1, &bool)" reference_name="(&string)" pdb_file="(&string)" />
```

-   restore\_pose - If you set this to 0, the pose will be _saved_ as whatever name is specified by reference_name.  If you set it to 1 (the default), it will delete the current pose and _restore the pose previously saved_ as reference_name as the current pose.
-   reference\_name - When saving a pose, the current pose will be saved under this name, to be referenced by other instances of SavePoseMover or other movers/filters.  When restoring a pose, this should be the name used by a previous SavePoseMover in which restore_pose=0.
-   pdb\_file - Optional. If present, will load the given PDB file into the referenced pose at parse time, rather than using the current pose.  If used, restore_pose should be set to 1, as the intent will be to replace the current pose with this one.


Here is an old example for grafting CDRs into an antibody (before the AntibodyCDRGrafter mover was created.)  Note that currently, `all=x` need to be strings. `="x"`. 

```
<ROSETTASCRIPTS>
	<MOVERS>
		<SavePoseMover name=save_current reference_name=current/>
		<SavePoseMover name=save_CDR reference_name=CDR/>
		<SavePoseMover name=restore_current restore_pose=1 reference_name=current/>
		<SavePoseMover name=L1 restore_pose=1 reference_name=L1 pdb_file=%%L1%%/>
		<SavePoseMover name=L2 restore_pose=1 reference_name=L2 pdb_file=%%L2%%/>
		<SavePoseMover name=L3 restore_pose=1 reference_name=L3 pdb_file=%%L3%%/>
		<SavePoseMover name=H1 restore_pose=1 reference_name=H1 pdb_file=%%H1%%/>
		<SavePoseMover name=H2 restore_pose=1 reference_name=H2 pdb_file=%%H2%%/>
		<SavePoseMover name=H3 restore_pose=1 reference_name=H3 pdb_file=%%H3%%/>
		<SavePoseMover name=DE restore_pose=1 reference_name=DE pdb_file=%%DE%%/>
		<ParsedProtocol name=save_cdr_restore >
			<Add mover=save_CDR />
			<Add mover=restore_current />
		</ParsedProtocol>
		<ParsedProtocol name=save_current_restore_ab >
			<Add mover=save_current />
			<Add mover=restore_ab />
		</ParsedProtocol>
		<KeepRegionMover name=k_L1 start_pdb_num=24L end_pdb_num=42L nter_overhang=2 cter_overhang=2/>
		<KeepRegionMover name=k_L2 start_pdb_num=57L end_pdb_num=72L nter_overhang=2 cter_overhang=2/>
		<KeepRegionMover name=k_L3 start_pdb_num=107L end_pdb_num=138L nter_overhang=2 cter_overhang=2/>
		<KeepRegionMover name=k_H1 start_pdb_num=24H end_pdb_num=42H nter_overhang=2 cter_overhang=2/>
		<KeepRegionMover name=k_H2 start_pdb_num=57H end_pdb_num=69H nter_overhang=2 cter_overhang=2/>
		<KeepRegionMover name=k_H3 start_pdb_num=107H end_pdb_num=138H nter_overhang=2 cter_overhang=2/>
		<CCDEndsGraftMover name=graft_L1 start_pdb_num=23L end_pdb_num=43L spm_reference_name=CDR copy_pdbinfo=1/>
		<CCDEndsGraftMover name=graft_L2 start_pdb_num=56L end_pdb_num=73L spm_reference_name=CDR copy_pdbinfo=1/>
		<CCDEndsGraftMover name=graft_L3 start_pdb_num=106L end_pdb_num=139L spm_reference_name=CDR copy_pdbinfo=1/>
		<CCDEndsGraftMover name=graft_H1 start_pdb_num=23H end_pdb_num=43H spm_reference_name=CDR copy_pdbinfo=1/>
		<CCDEndsGraftMover name=graft_H2 start_pdb_num=56H end_pdb_num=70H spm_reference_name=CDR copy_pdbinfo=1/>
		<CCDEndsGraftMover name=graft_H3 start_pdb_num=106H end_pdb_num=139H spm_reference_name=CDR copy_pdbinfo=1/>
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name=save_current />
		<Add mover_name=L1/>
    		<Add mover_name=k_L1 />
		<Add mover_name=save_cdr_restore/>
		<Add mover_name=graft_L1/>
		<Add mover_name=save_current/>
		<Add mover_name=L2/>
		<Add mover_name=k_L2/>
		<Add mover_name=save_cdr_restore/>
		<Add mover_name=graft_L2/>
		<Add mover_name=save_current/>
		<Add mover_name=L3/>
		<Add mover_name=k_L3/>
		<Add mover_name=save_cdr_restore/>
		<Add mover_name=graft_L3/>
		<Add mover_name=save_current/>
		<Add mover_name=H1/>
		<Add mover_name=k_H1/>
		<Add mover_name=save_cdr_restore/>
		<Add mover_name=graft_H1/>
		<Add mover_name=save_current/>
		<Add mover_name=H2/>
		<Add mover_name=k_H2/>
		<Add mover_name=save_cdr_restore/>
		<Add mover_name=graft_H2/>
		<Add mover_name=save_current/>
		<Add mover_name=H3/>
		<Add mover_name=k_H3/>
		<Add mover_name=save_cdr_restore/>
		<Add mover_name=graft_H3/>
		<Add mover_name=save_current/>
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

##See Also

* [[SaveAndRetrieveSidechainsMover]]
* [[DumpPdbMover]]
* [[I want to do x]]: Guide to choosing a mover