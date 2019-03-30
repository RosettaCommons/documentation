<i>Note:  Brian did not have enough time to write this page. Remind him of this and he will fix it. </i>

# PruneBuriedUnsats
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## PruneBuriedUnsats

Eliminate rotamers that contain a sidechain buried unsat and make no other sidechain h-bonds. Typically used with VBUNS (see [[buried unsat filter|scripting_documentation/RosettaScripts/Filters/filter_pages/BuriedUnsatHbondsFilter]]) and the [[approximate_buried_unsat_penalty|rosetta_basics/scoring/ApproximateBuriedUnsatPenalty]].

     <PruneBuriedUnsats name="(&string)" allow_even_trades="(&bool, false)" atomic_depth_probe_radius="(&Real, 2.3)" atomic_depth_resolution="(&Real, 0.5)" atomic_depth_cutoff="(&Real, 4.5)" minimum_hbond_energy="(&Real, -0.2)" />

If using the approximate_buried_unsat_penalty, it would be wise to set this to the same parameters as that.

##Options

* allow_even_trades - Allow residues that satisfy an unsat and create a new unsatisfiable one.
* atomic_depth_probe_radius - Probe radius for atomic depth calculation to determine burial.
* atomic_depth_resolution - Voxel resolution with which to calculate atomic depth.
* atomic_depth_cutoff - Atomic depth at which atoms are considered buried.
* Minimum energy (out of the typical rosetta -2.0) for a hbond to be considered to satisfy a polar.

##Credit
* Longxing Cao came up with the idea
* Brian Coventry coded it

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta