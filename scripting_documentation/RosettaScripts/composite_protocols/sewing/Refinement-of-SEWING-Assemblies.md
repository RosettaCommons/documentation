#Refinement of SEWING Assemblies

##Built-in refinement protocol
By default, SEWING runs full-atom refinement on all models that pass initial AssemblyScore cutoffs. This refinement consists of a condensed version of FastRelax (three cycles instead of the default 5) with residue type constraints (weight 1) favoring the native residue identities at each position (chimeras favor either native residue type).

##Custom refinement protocols
Since SEWING is often used to generate a large number of backbone conformations, refining all output structures during the initial SEWING run may be prohibitively slow. Therefore, it is common to skip the built-in refinement protocol (using the -sewing:skip_refinement flag) and filter and/or modify the assemblies before refinement. Custom refinement protocols also allow users to choose secondary structure-specific residue type constraint weights via the [[AssemblyConstraintsMover]].
###Pre-filtering assemblies
* Removing duplicates
* Score-based filtering

###Handling Ligands
Currently, SEWING strips out all non-protein components for starting structures (i.e. input structures for AppendAssemblyMover). If the starting structure binds a ligand, the ligand must therefore be added back to the assemblies. This is most easily accomplished by copying the ligand coordinates from the starting PDB file into the finished assemblies; since the starting node remains fixed during SEWING, the ligand placement will be correct. Improved handling of ligands is currently a SEWING development goal.

###Important Considerations
* Since the SEWING protocol forms chimeras from secondary structure elements with atoms that do not superimpose perfectly, it is critical to use **cartesian minimization** in any SEWING refinement protocol. This requires using a cartesian score function such as talaris2014_cart and specifying cartesian minimization (e.g. by setting cartesian=1 in [[FastDesign|FastDesignMover]]).
* When designing structures, it is also helpful to use a linear memory interaction graph to improve performance by using the command line option `-linmem_ig 10`.
* SEWING refinement protocols typically favor native residue identities (see below).

###Favoring native residues
When backbones are generated using [[SEWING movers|Assembly of models]], the native rotamers are saved with file name as a NativeRotamersFile (xxxx.rot). Therefore, one can give some bonus to these native residue types (add ResidueType constraints to pose) when designing sidechains (using [[AssemblyConstraintsMover]]). It is common practice to apply relatively weak constraints (e.g. weight 1) to helical and beta strand residues and stronger constraints (e.g. weight 5) to loop residues.

###Fixing residue identities in custom protocols
When using [[AppendAssemblyMover]], there are often several residues (such as residues forming key binding interactions) that should be held fixed during refinement. Since residue numbers in each final assembly will be different from the residue numbers in the input pdb and from each other, selecting these residues is not straightforward.

The [[RestrictIdentitiesAtAlignedPositions|RestrictIdentitiesAtAlignedPositionsOperation]] task operation can solve this problem. By using the starting node as the task operation's source_pdb and specifying the residue numbers in the starting node to be fixed, those residues can be fixed as the intended residue type. Since SEWING does not change the position of the starting node, the initial alignment will be correct; however, coordinate constraints must be used during refinement to ensure that the correct residues remain aligned.
##Common filters

##See Also
* [[SEWING]]: The SEWING home page
* [[AssemblyConstraintsMover]]
* [[Assembly of models]]
* [[SEWING Dictionary]]