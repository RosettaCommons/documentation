# RemodelMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RemodelMover (including building disulfides)

Remodel and rebuild a protein chain

IMPORTANT NOTE!!!!: Remodel uses an internal system of trajectories controlled by the option -num\_trajectory [integer, \>= 1]. If num\_trajectory \> 1 each result is scored with score12 and the pose with lowest energy is handed to the next mover or filter. -num\_trajectory 1 is recommended for rosetta\_scripts.

```xml
  <RemodelMover name="(&string)" blueprint="(&string)"/>      
```

-   blueprint: blueprint file name
-   other tags coming, use flags for now as described on the [[Remodel page|Remodel]]

For building multiple disulfides simultaneously using RemodelMover, use the following syntax-

```xml
<RemodelMover name="(&string)" build_disulf="True" match_rt_limit="(1.0 &Real)" quick_and_dirty="(0 &Bool)" bypass_fragments="(0 &Bool)" min_disulfides="(1 &Real)" max_disulfides="(1 &Real)" min_loop="(1 &Real)" fast_disulf="(0 &Bool)" keep_current_disulfides="(0 &Bool)" include_current_disulfides="(0 &Bool)"/>
```

-   `      build_disulf     ` : indicates that disulfides should be built into the structure
-   `      use_match_rt    ` : Handles disulfide searching by computing the rotation-translation (RT) matrix between all pairs of residue backbones, and comparing these RT matrices to a database of known disulfides.  Euclidian distance is used to determine the similarity between the query RT matrix and each disulfide in the database.  The cutoff for similarity between the RT matrix and a known disulfide is match_rt_limit (below).  Default true.
-   `      match_rt_limit     ` : Upper threshold for determining if two residues can form a disulfide based on the RT matrix between their backbone atoms.  1.0 is strict, 2.0 is loose, 6.0 is very loose, \>6 makes no difference.  Default 1.0.
-   `      use_disulf_fa_score    ` : Handles disulfide searching by actually building disulfide bonds between all pairs of residues within a distance cutoff, minimizing these, scoring the disulfides using the default full-atom disulfide potential (dslf_fa13), and then applying an upper threshold.  Some backbone flexibility may be allowed in the minimization.  Default false.
-   `      disulf_fa_max     ` : Upper threshold for determining if two residues can form a disulfide based on actually building and minimizing a disulfide there.  Default -0.25.
-   `      relax_bb_for_disulf     ` : Allow backbone minimization during disulfide building using use_disulf_fa_score.  This backbone relaxation is done on a poly-alanine backbone and thus the backbone may be more flexible than is actually feasible for a given structure, resulting in accepting disulfides that will be strained on the actual structure.  Allowing backbone minimization should increase the overall number of possible disulfide bonds found.  Default false.
-   `      quick_and_dirty     ` : Bypass the refinement step within remodel; useful to save time if performing refinement elsewehere
-   `      bypass_fragments     ` : Bypasses rebuilding the structure from fragments
-   `      min_disulfides     ` : Specifies the minimum number of disulfides required in the output structure. If min\_disulfides is greater than the number of potential disulfides that pass match\_rt\_limit, the protocol will fail. **This is only read/applied if build\_disulf or fast\_disulf are set to true.**
-   `      min_disulfides     ` : Specifies the maximum number of disulfides allowed in the output structure.
-   `      min_loop     ` : Specifies the minimum number of residues between the two cysteines to be disulfide bonded; used to avoid disulfides that link pieces of chain that are already close in primary structure.
-   `      fast_disulf     ` : Sets the build\_disulf, quick\_and\_dirty, and bypass\_fragment flags to true. Also bypasses any design during remodel, including building the disulfide itself! This means that the remodel mover must be followed by a design mover such as FastDesign. This is my recommended method for building multiple disulfides into a *de novo* scaffold.
-   `      keep_current_disulfides     ` : Will prevent Remodel from using a residue that is already part of a disulfide to form a new disulfide
-   `      include_current_disulfides     ` : Forces Remodel to include the existing disulfides on the list of potential disulfides (not much purpose except for debugging).


Note that no blueprint is required when fast\_disulf or build\_disulf; if no blueprint is provided, all residues will be considered as potential cysteine locations.

If multiple disulfides are being built simultaneously and the structure can accommodate multiple disulfide configurations (combinations of disulfide bonds), then the best ranking configuration according to DisulfideEntropyFilter is outputted. If the exact same input structure is provided to RemodelMover a second time (because it is part of a loop in rosetta\_scripts, for example), the second ranking configuration will be outputted the second time, and so forth. Using this method, multiple disulfide configurations on the same structure can be fed into downstream RosettaScripts movers and filters, and then looped over until an optimal one is found.

##See Also

* [[BluePrintBDRMover]]
* [[SetSecStructEnergiesMover]]
* [[I want to do x]]: Guide to choosing a mover
* [[DisulfideMover]]
* [[ForceDisulfidesMover]]
* [[DisulfidizeMover]]
