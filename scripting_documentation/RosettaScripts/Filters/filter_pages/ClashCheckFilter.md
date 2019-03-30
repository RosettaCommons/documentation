# ClashCheck
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ClashCheck

Calculate the number of heavy atoms clashing between building blocks.

    <ClashCheck name="(&string)" sym_dof_names="(&string)" clash_dist="(3.5 &Real)" nsub_bblock="(1 &Size)" cutoff="(0 &Size)" verbose="(0 &bool)" write2pdb="(0 &bool)"/>

-   clash\_dist - Distance between heavy atoms below which they are considered to be clashing. Note: A hard-coded cutoff of 2.6 is set for contacts between backbone carbonyl oxygens and nitrogens for bb-bb hbonds.
-   sym\_dof\_names - Only use with multicomponent systems. Name(s) of the sym\_dof(s) corresponding to the building block(s) between which to check for clashes.
-   nsub\_bblock - The number of subunits in the symmetric building block. Does not need to be set for multicomponent systems.
-   cutoff - Maximum number of allowable clashes.
-   verbose - If set to true, then will output a pymol selection string to the logfile with the clashing positions/atoms.
-   write2pdb - If set to true, then will output a pymol selection string to the output pdb with the clashing positions/atoms.

## See also

* [[GetRBDOFValuesFilter]]
* [[InterfacePackingFilter]]
* [[MutationsFilter]]
* [[OligomericAverageDegreeFilter]]
* [[SymUnsatHbondsFilter]]
