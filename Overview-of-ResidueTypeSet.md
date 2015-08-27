## What it is.
This class is responsible for iterating through the sets of residue types, including, but not limited to, amino
acids, nucleic acids, peptoid residues, and monosaccharides.  It first reads through a file that contains the
location of residue types in the database.  At the beginning of that file are the atom types, mm atom types,
element sets, and orbital types that will be used.  The sets are all for fa_standard.  If a new type of atom are
added for residues, this is where they would be added.  Once it assigns the types, it then reads in extra residue
params that are passed through the command line.  Finally, patches are applied to all residues added.

## What you need to know as a developer
The class is being updated in 2015-2016, as described below.. All prior code continues to be supported.
 
## Recent updates – the ResidueTypeSet project.
### Problem with original implementation
With the original ResidueTypeSet, it was difficult to automatically read in & model interesting PDBs with ligands, modified RNA types, proteins with some atoms virtualized, etc. without having to explicitly specify patches or new residue types. For example, cryoEM-based high-accuracy structures of ribosomes could be read in due to the resolving of nucleotide modifications.

In principle, much of this chemical diversity could be saved in Rosetta's database and be instantiated in of its known universe upon startup. But the original ResidueTypeSet system had a memory footprint and setup time that grows exponentially with the number of patches. This led to quite a few ugly (and imperfect) hacks in my lab where certain patches are only loaded in certain modes, etc., and a reluctance to introduce new ResidueTypes (which each get a large number of possible patch combinations). There are also .slim inventories of 'minimal' residue_types to prevent bloat on some low-memory systems like BlueGene.

This [pull request](https://github.com/RosettaCommons/main/pull/591) refactored the ResidueTypeSet system to load up residue_types and patches and only instantiate patched residue types as they are needed ('on the fly').

+ Only full instantiate ResidueTypes when they are explicitly requested; otherwise store them as compact placeholders.
+ New tools to instantiate residue_types based on aa, name3, and lists of desired properties/variants (which greatly reduce the number of instantations). Verified to give a big performance increase in, e.g., extract_pdbs (silent file extraction).
+ New tool to recognize PDB residues based on atom names without having a list of all patched residues, based on a customized binary search through Patches. Verified to give a big performance increase in PDB read in.

 Subsequent pull requests are accomplishing the following tasks:
+ remove rna residue type sets in favor of fa_standard.
+ removing command-line patch selectors which kept patches off by default; now they can be turned on.
+ No more -override_rsd_type_limit warning. 
+ assorted fixups.

###
There are still some important things to do:


the current implementation is not thread-safe, but its possible to return to a thread-safe version (with -chemical:on_the_fly false). @aleaverfay I'll need some advice on how to best hard-wire thread safety when needed; there are a couple of ways to do it, which I'll outline in a separate block below.
Actually unify the new ResidueTypeFinder class with classic ResidueTypeSelector.
Should be possible to further accelerate ResidueTypeFinder as it goes down a binary tree to apply patches to find residue_types -- this would require caching a map of which patches apply to which residue_types perhaps in ResidueTypeSet; this is currently done implicitly in name_map().
Rocco and I reintroduced ResidueType::variant_types() and it comes out as a list of std::string, instead of VariantType enum. (Rocco was working before @JWLabonte refactor). will be easy to restore. Should happen after @JWLabonte finishes pull request #56
There are currently 'placeholder' residue_types created with some basic info like name, name3, etc.; should be possible to not even create these and save more time.