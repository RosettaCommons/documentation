# AntibodyDesignMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AntibodyDesignMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

###Purpose

Runs the full Rosetta Antibody Design (RAbD) Protocol.  Requires an AHo numbered antibody. Note that only the top design will move on in RosettaScripts.  See the [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign ]] for more information.  Note that the [[AntibodyDesignProtocol]] has much less control and tweaks available. The default setting is to design all CDRs.  Any antibody design options discussed in the antibody design documentation but not set through the XML (as outlined in this document) can be set through the Command line.


```
<AntibodyDesignMover design_cdrs="(&string (ex: L1,L1,L3))" instructions_file="(&real)" />
```

###Recommended Settings

-   design_cdrs (&string) (Default=All CDRs): Set the CDRs you wish to design.  This will both GraftDesign and SeqDesign the CDRs.  This can also be set in the CDR instruction file. Setting it in this option overrides the instruction file.

-   instruction_file (&string): Path to the CDR instruction file.  The default settings will probably not apply to your specific antibody design file.  Make sure to read about the syntax of this file in the application documentation and set one up accordingly.  The current defaults can be found in the rosetta database: database/sampling/antibodies/design/default_instructions.txt.  Each option given in this file will over ride each individual default (if you only want to override one option, that is all you would need to put in your passed in instruction file.).


### Main Protocol Settings
-   design_protocol (&bool) (Default=generalized_monte_carlo): Set the antibody design protocol.  See app documentation for more information.
-   do_dock (&bool) (Default=false): Run RosettaDock (with SeqDesign if set) during the inner cycles (low and high) at optimal cycle values.  Useful to sample the antibody-antigen interface, but increases runtime significantly.
-   dock_cycles (&size) (Default=1): Change the number of times the dock protocol (Low/High) is run.
-   benchmark (&size) Default=false): Start with Random CDRs from the antibody design database for any CDRs that are undergoing GraftDesign.  Randomized sequences for CDRs undergoing SeqDesign is planned.

###ScoreFunction Settings

-   scorefxn (&string): Pass a scorefxn name to the mover, which acts as the global scorefunction.  Will automatically add constraint terms based on settings.

-   scorefxn_min (&string): Pass a scorefxn name to the mover, which is only used for minimization.  Will automatically add constraint terms based on settings.

###Distances

-   interface_dis (&bool): Set the interface detection distance.
-   neighbor_dis (&bool): Set the neighbor detection distance.

### Cycle Control

-   outer_cycles (&size): Set the number of outer cycles.
-   inner_cycles (&size): Set the number of inner (minimization) cycles.

### KT Control
-   outer_kt (&real): Set the KT of the outer loop.
-   inner_kt (&real): Set the KT of the inner loop.


###Optional
-   add_graft_log_to_pose (&bool) (Default=false): Add the full grafting log to the pose (AKA origin PDBs, clusters, etc.)  Useful to see how the protocol went.

-   use_epitope_csts (&bool) (Default=false): Use the [[ParatopeEpitopeSiteConstraintMover]] during design instead of just the [[ParatopeSiteConstraintMover]].  Epitope is auto-detected unless specified using the option below.
-   epitope_residues (&string): Use these residues as the antigen epitope.  Default is to auto-identify them within the set interface distance at protocol start if epitope constraints are enabled. Currently only used for constraints.  PDB Numbering. Optional insertion code. Example: 1A 1B 1B:A. Note that these site constraints are only used during docking unless -enable_full_protocol_atom_pair_cst is set.
-   paratope_cdrs (&string) (Default=all CDRs): Specifically set the paratope as these CDRs.

##See Also

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[AntibodyDesignProtocol]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide to choosing a mover