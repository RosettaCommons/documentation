# MouseSpyDockingProtocol
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MouseSpyDockingProtocol

This is a modified version of the [[DockingProtocol|DockingProtocolMover]] mover
that only runs the low resolution protocol
(regardless of your argument to `low_res_protocol_only`).

In short, the DockingProtocol runs as normal but caches the top N states it sees
as defined by its low resolution score function.
At the end of the run, the mover reevaluates these N states with Mouse (citation needed)
and returns the state with the best Mouse score.
The number N is given by the `spy_count` parameter below.

USAGE:

```xml
<MouseSpyDockingProtocol spy_count=(int,"15") score_name=(string,"MouseSpyDockingProtocol_score") docking_score_low=(string) partners=(string) ignore_default_docking_task=(bool,"false") name=(string)/>
```

MOUSE OPTIONS:

-	spy\_count (int,"15"):  Sets the number of docked states to reevalutate with MOUSE. DockingProtocol's low resolution step typically performs 500 steps. The default of spy\_count="15" measures the top 3%.

-	score\_name (string,"MouseSpyDockingProtocol\_score"):  The mover will store the final Mouse energy in the pose as an 'extra score'. This can be read later by the ReadPoseExtraScoreFilter.

DockingProtocol OPTIONS:

-	docking\_score\_low (string):  Low-resolution docking score function

-	partners (string):  String specifying docking patners; underscore should separate the partners e.g. AB\_C

-	dock\_min (bool,"false"):  Use the DockMinMover. It's unclear if this works with Mouse.

-	ignore\_default\_docking\_task (bool,"false"):  Ignore the default docking task and define your own. Unless this is specified, task operations will be appended to the default docking task.

-	name (string):  The name given to this instance.

## Example in action:

```xml
<ROSETTASCRIPTS>
   <SCOREFXNS>
     <ScoreFunction name="highres" weights="ref2015.wts"/>
     <ScoreFunction name="lowres" weights="score3.wts"/>
   </SCOREFXNS>

   <RESIDUE_SELECTORS>
     <Chain name="chainA" chains="A"/>
     <Chain name="chainB" chains="B"/>
     <InterfaceByVector name="interface" grp1_selector="chainA" grp2_selector="chainB"/>
   </RESIDUE_SELECTORS>

   <TASKOPERATIONS>
     <!-- Let's just say this is one-sided design to give an example -->
     <OperateOnResidueSubset name="one_sided_design" selector="chainA" >
       <RestrictToRepackingRLT/>
     </OperateOnResidueSubset>
  </TASKOPERATIONS>

   <MOVERS>
     <MouseSetupMover name="mouse_setup" jump_for_interface="1" task_operations="one_sided_design" />
     <MouseSpyDockingProtocol name="mouse_spy" docking_score_low="lowres" spy_count="15"/>
     <MouseFinalizeMover name="mouse_finalize"/>

      <RunSimpleMetrics name="run_sm" prefix="after_docking_">
       <MousePerResidueEnergy custom_type="per_res" />
       <MouseTotalEnergy custom_type="total" />
       <MouseTotalEnergy custom_type="total_with_interface_bias" interface_residues="interface" add_interface_size_bonus="true" />
     </RunSimpleMetrics>
   </MOVERS>

   <PROTOCOLS>
     <!-- Pose is converted to centroid mode. Original sidechains are stored in the pose. -->
     <!-- No need for the silly SaveAndRetrieveSidechains mover. -->
     <Add mover="mouse_setup"/>

     <!-- Drop-in replacement for DockingProtocol -->
     <Add mover="mouse_spy"/>

     <!-- Make sure to run all Mouse-related protocols before the finalize mover, including simple metrics -->
     <Add mover="run_sm"/>

     <!-- Delete Mouse's meta-data, convert back to full atom mode, restore original sidechains -->
     <Add mover="mouse_finalize"/>

     <!-- Since the sidechains are restored, the only difference between current pose and the original pose is the jump (docking) -->
   </PROTOCOLS>

   <!-- Of course, do some packing/design before evaluating this pose in high res -->
   <OUTPUT scorefxn="highres"/>

</ROSETTASCRIPTS>
```

##See Also

* [Protein-protein docking tutorial](https://www.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking)
* [[DockingProtocolMover]]
* [[MouseSetupMover]]
* [[MouseFinalizeMover]]
* [[MouseTotalEnergy]]
* [[MousePerResidueEnergy]]
* [[MousePerResidueEnergy]]
* [[MouseEnergy]]
