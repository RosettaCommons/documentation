# CDRDihedralConstraintMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## CDRDihedralConstraintMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework

###Purpose
Adds Circular Harmonic Dihedral Constraints to the Phi and Psi dihedral angles to a particular CDR either using the current computed North/Dunbrack CDR Cluster (requires AHo numbered antibody) or general constraints.  These constraints keep the CDR structure from moving too much during backbone optimization such as FastRelax. Please see the [[constraints | constraint-file#constraint-types]] page for more information on constraints and [[this page | General-Antibody-Options-and-Tips]] for more information on antibody numbering. 

```xml
<CDRDihedralConstraintMover name="dih_mover" cdr="(&string (ex: L1))" use_cluster_csts="(&bool)" />
```

###Required

-   cdr (& string): CDR to add the constraints to (ex: H1 or h1)

###Optional

####Cluster-based Constraint Settings
-   use_cluster_csts (&bool) (Default=true): Add cluster-based constraints?  If false, we will use general dihedral constraints. 

-   force_cluster (&string) (Ex: L1-11-1): Force addition of cluster constraints of this particular cluster.  Must be same CDR length as the current CDR.

-   cluster_data_required (&size) (Default=10): Value for cluster-based dihedral csts -> general dihedral csts switch.  If number of total structures used for cluster-based constraints is less than this value, general dihedral constraints will be used.  More data = better predictability.

-   use_general_constraints_on_failure (&bool) (Default=true): Add general constraints if cluster-based constraint addition failed.  It can fail if the cluster cannot be determined (such as some H3 loops), or if there is not enough data (see cluster_data_required option.  If this is false and cluster-based constraint addition failed, then we will not do anything.  

-   use_outliers (&bool) (Default=false):  Use a separate set of data for cluster-based constraints which contained outliers for the calculation.  Outliers are defined as having a dihedral distance of > 40 degrees and an RMSD of >1.5 A to the cluster center.  Use to increase sampling of small or rare clusters.

#### General Constraint Settings

-   general_phi_sd (&real) (Default=16): Standard deviation to use for phi while using general dihedral circular harmonic constraints
-   general_psi_sd (&real) (Default=16): Standard deviation to use for psi while using general dihedral circular harmonic constraints

##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[ParatopeSiteConstraintMover]]
* [[ParatopeEpitopeSiteConstraintMover]]
* [[Constraint File Overview | constraint-file#constraint-types]]
* [[I want to do x]]: Guide to choosing a mover
