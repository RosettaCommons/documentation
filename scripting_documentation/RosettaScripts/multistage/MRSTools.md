#MRS: Tools and Utilities

[[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

##Script Converter

##Estimate Memory

##Unarchive

##XML Template

##Info

As with traditional rosetta scripts, you can pass the `-info` flag
followed by a mover, filter, task operation, or residue selector name and Rosetta will
print the XML schema for that element to console.

For example, running:

```
multistage_rosetta_scripts.default.linuxgccrelease -info Idealize
```

gives

```
INFORMATION ABOUT MOVER "Idealize":

DESCRIPTION:

Idealizes the bond lengths and angles of a pose. It then minimizes the pose in a stripped-down energy function in the presence of coordinate constraints

USAGE:

<Idealize atom_pair_constraint_weight=(real,"0.0") coordinate_constraint_weight=(real,"0.01") fast=(bool,"false") chainbreaks=(bool,"false") report_CA_rmsd=(bool,"true") ignore_residues_in_csts=(residue_number_cslist) impose_constraints=(bool,"true") constraints_only=(bool,"false") pos_list=(int_cslist) name=(string)>
</Idealize>

OPTIONS:

"Idealize" tag:

	   atom_pair_constraint_weight (real,"0.0"):  Weight for atom pair constraints

	   coordinate_constraint_weight (real,"0.01"):  Weight for coordinate constraints

	   fast (bool,"false"):  Don't minimize or calculate stats after each idealization

	   chainbreaks (bool,"false"):  Keep chainbreaks if they exist

	   report_CA_rmsd (bool,"true"):  Report CA RMSD?

	   ignore_residues_in_csts (residue_number_cslist):  Ignore these residues when applying constraints

	   impose_constraints (bool,"true"):  Impose constraints on the pose?

	   constraints_only (bool,"false"):  Only impose constraints and don't idealize

	   pos_list (int_cslist):  List of positions to idealize

	   name (string):  The name given to this instance.

```

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
