#HBNet
*Back to [[Mover|Movers-RosettaScripts]] page.*
##HBNet

HBNet is a method to explicitly detect and design hydrogen bond networks within Rosetta.  It functions as a mover within the RosettaScripts framework and will exhaustively search for all networks within the design space that you define with [[TaskOperations|TaskOperations-RosettaScripts]], and that meet the criteria you specify with the options below

*[[how buried unsatisfied polar atoms are handled by HBNet|HBNet-BUnsats]].*<br>
*[[how to design hydrogen bond networks into helical bundles|HBNet-HelicalBundle]].*<br>
*[[how HBNet works|HBNet-HowItWorks]].*<br>
*[[how the code works and hooking into it HBNet|HBNet-Code]].*<br>
*[[how HBNet handles symmetric cases|HBNet-Symmetry]].*<br>

In general, HBNet should work with any existing XML by places it in the beginning of your design steps.  Because HBNet returns multiple poses (each with different networks or combinations of networks), everything downstream of HBNet must use the [[MultiplePoseMover]].  Here is a template XML:
```
<ROSETTASCRIPTS>
   <SCOREFXNS>
        PASTE YOUR SCFXN HERE AND THEN PASS IT TO HBNET
   </SCOREFXNS>
   <TASKOPERATIONS>
        PASTE YOUR TASK_OPERATIONS HERE AND THEN PASS THEM TO HBNET
   </TASKOPERATIONS>
   <FILTERS>
   </FILTERS>
   <MOVERS>
      <HBNet name=hbnet_mover scorefxn=[YOUR_SCORE_FUNCTION] hb_threshold=-0.5 min_network_size=3 max_unsat=1 write_network_pdbs=1 task_operations=[YOUR_TASK_OPS,HERE] />
      <MultiplePoseMover name=MPM_design max_input_poses=100>
         <ROSETTASCRIPTS>
                PASTE YOUR ENTIRE CURRENT XML HERE
         </ROSETTASCRIPTS>
       </MultiplePoseMover>
<PROTOCOLS>
  <Add mover_name=hbnet_mover/>
  <Add mover_name=MPM_design/>
</PROTOCOLS>
</ROSETTASCRIPTS>
```

##Options universal to all HBNet movers
- <b>hb\_threshold</b> (-0.5 &Real): 2-body h-bond energy cutoff to define rotamer pairs that h-bond.  I've found that -0.5 without ex1-ex2 is the best starting point.  If using ex1-ex2, try -0.75.  This parameter is the most important and requires some tuning; the tradeoff is that the more stringent (more negative), the faster it runs but you miss a lot of networks; too positive and it will run forever; using ex1-ex2 results in many redundant networks that end up being filtered out anyway.
- <b>scorefxn</b>: The scoring function to use.  If not passed, default is talaris, or if -beta flag is on, default is beta wts.
- <b>max\_unsats</b> (1 &Size): maximum number of buried unsatisfied polar atoms allowed

###New options for detecting native networks, and keeping and extending existing networks of input pose

- <b>find\_only\_native_networks (bool &false):<b>  HBnet will find only find native networks in your input pose that meet your criteria (specified by options) and return a single pose with csts for those networks.  If this option is true, all options below are overridden and HBNet does not search for new networks
- <b>find\_native\_networks (bool &false):<b>  Will find and report native networks in input pose but will also do design; for keep_existing_networks=true or extend_existing_networks=true, in addition to starting from “HBNet” PDBInfoLabel tags, HBnet will find all native networks in your input pose that meet your criteria (specified by options).
- <b>keep\_existing\_networks (bool &false):<b>  In addition to design, Keeps existing networks from the input pose for each pose returned by HBNet, and turn on csts for all; existing networks are identified by default by “HBNet” PDBInfoLabel tags in the input pose, but can also be detected anew by setting find_native_networks=1.   <b>If keep_existing_networks=true and extend_existing_networks=false,<b> then HBNet internally turns off design at input network positions (prevent_repacking); new networks are searched for and designed at the other positions based on your task_ops.  <b>If keep_existing_networks=true and extend_existing_networks=true,<b> then HBNet internally puts only the input rotamer of each network residue into the IG to try to extend; an extended network will replace its native network if it is better (otherwise native networks retained).
- <b>extend\_existing\_residues (bool &false):<b>  Detects existing networks and tries to extend them, and also will search for new networks at other positions based on your criteria.  Existing networks identified by “HBNet” PDBInfoLabel tags in the input pose, but can also be detected anew by setting find_native_networks=1.  For existing networks, HBNet internally puts only the input rotamer of each network residue into the IG to try to extend; an extended network will replace its native network if it is better (otherwise native networks retained).
- <b>only\_extend\_existing (bool &false):<b>  Will not look for new networks at other positions; will only try to extend and improve the existing networks.

## Specific cases
HBNet is a base classes that can be derived from to override key functions that do the setup, design and processing of the networks differently:

###HBNetStapleInterface
This 

```
<HBNetStapleInterface name=(&string) hb_threshold=(&real -0.85) stringent_satisfaction=(&bool true) />
```

UNDER CONSTRUCTION

###HBNetLigand

###HBNetCore

UNDER CONSTRUCTION

##See Also

* [[PerturbBundleMover]]
* [[BundleGridSampler]]

