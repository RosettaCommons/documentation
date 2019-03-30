# SidechainMC
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SidechainMC

The "off rotamer" sidechain-only Monte Carlo sampler. For a rather large setup cost, individual moves can be made efficiently.

The underlying mover is still under development/benchmarking, so it may or may not work with backbone flexibility or amino acid identity changes.

```xml
<SidechainMC name="(&string)" ntrials="(10000 &int)" scorefxn="(score12 &string)" temperature="(1.0 &real)" inherit_scorefxn_temperature="(0 &bool)" preserve_detailed_balance="(1 &bool)" task_operations="(&string,&string,&string)" prob_uniform="(0.0 &real)" prob_withinrot="(0.0 &real)" prob_random_pert_current="(0.0 &real)"/>
```

-   ntrials: number of Monte Carlo trials to make per mover application - should be at least several thousand
-   scorefxn: score function used for acceptance
-   temperature: Boltzmann acceptance temperature - usually around 1.0
-   inherit\_scorefxn\_temperature: override scorefxn and temperature with values from [MetropolisHastings](#MetropolisHastings)
-   preserve\_detailed\_balance: balance acceptance criterion with proposal density ratio
-   task\_operations: list of operations for generating a PackerTask
-   prob\_uniform: probability of a "uniform" move - all sidechain chis are uniformly randomized between -180° and 180°
-   prob\_withinrot: "within rotamer" - sidechain chis are picked from the Dunbrack distribution for the current rotamer
-   prob\_random\_pert\_current: "random perturbation of current position" - the current sidechain chis are perturbed ±10° from their current positions, biased by the resulting Dunbrack energy. Note that if your score function contains a Dunbrack energy term, this will result in double counting issues.
-   - If the previous three probabilities do not add to 1.0, the remainder is assigned to a "between rotamer" move - a random rotamer of the current amino acid is chosen, and chi angles for that rotamer are selected from the Dunbrack distribution


##See Also

* [[SidechainMover]]
* [[TryRotamersMover]]
* [[PackRotamersMover]]
* [[I want to do x]]: Guide to choosing a mover
