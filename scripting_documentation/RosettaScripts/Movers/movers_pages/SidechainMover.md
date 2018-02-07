# Sidechain
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Sidechain

The "off rotamer" sidechain-only moves. The *SidechainMover* is a *[[ThermodynamicMover|MetropolisHastings-Documentation]]* .

```xml
<Sidechain name="(&string)" preserve_detailed_balance="(1 &bool)" task_operations="(&string,&string,&string)" prob_uniform="(0.0 &real)" prob_withinrot="(0.0 &real)" prob_random_pert_current="(0.0 &real)"/>
```

-   preserve\_detailed\_balance: balance acceptance criterion with proposal density ratio
-   task\_operations: list of operations for generating a PackerTask
-   prob\_uniform: probability of a "uniform" move - all sidechain chis are uniformly randomized between -180° and 180°
-   prob\_withinrot: "within rotamer" - sidechain chis are picked from the Dunbrack distribution for the current rotamer
-   prob\_random\_pert\_current: "random perturbation of current position" - the current sidechain chis are perturbed ±10° from their current positions, biased by the resulting Dunbrack energy. Note that if your score function contains a Dunbrack energy term, this will result in double counting issues.
-   If the previous three probabilities do not add to 1.0, the remainder is assigned to a "between rotamer" move - a random rotamer of the current amino acid is chosen, and chi angles for that rotamer are selected from the Dunbrack distribution


##See Also

* [[SidechainMCMover]]
* [[TryRotamersMover]]
* [[PackRotamersMover]]
* [[I want to do x]]: Guide to choosing a mover
