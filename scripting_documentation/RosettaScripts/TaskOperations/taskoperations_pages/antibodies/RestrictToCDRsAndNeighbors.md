# RestrictToCDRsAndNeighbors
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictToCDRsAndNeighbors

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

### Brief
Task Operation to restrict packing to specific CDRs and neighbors. Will disable packing AND design for all other residues. See the design options for further control. 

See the [[DisableAntibodyRegionOperation]] and [[DisableCDRsOperation]] to further restrict the TaskFactory.

### Details 
By default, restricts to all packing of all CDRs and neighbors.  Analogous to the RestrictToLoopsAndNeighbors TaskOperation which does not currently have RS support. 

See options for control of which CDRs, including whether to only restrict to design and control of whether we design 
neighbor antigen and/or neighbor framework residues.

     <RestrictToCDRsAndNeighbors name="restrict" cdrs="(&string,&string)" numbering_scheme="(&string)" cdr_definition="(&string)" />

###Common Options 

-   cdrs (&string,&string) (default=all cdrs):  Select the set of CDRs you wish to restrict to (ex: H1 or h1)
-   neighbor_dis (&real) (default=6.0): Set the neighbor detection distance.  
-   numbering_scheme (&string):  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can also be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   cdr_definition (&string): Set the cdr definition you want to use.  Must also set the numbering_scheme XML option.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]]

### Design Options
-   design_cdrs (&bool) (default=false):  Allow design of selected CDRs (otherwise only repack)
-   design_antigen (&bool) (default=false): Allow design of neighbor antigen residues (otherwise only repack)
-   design_framework (&bool) default=false): Allow design of neighbor framework residues (otherwise only repack)
 

### Extra Options
-   stem_size (&size) (default=0): Set the stem size.  Will include N number of residues on either side of each CDR as being part of the CDR for restriction.

##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts