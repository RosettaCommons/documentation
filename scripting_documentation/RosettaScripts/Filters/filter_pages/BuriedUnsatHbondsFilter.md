# BuriedUnsatHbonds
*Back to [[Filters|Filters-RosettaScripts]] page.*
## BuriedUnsatHbonds

Maximum number of buried unsatisfied polar atoms allowed. This filter was significantly updated Dec 18, 2017: users can choose different reporting behaviors, and the default is to return the number of buried heavy-atom donors/acceptors that do not participate in any h-bonds.  The old behavior was to count all unsats as equal, and to use a ddG-style calculation (subtract \#unsat unbound from \#unsat bound); these options are still available but no longer the default.  The filter now by default uses a more generous definition of h-bonds (previously, many legit h-bonds were excluded because of sfxn exceptions); users can now choose between legacy SASA and VSASA for burial (Andrew's VSASA varsoldist is default); poses with more than 3 chains are now supported; the Filter is now Symmetry compatible, and users can pass sym_dof_names as in Jacob Bale's [[SymUnsatHbondsFilter]] .  The old filter behavior can be restored by setting use_legacy_options="true", but this is only recommended for benchmarking purposes

For a survey of buried polar atoms in native protein structures, see [[HBond-Preferences-Of-Buried-Polars]]. 

### Restoring the old filter's behavior: 
If `use_legacy_options="true"` then the filter works exactly like before and expects the same options, behaving as follows:
If a jump number is specified (default=1), then this number is calculated across the interface of that jump. If jump\_number=0, then the filter is calculated for a monomer. Note that \#unsat for monomers is often much higher than 20. Notice that water is not assumed in these calculations. By specifying task\_operations you can decide which residues will be used to compute the statistic. ONly residues that are defined as repackable (or designable) will be used for computing. Others will be ignored. A tricky aspect is that backbone unsatisfied hbonds will also only be counted for residues that are mentioned in the task\_operations, so this is somewhat inconsistent.

### Recommended usage examples: 
Can include multiple instances to report different metrics: 
All info about all unsat types is reported to log, and can be printed to pdb file output:

```
# old filter, recapitulates results of this filter before Dec 16 2017
<BuriedUnsatHbonds use_legacy_options="true" name="(&string)" scorefxn="(&string)" jump_number="(1 &Size)" cutoff="(20 &Size)" task_operations="(&string)"/>

# report number of backbone (bb) heavy-atom buns, using residue selector:
#  many native and de novo backbones have at least a couple of legit buried unsats in the backbone; most occur in loops or other flexible regions, but setting this to 0 will throw out potentially good designs; best to set cutoff to a few, or use confidence="0"
<BuriedUnsatHbonds name="new_buns_bb_heavy" residue_selector="(&string)" report_bb_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="4" residue_surface_cutoff="20.0" ignore_surface_res="true" print_out_info_to_pdb="true" />

# report the number of sidechain (sc) heavy-atom buns, using a residue selector
#  if doing design, and residue selector is design space, you want this to be 0
<BuriedUnsatHbonds name="new_buns_sc_heavy" residue_selector="(&string)" report_sc_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="0" residue_surface_cutoff="20.0" ignore_surface_res="true" print_out_info_to_pdb="true" />

```

### More recommended usage examples: 
This section is more of a story about the progression of buried unsat filters in the Baker lab during 2018

The story begins with the buried unsat filter examples in the section above: "Recommended usage examples". These were in use at the beginning of 2018 and the combined BB+SC versions are given below:

**2018 buns that HAVE the rotation bug**
```
<BuriedUnsatHbonds name="new_buns_all_heavy" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="4" residue_surface_cutoff="20.0" ignore_surface_res="true" print_out_info_to_pdb="true" confidence="0" />

<BuriedUnsatHbonds name="new_buns_all_heavy_interface" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="4" ignore_surface_res="false" print_out_info_to_pdb="true" use_ddG_style="true" confidence="0" />
```

However, during 2018, a long-known fact about the buried unsat filter was rediscovered: If the pose rotates in space, the number of buried unsats will change. In a simple test case, a pose was seen to have 0-4 buried unsats depending on its orientation. The exact mechanism for this is the approximate nature of the default SASA calculator. A collection of molecular dots are generated around each atom and SASA calculated based on the dots. But there are a discrete number of dots and their position does not rotate with the pose. As a result, different orientations lead to different SASA balls being generated.

The solution was to use the analytic SASA method in the DAlphaBall executable originally used for Holes. DAlphaBall may be generated by navigating to ```Rosetta/main/source/external/DAlpahBall``` and typing ```make```. Please make sure to put the compiler libraries in accessible directories, e.g. on Mac OSX, ```conda install -c anaconda gfortran_osx-64 gmp``` then ```ln -s ~/miniconda3/lib/libgfortran.* /usr/local/lib```.

**2018 buns that DO NOT HAVE the rotation bug**
```
# Both of these examples require the following commandline flag:
-holes:dalphaball Rosetta/main/source/external/DAlpahBall/DAlphaBall.macgcc

# Additionally, a bit of testing shows that a probe_radius≈1.1 best correlates with new_buns_all_heavy

<BuriedUnsatHbonds name="buns_all_heavy_ball" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="4" residue_surface_cutoff="20.0" ignore_surface_res="true" print_out_info_to_pdb="true" dalphaball_sasa="1" probe_radius="1.1" confidence="0" />

<BuriedUnsatHbonds name="buns_all_heavy_ball_interface" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="4" ignore_surface_res="false" print_out_info_to_pdb="true" use_ddG_style="true" dalphaball_sasa="1" probe_radius="1.1" confidence="0" />
```

With a more precise definition of buried unsats, it was now possible to examine them in greater detail. David Baker noted that perhaps one should be less concerned with buried unsats near the surface and more concerned with buried unsats deep in the core; a concept which he termed "very buried unsats". With this definition in mind, Brian Coventry proposed the following two types of buried unsats:

**VBUNS**
* very buried unsats
* anything deeper than 5.5A is considered unconditionally buried
* awaiting future improvements for explicit water modeling
 
```
# burial_cutoff is set arbitrarily high so that every atom deeper than 5.5 is considered buried
<BuriedUnsatHbonds name="vbuns_all_heavy" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" ignore_surface_res="false" print_out_info_to_pdb="true" atomic_depth_selection="5.5" burial_cutoff="1000" confidence="0" />

# we must define a burial cutoff for the apo form because otherwise, we may accidentally count buried unsats present in the monomer that are not caused by complex formation
# Requires the following commandline flag:
-holes:dalphaball Rosetta/main/source/external/DAlpahBall/DAlphaBall.macgcc
<BuriedUnsatHbonds name="vbuns_all_heavy_interface" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" ignore_surface_res="false" print_out_info_to_pdb="true" atomic_depth_selection="5.5" burial_cutoff="1000" use_ddG_style="true" burial_cutoff_apo="0.2" dalphaball_sasa="true" probe_radius="1.1" confidence="0" />
```

**SBUNS**
* surface buried unsats
* anything less deep than 5.5A uses DAlphaBall SASA to determine burial
* While VBUNS and SBUNS are designed such that ```BUNS ≈ VBUNS + SBUNS```, due to the unconditional burial of VBUNS, in general: ```BUNS <= VBUNS + SBUNS```
 
```
# This is the same as buns_all_heavy_ball but using atomic_depth to only select the surface
# We set atomic_depth_deeper_than="false" to select surface
<BuriedUnsatHbonds name="sbuns_all_heavy_ball" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="4" residue_surface_cutoff="20.0" ignore_surface_res="true" print_out_info_to_pdb="true" dalphaball_sasa="1" probe_radius="1.1" atomic_depth_selection="5.5" atomic_depth_deeper_than="false" confidence="0" />

# This is the same as buns_all_heavy_ball_interface but using atomic_depth to only select the surface
# We set atomic_depth_deeper_than="false" to select surface
<BuriedUnsatHbonds name="sbuns_all_heavy_interface" residue_selector="(&string)" report_all_heavy_atom_unsats="true" scorefxn="(&string)" cutoff="4" ignore_surface_res="false" print_out_info_to_pdb="true" use_ddG_style="true" dalphaball_sasa="1" probe_radius="1.1" atomic_depth_selection="5.5" atomic_depth_deeper_than="false" confidence="0" />
```

See [[this_page|rosetta_basics/scoring/ApproximateBuriedUnsatPenalty#visualizing-the-burial-region]] for python code to visualize the burial region (the link works even though it's red).

### Symmetry
The filter is now Symmetry aware.  The default for Symmetric case is that symmetry is auto-detected and will only count totals for the ASU.  If `use_ddG_style="true"` it's expected that users define `sym_dof_names`, and if `sym_dof_names="true"`, ddG-style is used by default; this behaves the same way as Jacob Bale's [[SymUnsatHbondsFilter]] for multicomponent symmetry; if `use_ddG_style="true"` and `sym_dof_names` not defined, then will search at symmetric interface residue (`only_interface="true"`).  Search space can also be defined by residue_selector.

### All options
-   use_legacy_options: revert to legacy options (equivalent to old, original BuriedUnsat Filter; WARNING! If this is true, will overwrite all other options; default is false.
-   generous_hbonds: count all h-bonds (not just those scored by the default scorefxn in rosetta; default is true. 
-   use_vsasa: use vsasa insteady of legacy sasa for burial calculation; default is true
-   ignore_surface_res: many polar atoms on surface atoms get flagged as buried unsat becuause they are occluded by a long sidechina (e.g. Lys or Arg) that could easily move out of the way; this option ignores surface residues, as deinfed by SASA (default) or sc_neighbors if use_sc_neighbors=true
-   ignore_bb_heavy_unsats: ignore bb heayy atom unsats when using hbnet-style behavior; default false.
-   use_sc_neighbors: use sc_neighbors instead of SASA for burial calculations; default false.
-   use_ddG_style: perform ddG style calcation: the Unsats are calculated by subtracting all unsats in bound state from unbound state; this is how the original BuriedUnsatHBondsFilter works; default false.
-   ddG_style_dont_recalc_surface: This fixes a bug(?) when use_ddG_style and ignore_surface_res are used together. In the apo structure, the surface_res are recalculated which can lead to spurious buried unsats when new residues become surface and are no longer counted.
-   jump_number: The jump over which to evaluate the filter; only applies to use_ddG_style.
-   only_interface: restrict unsat search only to interface residues; if true and more than one chain it's ignored; default false. 
-   cutoff: The upper threshold for counted buried unsat H-bonds, above which the filter fails; default 20.
-   print_out_info_to_pdb: print all info to pdb file into addition to tracer. 
-   probe_radius: probe radius to use for SASA buriedness calculations; default is grabbed from sasa_calculator_probe_radius in options code, which defaults to 1.4.
-   dalphaball_sasa: Use DAlphaBall to calculate SASA. Must include the -holes:dalphaball flag.
-   burial_cutoff: used to determine burial; deafault legacy SASA atomic_burial_cutoff is 0.3; default VSASA cutoff is 0.1; if use_sc_neighbors=true, default becomes 4.4 or can be user-specified to sc_neighbor cutoff that is desired.
-   probe_radius_apo: If set greater than 0, use a different probe_radius for the apo phase of use_ddG_style.
-   burial_cutoff_apo: If set greater than 0, use a different burial_cutoff for the apo phase of use_ddG_style.
-   residue_surface_cutoff: cutoff to determine which residues are surface if ignore_surface_res=true; default is 45.0 for SASA, 20.0 for VSASA and 2.0 if use_sc_neighbors=true.
-   atomic_depth_selection: Include only atoms past a certain depth. Depth is from edge of SASA surface to center of atom. Pose converted to poly-LEU before SASA surface calculation. -1 to disable.
-   atomic_depth_probe_radius: Probe radius for atomic_depth_selection. Set this high to exclude pores. Set this low to allow the SASA surface to enter pores.
-   atomic_depth_deeper_than: If true, only atoms deeper than atomic_depth_selection are included. If false, only atoms less deep than atomic_depth_selection are included.
-   use_reporter_behavior: report as filter score the type of unsat turned on; this is now TRUE by default.
-   report_all_heavy_atom_unsats: report all heavy atom unsats; IF ALL REORTER OPTIONS ARE FALSE, THIS BECOMES TRUE AND DEFAULT REPORTS ALL HEAVY UNSATS.
-   report_all_unsats: report total of all unsats (legacy behavior of the old filter).
-   report_sc_heavy_atom_unsats: report side chain heavy atom unsats.
-   report_bb_heavy_atom_unsats: report back bone heavy atom unsats.
-   report_nonheavy_unsats: report non heavy atom unsats (Hpol).
-   use_hbnet_behavior: no heavy unstas allowed (will return 9999); if no heavy unstas, will count Hpol unsats; FALSE by default; if set to true, will NOT use reporter behavior.
-   sym_dof_names: For multicomponent symmetry: what jump(s) used for ddG-like separation. (From Dr. Bale: For multicomponent systems, one can simply pass the names of the sym_dofs that control the master jumps. For one component systems, jump can still be used.)  IF YOU DEFINE THIS OPTION, it will use ddG-style separation for the calculation.
-   [[residue_selector|ResidueSelectors]]: residue selector that tells the filter to restrict the Unsat search to only those residues.
-   task_operations: define residues to look at by task operations (legacy behavior of old filter); now recommended to use residue_selector instead.

# See Also:
* [[HBond-Preferences-Of-Buried-Polars]]
* [[HbondsToResidueFilter]]
* [[HbondsToAtomFilter]]
* [[SymUnsatHbondsFilter]]
* [[BuriedUnsatHbonds2Filter]]
* [[ResidueSelectors]]
