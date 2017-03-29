# DeclareBond

Page created 28 March 2017 by Vikram K. Mulligan (vmullig@uw.edu).

*Back to [[Mover|Movers-RosettaScripts]] page.*

## DeclareBond

This mover tells Rosetta that a chemical bond exists between two atoms in two different residues.  Note that this is a _physical_ relationship, not a _kinematic_ relationship: the existence of the bond means that van der Waals interactions between the atoms will not be calculated.  It does not mean that moving the Pose will not stretch or distort the bond; on the contrary, because the DeclareBond mover does not, by default, alter the FoldTree of the Pose, moving the Pose most likely _will_ stretch or distort the bond.

This mover is often used after adding geometry with the [[PeptideStubMover]], and prior to closing loops with the [[GeneralizedKIC mover|GeneralizedKICMover]].

## Full options

<DeclareBond res1=(int) res2=(int) atom1=(string) atom2=(string) add_termini=(bool,"true") rebuild_fold_tree=(bool,"false") run_kic=(bool,"false") KIC_res1=(int,"0") KIC_res2=(int,"0") name=(string)>
</DeclareBond>

OPTIONS:

"DeclareBond" tag:

**res1 (int)**:  Residue containing first atom to connect with a bond.

**res2 (int)**:  Residue containing second atom to connect with a bond.

**atom1 (string)**:  Name of first atom.

**atom2 (string)**:  Name of second atom.

**add_termini (bool,"true")**:  If true, terminal types are added to any pose residues that have unconnected ends.  Note that the DeclareBond mover strips terminal types before adding a bond, so it is often best to set this option to true to add them back.  (The mover can also be used as a quick, kludgey way of adding termini to a pose, by declaring an already-existing bond with **add_termini="true"**.)

**rebuild_fold_tree (bool,"false")**:  Rebuild the fold tree after declaring this bond?  This is not recommended -- manual FoldTree rebuilding with the [[AtomTree|AtomTreeMover]] is a better idea.

**run_kic (bool,"false")**:  Run KIC to close any chainbreak caused by the declared chemical bond?  This is not recommended.  The [[GeneralizedKIC|GeneralizedKICMover]] offers far more control over kinematic closure.

**KIC_res1 (int,"0")**:  First residue to use in KIC if **run_kic="true"** is set.

**KIC_res2 (int,"0")**:  Second residue to use in KIC if **run_kic="true"** is set.

**name (string)**:  The name given to this instance.

##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[GeneralizedKIC|GeneralizedKICMover]]
* [[PeptideStubMover]]