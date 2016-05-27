#Refinement of SEWING Assemblies

##Built-in refinement protocol

##Custom refinement protocols

###Pre-filtering assemblies

###Favoring native residues
When backbones are generated using [[SEWING movers|Assembly of models]], the native rotamers are saved with file name as a NativeRotamersFile (xxxx.rot). Therefore, one can give some bonus to these native residue types (add ResidueType constraints to pose) when designing sidechains (using [[AssemblyConstraintsMover]]). It is common practice to apply relatively weak constraints (e.g. weight 1) to helical and beta strand residues and stronger constraints (e.g. weight 5) to loop residues.

###Fixing residue identities in custom protocols

##Common filters

##See Also
* [[SEWING]]: The SEWING home page
* [[AssemblyConstraintsMover]]
* [[Assembly of models]]
* [[SEWING Dictionary]]