#Refinement of SEWING Assemblies

##Built-in refinement protocol

##Custom refinement protocols

###Pre-filtering assemblies

###Important Considerations
* Since the SEWING protocol forms chimeras from secondary structure elements with atoms that do not superimpose perfectly, it is critical to use **cartesian minimization** in any SEWING refinement protocol. This requires using a cartesian score function such as talaris2014_cart 

###Favoring native residues
When backbones are generated using [[SEWING movers|Assembly of models]], the native rotamers are saved with file name as a NativeRotamersFile (xxxx.rot). Therefore, one can give some bonus to these native residue types (add ResidueType constraints to pose) when designing sidechains (using [[AssemblyConstraintsMover]]). It is common practice to apply relatively weak constraints (e.g. weight 1) to helical and beta strand residues and stronger constraints (e.g. weight 5) to loop residues.

###Fixing residue identities in custom protocols

##Common filters

##See Also
* [[SEWING]]: The SEWING home page
* [[AssemblyConstraintsMover]]
* [[Assembly of models]]
* [[SEWING Dictionary]]