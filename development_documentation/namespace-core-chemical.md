#core::chemical namespace

Chemical state shared as properties by all instances of atoms and molecules.

The core::chemical namespace holds the purely chemical entity representations used by Rosetta: no positional/conformational properties are included. While conceptually there could be a topological/connectivity graph of the chemical entities in a true chemical layer the lack of a use for such a layer and the implementation complexities that a layer paralleling the conformation representation bring in with C++ (e.g., a Decorator pattern approach brings in virtual/multiple inheritance) caused us to omit this layer. 