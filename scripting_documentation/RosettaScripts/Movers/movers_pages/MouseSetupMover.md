# MouseSetupMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MouseSetupMover

This mover must be run before performing any Mouse-related protocols.
In addition to setting up Tensorflow, it also caches sidechains in the pose so that they can be retrieved later with the [[MouseFinalizeMover]].
This means that the SaveAndRetrieveSidechains mover is not needed at all when docking with Mouse.

Note, this mover does convert the pose to poly-valine centroid mode.
Again, this is reverted eventually by the [[MouseFinalizeMover]].

This is also the steps where you provide Mouse with all of the task operations that will eventually be run on the pose during downstream movers (FastDesign, for example).
An example is shown below.

USAGE:

```xml
<MouseSetupMover jump_for_interface=(int,"1") task_operations=(string) packer_palette=(named_packer_palette) name=(string)/>
```

OPTIONS:

"MouseSetupMover" tag:

-	jump\_for\_interface (int,"1"):  Which jump defines the interface? If you only have 2 chains, the answer is likely 1.

-	task\_operations (string):  A comma-separated list of TaskOperations to use.

-	packer\_palette (named\_packer\_palette):  A previously-defined PackerPalette to use, which specifies the set of residue types with which to design (to be pruned with TaskOperations). As of this writing (October 2019), this has not been tested thoroughly in the context of Mouse. When in doubt, use task operations here.

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
* [[MouseFinalizeMover]]
* [[MouseTotalEnergy]]
* [[MousePerResidueEnergy]]
* [[MousePerResidueEnergy]]
* [[MouseEnergy]]
