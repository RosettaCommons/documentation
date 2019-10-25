# MouseSetupMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MouseSetupMover

This mover undos everything done by the MouseSetupMover.
At the end of this mover, you will be back in full atom mode with your original sidechain conformations.
The only structural thing that will be different about your pose is the jump (assuming you ran a docking protocol).

USAGE:

```xml
<MouseFinalizeMover name=(string)/>
```

OPTIONS:

"MouseFinalizeMover" tag:

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
       <MouseTotalEnergy custom_type="total_with_interface_bias" interface_residues="interface" />
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
* [[MouseSpyDockingProtocolMover]]
* [[MouseSetupMover]]
* [[MouseTotalEnergy]]
* [[MousePerResidueEnergy]]
* [[MouseEnergy]]
