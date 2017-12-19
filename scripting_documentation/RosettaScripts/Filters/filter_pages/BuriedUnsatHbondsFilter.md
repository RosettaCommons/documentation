# BuriedUnsatHbonds
*Back to [[Filters|Filters-RosettaScripts]] page.*
## BuriedUnsatHbonds

Maximum number of buried unsatisfied polar atoms allowed. This filter was significantly updated Dec 18, 2017: users can choose different reporting behaviors, and the default is to return the number of buried heavy-atom donors/acceptors that do not participate in any h-bonds.  The old behavior was to count all unsats as equal, and to use a ddG-style calculation (subtract \#unsat unbound from \#unsat bound); these options are still available but no longer the default.  The filter now by default uses a more generous definition of h-bonds (previously, many legit h-bonds were excluded because of sfxn exceptions); users can now choose between legacy SASA and VSASA for burial (Andrew's VSASA varsoldist is default); poses with more than 3 chains are now supported; the Filter is now Symmetry compatible, and users can pass sym_dof_names as in Jacob Bale's SymUnsatHbonds filter.  The old filter behavior can be restored by setting use_legacy_options="true", but this is only recommended for benchmarking purposes

### Restoring the old filter's behavior: 
If `use_legacy_options="true"` then the filter works exactly like before and expects the same options, behaving as follows:
If a jump number is specified (default=1), then this number is calculated across the interface of that jump. If jump\_number=0, then the filter is calculated for a monomer. Note that \#unsat for monomers is often much higher than 20. Notice that water is not assumed in these calculations. By specifying task\_operations you can decide which residues will be used to compute the statistic. ONly residues that are defined as repackable (or designable) will be used for computing. Others will be ignored. A tricky aspect is that backbone unsatisfied hbonds will also only be counted for residues that are mentioned in the task\_operations, so this is somewhat inconsistent.

### Recommended usage examples: 
Can include multiple instances to report difference metrics: 
All info about all unsat types is reported to log, and can be printed to pdb file output:

```
# old filter, recapitulates results of this filter before Dec 16 2017
<BuriedUnsatHbonds use_legacy_options="true" name="(&string)" scorefxn="(&string)" jump_number="(1 &Size)" cutoff="(20 &Size)" task_operations="(&string)"/>

# report the number of backbone (bb) heavy-atom buns, using residue selector
<BuriedUnsatHbonds name="new_buns_bb_heavy" residue_selector="(&string)" report_bb_heavy_atom_unsats="true" scorefxn="(&string)" residue_surface_cutoff="20.0" ignore_surface_res="true" print_out_info_to_pdb="true" confidence="0"/>

# report the number of sidechain (sc) heavy-atom buns, using a residue selector
<BuriedUnsatHbonds name="new_buns_sc_heavy" residue_selector="(&string)" report_sc_heavy_atom_unsats="true" scorefxn="(&string)" residue_surface_cutoff="20.0" ignore_surface_res="true" print_out_info_to_pdb="true" confidence="0"/>

```

### Symmetry
The filter is now Symmetry aware.  The default for Symmetric case is that symmetry is auto-detected and will only count totals for the ASU.  If `use_ddG_style="true"` it's expected that users define `sym_dof_names`, and if `sym_dof_names="true"`, ddG-style is used by default; this behaves the same way as Jacob Bale's SymUnsatHbonds filter for multicomponent symmetry; if `use_ddG_style="true"` and `sym_dof_names` not defined, then will search at symmetric interface residue (`only_interface="true"`).  Search space can also be defined by residue_selector.

### All options
-   use_legacy_options: revert to legacy options (equivalent to old, original BuriedUnsat Filter; WARNING! If this is true, will overwrite all other options; default is false.
-   generous_hbonds: count all h-bonds (not just those scored by the default scorefxn in rosetta; default is true. 
-   use_vsasa: use vsasa insteady of legacy sasa for burial calculation; default is true
-   ignore_surface_res: many polar atoms on surface atoms get flagged as buried unsat becuause they are occluded by a long sidechina (e.g. Lys or Arg) that could easily move out of the way; this option ignores surface residues, as deinfed by SASA (default) or sc_neighbors if use_sc_neighbors=true
-   ignore_bb_heavy_unsats: ignore bb heayy atom unsats when using hbnet-style behavior; default false.
-   use_sc_neighbors: use sc_neighbors instead of SASA for burial calculations; default false.
-   use_ddG_style: perform ddG style calcation: the Unsats are calculated by subtracting all unsats in bound state from unbound state; this is how the original BuriedUnsatHBondsFilter works; default false.
-   jump_number: The jump over which to evaluate the filter; only applies to use_ddG_style.
-   only_interface: restrict unsat search only to interface residues; if true and more than one chain it's ignored; default false. 
-   cutoff: The upper threshold for counted buried unsat H-bonds, above which the filter fails; default 20.
-   print_out_info_to_pdb: print all info to pdb file into addition to tracer. 
-   probe_radius: probe radius to use for SASA buriedness calculations; default is grabbed from sasa_calculator_probe_radius in options code, which defaults to 1.4.
-   burial_cutoff: used to determine burial; deafault legacy SASA atomic_burial_cutoff is 0.3; default VSASA cutoff is 0.1; if use_sc_neighbors=true, default becomes 4.4 or can be user-specified to sc_neighbor cutoff that is desired.
-   residue_surface_cutoff: cutoff to determine which residues are surface if ignore_surface_res=true; default is 45.0 for SASA, 20.0 for VSASA and 2.0 if use_sc_neighbors=true.
-   use_reporter_behavior: report as filter score the type of unsat turned on; this is now TRUE by default.
-   report_all_heavy_atom_unsats: report all heavy atom unsats; IF ALL REORTER OPTIONS ARE FALSE, THIS BECOMES TRUE AND DEFAULT REPORTS ALL HEAVY UNSATS.
-   report_all_unsats: report total of all unsats (legacy behavior of the old filter).
-   report_sc_heavy_atom_unsats: report side chain heavy atom unsats.
-   report_bb_heavy_atom_unsats: report back bone heavy atom unsats.
-   report_nonheavy_unsats: report non heavy atom unsats (Hpol).
-   use_hbnet_behavior: no heavy unstas allowed (will return 9999); if no heavy unstas, will count Hpol unsats; FALSE by default; if set to true, will NOT use reporter behavior.
-   sym_dof_names: For multicomponent symmetry: what jump(s) used for ddG-like separation. (From Dr. Bale: For multicomponent systems, one can simply pass the names of the sym_dofs that control the master jumps. For one component systems, jump can still be used.)  IF YOU DEFIN THIS OPTION, Will use ddG-style separation for the calulation.
-   residue_selector: residue selector that tells the filter to restrict the Unsat search to only those residues.
-   task_operations: define residues to look at by task operations (legacy behavior of old filter); now recommended to use residue_selector instead.

# See Also:

* [[HbondsToResidueFilter]]
* [[HbondsToAtomFilter]]
* [[SymUnsatHbondsFilter]]
* [[BuriedUnsatHbonds2Filter]]
