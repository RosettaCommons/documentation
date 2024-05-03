# CrosslinkerMover
Page created by Vikram K. Mulligan (vmullig@uw.edu) on 27 November 2016.<br/>
Last updated on 24 May 2022.<br/>
*Back to [[Mover|Movers-RosettaScripts]] page.*

[[_TOC_]]

## Description
This mover places chemical cross-linkers such as 1,3,5-tris(bromomethyl)benzene (TBMB), 1,4-bis(bromomethyl)benzene (paraBBMB), or trimesic acid (TMA).  It can set up covalent bonds and constraints, pack and energy-minimize the linker and the side-chains to which it is connected, and relax the entire structure.  Options are provided for filtering based on input geometry, to throw out poses that do not present side-chains in conformations compatible with the linker.

Metals are also effectively cross-links that connect several side-chains, as far as Rosetta is concerned, so as of 16 May 2018, this mover can also place metals.  When placing metals, metal-coordinating residues (currently L- or D-histidine, glutamate, or aspartate) are patched to add a virtual atom on the metal-coordinating side-chain atom representing the metal, atom pair constraints are added to tether the virtual atoms to one another and to ensure that all of the virtual atoms overlap (representing a single metal ion), and angle constraints are added for each trio of (liganding atom 1)--(metal virtual atom)--(liganding atom 2) to enforce tetrahedral, octahedral, square pyramidal, square planar, trigonal pyramidal, or trigonal planar geometry.  Future development will add support for other metal coordination geometries.

## Needed flags
The CrosslinkerMover requires that Rosetta load a params file for the crosslinker.  These are not loaded by default.  For example, to link three cysteine residues with TBMB, one needs the following commandline flag:

```
-extra_res_fa crosslinker/1.3.5_trisbromomethylbenzene.params
```

This flag loads the TBMB crosslinker.

When using the mover with symmetry, the symmetric variant of the TBMB crosslinker (which is one third of the crosslinker -- <i>vide infra</i>) must be loaded instead:

```
-extra_res_fa crosslinker/1.3.5_trisbromomethylbenzene_symm.params
```

When placing metals, no special flags are needed.

## Examples

### Placing 1,3,5-tris(bromomethyl)benzene (TBMB)

This example places 1,3,5-tris(bromomethyl)benzene (TBMB), linking cysteine residues 7, 21, and 35 with the linker.  It also sets up constraints, and repacks and energy-minimizes the linker and the side-chains to which it is connected.  By default, no global relaxation is performed, however.  In this case, the pose is asymmetric:

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15" weights="ref2015.wts" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_cys" resnums="7,21,35" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <CrosslinkerMover name="place_tbmb" residue_selector="select_cys" linker_name="TBMB" scorefxn="r15" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="place_tbmb" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Placing an N-terminus to cysteine sidechain thioether linkage, to make a lariat

This example links the N-terminus of a peptide to a side-chain of a cysteine, creating a thioether lariat.  It then uses [[generalized kinematic closure|GeneralizedKIC]] to close the macrocycle ring, and [[FastRelax]] to relax it.

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" />
		<ScoreFunction name="r15_cst" weights="ref2015_cst.wts" />
	</SCOREFXNS>
	<TASKOPERATIONS>
		<IncludeCurrent name="incl_curr" />
	</TASKOPERATIONS>
	<FILTERS>
	</FILTERS>
	<RESIDUE_SELECTORS>
		<Index name="select_thioether" resnums="1,8" />
	</RESIDUE_SELECTORS>
	<MOVERS>

		<PeptideStubMover name="make_pep" reset="true">
			<Append resname="GLY" />
			<Append resname="GLY" />
			<Append resname="GLY" />
			<Append resname="GLY" />
			<Append resname="GLY" />
			<Append resname="GLY" />
			<Append resname="GLY" />
			<Append resname="CYS" />
			<Append resname="GLY" />
			<Append resname="GLY" />
		</PeptideStubMover>

		<DeclareBond name="add_termini" atom1="C" atom2="N" res1="1" res2="2" add_termini="true" />

		<SetTorsion name="set_omegas">
			<Torsion angle="180" torsion_name="omega" residue="1" />
			<Torsion angle="180" torsion_name="omega" residue="2" />
			<Torsion angle="180" torsion_name="omega" residue="3" />
			<Torsion angle="180" torsion_name="omega" residue="4" />
			<Torsion angle="180" torsion_name="omega" residue="5" />
			<Torsion angle="180" torsion_name="omega" residue="6" />
			<Torsion angle="180" torsion_name="omega" residue="7" />
			<Torsion angle="180" torsion_name="omega" residue="8" />
			<Torsion angle="180" torsion_name="omega" residue="9" />
		</SetTorsion>

		<RandomizeBBByRamaPrePro name="random_rama" />

		<CrosslinkerMover name="cyclize" linker_name="thioether"
			residue_selector="select_thioether" scorefxn="r15"
			filter_by_constraints_energy="false"
			filter_by_sidechain_distance="false"
			pack_and_minimize_linker_and_sidechains="false"
		/>

		<GeneralizedKIC name="genkic" selector="lowest_energy_selector" closure_attempts="1000"
			stop_when_n_solutions_found="1" selector_scorefunction="r15" correct_polymer_dependent_atoms="true" >
			<AddResidue res_index="5" />
			<AddResidue res_index="6" />
			<AddResidue res_index="7" />
			<AddResidue res_index="8" />
			<AddResidue res_index="1" />
			<AddResidue res_index="2" />
			<AddResidue res_index="3" />
			<AddTailResidue res_index="9" />
			<AddTailResidue res_index="10" />
			<SetPivots res1="5" atom1="CA" res2="8" atom2="CB" res3="3" atom3="CA" />
			<CloseBond res1="8" atom1="SG" res2="1" atom2="CP2" bondlength="1.827" angle1="102.028" angle2="112.284" />
			<AddPerturber effect="randomize_backbone_by_rama_prepro" >
				<AddResidue index="5" />
				<AddResidue index="6" />
				<AddResidue index="7" />
				<AddResidue index="2" />
				<AddResidue index="3" />
			</AddPerturber>
			<AddPerturber effect="randomize_dihedral">
				<AddAtoms res1="8" atom1="N" res2="8" atom2="CA" />
				<AddAtoms res1="8" atom1="CA" res2="8" atom2="CB" />
				<AddAtoms res1="8" atom1="CB" res2="8" atom2="SG" />
				<AddAtoms res1="8" atom1="SG" res2="1" atom2="CP2" />
				<AddAtoms res1="1" atom1="CP2" res2="1" atom2="CO" />
				<AddAtoms res1="1" atom1="N" res2="1" atom2="CA" />
				<AddAtoms res1="1" atom1="CA" res2="1" atom2="C" />
			</AddPerturber>
			<AddFilter type="loop_bump_check" />
		</GeneralizedKIC>

		<FastRelax name="frlx" scorefxn="r15_cst" repeats="1" task_operations="incl_curr" />

	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="make_pep" />
		<Add mover="add_termini" />
		<Add mover="set_omegas" />
		<Add mover="random_rama" />
		<Add mover="cyclize" />
		<Add mover="genkic" />
		<Add mover="frlx" />
	</PROTOCOLS>

</ROSETTASCRIPTS>
```

### Placing a metal with trigonal planar or trigonal pyramidal coordination geometry

In this example, we assume that positions 12, 16, and 23 in the input structure are residue types that can coordinate a metal (currently, L- or D-histidine, aspartate, or glutamate).  The `metal_type` option determines the liganding atom-metal bond lengths, and defaults to "Zn" (zinc).  In the case of trigonal planar coordination, bond angles are constrained to 120 degrees, and an improper torsional constraint additionally pulls the metal into the plane of the liganding three atoms.  In the case of trigonal pyramidal coordination, bond angles are constrained to 109.47 degrees, and no improper torsional constraint is applied.

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15" weights="ref2015.wts" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_metal_coordinating" resnums="12,16,23" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <!-- Note: in the definition below, "trigonal_planar_metal" may be replaced with "trigonal_pyramidal_metal". -->
                <CrosslinkerMover name="metal_xlink" residue_selector="select_metal_coordinating" linker_name="trigonal_planar_metal" metal_type="Zn" scorefxn="r15" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="metal_xlink" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Placing a metal with square planar or square pyramidal coordination geometry

In this example, we assume that positions 3, 12, 16, and 23 in the input structure are residue types that can coordinate a metal (currently, L- or D-histidine, aspartate, or glutamate).  The `metal_type` option determines the liganding atom-metal bond lengths, and defaults to "Ni2" (nickel in the 2+ oxidation state) in the case of square planar or square pyramidal geometries.  In the case of square planar coordination, bond angles are constrained to 90 or 180 degrees, and an improper torsional constraint additionally pulls the metal into the plane of the liganding four atoms.  In the case of square pyramidal coordination, bond angles are constrained to 90 or 180 degrees, an ambiguous improper torsional constraint is applied keeping the metal in the plane of any four of the liganding atoms.

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15" weights="ref2015.wts" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
		<!--
			A fifth position must be selected by the residue selector below in the case of square pyramidal
			metal coordination.
		-->
                <Index name="select_metal_coordinating" resnums="3,12,16,23" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <!--
			Note: in the definition below, "square_planar_metal" may be replaced with "square_pyramidal_metal".  In this case, a fifth residue
			must be selected by the select_metal_coordinating residue selector.
		 -->
                <CrosslinkerMover name="metal_xlink" residue_selector="select_metal_coordinating" linker_name="square_planar_metal" metal_type="Ni2" scorefxn="r15" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="metal_xlink" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Placing a tetrahedrally-coordinated metal

In this example, we assume that positions 7, 12, 16, and 23 in the input structure are residue types that can coordinate a metal (currently, L- or D-histidine, aspartate, or glutamate).  The `metal_type` option determines the liganding atom-metal bond lengths, and defaults to "Zn" (zinc).  The `CrosslinkerMover` adds 109.47 degree bond angle constraints.

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15" weights="ref2015.wts" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_metal_coordinating" resnums="7,12,16,23" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <CrosslinkerMover name="metal_xlink" residue_selector="select_metal_coordinating" linker_name="tetrahedral_metal" metal_type="Zn" scorefxn="r15" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="metal_xlink" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Placing an octahedrally-coordinated metal

In this example, we assume that positions 7, 12, 16, 23, 26, and 30 in the input structure are residue types that can coordinate a metal (currently, L- or D-histidine, aspartate, or glutamate).  The `metal_type` option determines the liganding atom-metal bond lengths.  Currently, for octahedral coordination, the only supported type is Fe2 (for iron(II)), though this will be expanded in the future.  The `CrosslinkerMover` adds 90 or 180 degree bond angle constraints.

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15" weights="ref2015.wts" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_metal_coordinating" resnums="7,12,16,23,26,30" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <CrosslinkerMover name="metal_xlink" residue_selector="select_metal_coordinating" linker_name="octahedral_metal" metal_type="Fe2" scorefxn="r15" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="metal_xlink" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

## Usage with symmetry

This mover can be used for the case of linkers with symmetry that matches the symmetry of the pose.  In this case, the linker residue that gets added to the pose is actually a fragment of the total linker (for example, one third of the geometry in the case of C3 symmetry).  N such residues are added, one to each symmetry repeat, and covalent bonds and suitable constraints are set up between the fragments.  Such usage requires that the user pass the `symmetry=<string>` option, where the string is an uppercase character representing the symmetry type (C=cyclic, S=mirror cyclic, D=dihedral) followed by an integer indicating the number of repeats (_e.g._ "C3" for cyclic, threefold symmetry).  Here is an example in which the CrosslinkerMover is used with a symmetric pose with C3 symmetry (defined in a symmetry definition file `inputs/c3.symm`).  In this case, the ResidueSelector must select _equivalent_ cysteine residues in the three symmetric copies.

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15" weights="ref2015.wts" symmetric="true" />
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
                <Index name="select_cys" resnums="7,21,35" />
        </RESIDUE_SELECTORS>
        <MOVERS>
                <SetupForSymmetry name="setup_symm" definition="inputs/c3.symm" />
                <CrosslinkerMover name="threefold" residue_selector="select_cys" linker_name="TBMB" scorefxn="r15" symmetry="C3" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="setup_symm" />
                <Add mover="threefold" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

When placing tetrahedrally-coordinated metals, compatible symmetries are C2, D2, and S4.  When placing octahedrally-coordinated metals, compatible symmetries are C3, C2, D3, S2, and S6.

## Full options

```xml
<CrosslinkerMover name="(&string)" scorefxn="(&string)" residue_selector="(&string)" linker_name="(&string)"
    add_linker="(true &bool)" constrain_linker="(true &bool)"
    pack_and_minimize_linker_and_sidechains="(true &bool)" sidechain_fastrelax_rounds="(3 &int)"
    do_final_fastrelax="(false &bool)" final_fastrelax_rounds="(3 &int)" symmetry="(A1 &string)"
    filter_by_sidechain_distance="(true &bool)" sidechain_distance_filter_multiplier="(1.0 &real)"
    filter_by_constraints_energy="(true &bool)" constraints_energy_filter_multiplier="(1.0 &real)"
    filter_by_final_energy="(false &bool)" final_energy_cutoff="(0.0 &real)" metal_type="(Zn &string)"
/>
```

| Option | Required | Type | Description |
|---|---|---|---|
| name | YES | string | A unique name for this instance of the CrosslinkerMover. |
| linker\_name | YES | string | The name of the type of linker to use.  Currently, the allowed options are "tetrahedral\_metal", "octahedral\_metal", "trigonal\_planar\_metal", "square\_planar\_metal", "trigonal\_pyramidal\_metal", "square\_pyramidal\_metal", "TBMB" (for 1,3,5-tris(bromomethyl)benzene), "thioether", and "TMA" (for trimesic acid). |
| residue\_selector | YES | string | A previously-defined residue selector that has been set up to select the correct number of residues for the crosslinker type. |
| scorefxn | YES | string | A scorefunction to use for packing, energy-minimization, and filtering.  If constraints are turned off in this score function, they will be turned on automatically at apply time. |
| add\_linker | No | bool | Should the linker geometry be added to the pose?  Default true. |
| constrain\_linker | No | bool | Should constraints for the linker be added to the pose?  Default true. |
| pack\_and\_minimize\_linker\_and\_sidechains | No | bool | Should the linker and the connecting sidechains be repacked, and should the jump to the linker, and the linker and connnecting side-chain degrees of torsional freedom, be energy-minimized?  Default true. |
| sidechain\_fastrelax\_rounds | No | int | The number of rounds of FastRelax to apply when packing and minimizing side-chains and the liker.  Default 3. |
| do\_final\_fastrelax | No | bool | Should the whole pose be subjected to a FastRelax?  Default false. |
| final\_fastrelax\_rounds | No | int | The number of rounds of FastRelax to apply when relaxing the whole pose.  Default 3. |
| symmetry | No | string | Is this a symmetric pose being connected by a crosslinker with matching symmetry?  Default unused if not specified.  If specified, the string must be a single uppercase character representing the symmetry type ("C" for cyclic, "S" for mirror cyclic, "D" for dihedral, or "A" for achiral) followed by an integer representing the number of symmetry repeats (_e.g._ "S4" for cyclic fourfold symmetry with mirroring about the plane perpendicular to the symmetry axis from one repeat to the next). |
| filter\_by\_sidechain\_distance | No | bool | Prior to adding the linker geometry, should this mover abort with failure status if the selected side-chains are too far apart to connect to the linker?  Default true. |
| sidechain\_distance\_filter\_multiplier | No | real | This is a multiplier for the sidechain distance cutoff filter.  Higher values make the filter less stringent.  Default 1.0. |
| filter\_by\_constraints\_energy | No | bool | After adding the linker geometry, adding constraints, and repacking and minimizing the linker and the connecting side-chains, should ths mover abort with failure status if the constraints energy is too high (i.e. the energy-minimized linker geometry is bad)?  Default true. |
| constraints\_energy\_filter\_multiplier | No | real | This is a multiplier for the constraints energy cutoff filter.  Higher values make the filter less stringent.  Default 1.0. |
| filter\_by\_final\_energy | No | bool | At the end of this protocol, should this mover exit with error status if the final energy is above a user-defined cutoff?  Default false. |
| final\_energy\_cutoff | No | real | If we are exiting with error status if the final energy is too high, this is the energy cutoff.  Default 0.0. |
| metal\_type | No | string | The type of metal.  This determines the distance between the metal liganding atom and the virtual atom representing the metal.  Defaults to "Zn" (for zinc).  Only used when placing metal crosslinks. |

## Residue types that can be linked

Note that each type of crosslinker can link different types of side-chains:

| Abbreviation | Crosslinker | Number of residues linked | Types that can be linked | Compatible symmetries |
| ------------ | ----------- | ------------------------- | ------------------------ | --------------------- |
| octahedral\_metal | virtual atoms representing a metal (note: no new residue is placed) | 6 | L-histidine (HIS, HIS_D), D-histidine (DHI), L-aspartate (ASP), D-asparate (DAS), L-glutamate (GLU), D-glutamate (DGU) | S6, D3, C3, S2, C2, asymmetric |
| tetrahedral\_metal | virtual atoms representing a metal (note: no new residue is placed) | 4 | L-histidine (HIS, HIS_D), D-histidine (DHI), L-aspartate (ASP), D-asparate (DAS), L-glutamate (GLU), D-glutamate (DGU) | S4, D2, C2, asymmetric |
| square\_pyramidal\_metal | virtual atoms representing a metal (note: no new residue is placed ) | 4 | L-histidine (HIS, HIS_D), D-histidine (DHI), L-aspartate (ASP), D-asparate (DAS), L-glutamate (GLU), D-glutamate (DGU) | asymmetric |
| square\_planar\_metal | virtual atoms representing a metal (note: no new residue is placed ) | 4 | L-histidine (HIS, HIS_D), D-histidine (DHI), L-aspartate (ASP), D-asparate (DAS), L-glutamate (GLU), D-glutamate (DGU) | S4, C4, D2, S2, C2, asymmetric |
| trigonal\_pyramidal\_metal | virtual atoms representing a metal (note: no new residue is placed ) | 3 | L-histidine (HIS, HIS_D), D-histidine (DHI), L-aspartate (ASP), D-asparate (DAS), L-glutamate (GLU), D-glutamate (DGU) | C3, asymmetric |
| trigonal\_planar\_metal | virtual atoms representing a metal (note: no new residue is placed ) | 3 | L-histidine (HIS, HIS_D), D-histidine (DHI), L-aspartate (ASP), D-asparate (DAS), L-glutamate (GLU), D-glutamate (DGU) | C3, asymmetric |
| TBMB | 1,3,5-tris(bromomethyl)benzene | 3 | L-cysteine (CYS), D-cysteine (DCY) | C3, asymmetric |
| 1_4_BBMB | 1,4-bis(bromomethyl)benzene | 2 | L-cysteine (CYS), D-cysteine (DCY) | S2, C2, asymmetric |
| thioether  | N-terminal thioether lariat (note: no new residue is placed) | 2 | Anything (N-terminus) to L-cysteine (CYS) or D-cysteine (DCY) side-chain | asymmetric |
| TMA  | trimesic acid                  | 3 | L-lysine (LYS), D-lysine (DLY), L-ornithine (ORN), D-ornithine (DOR), L-2,4-diaminobutyric acid (DAB), D-2,4-diaminobutyric acid (DDA), L-2,3-diaminopropanoic acid (DPP), D-2,3-diaminopropanoic acid (DDP) | C3, asymmetric |

## Auto-generated documentation

[[include:mover_CrosslinkerMover_type]]

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
