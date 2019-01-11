#LegacyAssemblyConstraintsMover
##Note: This page is for LegacySEWING.
**This is an outdated page. For information on the current version of sewing, please visit the [[AssemblyMover]] and [[AppendAssemblyMover]] pages.**

##Purpose

The AssemblyConstraintsMover is used in the design of structures generated using SEWING. Although SEWING movers can perform refinement, it is more common to filter the output structures beforehand and refine a subset of them using a custom protocol. This mover uses the .rot file output by SEWING movers to add constraints that favor the native residue type (or types) at each position. 

##Options

* native_rotamers_file: Path to the .rot file generated during the SEWING protocol (required)
* native_bonus: Weight for residue type constraints (will be overridden by secondary structure-specific weights).
* helix_native_bonus: Residue type constraint weight for helical residues. Default 1.
* loop_native_bonus: Residue type constraint weight for loop residues. Default 1.
* strand_native_bonus: Residue type constraint weight for beta strand residues Default 1.

##Subtags

The AssemblyConstraintsMover does not accept any subtags. 

##Example
```xml
<MOVERS>
   <AssemblyConstraintsMover name="ACM" native_rotamers_file="test_0001_from_25.rot" native_bonus="1" />
   <FastRelax name="fastrelax" repeats="1" disable_design="false" scorefxn="talaris_cart" cartesian="1" task_operations="resfile,keep_curr,layerdesign" delete_virtual_residues_after_FastRelax="1"/>
</MOVERS>
<PROTOCOLS>
   <Add mover_name="ACM"/>
   <Add mover="fastrelax"/>
</PROTOCOLS>
```

##See Also
* [[SEWING]]: The SEWING home page
* [[Refinement of SEWING Assemblies]]
* [[Assembly of models]]