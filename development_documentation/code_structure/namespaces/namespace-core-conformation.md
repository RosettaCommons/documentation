#core::conformation namespace

Geometric information about individual molecular structures. 

Namespaces
----------

[[idealization|namespace-core-conformation-idealization]] Ideal values for bond length, bond angles, and torsion angles.

Detailed Description
--------------------

Geometric information about individual molecular structures.

The conformation layer contains the topological and positional representation of molecular structures and the logic necessary to update the positions when conformational changes have been made. The conformation layer does not represent the logic for making conformational changes ("moves") to achieve a goal or evaluating the energy of a conformation.

Conformation objects use named keys for identification and lookup in key-indexed containers. This makes code more readable, eliminates the need to know the index numbers that correspond to an object type, and insulates the code from changes or additions to the list of types. Key collections hold fixed keys of each type. The Key collections can be extended easily: New keys can be added anywhere in the key lists and the lists can be rearranged without breaking applications.


##See Also

* [[src Index Page]]: Explains the organization of Rosetta code in the `src` directory
* More namespaces in core:
  * [[core::chemical namespace|namespace-core-chemical]]
  * [[core::conformation::idealization|namespace-core-conformation-idealization]] **NO LONGER EXISTS**
  * [[core::fragments|namespace-core-fragments]]
  * [[core::io::pdb|namespace-core-io-pdb]]
  * [[core::scoring|namespace-core-scoring]]
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page