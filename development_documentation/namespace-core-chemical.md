<!-- --- title: Namespacerosetta 1 1Chemical -->rosetta::chemical Namespace Reference

Chemical state shared as properties by all instances of atoms and molecules. [More...](#details)

Detailed Description
--------------------

Chemical state shared as properties by all instances of atoms and molecules.

The [u'rosetta::chemical'] namespace holds the purely chemical entity representations used by Rosetta: no positional/conformational properties are included. While conceptually there could be a topological/connectivity graph of the chemical entities in a true chemical layer the lack of a use for such a layer and the implementation complexities that a layer paralleling the conformation representation bring in with C++ (e.g., a Decorator pattern approach brings in virtual/multiple inheritance) caused us to omit this layer. At this point the chemical layer contains just the element and compound atom types.

How to add a new type of element or compound Atom:

1.  Add the AtomKey entry for the Atom in AtomKeys.hh/.ii
2.  Add the entry for that Atom in the PeriodicTable constructor in PeriodicTable.ii/.cc. Make sure that the same AtomKey is used as the PeriodicTable key and the the first argument to the Atom\_ constructor.

 Note   
You can safely add new Atom types in the middle of the lists.

The order of the AtomKey entries in the AtomKeys and PeriodicTable files need not be consistent for program correctness but is a good idea.


