#AssemblyConstraintsMover

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
   <AssemblyConstraintsMover name=ACM native_rotamers_file="test_0001_from_25.rot" native_bonus=1 />
   <FastRelax name=fastrelax repeats=1 disable_design=false scorefxn=talaris_cart cartesian=1 task_operations=resfile,keep_curr,layerdesign delete_virtual_residues_after_FastRelax=1/>
</MOVERS>
<PROTOCOLS>
   <Add mover_name="ACM"/>
   <Add mover=fastrelax/>
</PROTOCOLS>
```

##See Also
* [[SEWING]]: The SEWING home page
* [[Sidechain Design aided by SEWING]]
* [[Assembly of models]]