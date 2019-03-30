# AddCDRProfileSetsOperation
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## AddCDRProfileSetsOperation

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

### Brief
Add Cluster-based sets of mutations as a TaskOperation. Essentially samples full sequences of CDRs within a particular CDR cluster randomly each time the packer is called. Does this for each CDR. Uses the MutationSetDesignOperation for the heavy lifting (not currently RS compatible) If a CDR has an unknown cluster or there are no data for that particular CDR, will skip that CDR. CDR definitions used are North/Dunbrack as the clusters are defined using it.

### Details 

Note that by default, a data cutoff of 10 is set.  If the cluster has less than 10 sequences it will be skipped. Use the set_cutoff function to change this.

**This TaskOperation is not currently recommended for H3 as it does not cluster well**


```xml
<AddCDRProfileSetsOperation cdrs="(&string,&string)" numbering_scheme="(&string)" include_native_restype="(&bool, true)" picking_rounds="(&size, 1)"/>
```


###Common Options 

-   cdrs (&string,&string) (default=all cdrs):  Select the set of CDRs you wish to restrict to (ex: H1 or h1)
-   numbering_scheme (&string):  Set the antibody numbering scheme.  This option can also be set through the command line.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   include_native_restype (&bool) (default=true):  Include the native residue type when sampling? 
-   picking_rounds (&size) (default=1): Set the number of times a residutype is chosen from the distribution each time the packer is generated.  Increase this number to increase variability of design.

### Length-based Sampling Options

-   limit_only_to_length (&bool) (default=false): Set the class to sample all CDR sequences within a particular length, instead of by cluster, which is the default.  If the length is small and the clusters are close together, this would work OK.  Generally not recommended though.
-   use_light_chain_type (&bool) (default=true): Use the light chain type if passed using command line options (_-light_chain_ [lambda/kappa]).  Recommended when sampling only sequences for particular lengths. 

### Uncommon Options
-   use_outliers (&bool) (default=false): Use cluster outliers as defined using DihedralDistance and RMSD.
-   cutoff (&size) (default=10): Will use the fallback strategy for this CDR if the total is less than or equal to this number.

### Benchmarking Options
-   force_north_paper_db (&bool) (default=false): Force the use of the original 2011 North/Dunbrack clustering paper data as the database instead of any up-to-date versions downloaded from PyIgClassify. 

##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
