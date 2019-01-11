# Shear
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Shear

Shear style backbone-torsion moves that minimize downstream propagation.

```xml
<Shear name="&string"
       residue_selector="('', &string)"
       scorefxn="('', &string)"
       temperature="(0.5 &Real)"
       nmoves="(1 &Integer)"
       angle_max="(6.0 &Real)"
       preserve_detailed_balance="(0 &bool)"/>
```

-   residue\_selector: An optional, previously-defined [[ResidueSelector|ResidueSelectors]], specifying the subset of residues to which the mover will be applied.  If not provided, the mover is applied to the whole pose.  (Alternatively, a MoveMap may be used -- see below).
-   scorefxn: If specified, the given scorefunction will be used to evaluate the moves. If not specified, the Rama score term will be used.
-   temperature: what MC acceptance temperature to use (tests only the rama score, so not a full MC).
-   nmoves: how many consecutive moves to make.
-   angle\_max: by how much to perturb the backbone.
-   preserve\_detailed\_balance: If set to true, does not test the MC acceptance criterion, and instead always accepts.

This mover can also take an optional MoveMap (see [[FastRelax|FastRelaxMover]] documentation for details) to define the residue subset to which it should be applied.  (Only residues defined to have flexible backbones are used.)  In the absence of the MoveMap, the mover is applied to the whole pose.

See Rohl CA, et al. (2004) [Protein structure prediction using Rosetta.](http://www.sciencedirect.com/science/article/pii/S0076687904830040) Methods Enzymol., 383:66


##See Also

* [[SmallMover]]
* [[SetTorsionMover]]
* [[I want to do x]]: Guide to choosing a mover
