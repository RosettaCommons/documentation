# AddNetChargeConstraintMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddNetChargeConstraintMover

This mover adds a net charge constraint to a pose.  This is a sequence constraint enforced by the [[netcharge score term|NetChargeEnergy]].  The composition constraint is set up using a ```.charge``` file, described in the [[documentation for the netcharge score term|NetChargeEnergy]].  Optionally, this mover may also attach a [[ResidueSelector|ResidueSelectors]] to the net charge constraint, which serves to select the subset of residues for which the net charge will be constrained.  For example, one could select just the binding pocket of a ligand-binding protein and require that it have a net negative charge.

Multiple net charge constraints can be added to the pose using multiple `AddNetChargeConstarintMover` instances.  Each instance can take a different ResidueSelector and/or ```.charge``` file.

```xml
<AddNetChargeConstraintMover name="(&string)" filename="(&string)" selector="(&string)" />
```

Options include:
- **filename** The ```.charge``` file used to set the desired net charge and the penalty function for deviating from this desired net charge.  Required input.
- **selector** A previously-defined [[ResidueSelector|ResidueSelectors]] to select a sub-region of the pose, the net charege of which will be constrained.  This input is optional.  If no [[ResidueSelector|ResidueSelectors]] is provided, the net charge of the whole pose is constrained.

Sequence constraints applied with this mover (or with the [[AddcompositionConstraintMover]] can be removed from the pose with the [[ClearConstraintsMover]] (which will also remove geometric constraints) or with the [[ClearCompositionConstraintsMover]] (which will remove all sequence constraints, but no geometric constraints).

As a final note, net charge constraints only affect scoring or packing if the ```netcharge``` score term has a non-zero weight in the scorefunction used for scoring or packing -- that is, if you use this mover, be sure to reweight ```netcharge``` to a non-zero weight.

##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AACompositionEnergy]]
* [[AddCompositionConstraintMover]]
* [[NetChargeEnergy]]
* [[ClearConstraintsMover]]
* [[ClearCompositionConstraintsMover]]
* [[AddHelixSequenceConstraints mover|AddHelixSequenceConstraintsMover]]
