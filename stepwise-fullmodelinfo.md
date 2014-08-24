#FullModelInfo
`FullModelInfo` is an object cached inside the pose, and is necessary to keep track of all information related to how a pose 'fits in' to global stepwise modeling problem.

Code for `FullModelInfo` is in `src/core/pose/full_model_info/FullModelInfo.cc`.

# How to use
-------------
FullModelInfo needs to be set up to do operations like adding & deleting. It contains info on everything in the full modeling problem. Example (sorry this hasn't been tested): 

```

// imagine pose has four residues with PDBInfo numbering a22,a23,u27,u28
pose::full_model_info::make_sure_full_model_info_is_setup( pose );  // will infer as much as possible from PDBInfo

std::cout << const_full_model_info( pose ).full_sequence() << std::endl;  // aannnuu  (note fill-in with n's)
std::cout << const_full_model_info( pose ).res_list() << std::endl; // [1, 2, 5, 6] 
std::cout << const_full_model_info( pose ).conventional_numbering() << std::endl; // [22, 23, 27, 28]
std::cout << const_full_model_info( pose ).other_pose_list() << std::endl; // [] (empty)

```

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

### full_model_parameters_, a FullModelParameters object 
----------------------------------------------------------
-This stores all information  related to the eventual full-length model. These include:

• full_sequence
• 'conventional' numbering/chain scheme,
•  cutpoint_open_in_full_model,  

See FullModelParameterType for full list of variables.

-Note that there are is no information here on what subset of
 residues a specific pose contains (thats in res_list).

-The variables in here really should be 'permanent' -- parameters that won't
  change during a run.

- Note that integer lists are stored in two ways, for convenience:
  parameter_values_at_res
   [ 0, 0, 1, 1, 0, 0, 2, 2 ] (has same size as full_sequence)

  parameter_values_as_res_lists -- same info as above, different format.
    { 0:[1, 2, 5, 6],  1:[3, 4], 2:[7, 8] }
