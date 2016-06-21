##  `ResidueTypeSet` – what it is
`core::chemical::ResidueTypeSet` is responsible for iterating through the sets of residue types, including, but not limited to, amino
acids, nucleic acids, peptoid residues, and monosaccharides.  It first reads through a file that contains the
location of residue types in the database.  At the beginning of that file are the atom types, mm atom types,
element sets, and orbital types that will be used.  The sets are all for fa_standard.  If a new type of atom are
added for residues, this is where they would be added.  Once it assigns the types, it then reads in extra residue
params that are passed through the command line.  Finally, patches are applied to all residues added.

## What you need to know as a developer
The class is being updated in 2015-2016, as described below. 
+ All prior Rosetta code with tests continues to be supported.
+ In new code, avoid use of functions like `aa_map_DO_NOT_USE`. By asking for everything with an AA (or name3) of the query type, these functions (now tagged with *DO_NOT_USE*)  require instantiation of an exponentially large number of residue_types. We are trying to remove all of these in the code, at which point we can delete these functions.
+ Instead, if you need a residue type, you can almost certainly get it with a function like `get_representative_type_with_variant_aa` and `get_all_types_with_variants_aa`, where you supply the AA (e.g., aa_ala) and a list of variants that you want.
+ If you know the exact name of your `ResidueType` (e.g., "ALA:NtermProteinFull"), just use `name_map`.
+ Adding new `ResidueType`s generated at runtime (as opposed to during readin of the residue_types.txt in the database) can get tricky. Talk to, uh, Rocco about that. 

## Recent updates – the `ResidueTypeSet` project.
### Problem with original implementation
With the original `ResidueTypeSet`, it was difficult to automatically read in & model interesting PDBs with ligands, modified RNA types, proteins with some atoms virtualized, etc. without having to explicitly specify patches or new residue types. For example, cryoEM-based high-accuracy structures of ribosomes could be read in due to the resolving of nucleotide modifications.

In principle, much of this chemical diversity could be saved in Rosetta's database and be instantiated in of its known universe upon startup. But the original `ResidueTypeSet` system had a memory footprint and setup time that grows exponentially with the number of patches. This led to quite a few ugly (and imperfect) hacks in my lab where certain patches are only loaded in certain modes, etc., and a reluctance to introduce new `ResidueType`s (which each get a large number of possible patch combinations). There are also .slim inventories of 'minimal' residue_types to prevent bloat on some low-memory systems like BlueGene.

This [pull request](https://github.com/RosettaCommons/main/pull/591) refactored the `ResidueTypeSet` system to load up residue_types and patches and only instantiate patched residue types as they are needed ('on the fly').

+ Only full instantiate `ResidueType`s when they are explicitly requested; otherwise store them as compact placeholders.
+ New tools to instantiate residue_types based on aa, name3, and lists of desired properties/variants (which greatly reduce the number of instantations). Verified to give a big performance increase in, e.g., `extract_pdbs` (silent file extraction).
+ New class [[ ResidueTypeFinder ]] to recognize PDB residues based on atom names without having a list of all patched residues, based on a customized binary search through Patches. Verified to give a big performance increase in PDB read in.

Some more information available in [these slides](https://dl.dropboxusercontent.com/u/21569020/Das_preRosettaCon2015_ResidueTypeSet.pdf).

 Subsequent pull requests are accomplishing the following tasks:
+ No more -override_rsd_type_limit warning. [Link](https://github.com/RosettaCommons/main/pull/725)
+ NCAA's are getting turned on as residue types, by default. [Link](https://github.com/RosettaCommons/main/pull/722)
+ Remove RNA residue type sets in favor of fa_standard, which encapsulates the RNA residue types and now does not incur a penalty in load time. [Link](https://github.com/RosettaCommons/main/pull/745)
+ Removing command-line patch selectors which kept patches off by default; now they can be turned on. [Link](https://github.com/RosettaCommons/main/pull/756)

### Some notes on internal implementation of updated `ResidueTypeSet`
+ Basics: We retain the class's `name_` and the standard information that applies to all ResidueTypes: 	`AtomTypeSetCOP atom_types_`, `ElementSetCOP elements_`, `MMAtomTypeSetCOP mm_atom_types_`, `orbitals::OrbitalTypeSetCOP orbital_types_`.
+ We retain a list of all `ResidueType`s in `ResidueTypeCOPs residue_types_`. But... each of these `ResidueType`s starts out as a 'placeholder' object with just `name`, `name3`, and `variants`. The rest of the object (atom names, atom graph, etc.) are instantiated when needed. The way to tell if a `ResidueType` is a placeholder or instantiated is through the `finalized()` function. (It should actually be possible/easy to deprecate this or make it a mutable cache of instantiated ResidueTypes, and we may want do so in the future, as it grows exponentially with number of patches.)
+ We still have `aa_map_`, `interchangeability_group_map_`, `name3_map_`, `aas_defined_`; but we should remove these when we get rid of all calls to *DO_NOT_USE* functions throughout the code!
+ To support rapid discovery of `ResidueType`s by the [[ ResidueTypeFinder ]], we now store lists of all the `base_residue_types_` (ResidueTypes without any pathces) and the `patches_`.
+ There is a boolean `on_the_fly` for whether or not the new placeholder/instantiation scheme is being used in this ResidueTypeSet. It is `true`  by default, unless you are using DNA adducts which are not yet supported (but could be; see below).

### To do
There are still some things to do (*Devs please add to this wishlist, and remove when done.*):
+ Turn on more and more reasonable residue_types and patches by default, including non-standard nucleotides, all posttranslational modifications of amino acids, the full repertoire of small molecules in the PDB.
+ The current implementation is not thread-safe, but its possible to return to a thread-safe version (with -chemical:on_the_fly false). Threads should be fairly easy to support through mutexes -- a lock needs to be set in the function `replace_residue_type_in_set_defying_constness`, and obeyed inside `make_sure_instantiated`.
+ There are currently 'placeholder' residue_types created with some basic info like name, name3, etc.; should be possible to not even create these and save more time and memory.
+ Sets of `Orbitals` could be applied through a `Patch`. See `ResidueTypeSet.cc` for some comments on how to do this.
+ DNA Water`Adduct`s could be applied as Patches. See `ResidueTypeSet.cc` for some comments on how to do this.
+ Check memory footprint is actually reduced (run `-chemical:on_the_fly false` to compare).
+ _Maybe_ unify the new [[ResidueTypeFinder]] class with classic `ResidueTypeSelector`.
+ Should be possible to further accelerate [[ResidueTypeFinder]] as it goes down a binary tree to apply patches to find residue_types -- this would require caching a map of which patches apply to which residue_types perhaps in ResidueTypeSet; this is currently done implicitly in name_map().
+ Even with above acceleration, `base_residue_types` are all instantiated. May want to be smarter about this.
       in the future may want to have 100,000 ligands in Rosetta, which could be kept as bare-bones
       'placeholder' `ResidueType`s with just `name3`. These would be instantiated only when recognized
       in say a PDB file or requested explicitly by `name3`.
+ Rocco and rhiju reintroduced `ResidueType::variant_types()` and it comes out as a list of `std::string`s, instead of a `VariantType` enum. (Rocco was working before @JWLabonte refactor). will be easy to restore. Should happen after @JWLabonte finishes [pull request #56](https://github.com/RosettaCommons/main/pull/56)