# ThreefoldLinkerMover
Page created by Vikram K. Mulligan (vmullig@uw.edu) on 27 November 2016.
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ThreefoldLinkerMover
This mover places three-way chemical cross-linkers such as 1,3,5-tris(bromomethyl)benzene.  It can set up covalent bonds and constraints, pack and energy-minimize the linker and the side-chains to which it is connected, and relax the entire structure.  Options are provided for filtering based on input geometry, to throw out poses that do not present side-chains in conformations compatible with the linker.

## Typical usage
This example places 1,3,5-tris(bromomethyl)benzene, linking cysteine residues 7, 21, and 35 with the linker.  It also sets up constraints, and repacks and energy-minimizes the linker and the side-chains to which it is connected.  By default, no global relaxation is performed, however.  In this case, the pose is asymmetric:

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <bnv weights="beta_nov15.wts" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_cys" resnums="7,21,35" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <ThreefoldLinkerMover name="threefold" residue_selector="select_cys" linker_name="TBMB" scorefxn="bnv" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="threefold" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

## Full options

```xml
<ThreefoldLinkerMover name=(&string) scorefxn=(&string) residue_selector=(&string) linker_name=(&string)
    add_linker=(true &bool) constrain_linker=(true &bool)
    pack_and_minimize_linker_and_sidechains=(true &bool) sidechain_fastrelax_rounds=(3 &int)
    do_final_fastrelax=(false &bool) final_fastrelax_rounds=(3 &int)
    threefold_symmetric=(false &bool)
    filter_by_sidechain_distance=(true &bool) sidechain_distance_filter_multiplier=(1.0 &real)
    filter_by_constraints_energy=(true &bool) constraints_energy_filter_multiplier=(1.0 &real)
    filter_by_final_energy=(false &bool) final_energy_cutoff=(0.0 &real)
/>
```

| Option | Required | Type | Description |
|---|---|---|---|
| name | YES | string | A unique name for this instance of the ThreefoldLinkerMover. |
| linker_name | YES | string | The name of the type of linker to use (e.g. TBMB for 1,3,5-tris(bromomethyl)benzene).  Currently, only TBMB is supported, though other linkers will be added in the future. |
| residue_selector | YES | string | A previously-defined residue selector that has been set up to select exactly three residues. |
| scorefxn | YES | string | A scorefunction to use for packing, energy-minimization, and filtering.  If constraints are turned off in this score function, they will be turned on automatically at apply time. |
| add_linker | No | bool | Should the linker geometry be added to the pose?  Default true. |
| constrain_linker | No | bool | Should constraints for the linker be added to the pose?  Default true. |
| pack_and_minimize_linker_and_sidechains | No | bool | Should the linker and the connecting sidechains be repacked, and should the jump to the linker, and the linker and connnecting side-chain degrees of torsional freedom, be energy-minimized?  Default true. |
| sidechain_fastrelax_rounds | No | int | The number of rounds of FastRelax to apply when packing and minimizing side-chains and the liker.  Default 3. |
| do_final_fastrelax | No | bool | Should the whole pose be subjected to a FastRelax?  Default false. |
| final_fastrelax_rounds | No | int | The number of rounds of FastRelax to apply when relaxing the whole pose.  Default 3. |