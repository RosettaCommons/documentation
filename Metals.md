# Working with metalloproteins in Rosetta#
Documentation by Vikram K. Mulligan, Baker Laboratory (vmullig@uw.edu)
Created 13 March 2014

## Usage cases
In general, there are broad types of task that a user might want to do with a metalloprotein:
* Carry out _de novo_ design of a metal-binding center in a protein.  This is best done with the enzyme design geometric constraints files, which are [described elsewhere](http://koblet.med.unc.edu:1235/docs/rosetta_basics/match-cstfile-format).
* Import a PDB file and do something to it (_e.g._ design a binder, redesign a loop, relax the structure, _etc._).  This documentation is intended for this case.