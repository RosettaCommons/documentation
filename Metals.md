# Working with metalloproteins in Rosetta
Documentation by Vikram K. Mulligan, Baker Laboratory (vmullig@uw.edu).  Created 13 March 2014

## Short summary
The **-in:auto_setup_metals** flag has been added to make it easy to import a PDB file containing a metalloprotein and to have Rosetta automatically detect covalent bonds to metal ions and create appropriate constraints.

## Usage cases
In general, there are three broad types of task that a user might want to do with a metalloprotein:
* Predict the structure of a metalloprotein, including discovering metal-coordinating residues.  This is currently not easy in Rosetta, though this functionality might be added in the future.
* Carry out _de novo_ design of a metal-binding center in a protein.  This is best done with the enzyme design geometric constraints files, which are [[described elsewhere|match-cstfile-format]]
* Import a PDB file describing a metalloprotein, and then do something to it (_e.g._ design a binder, redesign a loop, relax the structure, _etc._).  This documentation is intended for this case.

## What is Rosetta's default behavior, and why is this a problem?
By default, Rosetta is able to recognize most of the metal ions commonly found in proteins (Zn, Cu, Fe, Mg, Na, K, Ca, _etc._).  On import, however, Rosetta knows nothing about the covalent connectivity between the metal ion and surrounding amino acid residues.  As the foldtree is set up, the metal is added by a jump, rooted to the first residue.  This isn't ideal, since it means that a small change in the backbone conformation anywhere will not pull the metal along with the surrounding residues.

Because Rosetta knows nothing about metal ion covalent geometry by default, the scoring function will consider van der Waals interactions between the metal ion and surrounding side-chains, meaning that Rosetta will think that it is clashing horribly, yielding huge energy values.  Relaxing the structure will push all surrounding side-chains away from the metal, and could result in the metal moving away from the rest of the structure.  We probably don't want that.

Even worse, the protonation state of histidine residues (which commonly coordinate metal ions) is, by default, set without any knowledge of the metal.  This often places hydrogen atoms inside the van der Waals radius of the metal ion.

## How have metalloproteins been handled in the past?

Some people have created Enzdes-style geometric constraints files for each metalloprotein on which they want to work, but this is time-consuming and tedious, and requires user input that shouldn't be necessary.  It also requires that each protocol know how to use an Enzdes-style constraints file, and many do not.  Others have used virtual metal atoms, but this means that the scoring function ignores the charge on a metal ion, and creates other problems.  Some people have even created new metal-binding residue types that have included the metal, but this creates its own set of problems.

## What's the better solution?

The **-in:auto_setup_metals** flag has been added to handle import of metalloproteins from PDB files automatically.  This flag ensures the following:
* Rosetta automatically sets covalent bonds between metal ions and nearby metal-binding atoms on metal-binding residues.
* Rosetta automatically creates distance constraints between metal ions and the atoms that bind them.  The distances are based on the geometry in the PDB file.
* Rosetta automatically creates angle constraints between metal ions, the atoms that bind them, and the parent atoms to those atoms.  The angles are based on the geometry in the PDB file.
* Rosetta sets the **atom_pair_constraint** and **angle_constraint** weights in the scorefunction to 1.0, if they have not already been set in the weights file.
* Rosetta removes hydrogens from atoms that bind metal ions, and adjusts the charge on the residue appropriately (which can be important in special cases in which one residue coordinates multiple metal ions).
* Rosetta sets up the fold tree such that the metal atom is connected by a jump to the spatially closest metal-binding residue that precedes it in linear sequence.  This means that if the protein's backbone is moved, the metal will remain close to that residue (though not necessarily close to its side-chain, if that were to move).

## How do I control the default behavior of the **-in:auto_setup_metals** flag?

Three additional flags control the behavior:
* **-in:metals_detection_LJ_multiplier <value>** controls the threshold for detecting covalent interactions between metal ions and metal-binding residues.  A value of 1.5 means that a time and a half the sum of the van der Waals radii of the metal ion and potential metal-binding atoms is used as the threshold.
* **-in:metals_distance_constraint_multiplier <value>** controls the strength of the distance constraint, with 1.0 being the default.  Note that if an **atom_pair_constraint** weight is set by a protocol or by a weights file, the strength is automatically scaled appropriately (i.e. doubling the **atom_pair_constraint** weight does _not_ necessitate halving the value set with this flag).  If the value is set to 0, no atom_pair constraints are added.
* **-in:metals_angle_constraint_multiplier <value>** controls the strength of the angle constraint, with 1.0 being the default.  As before, if an **angle_constraint** weight is set by a protocol or by a weights file, the strength is automatically scaled appropriately.  If the value is set to 0, no angle constraints are added.

## How does Rosetta know what residues can bind metals, and what atoms in those residues form the covalent bonds to metals?

Metal-binding residues have the **METALBINDING** property in their properties list (in the params file).  Additionally, metal-binding atoms are specified with the **METAL_BINDING_ATOMS <atomname1> <atomname2> ...** line (also in the params file).  Meanwhile, metal ions have the **METAL** property in their properties list.  Note: metal ions must have the metal atom as atom 1.

## Does this work for noncanonical amino acid residues, too?

Absolutely.  The noncanonical amino acid (2,2'-bipyridin-5yl)alanine (BPY) has been added to the database, and can serve as a demonstration case.

## Is there a good way to confirm that Rosetta is setting the atomic connectivity properly?

Yes.  Explicit CONECT records can be written on PDB export by using the **-inout:connect_info_cutoff 0.0** and **-inout:dump_connect_info true** flags.  Bonds to the metal ion will be visible when the PDB output from Rosetta is loaded in PyMOL if you use these flags.

## I'd like to do other things with metals in my own protocols.  Where can I find the code for the functionality described here?

Utility functions are located in **src/core/pose/metalloproteins/util.cc** and **src/core/pose/util.cc**.  The **is_metal()** and **is_metalbinding()** methods have both been added to both the **core::chemical::ResidueType** and **core::conformation::Residue** classes, letting you query whether a residue is a metal ion or a metal-binding residue.  For metal-binding residues, the **get_metal_binding_atoms()** method in **ResidueType** and **Residue** provides a list of indices of metal-binding atoms.

## Caveats

This has not yet been tested with Cartesian minimization, the **cart_bonded** score term, or symmetry.  These might create problems.