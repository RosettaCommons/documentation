# Backrub
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Backrub

Purely local moves using rotations around axes defined by two backbone atoms.

```xml
<Backrub name="(&string)" pivot_residues="(all residues &string)" pivot_atoms="(CA &string)" min_atoms="(3 &Size)" max_atoms="(34 &Size)" max_angle_disp_4="(40/180*pi &Real)" max_angle_disp_7="(20/180*pi &Real)" max_angle_disp_slope="(-1/3/180*pi &Real)" preserve_detailed_balance="(0 &bool)" require_mm_bend="(1 &bool)"/>
```

-   pivot\_residues: residues for which contiguous stretches can contain segments (comma separated) can use PDB numbers (\<resnum\>\<chain\>) or absolute Rosetta numbers (integer)
-   pivot\_atoms: main chain atoms usable as pivots (comma separated)
-   min\_atoms: minimum backrub segment size (atoms)
-   max\_atoms: maximum backrub segment size (atoms)
-   max\_angle\_disp\_4: maximum angular displacement for 4 atom segments (radians)
-   max\_angle\_disp\_7: maximum angular displacement for 7 atom segments (radians)
-   max\_angle\_disp\_slope: maximum angular displacement slope for other atom segments (radians)
-   preserve\_detailed\_balance: if set to true, does not change branching atom angles during apply and sets ideal branch angles during initialization if used with MetropolisHastings
-   require\_mm\_bend: if true and used with MetropolisHastings, will exit if mm\_bend is not in the score function
-   movemap\_factory: The name of the pre-defined MoveMapfactory that will be used to alter the default behaviour of the MoveMap. By default, all backbone, chi, and jump DOFs are allowed to change. A MoveMapFactory can be used to change which of those DOFs are actually enabled. The provision of MoveMapFactory can allow dynamic allocation as the factory can take residues from the residue selector. Be warned that combining a MoveMapFactory with a Movemap can result in unexpected behaviour. The Movemap provided as a subelement of this element will be generated, and then the DoF modifications specified in the MoveMap Factory will be applied afterwards. Note that if residues are defined with the pivot_residues tag, they will override residues defined by both the movemap or the movemap factory.



##See Also

* [[BackrubDDMover]]: Backrub-style backbone and sidechain sampling
* [[Backrub]]: The backrub application
* [[Backrub Server (external link)|https://kortemmelab.ucsf.edu/backrub/cgi-bin/rosettaweb.py?query=index]]: Web-based server that provides backrub ensembles for academic users
* [[I want to do x]]: Guide to choosing a mover
