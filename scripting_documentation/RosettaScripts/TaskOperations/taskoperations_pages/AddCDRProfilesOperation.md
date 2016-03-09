# AddCDRProfilesOperation
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## AddCDRProfilesOperation

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework

### Brief
Add Cluster-based CDR Profiles as the task operation for the set of CDRs by default.
Uses the ResidueProbDesignOperation to sample the CDR Cluster profile based on the probability distribution for the CDR clusters.  Multiple rounds of packing are recommended to sample on the distributions.
CDR definitions used are North/Dunbrack as the clusters are defined using it.  By default ALL CDRs are set for sampling.


##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts