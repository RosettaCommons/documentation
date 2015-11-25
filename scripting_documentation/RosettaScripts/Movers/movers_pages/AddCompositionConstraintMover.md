# AddCompositionConstraintMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddCompositionConstraintMover

This mover adds an amino acid composition constraint to a pose.  This is a sequence constraint enforced by the [[aa_composition score term|AACompositionEnergy]].  The composition constraint is set up using a ```.comp``` file, described in the [[documentation for the aa_composition score term|AACompositionEnergy]].  Optionally, this mover may also attach a [[ResidueSelector|ResidueSelectors]] to the composition constraint, which serves to select the subset of residues for which the sequence will be constrained.  For example, one could select just the core of a protein and require that it be no more than 10% aromatic and no more than 5% polar.

```
<AddCompositionConstraintMover name=(&string) filename=(&string) selector=(&string) />
```

Options include:
- **filename** The ```.comp``` file used to set up the composition constraint.  Required input.
- **selector** A previously-defined [[ResidueSelector|ResidueSelectors]] to select a sub-region of the pose whose amino acid composition will be constrained.  If none is provided, the amino acid composition of the whole pose is constrained.

Note that multiple movers of this type can be applied in sequence to add many composition constraints to the pose.  Each can take a different ResidueSelector and a different ```.comp``` file.

##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AACompositionEnergy]]
* [[ClearConstraintsMover]]
* [[ClearCompositionConstraintsMover]]