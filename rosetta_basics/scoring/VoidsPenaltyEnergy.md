# Voids penalty score term (voids\_penalty)
Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory, on 21 December 2017.

**Note:** The ```voids_penalty``` score term is currently unpublished.  If you use it for something interesting, please include Vikram K. Mulligan in your author list.

[[_TOC_]]

## Purpose and algorithm

The ```voids_penalty``` scoring term is intended for use during design, to penalize buried voids or cavities and to guide the packer to design solutions in which all buried volume is filled with side-chains.  The identification of buried voids is inherently not pairwise-decomposable.  This scoring term is intended to work with Alex Ford's changes to the packer that permit fast-to-calculate but non-pairwise-decomposable scoring terms to be used during packing or design.

Ordinarily, the identification of buried voids is also inherently slow, meaning that it's difficult to make this something that could be penalized in a way that would allow repeated rapid evaluation for the million or so steps in a packer trajectory.  Fortunately, much of the computational expense can be diverted to a precomputation, and that is the approach taken here.  The score term actually behaves in different ways for packing, scoring, and minimizing, as outlined below:

### Behaviour during packing

#### Precomputation

The precomputation steps are computationally costly, requiring up to a few CPU-seconds and scaling linearly with the volume (in voxels) of the pose and the number of rotamers.  The approach is as follows:

1.  A voxel grid is overlaid upon the pose.  The default voxel size is 0.5 Angstroms, though this is user-configurable.
2.  Voxels are classified as "buried" or "not buried" based on the method of sidechain neighbour cones.  Briefly, this involves projecting a cone along each Calpha-Cbeta vector, counting the number of overlapping cones that contain a given voxel, and counting that voxel as buried if the number is greater than or equal to a user-defined threshold (default 6 cones).  The total buried volume, which is the volume that we are trying to fill with side-chains, is computed and stored.
3.  All non-packable positions are examined.  For each non-packable residue, all buried voxels that that residue overlaps are removed from the buried set, and the stored total buried volume is updated accordingly.  This ensures that we won't be trying to fill volume that is already filled by non-packable residues.
4.  All candidate rotamers are examined.  For each rotamer, the number of buried voxels that the rotamer overlaps is counted and used to determine a volume for that rotamer.  These volumes are stored.
5.  Any voxel touched by no rotamer is removed from the buried set, and the total buried volume is updated to reflect this pruning.  This ensures that unreachable volume doesn't distort the calculation.

At the end of the precomputation, we have (a) a value for the total buried volume (which we will call ```V```) and (b) a number for the buried volume of each rotamer, which we will call ```v(i,j)``` for the volume of the jth rotamer at position i.  The voxel grid is discarded at this point to liberate memory, and the packer trajectory then commences.

#### Computation during packer trajectory

During the packer trajectory, the ```voids_penalty``` score term imposes a quadratically ramping penalty for the difference between the total buried volume that we are trying to fill (```V```) and the sum of the buried volumes of the rotamers currently being considered (```sum_over_i( v(i,s_i)``` ), where ```s``` is a vector of indices of currently-considered rotamers.  The effect is to guide the packer to solutions in which the sum of the buried volumes of the current rotamers matches the total volume to fill -- _i.e._ solutions with no buried voids or cavities.  Since ```V``` and ```v(i,s_i)``` are both precomputed, ```( V-sum_over_i( v(i,s_i) ) )^2``` is extremely fast to compute on the fly for each step in the packer trajectory.

Note that there likely exist packer solutions in which the total volume of rotamers matches the total volume to be filled, but which nevertheless result in voids (due to some residues overlapping).  These are selected against by other score terms, such as ```fa_rep```.  The only solutions that result in low ```fa_rep``` scores _and_ low ```voids_penalty``` scores have few cavities.  (The score term may guide the packer to solutions that would have been discarded due to slightly positive ```fa_rep``` scores, however.  This is a feature, not a bug: it means that solutions can be selected with small clashes that can be resolved with minimization to give good, voids-free packing.)

#### Overall speed during packing

On a benchmark using thirty-six 100-residue poses with full design of core and boundary residues using [[FastDesign|FastDesignMover]], the ```voids_penalty``` score term resulted in a 23% slowdown using a 0.5 Angstrom voxel grid (the default).  This increases to a 60% slowdown when the term is enabled during regular scoring (see next section).

### Behaviour during scoring

The default behaviour of the ```voids_penalty``` score term is to do nothing during regular scoring -- _i.e._ this score term returns 0 by default during scoring, and serves only to guide the packer to good solutions with no voids.  However, the user may optionally enable ```voids_penalty``` during regular scoring either with the ```-score:voids_penalty_energy_disabled_except_during_packing false``` flag.  In this case, whenever the pose is scored, the following steps will occur:

1.  A voxel grid (default 0.5 Angstroms voxel size) is overlaid upon the pose.
2.  Voxels are classified as "buried" or "not buried" based on the method of sidechain neighbour cones, as described above.  The volume of the buried voxels, ```V```, is computed and stored.
3.  For each residue, the number of buried voxels overlapping the residue are counted to compute the buried volume of the residue.  The sum of the buried volumes of all residues, ```v```, is computed and stored.
4.  A quadratic penalty function ```( V - v )^2``` is computed and returned.

There are two important points to note about this scoring algorithm:
* It is slow.  Because a volumetric computation must be done for _every_ evaluation of the scoring function, it is best to leave scoring disabled unless it really is needed.
* It is slightly different from the method used during packing, since, during a regular evaluation of the scoring function, there is no concept of a rotamer set, and therefore no way to prune "unreachable" volume.  As such, the score returned reflects the fraction of total volume that is filled, not the fraction of reachable volume that is filled.

### Behaviour during minimizing

The ```voids_penalty``` score term does not currently define derivatives.  As such, it is currently hard-coded to be disabled completely during minimization trajectories, under all circumstances.  This means that it is not evaluated unnecessarily during line minimization, though it is also conceivably possible for the minimizer to introduce voids that were not present during packing.

## User control

### Basic control

In the simplest case, the ```voids_penalty``` score term is invoked simply by turning it on (_i.e._ weighting ```voids_penalty``` to a nonzero weight) in the scorefunction used by any Rosetta design module that invokes the Rosetta packer.  (Such modules include the [[fixbb application|fixbb]], the [[PackRotamersMover]], the [[FastDesign mover|FastDesignMover]], _etc._)  The reweighting can be done with a weights file passed in at the commandline, or in the ```<SCOREFXNS>``` section of a RosettaScripts XML script.  For example, the simple addition of the commented line in the script below penalizes voids:

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="r15_voids" weights="ref2015.wts" >
			<Reweight scoretype="voids_penalty" weight="0.25" /> # This is the only line that must be added to convert this design script to one that penalizes voids during design.
		</ScoreFunction>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<Layer name="select_surf" select_core="false" select_boundary="false" select_surface="true" />
	</RESIDUE_SELECTORS>
	<TASKOPERATIONS>
		<OperateOnResidueSubset name="no_repack_surf" selector="select_surf" >
			<PreventRepackingRLT />
		</OperateOnResidueSubset>
		<ReadResfile name="allowed_for_design" filename="inputs/design.resfile" />
	</TASKOPERATIONS>
	<MOVERS>
		<FastDesign name="design" scorefxn="r15_voids" repeats="1" task_operations="no_repack_surf,allowed_for_design" />
	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="design" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15_voids" />
</ROSETTASCRIPTS>

```

The weight provided governs the extent to which voids are penalized.  If set too low, the behaviour becomes indistinguishable from design without the term.  If set too high, voids are penalized so strongly that high-energy rotamers, clashes, or other features that result in high energetic scores might be accepted to satisfy the requirement that there be no voids.  The recommended approach is to use a value between 0.05 and 1.0, tuned by trial-and-error to produce results with good energies and relatively few voids.

### Designing sub-regions of poses

Note that because unreachable voxels and voxels filled by residues that are not designable are pruned automatically, the simple setup described above is all that is required even when task operations are used to restrict design to sub-regions of a pose.

### Advanced options

Certain options allow the user to tweak the definition of a buried voxel, to adjust the resolution of the voxel grid used for design, or otherwise to configure the ```voids_penalty``` score term.  Note, however, that the default settings have been chosen to work in most situations, so it should rarely be necessary to deviate from these.  Nevertheless, the configurable parameters are listed below, and can either be set globally at the command line, or for a particular scoring function through the RosettaScripts interface (or through EnergyMethodOptions in PyRosetta):

| Option | Type  | Description |
| ------ | ----- | ----------- |
| voids_penalty_energy_voxel_size                     | Real    | The size, in Angstroms, of the voxels used in the voxel grid for the ```voids_penalty``` energy.  Defaults to 0.5 A (a cube with a side of 0.5 Angstroms). |
| voids_penalty_energy_voxel_grid_padding             | Real    | This is the enlargement (on all sides) of the bounding box for the pose when setting up the voxel grid.  Defaults to 1.0 A padding on all sides. |
| voids_penalty_energy_containing_cones_cutoff        | Integer | The minimum number of cones projecting from side-chains in which a voxel must lie in order for that voxel to be considered to be buried.  Defaults to 6 cones. |
| voids_penalty_energy_cone_dotproduct_cutoff         | Real    | The cutoff value for the dot product of a cone vector and a cone base-test point vector below which we declare the test point not to be within the cone.  Effectively, this is the cone width.  Lower values make broader cones.  Default 0.1.  Can range from 1.0 (infinitely thin cone) to -1.0 (full spherical volume), with 0.0 representing all points on one side of the plane perpendicular to the cone vector. |
| voids_penalty_energy_cone_distance_cutoff           | Real    | The cutoff value for the distance from the cone base at which we are considered no longer to be within the cone.  Defaults to 8.0 Angstroms. |
| voids_penalty_energy_disabled_except_during_packing | Boolean | If true, then the ```voids_penalty``` term is only evaluated during packing (and not scoring or minimizing).  If false, then it is evaluated during packing and scoring (but not minimizing).  True by default.  Can be overridden for a particular ScoreFunction on a per-instance basis. |

The example RosettaScripts XML below shows how these options might be set for a particular scorefunction (rather than globally), within RosettaScripts.

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="r15_voids" weights="ref2015.wts" >
			<Reweight scoretype="voids_penalty" weight="0.25" />
			# The following settings are set ONLY for the r15_voids scorefunction, and will not affect other scorefunctions.
			<Set voids_penalty_energy_containing_cones_cutoff="5" />
			<Set voids_penalty_energy_cone_dotproduct_cutoff="0.05" />
			<Set voids_penalty_energy_cone_distance_cutoff="9.0" />
			<Set voids_penalty_energy_voxel_size="0.25" />
			<Set voids_penalty_energy_voxel_grid_padding="0.5" />
			<Set voids_penalty_energy_disabled_except_during_packing="false" />
		</ScoreFunction>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<Layer name="select_surf" select_core="false" select_boundary="false" select_surface="true" />
	</RESIDUE_SELECTORS>
	<TASKOPERATIONS>
		<OperateOnResidueSubset name="no_repack_surf" selector="select_surf" >
			<PreventRepackingRLT />
		</OperateOnResidueSubset>
		<ReadResfile name="allowed_for_design" filename="inputs/design.resfile" />
	</TASKOPERATIONS>
	<MOVERS>
		<FastDesign name="design" scorefxn="r15_voids" repeats="1" task_operations="no_repack_surf,allowed_for_design" />
	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="design" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15_voids" />
</ROSETTASCRIPTS>

```

## Use with symmetry

The ```voids_penalty``` scoring function is fully compatible with symmetry.  Unfortunately, symmetry does not significantly accelerate the precalculation, since symmetric copies of rotamers must each have their volumes quantified due to small asymmetries introduced by the discretization of the space in a voxel grid.  It does slightly accelerate the calculation carried out for each simulated annealing move, though, since 
the sum of the volumes of symmetric rotamers can be precalculated.

## Organization of the code

The ```voids_penalty``` scorefunction is located in ```core.4```, and in the ```core::pack::guidance_scoreterms::voids_penalty_energy``` namespace.  The relevant classes (located in this namespace) are ```VoidsPenaltyEnergy```, which is an energy method that inherits from ```core::scoring::methods::WholeStructureEnergy``` and ```core::scoring::annealing::ResidueArrayAnnealableEnergy```, and ```VoidsPenaltyVoxelGrid```, a helper class used to place a voxel grid on a pose, prune non-buried voxels, compute buried volume, and calculate volumes of buried rotamers.  Each instance of the ```VoidsPenaltyEnergy``` class transiently creates a ```VoidsPenaltyVoxelGrid``` instance during packer initialization, or during scoring (the latter if and only if the ```-voids_penalty_energy_disabled_except_during_packing false``` option is used).

Note that implementation of the ```VoidsPenaltyEnergy``` class required that the ```ResidueArrayAnnealableEnergy``` base class, defined in ```core.3```, be aware of the existence of the ```core::pack::rotamer_set::RotamerSets``` class, defined in ```core.4``` (though full header inclusion was _not_ necessary).  For this reason, a forward declaration of the ```RotamerSets``` class was added to the ```src/core/scoring/annealing``` directory -- a minor but necessary violation of Rosetta namespace and library level conventions which does _not_ significantly impact compliation time or complexity.

##See Also

* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[Design-centric guidance terms|design-guidance-terms]]
* [[AACompositionEnergy]]
* [[AARepeatEnergy|Repeat-stretch-energy]]
* [[BuriedUnsatPenalty]]
* [[HBNetEnergy]]
* [[NetChargeEnergy]]
