# AddCompositionConstraintMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddCompositionConstraintMover

This mover adds an amino acid composition constraint to a pose.  This is a sequence constraint enforced by the [[aa_composition score term|AACompositionEnergy]].  The composition constraint is set up using a ```.comp``` file, described in the [[documentation for the aa_composition score term|AACompositionEnergy]] or an inline composition constraint defined via `Comp` subtags. With a `Comp` subtag, constraint lines *may* be terminated by a `;` to support single-line definitions.

Optionally, this mover may also attach a [[ResidueSelector|ResidueSelectors]] to the composition constraint, which serves to select the subset of residues for which the sequence will be constrained.  For example, one could select just the core of a protein and require that it be no more than 10% aromatic and no more than 5% polar.

```xml
<AddCompositionConstraintMover name="(&string)" filename="(&string)" selector="(&string)">
  <Comp entry="(&string)" />
</AddCompositionConstraintMover>
```

Options include:
- **filename** The ```.comp``` file used to set up the composition constraint.  Required input.
- **selector** A previously-defined [[ResidueSelector|ResidueSelectors]] to select a sub-region of the pose whose amino acid composition will be constrained.  If none is provided, the amino acid composition of the whole pose is constrained.

Note that multiple movers of this type can be applied in sequence to add many composition constraints to the pose.  Each can take a different ResidueSelector and a different composition definition.

##Example
```xml
<AddCompositionConstraintMover name="comp_constraint" selector="surflayer" >
<Comp entry="PENALTY_DEFINITION; TYPE ASP; FRACTION 0.5; DELTA_START -1;DELTA_END 1;PENALTIES 1 0 1; BEFORE_FUNCTION QUADRATIC;AFTER_FUNCTION QUADRATIC; END_PENALTY_DEFINITION;" />
</AddCompositionConstraintMover>
```

##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AACompositionEnergy]]
* [[NetChargeEnergy]]
* [[AddNetChargeConstraintMover]]
* [[ClearConstraintsMover]]
* [[ClearCompositionConstraintsMover]]
* [[AddHelixSequenceConstraints mover|AddHelixSequenceConstraintsMover]]
