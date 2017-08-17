# DisableCDRsOperation
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DisableCDRsOperation

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

###Purpose
Disable Packing and/or design of a set of CDRs.  By default, disables both packing and design of all CDRs.

     <DisableCDRsOperation cdrs="(&string,&string)" disable_packing_and_design="(&bool)" numbering_scheme="(&string)" cdr_definition="(&string)" />

###Options 

-   cdrs (&string,&string) (default=all cdrs):  Select the set of CDRs you wish to disable (ex: H1 or h1)

-   disable_packing_and_design (&bool) (default=true): Disable packing and design vs. design only?  If false, then only design is disabled for those CDRs selected.
-   numbering_scheme (&string):  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can also be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   cdr_definition (&string): Set the cdr definition you want to use.  Must also set the numbering_scheme XML option.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]]

 

##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts