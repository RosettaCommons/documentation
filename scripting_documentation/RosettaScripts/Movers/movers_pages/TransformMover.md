# Transform
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Transform

```xml
<Transform name="&string" chain="&string" box_size="&real" move_distance="&real" angle="&real" cycles="&int" repeats="&int" temperature="&real" initial_perturb="&real" initial_angle_pertub="&real" rmsd="&real" optimize_until_score_is_negative="&bool" use_constraints="&bool" cst_fa_file="&string" cst_fa_weight="%real"
ensemble_proteins="&string" use_main_model="&bool" grid_set="&string" />
```

The Transform mover is designed to replace the Translate, Rotate, and SlideTogether movers, and typically exhibits faster convergence and better scientific performance than these movers. The Transform mover performs a monte carlo search of the ligand binding site using precomputed scoring grids. Currently, this mover only supports docking of a single ligand, and requires that [[Scoring Grids be specified and computed|RosettaScripts#rosettascript-sections_ligands_scoringgrids]].

-   chain: The ligand chain, specified as the PDB chain ID
-   box\_size: The maximum translation that can occur from the ligand starting point. the "box" here is actually a sphere with the specified radius. Any move that results in the center of the ligand moving outside of this radius will be rejected
-   move\_distance: The maximum translation performed per step in the monte carlo search. Distance should be specified in angstroms. A random value is selected from a gaussian distribution between 0 and the specified distance.
-   angle: The maximum rotation angle performed per step in the monte carlo search. Angle should be specified in degrees. a random value is selected from a gaussian distribution between 0 and the specified angle in each dimension.
-   cycles: The total number of steps to be performed in the monte carlo simulation. The lowest scoring accepted pose will be output by the mover
-   repeats: The total number of repeats of the monte carlo simulation to be performed. if repeats \> 1, the simulation will be performed the specified number of times from the initial starting position, with the final pose selected.
-   temperature: The boltzmann temperature for the monte carlo simulation. Temperature is held constant through the simulation. The higher the number, the higher the percentage of accepted moves will be. 5.0 is a good starting point. "Temperature" here does not reflect any real world units.
-   initial\_perturb: Make an initial, unscored translation and rotation. Translation will be selected uniformly in a sphere of the given radius (in Angstroms) around the starting position. Additionally, the ligand will be randomly rotated 360 degrees around each of the x, y, and z axes. Large values are useful for benchmarking to scramble the starting position, and small values are useful for docking rod-like ligands in narrow pockets, where the Monte Carlo nature of the protocol may not allow for end-over end ligand flipping.
-   initial_angle_perturb: Control the size of the rotational perturbation by intitial\_perturb. The axis will be chosen randomly, and the amount of rotation will be randomly chosen between zero and the given value (in degrees).
-   rmsd: The maximum RMSD to be sampled away from the starting position. if this option is specified, any move above the specified RMSD will be rejected.
-   optimize_until_negative: Continue sampling beyond "cycles" if score is positive.
-   use_constraints: Incorporate constraint scoring into grid scoring. Requires a constraint file and weight
-   cst_fa_file: File to read constraints from. Not kept beyond Transform mover
-   cst_fa_weight: Weight for full atom constraints (Default = 1.0) Not kept beyond Transform mover
-   ensemble_proteins: File listing additional PDB files to generate scoring grids with 
-   use_main_model: Proceed to next mover using the model provided via in:file:s regardless of which is best scoring
-   grid_set: The scoring grid to use with Transform scoring.  See [[this section of the RosettaScripts documentation|RosettaScripts#rosettascript-sections_ligands_scoringgrids]] for information on specifying scoring grids.  Defaults to "default" if not specified.


##See Also

* [[RenderGridsToKinemageMover]]: Computes and outputs scoring grids.
* [[TranslateMover]]
* [[RotateMover]]
* [[SlideTogetherMover]]
* [[RigidBodyTransMover]]: Performs rigid body translation of chains
* [[I want to do x]]: Guide to choosing a mover
