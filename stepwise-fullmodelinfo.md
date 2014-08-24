#FullModelInfo
`FullModelInfo` is an object cached inside the pose, and is necessary to keep track of all information related to how a pose 'fits in' to global stepwise modeling problem.

Code for `FullModelInfo` is in `src/core/pose/full_model_info/FullModelInfo.cc`.

Several powerful functions for dealing with poses with `full_model_info` objects are available in `stepwise/modeler/util.hh`, including `merge_two_poses_using_full_model_info`, `slice`, `split_pose`, `fix_up_residue_type_variants`, and `figure_out_moving_chain_breaks`.

# How to use
-------------
FullModelInfo needs to be set up to do operations like adding & deleting. It contains info on everything in the full modeling problem. Example (**sorry this hasn't been tested**): 

```

// imagine pose has four residues with PDBInfo numbering a22,a23,u27,u28
pose::full_model_info::make_sure_full_model_info_is_setup( pose );  // will infer as much as possible from PDBInfo

std::cout << const_full_model_info( pose ).full_sequence() << std::endl;  // aannnuu  (note fill-in with n's)
std::cout << const_full_model_info( pose ).res_list() << std::endl; // [1, 2, 5, 6] 
std::cout << const_full_model_info( pose ).conventional_numbering() << std::endl; // [22, 23, 27, 28]
std::cout << const_full_model_info( pose ).other_pose_list() << std::endl; // [] (empty)

```

More detailed examples of how to set up `full_model_info` are available in `src/protocols/stepwise/full_model_info/FullModelInfoSetupFromCommandLine`.

# Note on numbering schemes
---------------------------
There are three kinds of numbering schemes that we need to keep track of in stepwise modeling:

• Rosetta's pose numbering. In the above four residue pose, this would be [1, 2, 3, 4]. This numbering is also called `working` numbering throughout the stepwise code.

• Full-model numbering. This is numbering like 1, 2, ... incrementing with each residue in the **full model**. In the above  problem, these numbers could go from 1 through 6. For the pose of interest, its `res_list` stores numbers in this scheme, [1, 2, 5, 6].

• Conventional numbering (and chains). What you might see in PDB info -- [22, 23, 27, 28] in above case.

# What is in FullModelInfo
---------------------------
There are three things in FullModelInfo:

### res_list
------------
This is a `utility::vector1< Size >` that holds the numbers of each residue in the current pose, in full-model numbering.

### full_model_parameters
----------------------------------------------------------
This is a FullModelParameters object, and it stores all information related to the eventual full-length model. 
These include:

• full_sequence
• 'conventional' numbering/chain scheme,
• cutpoint_open_in_full_model,  
• fixed_domain (any residues that are part of input PDBs and should not move),
etc.  

See FullModelParameterType for full list of variables.

-Note that there are is no information here on what subset of
 residues a specific pose contains (thats in res_list).

-The variables in here really should be 'permanent' -- parameters that won't
  change during a run.

- Note that integer lists are stored in two ways, for convenience:
  parameter_values_at_res
   `[ 0, 0, 1, 1, 0, 0, 2, 2 ] (has same size as full_sequence)`

  parameter_values_as_res_lists -- same info as above, different format.
    `{ 0:[1, 2, 5, 6],  1:[3, 4], 2:[7, 8] }`

### other_pose_list
----------------------------------------------------------
This is a vector of PoseOPs.  

Suppose you're building a big model, and you have one pose for residues 22-28 and another two poses for residues 90-100 and for residues 120-130 built. In the stepwise framework, you'd hold on to the first pose, and it would contain references to the other poses in its `other_pose_list`.  In this example, the other poses would themselves have empty other_pose_lists.  

There are useful helper functions in `stepwise/modeler/util.hh` to `switch_focus_to_other_pose`.

[Originally, there was a scheme in which having each pose held references to immediately neighboring poses to create a 'pose tree', which might have made some loop-closure energies easier to compute, but this was ditched.]

---
Go all the way back to [[StepWise Overview|stepwise-classes-overview]].


