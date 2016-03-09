# AddCDRProfileSetsOperation
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## AddCDRProfileSetsOperation

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework

### Brief
Add Cluster-based sets of mutations as a TaskOperation. Essentially samples full sequences of CDRs within a particular CDR cluster randomly each time the packer is called. Does this for each CDR. Uses the MutationSetDesignOperation for the heavy lifting (not currently RS compatible) If a CDR has an unknown cluster or there are no data for that particular CDR, will skip that CDR. CDR definitions used are North/Dunbrack as the clusters are defined using it.


##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts