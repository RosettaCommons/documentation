# DeclareBond

Page created 28 March 2017 by Vikram K. Mulligan (vmullig@uw.edu).  Last modified 18 July 2017.

*Back to [[Mover|Movers-RosettaScripts]] page.*

## DeclareBond

This mover tells Rosetta that a chemical bond exists between two atoms in two different residues.  Note that this is a _physical_ relationship, not a _kinematic_ relationship: the existence of the bond means that van der Waals interactions between the atoms will not be calculated.  It does not mean that moving the Pose will not stretch or distort the bond; on the contrary, because the DeclareBond mover does not, by default, alter the FoldTree of the Pose, moving the Pose most likely _will_ stretch or distort the bond.

This mover is often used after adding geometry with the [[PeptideStubMover]], and prior to closing loops with the [[GeneralizedKIC mover|GeneralizedKICMover]].

If the mover crashes with a "doesn't have connection" error, this is because you need to create a new inter-residue connection for the residue where your bond is. You can accomplish this by giving the connected residues their own [[params files|Residue-Params-file]] with a CONNECT line for each connection.

## Full options

```xml
<DeclareBond res1=(int) res2=(int) atom1=(string) atom2=(string)
     add_termini=(bool,"true") rebuild_fold_tree=(bool,"false")
     run_kic=(bool,"false") KIC_res1=(int,"0") KIC_res2=(int,"0") name=(string)
/>
```

"DeclareBond" tag:

**res1 (int)**:  Residue containing first atom to connect with a bond.

**res2 (int)**:  Residue containing second atom to connect with a bond.

**atom1 (string)**:  Name of first atom.

**atom2 (string)**:  Name of second atom.

**add\_termini (bool,"true")**:  If true, terminal types are added to any pose residues that have unconnected ends.  Note that the DeclareBond mover strips terminal types before adding a bond, so it is often best to set this option to true to add them back.  (The mover can also be used as a quick, kludgey way of adding termini to a pose, by declaring an already-existing bond with **add_termini="true"**.)

**rebuild\_fold\_tree (bool,"false")**:  Rebuild the fold tree after declaring this bond?  This is not recommended -- manual FoldTree rebuilding with the [[AtomTree mover|AtomTreeMover]] is a better idea.

**run\_kic (bool,"false")**:  Run KIC to close any chainbreak caused by the declared chemical bond?  This is not recommended.  The [[GeneralizedKIC mover|GeneralizedKICMover]] offers far more control over kinematic closure.

**KIC\_res1 (int,"0")**:  First residue to use in KIC if **run_kic="true"** is set.

**KIC\_res2 (int,"0")**:  Second residue to use in KIC if **run_kic="true"** is set.

**name (string)**:  The name given to this instance.

## Typical usage

Typically, one simply declares the first and last atoms.  For example, to declare a peptide bond between residues 16 and 17, one would use the following syntax:

```xml
<DeclareBond name="connect_16_to_17" res1="16" res2="17" atom1="C" atom2="N" />
```

## See Also

* [[I want to do x]]: Guide to choosing a mover
* [[GeneralizedKIC|GeneralizedKICMover]]
* [[PeptideStubMover]]