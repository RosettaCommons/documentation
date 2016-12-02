# EnzScore
*Back to [[Filters|Filters-RosettaScripts]] page.*
## EnzScore

Calculates scores of a pose e.g. a ligand-protein interface taking into account (or not) enzdes style cst\_energy. Residues can be accessed by res\_num/pdb\_num or their constraint id. One and only one of res/pdb\_num, cstid, and whole\_pose tags can be specified. energy should be less than cutoff to pass.

```
<EnzScore name="(&string)"  scorefxn="(&string, score12)" whole_pose="(&bool,0)" score_type="(&string)" res_num/pdb_num="(see convention)" cstid="(&string)" energy_cutoff="(0.0 &float)"/>
```

-   cstid: string corresponding to cst\_number+template (A or B, as in remarks and cstfile blocks). each enzdes cst is between two residues; A or B allows access to the corresponding residue in a given constraint e.g. cstid=1A means cst \#1 template A (i.e. for the 1st constraint, the residue corresponding to the block that is described first in the cstfile and its corresponding REMARK line in header), cstid=4B (for the 4th constraint, the residue that is described second in the cstfile block and its REMARK line in header).
-   score\_type: usual rosetta score\_types; cstE will calculate enzdes style constraint energy
-   whole\_pose: calculate total scores for whole pose
-   pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]

## See also

* [[Matching|match]]
* [[Enzyme Design|enzyme-design]]
* [[Ligand docking|ligand-dock]]
* [[LigInterfaceEnergyFilter]]
* [[RepackWithoutLigandFilter]]
