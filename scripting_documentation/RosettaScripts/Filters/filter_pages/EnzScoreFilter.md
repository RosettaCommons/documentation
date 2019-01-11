# EnzScore
*Back to [[Filters|Filters-RosettaScripts]] page.*
## EnzScore

Calculates scores of a pose e.g. a ligand-protein interface taking into account (or not) enzdes style cst\_energy. Residues can be accessed by res\_num/pdb\_num or their constraint id. One and only one of res/pdb\_num, cstid, and whole\_pose tags can be specified. Energy should be less than energy_cutoff to pass.

If whole_pose=0 and none of res_num/pdb_num or cstid are specified, EnzScore will attempt to automatically determine the ligand residue and calculate the score for that residue.  This will work with simple poses, for example when dealing with a single polypeptide chain and a single ligand connected by the last jump in the pose.  Multiple chains, multiple ligands, symmetry, etc. may break this functionality, so it is strongly recommended to specify one of whole_pose, res/pdb_num, or cstid whenever possible.

```xml
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
