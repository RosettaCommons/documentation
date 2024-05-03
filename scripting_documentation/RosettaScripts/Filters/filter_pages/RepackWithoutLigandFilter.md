# RepackWithoutLigand
*Back to [[Filters|Filters-RosettaScripts]] page.*
## RepackWithoutLigand

Calculates delta\_energy or RMSD of protein residues in a protein-ligand interface when the ligand is removed and the interface repacked. 

Access delta\_energy by using energy\_threshold option.

Access RMSD by using rms\_threshold and target\_res options.

```xml
<RepackWithoutLigand name="(&string)"  scorefxn="(&string, score12)" target_res="(&string)" target_cstids="(&string)" energy_threshold="(0.0 &float)" rms_threshold="(0.5 &float)"/>
```

-   target\_cstids: comma-separated list corresponding to cstids (see EnzScore for cstid format)
-   target\_res: comma-separated list corresponding to res\_nums/pdb\_nums (following usual convention: [[RosettaScripts#rosettascripts-conventions_specifying-residues]] ) OR "all\_repacked" which will include all repacked neighbors of the ligand (the repack shell).
-   rms\_threshold: maximum allowed RMS of repacked region; (i.e. RMSD\<rms\_threshold filter passes, else fails)
-   energy\_threshold: delta\_Energy allowed (i.e. if E(with\_ligand)-E(no\_ligand) \< threshold, filter passes else fails)

Known issues:
Use command line flag `-detect_design_interface` to speed up the filter. This filter is very slow without this flag.

## See also:

* [[Ligand Docking|ligand-dock]]
* [[DeltaFilter]]
* [[DSasaFilter]]
* [[DiffAtomBurialFilter]]
* [[LigInterfaceEnergyFilter]]
