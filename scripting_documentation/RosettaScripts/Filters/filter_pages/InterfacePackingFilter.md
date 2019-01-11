# InterfacePacking
*Back to [[Filters|Filters-RosettaScripts]] page.*
## InterfacePacking

Calculates Will Sheffler's holes score for atoms at inter-building block interfaces.. Works with symmetric assemblies with one or more building blocks. Be sure to set the -holes:dalphaball option!

    <InterfacePacking name="(&string)" sym_dof_names="('' &string)" contact_dist="(10.0 &Real)" distance_cutoff="(9.0 &Real)" lower_cutoff="(-5 &lower_cutoff)" upper_cutoff="(5 &upper_cutoff)"/>

-   sym\_dof\_names - Must be provided. Name(s) of the sym\_dof(s) corresponding to the building block(s) for which to calculate the holes score(s).
-   contact\_dist - Maximum distance between CA or CB atoms of the primary subunit(s) and the other subunits to be included in the subpose used for the holes calculations. (Should this be change to heavy atoms and set to be the same value as distance\_cutoff?)
-   distance\_cutoff - Maximum distance between heavy atoms of the primary subunit(s) and neighboring subunits in order for the holes score to be included in the calculation.
-   lower\_cutoff - Minimum passing holes score.
-   upper\_cutoff - Maximum passing holes score.

## See also

* [[InterfaceHolesFilter]]
* [[ClashCheckFilter]]
* [[GetRBDOFValuesFilter]]
* [[MutationsFilter]]
* [[OligomericAverageDegreeFilter]]
* [[SymUnsatHbondsFilter]]
