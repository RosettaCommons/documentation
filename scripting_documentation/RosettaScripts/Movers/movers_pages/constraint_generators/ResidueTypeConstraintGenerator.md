#ResidueTypeConstraintGenerator
The ResidueTypeConstraintGenerator is used in conjunction with [[AddConstraintsMover]]to add residue type constraints to a pose. By default, it constrains all residues to their starting identities. A residue selector can be used to specify which residues should be constrained, and a name3 for the desired residue type can be specified to constrain selected residues to a particular identity.
```
<ResidueTypeConstraintGenerator name="(&string;)"
        favor_native_bonus="(1.0 &real;)" rsd_type_name3="(&string;)"
        use_native="(false &bool;)" residue_selector="(&string;)" />
```
favor_native_bonus: Unweighted score bonus the pose will receive for having the specified residue type at the specified position
rsd_type_name3: Three-letter code for the amino acid to which you want to constrain this residue. If unspecified, this defaults to the native amino acid at this position.
use_native: Use native structure (provided with in:file:native) as reference pose for defining desired residue identities
residue_selector: Selector specifying residues to be constrained. When not provided, all residues are selected

##See Also##
* [[AddConstraintsMover]]