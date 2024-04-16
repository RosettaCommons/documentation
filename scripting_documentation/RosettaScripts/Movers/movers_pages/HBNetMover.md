#HBNet
*Back to [[Mover|Movers-RosettaScripts]] page.*
_Note:  This documentation is for the HBNet mover.  For information on the `hbnet` design-centric score term, an alternative method for creating hydrogen bond networks, see [[this page|HBNetEnergy]]._

##HBNet
HBNet is a method to explicitly detect and design hydrogen bond networks within Rosetta.  It functions as a mover within the RosettaScripts framework and will exhaustively search for all networks within the design space that you define with [[TaskOperations|TaskOperations-RosettaScripts]], and that meet the criteria you specify with the options below

###UPDATE 12/2017:
The new Monte Carlo sampling approach (MC HBNet) is now in master and it is highly recommended (likely become the default soon); to use it, simply add ```monte_carlo="true"``` to the existing HBNet or HBNetStapleInterface movers.  The new MC search procedure is much faster, enables consistent runtimes and memory usage, and consistently yields a larger number of high-quality networks in a much shorter runtime.  To control the number of MC trials, set ```total_num_mc_runs="10000"```; making this value smaller will result in shorter runtimes, making it bigger will result in longer runtimes (and often more solutions).  Other MC HBNet options are listed below. Setup, network evaluation/ranking, and output are still handled the same as in HBNet.

*[[how buried unsatisfied polar atoms are handled by HBNet|HBNet-BUnsats]].*<br>
*[[how to design hydrogen bond networks into helical bundles|HBNet-HelicalBundle]].*<br>
*[[how HBNet works|HBNet-HowItWorks]].*<br>
*[[how HBNet handles symmetric cases|HBNet-Symmetry]].*<br>

In general, HBNet should work with any existing XML by placing it in the beginning of your design steps.  Because HBNet returns multiple poses (each with different networks or combinations of networks), everything downstream of HBNet must use the [[MultiplePoseMover]].  

####Quickstart: what you absolutely must have in your XML to effectively use HBNet:

1. Call either the ```HBNet``` or ```HBNetStapleInterface``` mover in your PROTOCOLS block before your main design steps
2. Call ```MultiplePoseMover``` (MPM) immediately after HBNet; then inside the MPM, paste your normal design XML; this will design your pose as you normally would, but with the networks already there and fixed in place.
3. For all of your design movers in MPM, be sure to pass the following task operation (see Template XML below) to ensure networks aren't designed away: HBNet automatically applies csts to ensure the h-bonds stay in place, but if you change the AA type with taskops, the csts can no longer be properly applied.  On this same note, be sure to **only use ```_cst``` scorefxns for design steps post-HBNet; for example ```beta_cst``` rather than beta.**

####Template XML:
```xml
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
      <HBNet name="hbnet_mover" scorefxn=[YOUR_SCORE_FUNCTION] hb_threshold="-0.5" min_network_size="3" max_unsat_Hpol="1" write_network_pdbs="1" monte_carlo="false" task_operations=[YOUR_TASK_OPS_HERE] />
      <MultiplePoseMover name="MPM_design" max_input_poses="100">
         <ROSETTASCRIPTS>
                PASTE YOUR ENTIRE CURRENT DESIGN XML HERE
                # only use _cst scorefxn during design to make sure the constraints automatically turned on by HBNet are respected
                # residue selector and taskop to ensure network residues aren't designed away
                # residue selector will automatically detect all HBNet residues
                <ResiduePDBInfoHasLabel name="hbnet_residues" property="HBNet" />
                <OperateOnResidueSubset name="hbnet_task" selector="hbnet_residues">
                    <RestrictToRepackingRLT/> # can also use PreventRepackingRLT here, but I find that repack only works best, because it allows some wiggle room, and the csts applied automatically by h-bond keep the h-bonds in place
                </OperateOnResidueSubset>
         </ROSETTASCRIPTS>
       </MultiplePoseMover>
<PROTOCOLS>
  <Add mover_name="hbnet_mover"/>
  <Add mover_name="MPM_design"/>
</PROTOCOLS>
</ROSETTASCRIPTS>
```

###Specific cases and usage examples: 
HBNet is a base classes that can be derived from to override key functions that do the setup, design and processing of the networks differently:

####HBNetStapleInterface: for designing protein-protein interfaces:
Expects a pose with >= 2 chains and will by default start the network search at all interface residues, attempting to find h-bond networks that span across the interface.

```xml
# symmetric
<HBNetStapleInterface scorefxn="hard_symm" name="hbnet_interf" hb_threshold="-0.5"design_residues="NSTQHYW" write_network_pdbs="true" min_networks_per_pose="1" max_networks_per_pose="4" use_aa_dependent_weights="true" min_core_res="2" min_network_size="3" max_unsat_Hpol="3" onebody_hb_threshold="-0.3" task_operations="arochi,init_layers,current" />

# asymmetric
<HBNetStapleInterface scorefxn="hard" name="hbnet_interf" hb_threshold="-0.5"design_residues="NSTQHYW" write_network_pdbs="true" min_intermolecular_hbonds="3" min_networks_per_pose="1" max_networks_per_pose="4" use_aa_dependent_weights="true" min_core_res="2" min_network_size="3" max_unsat_Hpol="3" task_operations="arochi,init_layers,current" />
``` 

**Useful options:**
* For helical bundles, ```min_helices_contacted_by_network="4"``` would require that 4 different helices each contribute at least 1 rotamer to each h-bond network for it to pass
* Combining multiple networks in same output PDB: ```min_networks_per_pose="2"``` with ```max_networks_per_pose="4"``` will try outputting combinations of between 2 to 4 compatible networks at once when returning output poses.

**There used to be HBNetLigand and HBNetCore movers, but both of these design cases are better accomplished now by using the regular HBNet mover with the right options (see below):**

#### Designing networks into the core of a monomer:
The default is that it will start searching at all positions in the monomeric Pose, which is often note ideal: if possible specify ```start_selector``` to start at positions you want to potentially be part of the networks, and define your design space carefully with ```task_operations```.
```xml
<HBNet scorefxn="beta" monte_carlo_branch="true" total_num_mc_runs="100000" core_selector="core" name="hbnet" hb_threshold="-0.5" min_core_res="2" minimize="false" min_network_size="5" max_unsat_Hpol="2" start_selector="[YOUR_SELECTOR]" task_operations="[YOUR TASKOPS" />
```

#### Designing networks around a polar small molecule ligand
If your goal is to design a network that satisfies a polar small molecule, use ```start_selector``` to start at the ligand (and any first shell contacts you might want to keep).  One challenge that arose in these design cases is that HBNet only searches for networks among packable/designable positions, but often users want to keep the ligand and some first-shell contacts fixed (NATRO or PreventRepacking).  To solve this issue, we added the option ```use_only_input_rot_for_start_res```, which if true, takes the ```start_selector``` positions, fixes their identity, turns on proton Chi sampling, but otherwise fixes their rotamer.  This allows for more h-bonding possibilities by sampling multiple Hpol positions.  (Option added together with Benjamin Basanta; commutativity logic reworked by Vikram K. Mulligan.)
**NOTE:** ```use_only_input_rot_for_start_res``` only works if set to true and if the start selector is set to be packable. If using an abnormal starting rotamer, [[IncludeCurrent|IncludeCurrentOperation]] is recommended to ensure that this flag will not cause your start vector to be empty.

```xml
<HBNet name="hbnet_ligand" scorefxn="standardfxn" hb_threshold="-0.5" start_selector="ligand" design_residues="STNQYW" write_cst_files="False" write_network_pdbs="False" store_subnetworks="False" minimize="False" min_network_size="3" max_unsat_Hpol="0" task_operations="no_design_or_pack,limitAroChi,includeCurrent" use_only_input_rot_for_start_res="True"/>
```

###FAQ
**Why do my output poses all have clashes?**  HBNet will return networks iteratively by placing them onto your input Pose; because each network doesn't constitute the entire design space (packable/design residues) it is common and expected to see clashes between network residues and untouched input residues if you output directly after HBNet; **the assumption is that any residues that are packable/designable during HBNet will also be packable/designable during downstream design**, which will be performed after HBNet. If this is not desired, you have 2 options:

1. Make all packable/designable positions (except PRO/GLY/Disulfide) poly-ALA and place the network onto that Pose for output: ```output_poly_ala_background="true"```
2. You can output these poly-ALA background poses in addition to standard output with  ```write_network_pdbs="true"```; useful for debugging and inspection (or to check if your network changed during downstream design).

**Why is HBNet so slow?** The best way to handle this is to now use MC HBNet by passing ```monte_carlo="true"```, but in all cases, especially original HBNet, the runtime will scale with the size of your design space and how many networks are found (which is kind of a catch-22, because you likely want to find a lot of networks).  There are several ways to make HBNet much faster (and often get better results too):

1. Make ```hb_threshold``` more stringent (more negative).  With MC-HBNet you can safely set it to -0.5; with original HBNet, use -0.5 unless using ex1ex2, in which case start at -0.75
2. Be more specific with your ```task_operations```; the more you can restrict your design space, and especially high-entropy sidechains (Lys/Arg), the better.
3. Use ```start_selector``` to only start searching at a small number of positions of interest.
4. Make use of the options to only allow the properties you desire, e.g. ```min_network_size="5"```

###Options universal to all HBNet movers
- <b>hb\_threshold</b> (-0.5 &Real): 2-body h-bond energy cutoff to define rotamer pairs that h-bond.  I've found that -0.5 without ex1-ex2 is the best starting point.  If using ex1-ex2, try -0.75.  This parameter is the most important and requires some tuning; the tradeoff is that the more stringent (more negative), the faster it runs but you miss a lot of networks; too positive and it will run forever; using ex1-ex2 results in many redundant networks that end up being filtered out anyway.
- <b>scorefxn</b>: The scoring function to use.  If not passed, default is whatever current Rosetta default scorefxn is.
- <b>max\_unsat\_Hpol</b> (1 &Size): maximum number of buried unsatisfied polar hydrogen (Hpol) atoms allowed in each network: *[[the way I treat buried unsats|HBNet-BUnsats]].*  If there are heavy atom donors or acceptors that are buried and unsatisfied, those networks are thrown out.  This behavior can be overridden to allow heavy atom unsats by setting <b>no_heavy_unsats_allowed=false</b>, but this is not recommended
- <b>write_network_pdbs</b>: writes out pdb files of only the network (in poly-Ala background where any designable/packable residue is Ala -- rest of pose untouched); this is simply for debugging and visualizing the network as detected by HBNet
- <b>write_cst_files</b>: writes out Rosetta .cst constraint files for each network.
- <b>min_network_size</b>: minimum number of residues required for each network.  *Note: in symmetric cases, this refers to the number of residues in the ASU!*
- <b>max_network_size</b>: maximum number of residues required for each network.
- <b>start_resnums</b>: comma delimited list of residue positions to start network search from (e.g. "1,2,3,5"); now is better to use <b>start_selector</b> residue selector.
- <b>start_selector</b>: residue selector that tells HBNet which residues to start from (will only search for networks that include these residues).
- <b>core_selector</b>: residue selector that defines what HBNet considers "core"; used in buriedness determination for unsats; default is layer selector default using sidechain neighbors(core=5.2).
- <b>min_core_res</b>: minimum core residues each network must have (as defined by core selector).
- <b>design_residues (string &"STRKHYWNQDE"</b>: string of one-letter AA codes; which polar residues types do you want to include in the search; the default is all AA's that can potentially make h-bonds, further restricted by the <b>task_operations</b> you pass.
- <b>task_operations</b>: comma-delimited list of task operations you have previously defined in your XML; HBNet will respect any task operation passed to it, and only search for networks within the design space you define by these taskops; the more that you can restrict your design space to only what you want, the faster HBNet will run.
- <b>store_network_scores_in_pose</b>: Boolean. If true, adds "HBNet_NumUnsatHpol",
"HBNet_Saturation", and "HBNet_Score" to pose as an extra score. These scores will be
printed in the score.sc file and can be accessed using the
[[ReadPoseExtraScoreFilter|ReadPoseExtraScoreFilter]].

###Options for MC HBNet
- <b>monte\_carlo</b> (bool,"false"):
  Step right up and try your luck with this stochastic HBNet protocol!
  This protocol boasts faster runtimes (especially for large systems) and more consistent memory usage.
  Equivalent to `monte_carlo_branch`.
- <b>total\_num\_mc\_runs</b> (uint,"10000"):
  number of monte carlo runs to be divided over all the seed hbonds.
- <b>monte\_carlo\_seed\_must\_be\_buried</b> (bool,"false"):
  only branch from hbonds where at least one residue is buried.
  Effectively, this results in only finding networks that have at least one buried residue.
- <b>monte\_carlo\_seed\_must\_be\_fully\_buried</b> (bool,"false"):
  only branch from hbonds where both residues are buried.
  This results in only finding networks that have at least one buried hbond but this does not prevent having additional exposed hbonds.
- <b>seed\_hbond\_threshold</b> (real,"0"):
  Maybe you only want to branch from strong hbonds.
  If this value is -1.2, for example, then only hbonds with a strength of -1.2 or lower will be branched from.

####New options for detecting native networks, and keeping and extending existing networks of input pose

- <b>find\_only\_native_networks (bool &false):</b>  HBnet will find only find native networks in your input pose that meet your criteria (specified by options) and return a single pose with csts for those networks.  If this option is true, all options below are overridden and HBNet does not search for new networks
- <b>find\_native\_networks (bool &false):</b>  Will find and report native networks in input pose but will also do design; for keep_existing_networks=true or extend_existing_networks=true, in addition to starting from “HBNet” PDBInfoLabel tags, HBnet will find all native networks in your input pose that meet your criteria (specified by options).
- <b>keep\_existing\_networks (bool &false):</b>  In addition to design, Keeps existing networks from the input pose for each pose returned by HBNet, and turn on csts for all; existing networks are identified by default by “HBNet” PDBInfoLabel tags in the input pose, but can also be detected anew by setting find_native_networks=1.   <b>If keep_existing_networks=true and extend_existing_networks=false,</b> then HBNet internally turns off design at input network positions (prevent_repacking); new networks are searched for and designed at the other positions based on your task_ops.  <b>If keep_existing_networks=true and extend_existing_networks=true,</b> then HBNet internally puts only the input rotamer of each network residue into the IG to try to extend; an extended network will replace its native network if it is better (otherwise native networks retained).
- <b>extend\_existing\_networks (bool &false):</b>  Detects existing networks and tries to extend them, and also will search for new networks at other positions based on your criteria.  Existing networks identified by “HBNet” PDBInfoLabel tags in the input pose, but can also be detected anew by setting find_native_networks=1.  For existing networks, HBNet internally puts only the input rotamer of each network residue into the IG to try to extend; an extended network will replace its native network if it is better (otherwise native networks retained).
- <b>only\_extend\_existing (bool &false):</b>  Will not look for new networks at other positions; will only try to extend and improve the existing networks.

####Experimental options - use at your own risk!
- <b>secondary_search</b> (bool &false): if during IG traversal, a search trajectory terminates in rotamer than cannot make any h-bonds, search again from that rotamer using a lower hb_threshold (-0.25).

###General guidelines and advice :
1. If your problem involves interface design, use HBNetStapleInterface, which automatically detects interfaces, starts the search at interface residues, and requires that each network spans an interface (defined as at least 2 different chains must contribute a sidechain to each network); it will still search your entire design space (as defined by your task operations), so the networks have the potential to branch out from the interface as far as you'll let them.  Because we ultimately want satisfied networks, it's important that your taskops allow some additional residues around the interface to be packable/designable, so that second shell h-bonds can fully satisfy the network.  This will be hard if you only set interface residues to be designable.
2. If you have a monomer (e.g. you're trying to internally satisfy a loop), use regular HBNet mover, but be sure to 1) specify start_selector option (residue selector that HBNet will use to initiate the search, ensuring that each network contains at least one starting residue), and 2) specify task operations to focus your design space.  If you don't do these two things, and your pose is >100aa, HBNet may run for weeks...or years...
3. In general, Use the same taskops that you'd normally use for your design case, but just ensure that polar residues are allowed (e.g. in LayerDesign, add the polar aa's you want to consider to the core layer)
4. In general, more restrictive is better -- the more you can guide HBNet with task operations and setting the correct options, the faster it will run, and the more likely it is to give you what you want.
5. Some rules of thumb: start with hb_threshold = "-0.5" and no ex1ex2 in your taskop.  If you must use extra rotamers, start with hb_threshold = "-0.7"; if you are not getting the output that you want, and the runtime is reasonably fast, then make these criteria looser: make hb_threshold more positive (never go past -0.25), include extra rotamers, and make your taskops broader.  If your run is too slow, make these same things more stringent.  It's normal that you have to do some scouting to find the right settings for your design case -- but also keep in mind that many docks or scaffolds simply won't be able to accommodate perfect network -- it's a numbers game: the more you can sample, the more likely you'll find good network.

##See Also

* [[PerturbBundleMover]]
* [[BundleGridSamplerMover]]
* [[Designing with the hbnet score term|HBNetEnergy]]