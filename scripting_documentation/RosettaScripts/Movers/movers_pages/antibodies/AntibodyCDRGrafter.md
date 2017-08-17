# AntibodyCDRGrafter
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AntibodyCDRGrafter

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework

###Purpose

Graft CDR loops from one structure to another, optionally optimize CDRs and neighbor CDRs of the grafted one.  
Results in 100 percent loop closure if using both graft graft movers (where peptide bond geometries of both ends are checked relative to ideal values).

###Algorithm

Closes loops using the [[CCDEndsGraftMover]] and optionally the [[AnchoredGraftMover]]. Optionally optimizes using dihedral constrained relaxed on the CDR loops (general - not cluster-based for now). ( [[CDRDihedralConstraintMover]] , [[FastRelaxMover]] ). 

####Defaults

By default, uses two residues on N and C terminal of insert CDR and scaffold to close loop and stops after the graft is closed.

Can graft/optimize the DE loop - known here as proto_l4 / l4 and proto_h4.  If grafting L1, it is highly recommended to optimize or even graft the DE loop (optimization of the DE loop is on by default). 

This Mover will take care of all deletion of regions, copying coords, etc so no pre-prep of either structure is necessary.  


####Neighbor CDR optimization

Used if optimize_cdrs option is given.  Neighbors of CDRs are defined as follows.  Will add grafted CDRs and neighbor CDRs to be optimized if optimization is enabled.  DE/CDR4 can be turned off by setting the option optimize_cdr4_if_neighbor to false.

Neighbor CDRs.
```
L1 - L2 L3 L4
L2 - L1 L4
L3 - L1 H3
L4 - L1 L2	

H1 - H2 H3 H4
H2 - H1 H4
H3 - H1 L3
H4 - H1 H2

```



     <AntibodyCDRGrafter name="grafter" cdrs="(&string,&string)" numbering_scheme="(&string)" cdr_definition="(&string)" donor_structure_from_pdb="(&string)" use_secondary_graft_mover(&bool) optimize_cdrs(&bool) optimize_cdr4_if_neighbor(&bool) scorefxn="s"/>


###Common Options 

-   __cdrs__ (&string,&string) (default=all (6) cdrs):  Select the set of CDRs you wish to restrict to (ex: H1 or h1) including only one.  Can graft DE loop by passing L4 or H4 as the loop.
-   __input_ab_scheme__ (&string):  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can alternatively be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   __cdr_definition__ (&string): Set the cdr definition you want to use.  Must also set the numbering_scheme XML option.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]]
-   _stop_after_closure_ (&bool) (default=1): Set a boolean for whether to stop after closure or not.  


###Donor Structure
-   _donor_structure_from_pdb_ (&string): Path to the structure that you will use for the graft.  Can be a full PDB, a single antibody chain, or a just a CDR with 3 residues extra on either side.  Must be renumbered and numbering must match structure we are grafting into (-s)
-   _donor_structure_from_spm_ (&string): Same as above, but structure comes from the [[SavePoseMover]].  This is the reference name to the SPM.

###Optimization
-   __optimize_cdrs__ (&bool) (default=0): Set to optimize any grafted and neighbor CDRs using dihdedral constrained relax on them. Recommended if using secondary graft mover.
-   __optimize_cdr4_if_neighbor__ (&bool) (default=1): Set to include the DE loop/CDR4 if it is a neighbor to a grafted CDR and _optimization is set to on_. Recommended if optimizing, especially for CDR1.
-   _dihedral_cst_wt_ (&Real) (default=2.0): Set the dihedral constraint weight used if optimization is done and the scorefxn dihedral_constraint weight is zero. 
-   __use_secondary_graft_mover__ (&bool) (default=0): Set a boolean for whether to use the secondary graft mover is the graft is not closed using the first.  Using this results in 100% graft closure, however, in order to fix the structure, optimize_cdrs is highly recommended. ~85% Graft closure without (slight non ideal values for peptide bond distance and angles.)


###More Options
-   _nter_overhang_ (&size) (default=3): Number of extra residues on the Nter side of the CDR to use for superposition for insertion.  Will delete these residues before insertion.
-   _cter_overhang_ (&size) (default=3): Number of extra residues on the Nter side of the CDR to use for superposition for insertion.  Will delete these residues before insertion. 
-   __scorefxn__ (&string) (default=Rosetta default): All Atom scorefunction to use for final repack


##See Also

* [[SavePoseMover]]
* [[AnchoredGraftMover]]
* [[CCDEndsGraftMover]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[ParatopeSiteConstraintMover]]
* [[ParatopeEpitopeSiteConstraintMover]]
* [[Constraint File Overview | constraint-file#constraint-types]]
* [[I want to do x]]: Guide to choosing a mover