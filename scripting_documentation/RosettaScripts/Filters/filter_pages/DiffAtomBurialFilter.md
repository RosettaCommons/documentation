# DiffAtomBurial
*Back to [[Filters|Filters-RosettaScripts]] page.*
## DiffAtomBurial

-   As of 12-3-12: I'd be careful of using this one. After checking many of these filtered results by hand, I'm not convinced that it works properly / the way one would expect.

Compares the DSasa of two specified atoms and checks to see if one is greater or less than other. This is useful for figuring out whether a ligand is oriented in the correct way (i.e. whether in the designed interface one atom is more/less exposed than another)

```xml
<DiffAtomBurial name="(&string)"  res1_res_num/res1_pdb_num="(0, see res_num/pdb_num convention)" res2_res_num/res2_pdb_num="(0, see convention)" atomname1="(&string)" atomname2="(&string)" sample_type="(&string)"/>
```

pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]

-   res1\_res\_num/res2\_res\_num: conventional pose numbering of rosetta, res\_num=0 will mean ligand (Assuming there is only one ligand)
-   res1\_pdb\_num/res2\_pdb\_num: conventional pdb\_numbering such as 100A (residue 100 chain A), 1X (residue 1 chain X e.g. of ligand)
-   atomname1/atomname2: atomnames of the respective atoms
-   sample\_type: "more" or "less". "more" means Dsasa1\>Dsasa2 (atom1 is more buried than atom2); "less" means Dsasa1\<Dsasa2 (atom1 is less buried than atom2)

## See also:

* [[Ligand Docking|ligand-dock]]
* [[DSasaFilter]]
* [[LigInterfaceEnergyFilter]]
* [[RepackWithoutLigandFilter]]
