#FullModelInfo
`FullModelInfo` is in `src/core/pose/full_model_info/FullModelInfo.cc`

# How to use
FullModelInfo needs to be set up to do operations like adding & deleting. It contains info on everything in the full modeling problem. Example (sorry this hasn't been tested): 

```
// imagine pose has four residues with PDBInfo numbering a22,a23,u27,u28
pose::full_model_info::make_sure_full_model_info_is_setup( pose );  // will infer as much as possible from PDBInfo
std::cout << const_full_model_info( pose ).full_sequence() << std::endl;  // aannnuu  (note fill-in with n's)
std::cout << const_full_model_info( pose ).res_list() << std::endl; // [1, 2, 5, 6] 
std::cout << const_full_model_info( pose ).conventional_numbering() << std::endl; // [22, 23, 27, 28]
```