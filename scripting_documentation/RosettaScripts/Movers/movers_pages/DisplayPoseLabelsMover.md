#DisplayPoseLabelsMover
[[include:mover_DisplayPoseLabelsMover_type]]

This is mainly an informative Mover. It will print the labels assigned to each residue of the pose as an alignment over the sequence. If TaskOperations and or MoveMapFactory is provided, it will also show packable/editable - bb/chi movable residues.  
Furthermore, it will save the labels of the Pose as a `REMARK`, which can be read back by [[LabelPoseFromResidueSelectorMover]].