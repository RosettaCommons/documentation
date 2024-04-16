# ParatopeEpitopeConstraintMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ParatopeEpitopeConstraintMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework

###Purpose

Adds SiteConstraints from the Antibody Paratope to the Epitope on the antigen.  Individual residues of the paratope can be set, or specific CDRs of the paratope can be set as well. The Epitope is auto-detected within the set interface distance, unless epitope residues are specified.  These SiteConstraints help to keep only the paratope in contact with the antigen epitope (as apposed to the framework or other parts of the antigen) during rigid-body movement. See the [[Constraint File Overview | constraint-file#constraint-types]] for more information on manually adding SiteConstraints.  Do not forget to add the atom_pair_constraint term to your scorefunction. A weight of .01 for the SiteConstraints seems optimum. Default paratope is defined as all 6 CDRs (or 3 if working with a camelid antibody).  

####Details

Will only add the constraint if not already present.  Uses a Linear Harmonic at 0, 1, 10 by default.  Which means paratope-epitope contact will have penalty at greater than 10 A. Linear Harmonic distance tolerance (last number) is set at the interface distance.

#### What is a SiteConstraint?

Constraint that a residue interacts with some other chain or region. SiteConstraints are a set of ambiguous atom-pair constraints that evaluate whether a residue interacts with some other chain or region - roughly, that it is (or is not) in a binding site. More specifically, if we have a SiteConstraint on a particular residue, that SiteConstraint consists of a set of distance constraints on the C-alpha from that residue to the C-alpha of all other residues in a set, typically the set being specific residues on another chain or chains. After each constraint is evaluated, only the constraint giving the lowest score is used as the SiteConstraint energy for that residue.

```xml
<ParatopeEpitopeConstraintMover paratope_cdrs="(&string (ex: L1,L1,L3))" interface_distance="(&real)" />
```

###Optional

#### Paratope and Epitope Definition

-   paratope_cdrs (&string) (Default=all CDRs): Specifically set the paratope as these CDRs.
-   paratope_residues_pdb (&string) : Set specific residues as the paratope.  (Ex: 24L,26L-32L, 44H-44H:A).  Can specify ranges or individual residues as well as insertion codes (Ex: 44H:A with A being insertion code).  Optionally set paratope_residues instead of paratope_residues_pdb as the internal rosetta residue numbers (Ex: 14,25,26).  Internal rosetta numbering parsing does not currently support ranges.
-   epitope_residues_pdb (&string) : Set specific residues as the epitope.  (Ex: 24L,26L-32L, 44H-44H:A).  Can specify ranges or individual residues as well as insertion codes (Ex: 44H:A with A being insertion code).  Optionally set epitope_residues instead of epitope_residues_pdb as the internal rosetta residue numbers (Ex: 14,25,26).  Internal rosetta numbering parsing does not currently support ranges.

#### Etc.

-   interface_distance (&real) (Default=10): Distance in Angstroms for the interface, which effects when the SiteConstraint penalty begins. 


##See Also

* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[CDRDihedralConstraintMover]]
* [[ParatopeSiteConstraintMover]]
* [[Constraint File Overview | constraint-file#constraint-types]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[I want to do x]]: Guide to choosing a mover
