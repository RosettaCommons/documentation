#core::chemical namespace

Chemical state shared as properties by all instances of atoms and molecules.

The core::chemical namespace holds the purely chemical entity representations used by Rosetta: no positional/conformational properties are included. While conceptually there could be a topological/connectivity graph of the chemical entities in a true chemical layer the lack of a use for such a layer and the implementation complexities that a layer paralleling the conformation representation bring in with C++ (e.g., a Decorator pattern approach brings in virtual/multiple inheritance) caused us to omit this layer. 

##See Also

* [[src Index Page]]: Explains the organization of Rosetta code in the `src` directory
* More namespaces in core:
  * [[core::conformation namespace|namespace-core-conformation]]
  * [[core::conformation::idealization|namespace-core-conformation-idealization]] **NO LONGER EXISTS**
  * [[core::fragments|namespace-core-fragments]]
  * [[core::io::pdb|namespace-core-io-pdb]]
  * [[core::scoring|namespace-core-scoring]]
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page