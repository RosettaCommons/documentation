# Small
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Small

Small-move style backbone-torsion moves that, unlike shear, do not minimize downstream propagation.

```
<Small name="&string" temperature=(0.5 &Real) nmoves=(1 &Integer) angle_max=(6.0 &Real) preserve_detailed_balance=(0 &bool)/>
```

-   temperature: what MC acceptance temperature to use (tests only the rama score, so not a full MC).
-   nmoves: how many consecutive moves to make.
-   angle\_max: by how much to perturb the backbone.
-   preserve\_detailed\_balance: If set to true, does not test the MC acceptance criterion, and instead always accepts.

See Rohl CA, et al. (2004) Methods Enzymol. Protein structure prediction using Rosetta, 383:66


##See Also

* [[ShearMover]]
* [[I want to do x]]: Guide to choosing a mover
