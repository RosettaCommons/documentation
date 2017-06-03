# CrosslinkerMover
Page created by Vikram K. Mulligan (vmullig@uw.edu) on 27 November 2016.<br/>
*Back to [[Mover|Movers-RosettaScripts]] page.*

[[_TOC_]]

## Description
This mover places three-way chemical cross-linkers such as 1,3,5-tris(bromomethyl)benzene (TBMB).  It can set up covalent bonds and constraints, pack and energy-minimize the linker and the side-chains to which it is connected, and relax the entire structure.  Options are provided for filtering based on input geometry, to throw out poses that do not present side-chains in conformations compatible with the linker.

## Needed flags
The CrosslinkerMover requires that Rosetta load a params file for the crosslinker, as well as the sidechain conjugation variant types for the sidechains that will be cross-linked.  These are not loaded by default.  For example, to link three cysteine residues with TBMB, one needs the following commandline flag:

```
-extra_res_fa sidechain_conjugation/CYX.params crosslinker/1.3.5_trisbromomethylbenzene.params
```

These load the CYX cysteine variant (used when cysteine is conjugated to things other than disulfide-forming residues) and the TBMB crosslinker.

When using the mover with symmetry, the symmetric variant of the TBMB crosslinker (which is one third of the crosslinker -- <i>vide infra</i>) must be loaded instead:

```
-extra_res_fa sidechain_conjugation/CYX.params crosslinker/1.3.5_trisbromomethylbenzene_symm.params
```

## Typical usage
This example places 1,3,5-tris(bromomethyl)benzene (TBMB), linking cysteine residues 7, 21, and 35 with the linker.  It also sets up constraints, and repacks and energy-minimizes the linker and the side-chains to which it is connected.  By default, no global relaxation is performed, however.  In this case, the pose is asymmetric:

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="bnv" weights="beta_nov15.wts" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_cys" resnums="7,21,35" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <CrosslinkerMover name="threefold" residue_selector="select_cys" linker_name="TBMB" scorefxn="bnv" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="threefold" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

## Usage with symmetry

This mover can be used for the case of linkers with c3 symmetry and poses with c3 symmetry.  In this case, the linker residue that gets added to the pose is actually a fragment of the total linker (one third of the geometry).  Three such residues are added, one to each symmetry repeat, and covalent bonds and suitable constraints are set up between the fragments.  Such usage requires that the user pass the `threefold_symmetric="true"` option.  Here is an example in which the CrosslinkerMover is used with a symmetric pose with C3 symmetry (defined in a symmetry definition file `inputs/c3.symm`).  In this case, the ResidueSelector must select _equivalent_ cysteine residues in the three symmetric copies.

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="tala" weights="beta_nov15.wts" symmetric="true" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_cys" resnums="7,21,35" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <SetupForSymmetry name="setup_symm" definition="inputs/c3.symm" />
                <CrosslinkerMover name="threefold" residue_selector="select_cys" linker_name="TBMB" scorefxn="tala" threefold_symmetric="true" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="setup_symm" />
                <Add mover="threefold" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

## Full options

```xml
<CrosslinkerMover name="(&string)" scorefxn="(&string)" residue_selector="(&string)" linker_name="(&string)"
    add_linker="(true &bool)" constrain_linker="(true &bool)"
    pack_and_minimize_linker_and_sidechains="(true &bool)" sidechain_fastrelax_rounds="(3 &int)"
    do_final_fastrelax="(false &bool)" final_fastrelax_rounds="(3 &int)"
    threefold_symmetric="(false &bool)"
    filter_by_sidechain_distance="(true &bool)" sidechain_distance_filter_multiplier="(1.0 &real)"
    filter_by_constraints_energy="(true &bool)" constraints_energy_filter_multiplier="(1.0 &real)"
    filter_by_final_energy="(false &bool)" final_energy_cutoff="(0.0 &real)"
/>
```

| Option | Required | Type | Description |
|---|---|---|---|
| name | YES | string | A unique name for this instance of the CrosslinkerMover. |
| linker_name | YES | string | The name of the type of linker to use (e.g. TBMB for 1,3,5-tris(bromomethyl)benzene).  Currently, only TBMB is supported, though other linkers will be added in the future. |
| residue_selector | YES | string | A previously-defined residue selector that has been set up to select exactly three residues. |
| scorefxn | YES | string | A scorefunction to use for packing, energy-minimization, and filtering.  If constraints are turned off in this score function, they will be turned on automatically at apply time. |
| add_linker | No | bool | Should the linker geometry be added to the pose?  Default true. |
| constrain_linker | No | bool | Should constraints for the linker be added to the pose?  Default true. |
| pack_and_minimize_linker_and_sidechains | No | bool | Should the linker and the connecting sidechains be repacked, and should the jump to the linker, and the linker and connnecting side-chain degrees of torsional freedom, be energy-minimized?  Default true. |
| sidechain_fastrelax_rounds | No | int | The number of rounds of FastRelax to apply when packing and minimizing side-chains and the liker.  Default 3. |
| do_final_fastrelax | No | bool | Should the whole pose be subjected to a FastRelax?  Default false. |
| final_fastrelax_rounds | No | int | The number of rounds of FastRelax to apply when relaxing the whole pose.  Default 3. |
| threefold_symmetric | No | bool | Is this a threefold-symmetric pose being connected by a threefold-symmetric crosslinker?  Default false. |
| filter_by_sidechain_distance | No | bool | Prior to adding the linker geometry, should this mover abort with failure status if the selected side-chains are too far apart to connect to the linker?  Default true. |
| sidechain_distance_filter_multiplier | No | real | This is a multiplier for the sidechain distance cutoff filter.  Higher values make the filter less stringent.  Default 1.0. |
| filter_by_constraints_energy | No | bool | After adding the linker geometry, adding constraints, and repacking and minimizing the linker and the connecting side-chains, should ths mover abort with failure status if the constraints energy is too high (i.e. the energy-minimized linker geometry is bad)?  Default true. |
| constraints_energy_filter_multiplier | No | real | This is a multiplier for the constraints energy cutoff filter.  Higher values make the filter less stringent.  Default 1.0. |
| filter_by_final_energy | No | bool | At the end of this protocol, should this mover exit with error status if the final energy is above a user-defined cutoff?  Default false. |
| final_energy_cutoff | No | real | If we are exiting with error status if the final energy is too high, this is the energy cutoff.  Default 0.0. |

##See also
* [[Information on constraints|constraint-file]]
* [[ResidueSelectors]]
* [[Symmetry]]: Using symmetry in Rosetta
* [[SymmetryAndRosettaScripts]]
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]