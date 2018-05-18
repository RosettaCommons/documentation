# Small
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Small

Small-move style backbone-torsion moves that, unlike shear, do not minimize downstream propagation.

```xml
<Small name="&string"
       residue_selector="('' &string)"
       scorefxn="('' &string)"
       temperature="(0.5 &Real)"
       nmoves="(1 &Integer)"
       angle_max="(6.0 &Real)"
       preserve_detailed_balance="(0 &bool)" />
```

-   residue\_selector: An optional, previously-defined [[ResidueSelector|ResidueSelectors]], specifying the subset of residues to which the mover will be applied.  If not provided, the mover is applied to the whole pose.  (Alternatively, a MoveMap may be used -- see below).
-   scorefxn: If specified, the given scorefunction will be used to evaluate the moves. If not specified, the Rama score term will be used.
-   temperature: What MC acceptance temperature to use (tests only the rama score, so not a full MC).
-   nmoves: How many consecutive moves to make.
-   angle\_max: By how much to perturb the backbone.
-   preserve\_detailed\_balance: If set to true, does not test the MC acceptance criterion, and instead always accepts.

This mover can also take an optional MoveMap (see [[FastRelax|FastRelaxMover]] documentation for details) to define the residue subset to which it should be applied.  (Only residues defined to have flexible backbones are used.)  In the absence of the MoveMap, the mover is applied to the whole pose.

This mover currently supports alpha-amino acids, carbohydrates, and oligourea residues.  In the case of oligourea residues, only the first three mainchain torsions (called "phi", "theta", and "psi" in Rosetta) are perturbed; the two amide bonds ("mu" and "omega") remain fixed.

See Rohl CA, et al. (2004) Methods Enzymol. Protein structure prediction using Rosetta, 383:66


##See Also

* [[ShearMover]]
* [[SetTorsionMover]]
* [[I want to do x]]: Guide to choosing a mover
