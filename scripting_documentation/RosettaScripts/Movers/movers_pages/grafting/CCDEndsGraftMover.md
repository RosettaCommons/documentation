# CCDEndsGraftMover
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## CCDEndsGraftMover

[[_TOC_]]

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

##Overview
###Brief 

General purpose Grafting class which:

1) superimposes the insert onto the scaffold using any overhang residues

2) Inserts the pose piece into the scaffold pose, deleting any overhang residues or residues in the region the isertion will occur between.

3) Cycles of:

  - a) SmallMover for sampling (Can be disabled))

  - b) CCDs both terminal ends of the scaffold using flexibility settings or movemap to close the graft.  

  - c) MinMover to help close the graft through chain break terms

  - d) Closure check - will return if closed (Can be disabled)

  - e) MonteCarlo Boltzmann criterion

5) Repacks flexible residues and insert residues

**Differs from AnchoredGraftMover in that the insert is held fixed in space after the superposition instead of using one giant arm to close the insertion.**


###Details 

Uses two CCD arms on either side of the scaffold to close graft.  Insert is held fixed in cartesian space after superposition of any overhang residues by default.

```
****Nter_loop_start-----> | Piece | <----Nter_loop_end****
```

Default flexibility on Nter and Cter is only two residues (--> part of diagram).  Will delete any residues between start and end of the scaffold, and any overhang residues from the insert.


Internally, apply performs the insertion, idealizes the loop residues (omegas to 180, peptide bonds idealized) and the newly made polymer connections at the insert point, and then attempts to close the loop(s). Repacks sidechains of insert and overhang residues after insertion is complete. By default, will stop apply once graft is closed.  Closure is measured as all bond lengths and angles of loop being acceptable.

It is intended, but not guaranteed, to produce a graft with good rama, omega, and chainbreak/peptide_bond scores. All-atom minimization of graft or pose after insertion is recommended.

##XML Script
     <CCDEndsGraftMover name="(&string)" spm_reference_name="(&string)" start_ (&string) end_="(&string)" nter_overhang="(&size, 0)" cter_overhang="(&size, 0)" stop_at_closure="(&bool, true)", copy_pdbinfo="(&bool, false)"/>

###Required XML Options 

**Combine with [[SavePoseMover]] for insertions**

-   spm_reference_name (&string): The name of the reference pose we are inserting.  See [[SavePoseMover]] for more info.
-   start_: PDB Number to start keep region from (including it). Ex: 24L or internal Rosetta numbering
-   end_: PDB Number to end keep region at (including it); Ex: 42L or internal Rosetta numbering

###Flexibility Options

**Connection: scaffold-insert-scaffold**

-   scaffold_flex_Nter (&size) (default=2):  Use this many residues Nter of the insert to optimize the insertion and close the peptide bond of the scaffold-insert. 
-   scaffold_flex_Cter (&size) (default=2):  Use this many residues Cter of the insert to optimize the insertion and close the peptide bond of the scaffold-insert. 
-   insert_flex_Nter (&size) (default=0): Use this many insert residues on the Nter side to optimize the insertion and close the peptide bond of the scaffold-insert. 
-   insert_flex_Cter (&size) (default=0): Use this many insert residues on the Cter side to optimize the insertion and close the peptide bond of the scaffold-insert. 


###Extra XML Options
-   Nter_overhang (&size) (default=0): Number of extra residues on the Nter side of your insert to use for superposition for insertion.  Will delete these residues before insertion.
-   Cter_overhang (&size) (default=0): Number of extra residues on the Nter side of your insert to use for superposition for insertion.  Will delete these residues before insertion.
-   mintype (&string) (default=dfpmin_armijo_nonmonotone): Sets the mintype for the MinMover
-   copy_pdbinfo(&bool) (default=false): Copy the PDBInfo (PDB residue numbers and chain Ids) into the new pose.  Make these able to be output in the final pose. 
-   cen_scorefxn (&string) (default=smoothed version of that used originally for Steven Lewis' AnchoredDesignProtocol): Centroid Scorefunction to use
-   fa_scorefxn (&string) (default=Rosetta default): All Atom scorefunction to use for final repack
-   cycles (&size) (default=300): Set the number of cycles to use.
-   final_repack (&size) (default=true): Do a final repack of the insert and neighbors after the protocol is complete?
-   neighbor_dis (&real) (default=4.0): Set the neighbor detection distance for the final repack
-   skip_sampling (&bool) (default=false): Sets the mover to skip the small mover sampling step.


###MoveMap Options

You can optionally specify movemaps for both the insert and the scaffold to use during minimization, CCD, etc.  Not recommended for general use, use the flexibility options instead for simplicity. See the [[FastRelaxMover]] for more details on MoveMap specification. 

Will combine the movemaps for apply, and renumber everything. Flexible residues in multiple chains not recommended. This can be amazing as you can use loop regions in various parts of your protein to help the graft complete.

Note: Will disregard flexibility settings, as the movemaps will be used as primary way to define flexibility. May want to consider turning off the sampling step when passing crazy movemaps.


-   insert_movemap: Specify the insert movemap as an inner tag.
-   scaffold_movemap: Specify the scaffold movemap as an inner tag


##XML Example

In this example, we graft 3 CDRs (loopy regions) from one antibody (graft_from.pdb) into another using the SavePoseMover.  I know it is confusing - it is much easier to use this mover with PyRosetta. 

We use the KeepRegionMover to iteratively cut out a CDR from the PDB, save its state in the save pose mover, graft it in, and then repeat.  SavePoseMover is used to save the state of different structures so we can combine them, delete things in them, etc.  We use the [[ParsedProtocolMover]] to combine movers as a sequence. 

We are then left with a new antibody that has CDRs from a different antibody.  No chain breaks should be present in this new antibody.  Note that CCDEndsGraftMover does not always work to close regions.  The [[AnchoredGraftMover]] is better at closing non-loopy regions; however, it can result in strange structures and itself may require additional optimization for the structure.  The RAbD Antibody Design program uses a combination of both movers to close and optimize 100 percent of antibody CDR grafts. 


```xml
<ROSETTASCRIPTS>
	<MOVERS>
		<SavePoseMover name="save_current" reference_name="current"/>
		<SavePoseMover name="save_CDR" reference_name="CDR"/>
		<SavePoseMover name="restore_current" restore_pose="1" reference_name="current"/>
		<SavePoseMover name="restore_ab" restore_pose="1" reference_name="ab" pdb_file="graft_from.pdb"/>
		<ParsedProtocol name="save_cdr_restore" >
			<Add mover="save_CDR" />
			<Add mover="restore_current" />
		</ParsedProtocol>
		<ParsedProtocol name="save_current_restore_ab" >
			<Add mover="save_current" />
			<Add mover="restore_ab" />
		</ParsedProtocol>
		<KeepRegionMover name="k_L1" start_="24L" end_="42L" nter_overhang="2" cter_overhang="2"/>
		<KeepRegionMover name="k_L2" start_="57L" end_="72L" nter_overhang="2" cter_overhang="2"/>
		<KeepRegionMover name="k_L3" start_="107L" end_="138L" nter_overhang="2" cter_overhang="2"/>
		<CCDEndsGraftMover name="graft_L1" start_="23L" end_="43L" spm_reference_name="CDR" copy_pdbinfo="1"/>
		<CCDEndsGraftMover name="graft_L2" start_="56L" end_="73L" spm_reference_name="CDR" copy_pdbinfo="1"/>
		<CCDEndsGraftMover name="graft_L3" start_="106L" end_="139L" spm_reference_name="CDR" copy_pdbinfo="1"/>
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name="save_current" />
		<Add mover_name="restore_ab"/>
    		<Add mover_name="k_L1" />
		<Add mover_name="save_cdr_restore"/>
		<Add mover_name="graft_L1"/>
		<Add mover_name="save_current_restore_ab"/>
		<Add mover_name="k_L2"/>
		<Add mover_name="save_cdr_restore"/>
		<Add mover_name="graft_L2"/>
		<Add mover_name="save_current_restore_ab"/>
		<Add mover_name="k_L3"/>
		<Add mover_name="save_cdr_restore"/>
		<Add mover_name="graft_L3"/>
		<Add mover_name="save_current"/>
	</PROTOCOLS>
</ROSETTASCRIPTS>
```


##See Also

* [[SavePoseMover]]
* [[AnchoredGraftMover]]
* [[Insertion and Deletion | Movers-RosettaScripts#general-movers_insertion-and-deletion-grafting]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
