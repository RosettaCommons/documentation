# AntibodyDesignProtocol
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AntibodyDesignProtocol

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]] 

###Purpose

Runs the full Rosetta Antibody Design (RAbD) Protocol.  Requires an AHo numbered antibody. Note that only the top design will move on in RosettaScripts.  See the [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign ]] for more information.  Note that the [[AntibodyDesignMover]] allows more control. The default setting is to design all CDRs.  Any antibody design options discussed in the antibody design documentation but not set through the XML (as outlined in this document) can be set through the Command line. More options are available to the [[AntibodyDesignMover]]


```xml
<AntibodyDesignProtocol seq_design_cdrs="(&string (ex: L1,L1,L3))"  graft_design_cdrs="(&string (ex: L1,L1,L3))"/>
```

###Recommended Settings

-   seq_design_cdrs (&string): Set the CDRs you wish to design.  This will run sequence design during the protocol on these CDRs using cluster-based profiles by default if they are available for that particular CDR. The instruction_file can be used to tailer the design further. 

-   graft_design_cdrs (&string): Set the CDRs you wish to design.  This will sample loops from the RAbD database.  An instruction file can be used to specify particular lengths, clusters, or to sample from the current cluster. 

### Full Options

[[include:mover_AntibodyDesignProtocol_type]]


##See Also

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]
* [[Main AntibodyDesign Mover | AntibodyDesignMover]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[AntibodyDesignMover]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide to choosing a mover