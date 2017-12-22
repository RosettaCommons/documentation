# Voids penalty score term (voids\_penalty)
Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory, on 21 December 2017.

## Purpose and algorithm

The ```voids_penalty``` scoring term is intended for use during design, to penalize buried voids or cavities and to guide the packer to design solutions in which all buried volume is filled with side-chains.  The identification of buried voids is inherently not pairwise-decomposable.  This scoring term is intended to work with Alex Ford's changes to the packer that permit fast-to-calculate but non-pairwise-decomposable scoring terms to be used during packing or design.

Ordinarily, the identification of buried voids is also inherently slow, meaning that it's difficult to make this something that could be penalized in a way that would allow repeated rapid evaluation for the million or so steps in a packer trajectory.  Fortunately, much of the computational expense can be diverted to a pre-computation, and that is the approach taken here.  The score term actually behaves in differet ways for packing, scoring, and minimizing, as outlined below:

### Behaviour during packing

#### Pre-computation

The pre-computation steps are computationally costly, requiring up to a few CPU-seconds and scaling linearly with the volume (in voxels) of the pose and the number of rotamers.  The approach is as follows:

1.  A voxel grid is overlaid upon the pose.  The default voxel size is 0.5 Angstroms, though this is user-configurable.
2.  Voxels are classified as "buried" or "not buried" based on the method of sidechain neighbour cones.  Briefly, this involves projecting a cone along each Calpha-Cbeta vector, counting the number of overlapping cones that contain a given voxel, and counting that voxel as buried if the number is greater than or equal to a user-defined threshold (default 6 cones).  The total buried volume, which is the volume that we are trying to fill with side-chains, is computed and stored.
3.  All non-packable positions are examined.  For each non-packable residue, all buried voxels that that residue overlaps are removed from the buried set, and the stored total buried volume is updated accordingly.  This ensures that we won't be trying to fill volume that is already filled by non-packable residues.
4.  All candidate rotamers are examined.  For each rotamer, the number of buried voxels that the rotamer overlaps is counted and used to determine a volume for that rotamer.  These volumes are stored.
5.  Any voxel touched by no rotamer is removed from the buried set, and the total buried volume is updated to reflect this pruning.  This ensures that unreachable volume doesn't distort the calculation.

At the end of the pre-computation, we have (a) a value for the total buried volume (which we will call ```V```) and (b) a number for the buried volume of each rotamer, which we will call ```v(i,j)``` for the volume of the jth rotamer at position i.  The voxel grid is discarded at this point to liberate memory, and the packer trajectory then commences.

#### Computation during packer trajectory

During the packer trajectory, the ```voids_penalty``` score term imposes a quadratically ramping penalty for the difference between the total buried volume that we are trying to fill (```V```) and the sum of the buried volumes of the rotamers currently being considered (```sum_over_i( v(i,s_i)``` ), where ```s``` is a vector of indices of currently-considered rotamers.  The effect is to guide the packer to solutions in which the sum of the buried volumes of the current rotamers matches the total volume to fill -- _i.e._ solutions with no buried voids or cavities.  Since ```V``` and ```v(i,s_i)``` are both precomputed, ```( V-sum_over_i( v(i,s_i) ) )^2``` is extremely fast to compute on the fly for each step in the packer trajectory.

Note that there likely exist packer solutions in which the total volume of rotamers matches the total volume to be filled, but which nevertheless result in voids (due to some residues overlapping).  These are selected against by other score terms, such as ```fa_rep```.  The only solutions that result in low ```fa_rep``` scores _and_ low ```voids_penalty``` scores have few cavities.  (The score term may guide the packer to solutions that would have been discarded due to slightly positive ```fa_rep``` scores, however.  This is a feature, not a bug: it means that solutions can be selected with small clashes that can be resolved with minimization to give good, voids-free packing.)

### Behaviour during scoring

The default behaviour of the ```voids_penalty``` score term is to do nothing during regular scoring -- _i.e._ this score term returns 0 by default during scoring, and serves only to guide the packer to good solutions with no voids.  However, the user may optionally enable ```voids_penalty``` during regular scoring either with the ```-score:voids_penalty_energy_disabled_except_during_packing false``` flag.  In this case, whenever the pose is scored, the following steps will occur:

1.  A voxel grid (default 0.5 Angstroms voxel size) is overlaid upon the pose.
2.  Voxels are classifed as "buried" or "not buried" based on the method of sidechain neihgbour cones, as described above.  The volume of the buried voxels, ```V```, is computed and stored.
3.  For each residue, the number of buried voxels overlapping the residue are counted to compute the buried volume of the residue.  The sum of the buried volumes of all residues, ```v```, is computed and stored.
4.  A quadratic penalty function ```( V - v )^2``` is computed and returned.

There are two important points to note about this scoring algorithm:
* It is slow.  Because a volumetric computation must be done for _every_ evaluation of the scoring function, it is best to leave scoring disabled unless it really is needed.
* It is slightly different from the method used during packing, since, during a regular evaluation of the scoring function, there is no concept of a rotamer set, and therefore no way to prune "unreachable" volume.  As such, the score returned reflects the fraction of total volume that is filled, not the fraction of reachable volume that is filled.

### Behaviour during minimizing

The ```voids_penalty``` score term does not currently define derivatives.  As such, it is currently hard-coded to be disabled completely during minimization trajectories, under all circumstances.

## User control

TODO

## Use with symmetry

TODO

## Organization of the code

TODO

##See Also

* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[AACompositionEnergy]]
* [[AARepeatEnergy]]
* [[HBNetEnergy]]
* [[NetChargeEnergy]]
