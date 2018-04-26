# Working With Metalloproteins in Rosetta
By Vikram K. Mulligan, Baker Laboratory (vmullig@uw.edu).  Documentation created 13 March 2014; changes checked into master branch 14 March 2014.

## Short summary
The **-in:auto_setup_metals** flag has been added to make it easy to import a PDB file containing a metalloprotein and to have Rosetta automatically detect coordinate covalent bonds to metal ions and create appropriate constraints.

## Usage cases
In general, there are three broad types of task that a user might want to do with a metalloprotein:
* Predict the structure of a metalloprotein, including discovering metal-coordinating residues.  This is currently not easy in Rosetta, though this functionality might be added in the future.  (Note that there has been some work on predicting metalloprotein structure in situations in which the metal-site geometry is known.  See [Wang _et al._ (2010). _Protein Sci._ 19(3):494-506](http://www.ncbi.nlm.nih.gov/pubmed/20054832) for details.)
* Carry out _de novo_ design of a metal-binding center in a protein.  This is best done with the enzyme design geometric constraints files, which are [[described elsewhere|match-cstfile-format]]
* Import a PDB file describing a metalloprotein, and then do something to it (_e.g._ design a binder, redesign a loop, relax the structure, _etc._).  This documentation is intended for this case.

## What is Rosetta's default behavior, and why is this a problem?
By default, Rosetta is able to recognize most of the metal ions commonly found in proteins (Zn, Cu, Fe, Mg, Na, K, Ca, _etc._).  On import, however, Rosetta knows nothing about the covalent connectivity between the metal ion and surrounding amino acid residues.  As the foldtree is set up, the metal is added by a jump, rooted to the first residue.  This isn't ideal, since it means that a small change in the backbone conformation anywhere will not pull the metal along with the surrounding residues.

Because Rosetta knows nothing about metal ion covalent geometry by default, the scoring function will consider van der Waals interactions between the metal ion and surrounding side-chains, meaning that Rosetta will think that it is clashing horribly, yielding huge energy values.  Relaxing the structure will push all surrounding side-chains away from the metal, and could result in the metal moving away from the rest of the structure.  We probably don't want that.

Even worse, the protonation state of histidine residues (which commonly coordinate metal ions) is, by default, set without any knowledge of the metal.  This often places hydrogen atoms inside the van der Waals radius of the metal ion.

## How have metalloproteins been handled in the past?

Some people have created Enzdes-style geometric constraints files for each metalloprotein on which they want to work, but this is time-consuming and tedious, and requires user input that shouldn't be necessary.  It also requires that each protocol know how to use an Enzdes-style constraints file, and many do not.  Others have used virtual metal atoms, but this means that the scoring function ignores the charge on a metal ion, and creates other problems.  Some people have even created new metal-binding residue types that have included the metal, but this creates its own set of problems.  Finally, some have just worked with apo-metalloproteins (the metal-free versions of the proteins), which is valid in some cases, but is not a generally-applicable strategy.

## What's the better solution?

The **-in:auto_setup_metals** flag has been added to handle import of metalloproteins from PDB files automatically.  This flag ensures the following:
* Rosetta automatically sets covalent bonds between metal ions and nearby metal-binding atoms on metal-binding residues.
* Rosetta automatically creates distance constraints between metal ions and the atoms that bind them.  The distances are based on the geometry in the PDB file.
* Rosetta automatically creates angle constraints between metal ions, the atoms that bind them, and the parent atoms to those atoms.  The angles are based on the geometry in the PDB file.
* Rosetta sets the **metalbinding_constraint** weight in the scorefunction to 1.0, if it has not already been set in the weights file.
* Rosetta removes hydrogens from atoms that bind metal ions, and adjusts the charge on the residue appropriately (which can be important in special cases in which one residue coordinates multiple metal ions).
* Rosetta sets up the fold tree such that the metal atom is connected by a jump to the spatially closest metal-binding residue that precedes it in linear sequence.  This means that if the protein's backbone is moved, the metal will remain close to that residue (though not necessarily close to its side-chain, if that were to move).
The [[SetupMetalsMover]] provides the same function as the flag in mover form.

## How do I control the default behavior of the **-in:auto_setup_metals** flag?

Three additional flags control the behavior:
* **-in:metals_detection_LJ_multiplier <value>** controls the threshold for detecting covalent interactions between metal ions and metal-binding residues.  A value of 1.5 means that a time and a half the sum of the van der Waals radii of the metal ion and potential metal-binding atoms is used as the threshold.
* **-in:metals_distance_constraint_multiplier <value>** controls the strength of the distance constraint, with 1.0 being the default.  Note that if a **metalbinding_constraint** weight is set by a protocol or by a weights file, the strength is automatically scaled appropriately (i.e. doubling the **metalbinding_constraint** weight does _not_ necessitate halving the value set with this flag).  If the value is set to 0, no atom pair constraints are added.
* **-in:metals_angle_constraint_multiplier <value>** controls the strength of the angle constraint, with 1.0 being the default.  As before, if a **metalbinding_constraint** weight is set by a protocol or by a weights file, the strength is automatically scaled appropriately.  If the value is set to 0, no angle constraints are added.
The SetupMetalsMover by default uses the values for these multipliers set on the command line. The values can also be specified in the mover tag using RosettaScripts.
## How does Rosetta know which residue types can bind metals?

Metal-binding residues have the **METALBINDING** property in their properties list (in the params file).  Additionally, metal-binding atoms are specified with the **METAL_BINDING_ATOMS <atomname1> <atomname2> ...** line (also in the params file).  Meanwhile, metal ions have the **METAL** property in their properties list.  Note: metal ions must have the metal atom as atom 1.

## Does this work for noncanonical amino acid residues, too?

Absolutely.  The noncanonical amino acid (2,2'-bipyridin-5yl)alanine (BPY) has been added to the database, and can serve as a demonstration case.

## How can I confirm that Rosetta is setting the atomic connectivity properly?

Explicit CONECT records should now be written out by default to the PDB file.  You can use these to confirm that there are bonds between the metal-binding atoms and the metal.  Bonds to the metal ion will be visible when the PDB output from Rosetta is loaded in PyMOL.

You can also force the dumping of all CONECT records (not just the bonds to noncanonical entities like metal centres) with the **-write_all_connect_info** flag.

## Does this work within RosettaScripts?

As of 13 May 2014, it does.  One caveat is that constraint weights must be turned on explicitly in the scorefunction used in order for metal constraints to work.  Additionally, any mover that clears constraints will clear the metal constraints.

**UPDATE** 25 April 2017: The new SetupMetalsMover provides the same functionality as the flag in mover form (constraint weights must still be explicitly set in the score function). The constraints_only option allows users to add constraints back without setting up covalent bonds; this can be useful i.e. after calling a mover that clears constraints.

## Is this compatible with centroid mode?

**Short answer:** Yes, probably (as of April 2018) **Long Answer:** If your metalbinding geometry is through backbone atoms, there shouldn't be much of a concern, assuming you remember to enable the metalbinding_constraint term in your centroid scorefunctions. (It will not be automatically enabled for you.) If the coordination is through sidechain atoms, there are a few caveats. As protein sidechain atoms are not normally present during centroid mode, there's a difficulty in translating the covalent bonds and the constraints into standard centroid mode residues. 

Rosetta gets around this by creating a special united-atom residue type, where all the sidechain atoms are explicitly represented. There's two potential issues with this approach. The first is that, because it doesn't have the CEN atom, this special residue won't be scored in centroid mode like a standard protein residue. The other is due to sampling limitations. Because most centroid mode protocols don't consider sidechain sampling, the sidechain conformation of metalbinding residues will effectively be locked in their starting position. This might not be an issue if you're not sampling in the immediate neighborhood of the residue (e.g. if you're doing loop remodeling in another part of the protein), but if you're doing backbone remodeling in the vicinity of the metalbinding residue, you may be unfairly rejecting acceptable conformations due to the immobility of the residue sidechain.

Note this is only if you read in the pose as full atom, apply the metalbinding setup, and then later convert to centroid (e.g. during a loop remodeling segment of the protocol). If you directly read the structure in as a centroid mode pose (e.g. with the -in:file:centroid flag), Rosetta will never have the sidechain atoms to appropriately set up the bonds to the metal and constraints in the first place.

## I'd like to do other things with metals in my own protocols.

Can you ask that in the form of a question?

## Where can I find the code for the functionality described here?

Good question.  Utility functions are located in **src/core/util/metalloproteins_util.cc**.  (Functions in this file duplicate some of the functionality in **src/protocols/toolbox/match_enzdez_util/** with some modifications; in the future, this should probably be consolidated to avoid code duplication.)  The **is_metal()** and **is_metalbinding()** methods have both been added to both the **core::chemical::ResidueType** and **core::conformation::Residue** classes, letting you query whether a residue is a metal ion or a metal-binding residue.  For metal-binding residues, the **get_metal_binding_atoms()** method in **ResidueType** and **Residue** provides a list of indices of metal-binding atoms.

## Caveats

* Metals followed by a "1" or "2" character (_e.g._ ZN1, CU2, etc.) are interpreted as the corresponding metal on PDB import.  This can create problems (_e.g._ CO2 is interpreted as cobalt, not carbon dioxide).
* This has not yet been tested with Cartesian minimization, the **cart_bonded** score term, or symmetry.  These might create problems.
* Within RosettaScripts, constraint weights must be turned on explicitly in a user-defined scorefunction.
* Any protocol or RosettaScripts mover that resets constraints will reset the metal constraints.

##See Also

* [[SetupMetalsMover]]