#MetalContactsConstraintGenerator

###Summary
Generates distance, angle, and dihedral constraints for the specified metal atom in the selected ligand residue. By default, all values are constrained to the value of the measurement in the pose at the time when the constraint generator is created. Users can also provide alternate base atoms (and bases of those base atoms) to customize how angles/dihedrals are measured.

The user must specify only one metal atom per constraint generator to set up by providing a resnum or residue selector an an atom name. This atom may be either a standalone metal ion or part of a larger complex.

An atom is considered a metal contact if:
1) It is identified in the residue's params file as a metal binding atom
AND
2) The distance between the atom and the metal atom is less than or equal to the sum of their van der Waals radii multiplied by the dist_cutoff_multiplier.
Residues in which contacts are constrained can be constricted by providing either contact_resnums or a contact_residue_selector; non-internal contacts outside that set will not be set up.

###Glossary

Note that multiple ideal values can be provided for all angles/dihedrals. If constrain_to_closest is set to true, each value will be constrained to the provided ideal value closest to the measurement found in the pose at the time the constraints are created.

Terms:
* Contact- Atom directly in contact with the metal ion
* Metal- The metal atom that the user has specified in the constraint generator.
* Base- The base atom of the contact. Unless otherwise specified, this is the base_atom defined by the ResidueType.
* Base_base- The base atom of the base.
* Other_contact- A different atom directly in contact with the metal ion. May be either an atom from another coordinating residue or, if score_against_internal_contacts is set to true, another atom within the ligand residue that is in contact with the metal atom.
* Other_base- The base atom of other_contact.

The angles specified in this constraint generator are defined as follows:
* Distance: contact-metal
* Angle_about_contact: base-contact-metal
* Dihedral_about_contact: base_base-base-contact-metal
* Angle_about_metal: contact-metal-other_contact
* Dihedral_about_metal: base-contact-metal-other_contact
* Dihedral_3: contact-metal-other_contact-other_base

###Usage

```xml
<MetalContactsConstraintGenerator name="(&string;)"
        dist_cutoff_multiplier="(1.0 &real;)" ligand_atom_name="(&string;)"
        ligand_selector="(&string;)" contact_selector="(&string;)"
        ligand_resnum="(&positive_integer;)"
        contact_resnums="(&refpose_enabled_residue_number_cslist;)"
        base_atom_name="(&string;)" base_base_atom_name="(&string;)"
        ideal_distance="(&real;)" ideal_angle_about_contact="(&real_cslist;)"
        ideal_dihedral_about_contact="(&real_cslist;)"
        ideal_angle_about_metal="(&real_cslist;)"
        ideal_dihedral_about_metal="(&real_cslist;)"
        ideal_dihedral_3="(&real_cslist;)"
        score_against_internal_contacts="(false &bool;)"
        constrain_to_closest="(true &bool;)"
 />
```

* dist_cutoff_multiplier: Multiply van der Waals radii of metal and contact atom by this value during contact detection.
* ligand_atom_name: (REQUIRED) Name of ligand metal atom you want to constrain.
* ligand_selector: Residue selector specifying which metal-containing ligand to constrain
* contact_selector: Residue selector restricting which residues should be considered as potential ligand contacts.
* ligand_resnum: Residue number for ligand to be constrained
* contact_resnums: Residue numbers for residues that could be considered as contacts. If neither this option nor a residue selector is specified, then all residues are considered.
* base_atom_name: Name of atom to use as base of contact atoms for angles/dihedrals. Defaults to residue's base atom for contact atom.
* base_base_atom_name: Name of atom to use as base of base of contact atoms for angles/dihedrals. Defaults to residue's base atom.
* ideal_distance: Ideal distance between constrained metal and contact atom. Defaults to current distance.
* ideal_angle_about_contact: Comma-separated list of possible optimal angles, base-contact-metal. Defaults to current angle.
* ideal_dihedral_about_contact: Comma-separated list of possible optimal dihedrals, base_base-base-contact-metal. Defaults to current dihedral.
* ideal_angle_about_metal: Comma-separated list of possible optimal angles, contact-metal-other_contact. Defaults to current angle.
* ideal_dihedral_about_metal: Comma-separated list of possible optimal dihedrals, base-contact-metal-other_contact. Defaults to current dihedral.
* ideal_dihedral_3: Comma-separated list of possible optimal dihedrals, contact-metal-other_contact-other_base. Defaults to current dihedral.
* score_against_internal_contacts: Should we score angles and dihedrals vs other atoms in the ligand?
constrain_to_closest: If multiple ideal angle/dihedral values are provided, constrain each measurement to the ideal value which is closest to the value of that measurement at the time when constraints were set up. If set to false, an AmbiguousConstraint to all the provided values will instead be used. Default true.

##See Also
* [[ConstraintGenerators]]
* [[AddConstraints]]
* [[RemoveConstraints]]
* [[SetupMetalsMover]]
* [[Metals]]
