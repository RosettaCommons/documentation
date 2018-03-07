#LabelPoseFromResidueSelectorMover

[[include:mover_LabelPoseFromResidueSelectorMover_type]]

Very similar behaviour to [[AddResidueLabelMover]].
It allows to both label (`property`) or unlabel (`remove_property`). Even use both at the same time (will be applied over the same selection).
If `from_remark` is provided, nothing else is needed; it will read label remarks from the silent file and apply them to the Pose. Those remarks are in the format: `REMARK LABELS LABEL1:1-15,23,25;LABEL2:...`, as written by [[DisplayPoseLabelsMover]].