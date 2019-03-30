# AntibodyDesignMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AntibodyDesignMover

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

###Purpose

Runs the full Rosetta Antibody Design (RAbD) mover.  Requires an AHo numbered antibody. Note that only the top design will move on in RosettaScripts.  See the [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign ]] for more information.  Note that the [[AntibodyDesignProtocol]] runs the `AntibodyDesignMover`, but has a simpler interface.  Any antibody design options discussed in the antibody design documentation but not set through the XML (as outlined in this document) can be set through the Command line.

##Basic Options

### Sequence Design

Generally, one would want to do a simple run that optimizes the interface energy and uses cluster-based profiles for sequence design:

```xml
<AntibodyDesignMover seq_design_cdrs="(&string (ex: L1,L1,L3))" mc_optimize_dG="1"/>
```

### Graft Design

If you want to explore different loop conformations of different CDRs, you can use the `graft_design_cdrs` option to graft these on from the database and refine.  You may use any combination of sequence and graft design CDRs.  There are many more options, like being able to limit the length, or staying within the current cluster.  In order to control these, you would pass a `cdr_instruction_file`.  See the full RAbD manual for more: [[RosettaAntibodyDesign#antibody-design-cdr-instruction-file]]

```xml
<AntibodyDesignMover graft_design_cdrs="(&string (ex: L1,L1,L3))" seq_design_cdrs="(&string (ex: L1,L1,L3))" mc_optimize_dG="1"/>
```

##Full Options



[[include:mover_AntibodyDesignMover_type]]

##See Also

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[AntibodyDesignProtocol]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide to choosing a mover