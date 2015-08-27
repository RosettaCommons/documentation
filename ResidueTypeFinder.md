## What `ResidueTypeFinder` is
Intended to be a super-efficient way to get ResidueType's from a ResidueTypeSet, without
having to instantiate *everything* in the ResidueTypeSet, which can take an exponentially
long time if there are a lot of patches.

## What it does
+ `get_all_residue_types()`does a binary tree search adding patches, one-by-one. This sounds tedious, but at most branches in the tree ('try patch or not?') we typically have enough information to shut down traversal of a branch. for example if we are looking for a list of atom_names that we saw in a residue from a PDB file, if the Patch deletes one of those atoms, its probably not worth trying. And if it adds a desired atom, we should try it. Usually returns a small list. 
+ for `get_all_residue_types()` or `get_best_match_residue_type_for_atom_names()`, best to use
     as many constraints as possible that are specific to the desired residue type(s).
+ for `get_representative_type()`, best to use as few desired constraints as possible. This function's job is to traverse down the tree until it finds one `ResidueType` with the desired variants, name, etc.

## To do
+ probably should refactor all the checks/filters into functionalities for
     `chemical::ResidueTypeSelector`.  Something like:
             `bool ResidueTypeSelector::check_patch_worth_trying( Patch, ResidueType )`
+ Currently, `ResidueTypeFinder` punts to old finding routine (residue_types_DO_NOT_USE) when you are asking for a custom_variant (this happens in enzdes code). This takes time that is exponentially long in the number of patches. If we thought about this a little harder, we could probably handle this use case more gracefully -- perhaps by defining custom_variants as 'metapatches'.