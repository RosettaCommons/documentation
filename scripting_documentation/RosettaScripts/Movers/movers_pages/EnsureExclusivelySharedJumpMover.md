# EnsureExclusivelySharedJumpMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## EnsureExclusivelySharedJumpMover

[[include:mover_EnsureExclusivelySharedJumpMover_type]]


### Example:

```xml
<ROSETTASCRIPTS>
  <RESIDUE_SELECTORS>
    <Chain name="sele" chains="1,3"/>
  </RESIDUE_SELECTORS>

  <MOVERS>
    <EnsureExclusivelySharedJumpMover name="ensure_jump" residue_selector="sele"/> 
  </MOVERS>

  <JUMP_SELECTORS>
    <ExclusivelySharedJumpSelector name="js" residue_selector="sele"/>
  </JUMP_SELECTORS>

  <RESIDUE_SELECTORS>
    <JumpDownstream name="downstream" jump_selector="js"/>
  </RESIDUE_SELECTORS>

  <SIMPLE_METRICS>
    <SelectedResiduesPyMOLMetric name="starting_pymol_selection" residue_selector="sele" custom_type="start"/>
    <SelectedResiduesPyMOLMetric name="final_pymol_selection" residue_selector="downstream" custom_type="final"/>
  </SIMPLE_METRICS>

  <PROTOCOLS>
    <Add mover_name="ensure_jump"/>
    <Add metrics="starting_pymol_selection,final_pymol_selection" />
  </PROTOCOLS>
</ROSETTASCRIPTS>
```