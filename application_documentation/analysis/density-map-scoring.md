#Scoring Structures with Electron Density

Metadata
========

Last edited 6/26/09. Code and documentation by Frank DiMaio (dimaio@u.washington.edu).

Overview
========

Several scoring functions have been added to Rosetta which describe how well a structure agrees to experimental density data. Density map data is read in CCP4/MRC format (the density has to minimally cover the asymmetric unit).  The various scoring functions trade off speed versus accuracy, and their use should be primarily determined by the resolution of the density map data:

-   **elec\_dens\_fast** is recommended for most cases.

Additionally, a slower but more precise scoring function is available.  This is only recommended if **elec\_dens\_fast** performs poorly (for example, if map quality varies significantly throughout the map):
-   **elec\_dens\_window** - Uses the sum of correlations of a sliding window of residues versus the experimental data; structure density only uses all heavy atoms.

Finally, the following scorefunctions are obsolete (elec_dens_fast is recommended) but are kept for historical reasons:
-   **elec\_dens\_whole\_structure\_ca** - Uses the correlation of the whole structure density versus the experimental data; structure density only uses C-alphas.
-   **elec\_dens\_whole\_structure\_allatom** - Uses the correlation of the whole structure density versus the experimental data; structure density only uses all heavy atoms.

These are user-controlled by a set of command-line flags (see sample command lines and options below). They may also be specified in weights file/patch files like any other scoring function.  The weights to use vary depending on resolution of data but the following give reasonable ranges:

- **elec\_dens\_fast**: ~25 is generally good, higher for high-resolution (<3Å) and lower for low-resolution (>6Å)
- **elec\_dens\_window**: ~0.2 is generally good, higher for high-resolution (<3Å) and lower for low-resolution (>6Å)

These scoring functions may be used like any other scoring function in rosetta with one key exception: because the fit-to-density score depends on the overall rigid-body orientation of the molecule, all poses to be scored must be rooted on a virtual residue, with a jump to the remainder of the pose. Convenience methods to set this up are shown below, and the rigid-body orientation should always be allowed to move (via the flag **-jump\_move**).

Sample Command Lines
====================

Sample 1: relax a structure 1cid.pdb into a map 1cid\_5A.mrc :

```
bin/relax.linuxgccrelease \
 -database ~/rosetta/main/database \
 -in:file:s 1cid.pdb \
 -relax:fastrelax_repeats 4 \
 -relax:jump_move true \
 -edensity:mapfile 1cid_5A.mrc \
 -edensity:mapreso 5.0 \
 -edensity:fastdens_wt 0.2 \
 -out::nstruct 5 \
 -ex1 -ex2aro 
```

Sample 2: perform homology modeling using density data (for complete documentation of homology modeling see [[ RosettaCM | RosettaCM ]]:

1) Replace the scorefunction block in the XML file with:
```
<SCOREFXNS>
    <stage1 weights=score3 symmetric=0>
        <Reweight scoretype=atom_pair_constraint weight=0.5/>
        <Reweight scoretype=elec_dens_fast weight=10.0/>
    </stage1>
    <stage2 weights=score4_smooth_cart symmetric=0>
        <Reweight scoretype=atom_pair_constraint weight=0.5/>
        <Reweight scoretype=elec_dens_fast weight=10.0/>
    </stage2>
    <fullatom weights=talaris2013_cart symmetric=0>
        <Reweight scoretype=atom_pair_constraint weight=0.5/>
        <Reweight scoretype=elec_dens_fast weight=25.0/>
    </fullatom>
</SCOREFXNS>
```

2) Use the commandline:

```
Rosetta/main/source/bin/rosetta_scripts.linuxclangrelease \
     -database Rosetta/main/database \
     -in:file:fasta target.fasta \
     -parser:protocol hybridize.xml \
     -default_max_cycles 200 \
     -edensity:mapfile 1cid_5A.mrc \
     -edensity:mapreso 5.0 \
     -nstruct 10 \
     -dualspace
```

Density-Scoring Options
=======================

**Common options**:

-   -edensity:mapfile

Input map in CCP4/MRC format covering the asymmetric unit.

-   -edensity:mapreso

The resolution of the data.  If not given it will be estimated from the voxel size of the input map.

-   -edensity:cryoem_scatterers

Use cryoEM scattering factors (default: X-ray).

-   -edensity:fastdens\_wt
-   -edensity:sliding\_window\_wt

IF SUPPORTED BY THE PROTOCOL (see below for supported protocols), set the weight on the corresponding scorefunction.

-   -edensity:sliding\_window

Width (\# residues) to use for sliding window scoring.  Must be an odd value; default is 1.  Higher values are recommended in low-resolution cases (3,5 or even 7).

**Less frequently used options**:

-   -edensity:atom\_mask
-   -edensity:ca\_mask

Mask width around each atom/CA [default resolution-dependent]

-   -edensity:realign min

Rigid-body minimize into density after loading the map.


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

