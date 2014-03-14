# Working with metalloproteins in Rosetta
Documentation by Vikram K. Mulligan, Baker Laboratory (vmullig@uw.edu)
Created 13 March 2014

## Usage cases
In general, there are broad types of task that a user might want to do with a metalloprotein:
* Predict the structure of a metalloprotein, including discovering metal-coordinating residues.  This is currently not easy in Rosetta, though this functionality might be added in the future.
* Carry out _de novo_ design of a metal-binding center in a protein.  This is best done with the enzyme design geometric constraints files, which are [[described elsewhere|match-cstfile-format]]
* Import a PDB file describing a metalloprotein, and then do something to it (_e.g._ design a binder, redesign a loop, relax the structure, _etc._).  This documentation is intended for this case.

## What is Rosetta's default behavior, and why is this a problem?
By default, Rosetta is able to recognize most of the metal ions commonly found in proteins (Zn, Cu, Fe, Mg, Na, K, Ca, _etc._).  On import, however, Rosetta knows nothing about the covalent connectivity between the metal ion and surrounding amino acid residues.  As the foldtree is set up, the metal is added by a jump to the spatially closest metal-binding residue that precedes it in linear sequence.  This means that if the protein's backbone is moved, the metal will remain close to that residue (though not necessarily close to its side-chain, should that move).

Because Rosetta knows nothing about metal ion covalent geometry by default, the scoring function will consider van der Waals interactions between the metal ion and surrounding side-chains, meaning that Rosetta will think that it is clashing horribly, yielding huge energy values.  Relaxing the structure will push all surrounding side-chains away from the metal, and could result in the metal moving away from the rest of the structure.  We probably don't want that.

Even worse, the protonation state of histidine residues (which commonly coordinate metal ions) is, by default, set without any knowledge of the metal.  This often places hydrogen atoms inside the van der Waals radius of the metal ion.

## What's the solution?

The **-in:auto_setup_metals** flag automatically handles import of metalloproteins from PDB files.  This flag ensures the following:
* Rosetta automatically sets covalent bonds between metal ions and nearby metal-binding atoms on metal-binding residues.
* Rosetta automatically creates distance constraints between metal ions and the atoms that bind them.  The distances are based on the geometry in the PDB file.
* Rosetta automatically creates angle constraints between metal ions, the atoms that bind them, and the parent atoms to those atoms.  The angles are based on the geometry in the PDB file.
* Rosetta sets the **atom_pair_constraint** and **angle_constraint** weights in the scorefunction to 1.0, if they have not already been set in the weights file.

## How do I control the default behavior of the **-in:auto_setup_metals** flag?
