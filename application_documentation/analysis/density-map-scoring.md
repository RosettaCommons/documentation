#Scoring Structures with Electron Density

Metadata
========

Last edited 6/26/09. Code and documentation by Frank DiMaio (dimaio@u.washington.edu).

Overview
========

Three scoring functions have been added to Rosetta which describe how well a structure agrees to experimental density data. Density map data is read in CCP4/MRC format (the density has to minimally cover the asymmetric unit). The various scoring functions trade off speed versus accuracy, and their use should be primarily determined by the resolution of the density map data:

-   **elec\_dens\_whole\_structure\_ca** - Low resolution (5A+) - Uses the correlation of the whole structure density versus the experimental data; structure density only uses C-alphas.
-   **elec\_dens\_whole\_structure\_allatom** - Medium resolution (4-6A) - Uses the correlation of the whole structure density versus the experimental data; structure density only uses all heavy atoms.
-   **elec\_dens\_window** - High resolution (2-4A) - Uses the sum of correlations of a sliding window of residues versus the experimental data; structure density only uses all heavy atoms. Unlike the other two scoring functions, this uses the fit-to-density score when repacking the structure.

These scoring functions may be combined and are user-controlled by a set of command-line flags (see sample command lines and options below). They may also be specified in weights file/patch files like any other scoring function.

This scoring function may be used like any other scoring function in rosetta with one key exception. Because (unlike any other scoring function) the fit-to-density score depends on the overall rigid-body orientation of the molecule, all poses to be scored must be rooted on a virtual residue, with a jump to the remainder of the pose. Convience methods to set this up are shown below. Additionally, for some protocols, it makes sense to allow movement along this jump. For example, when relaxing a structure into density, '-jump\_move true' should generally be given.

Sample Command Lines
====================

Sample 1: relax a structure 1cid.pdb into a map 1cid\_5A.mrc using the hi-res scoring function (with a sliding window width of 5):

```
bin/relax.linuxgccrelease \
 -database ~/rosetta/main/database \
 -in:file:s 1cid.pdb \
 -score:weights score13_env_hb \
 -relax:fast \
 -relax:fastrelax_repeats 4 \
 -relax:jump_move true \
 -edensity:mapfile 1cid_5A.mrc \
 -edensity:mapreso 5.0 \
 -edensity:grid_spacing 2.0 \
 -edensity:realign min \
 -edensity:sliding_window_wt 0.2 \
 -edensity:sliding_window 5 \
 -out::nstruct 5 \
 -ex1 -ex2aro 
```

Sample 2: remodel the loops specified in 1cid.loopfile in structure 1cid.pdb into map 1cid\_5A.mrc, using the medium-res scoring function:

```
bin/loopmodel.linuxgccrelease \
 -database ~/rosetta/main/database \
 -s 1cid.pdb \
 -score:weights score13_env_hb \
 -loops::frag_sizes 9 3 1 \
 -loops::frag_files aa1cid_09_05.200_v1_3.gz aa1cid_03_05.200_v1_3.gz none \
 -loops::build_attempts 10 \
 -loops::remodel quick_ccd_moves \
 -loops::intermedrelax no \
 -loops::refine no \
 -loops::relax fastrelax \
 -loops::strict_loops \
 -relax:fastrelax_repeats 4 \
 -relax:jump_move true \
 -edensity:mapfile 1cid_5A.mrc \
 -edensity:mapreso 5.0 \
 -edensity:grid_spacing 2.0 \
 -edensity:realign min \
 -edensity:whole_structure_allatom_wt 0.05 \
 -out::nstruct 5
```

Density-Scoring Options
=======================

-   -edensity:mapfile
-   -edensity:mapreso
-   -edensity:grid\_spacing

Input map in CCP4/MRC format covering asymmetric unit. Compute rho\_c using 'mapreso' resolution, resampling map to 'grid\_spacing' per voxel. If grid\_sampling exceeds mapreso/2, the derivatives will not be properly computed.

-   -edensity:sliding\_window\_wt
-   -edensity:whole\_structure\_ca\_wt
-   -edensity:whole\_structure\_allatom\_wt

IF SUPPORTED BY THE PROTOCOL (see below for supported protocols), set the weight on the three scoring functions.

-   -edensity:sliding\_window

Width (\# residues) to use for sliding window scoring [default 1]

-   -edensity:atom\_mask
-   -edensity:ca\_mask

Mask width around each atom/CA [default resolution-dependent]

-   -edensity:realign {no | min}

IF SUPPORTED BY THE PROTOCOL, how to initially align the pose to the map (6D docking options coming soon!)

Supported Protocols
===================

Supported protocols:

-   score app
-   relax
-   loopmodel
-   ca\_to\_allatom
-   ab initio (through the topology broker) - density scores must be set through patches (command-line density weights are ignored)

To enable fit-to-density scoring during ab initio, a claimer must be added to the topology broker file:

```
CLAIMER DensityScoringClaimer
anchor 98
END_CLAIMER
```

In general the anchor residue should be in a region that will remain fixed throughout the protocol (to avoid unintentional rigid-body movement of the entire structure); for example within a rigid chunk in the RigidChunkClaimer. In general, fit-to-density weight should not be turned on until very late in the protocol (stage 3 or stage 4).

Adding Density Scoring to a New Protocol
========================================

A mover, **protocols::electron\_density::SetupForDensityScoringMover** has been added which does the following in preparatio for scoring a structure against density:

-   Ensures pose is rooted on VRT
-   Uses -edensity:realign flag value to dock pose to dens map
-   [OPTIONALLY] Use only a subset of residues to initially dock pose

The third option is intended for comparative modelling cases where there may be missing density in the starting pose.

A function has also been added, **core::scoring::electron\_density::add\_dens\_scores\_from\_cmdline\_to\_scorefxn(ScoreFunction&)** , which uses values of -edensity:sliding\_window\_wt, edensity:whole\_structure\_ca\_wt and edensity:whole\_structure\_allatom\_wt to update the score function.

For protocols which do not modify the root of the fold tree, this is all that is needed to make use of fit-to-density scoring (although additional moves that modify the rigid-body orientation of the system may be necessary to produce meaningful results).

##See Also

* [[Analysis applications | analysis-applications]]: other design applications
* [[Point mutation scan| pmut-scan-parallel ]]: Parallel detection of stabilizing point mutations using design
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs

