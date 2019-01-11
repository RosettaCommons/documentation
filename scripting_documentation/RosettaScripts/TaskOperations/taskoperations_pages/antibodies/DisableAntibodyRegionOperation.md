# DisableAntibodyRegionOperation
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DisableAntibodyRegionOperation

A TaskOperation that disables packing +/or design of a particular antibody region.
By default, disables packing and design of the cdr_region.  Make sure to set the region you want disabled.

     <DisableAntibodyRegionOperation region="(&string)" disable_packing_and_design="(&bool)" numbering_scheme="(&string)" cdr_definition="(&string)" />

###Options 

-   region (&string) (default=cdr_region):  Select the region you wish to disable. Accepted strings: cdr_region, framework_region, antigen_region.
-   disable_packing_and_design (&bool) (default=true): Disable packing and design vs. design only?  If false, then only design is disabled for those CDRs selected.
-   numbering_scheme (&string):  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can also be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   cdr_definition (&string): Set the cdr definition you want to use.  Must also set the numbering_scheme XML option.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]]

 

##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts