# AntibodyDesignProtocol
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AntibodyDesignProtocol

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]] 

###Purpose

Runs the full Rosetta Antibody Design (RAbD) Protocol.  Requires an AHo numbered antibody. Note that only the top design will move on in RosettaScripts.  See the [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign ]] for more information.  Note that the [[AntibodyDesignMover]] allows more control. The default setting is to design all CDRs.  Any antibody design options discussed in the antibody design documentation but not set through the XML (as outlined in this document) can be set through the Command line.


```xml
<AntibodyDesignProtocol design_cdrs="(&string (ex: L1,L1,L3))" instructions_file="(&real)" />
```

###Recommended Settings

-   design_cdrs (&string) (Default=All CDRs): Set the CDRs you wish to design.  This will both GraftDesign and SeqDesign the CDRs.  This can also be set in the CDR instruction file. Setting it in this option overrides the instruction file.

-   instruction_file (&string): Path to the CDR instruction file.  The default settings will probably not apply to your specific antibody design file.  Make sure to read about the syntax of this file in the application documentation and set one up accordingly.  The current defaults can be found in the rosetta database: database/sampling/antibodies/design/default_instructions.txt.


###Optional

-   remove_antigen (&bool) (Default=false): Remove the antigen before design.  Used for stability improvement of the antibody or library generation and computational benchmarking.
-   run_snugdock (&bool) (Default=false): Run snugdock on the top antibody after design.
-   run_relax (&bool) (Default=false): Run FastRelax on the top antibody after design.

##See Also

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]
* [[Main AntibodyDesign Mover | AntibodyDesignMover]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[AntibodyDesignMover]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide to choosing a mover
