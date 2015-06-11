#rosetta::scoring Namespace Reference

Energy functions and scoring methods for computing acceptability of decoys.

Detailed Description
--------------------

Energy functions and scoring methods for computing acceptability of decoys.

The scoring layer contains the energy function objects (functors) and the scoring method functors that compute weighted sums of energies (scores). The energy and scoring functors live in Strategy pattern hierarchies with abstract interfaces to provide decoupling between their calling clients and the concrete methods, providing a "pluggable" design that makes the addition of new functions and the modification of existing functions simple and with a low recompilation burden.

The scoring layer is designed to depend on the conformation and chemical layers but not on optimization or any protocol-specific layers.

##See Also

* [[src Index Page]]: Explains the organization of Rosetta code in the `src` directory
* [[Scoring explained]]: Explanation of scoring in Rosetta
* [[Score types]]: Description of Rosetta score functions and score terms
  * [[Additional score types|score-types-additional]]
* More namespaces in core:
  * [[core::chemical|namespace-core-chemical]]
  * [[core::conformation namespace|namespace-core-conformation]]
  * [[core::conformation::idealization|namespace-core-conformation-idealization]] **NO LONGER EXISTS**
  * [[core::fragments|namespace-core-fragments]]
  * [[core::io::pdb|namespace-core-io-pdb]]
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page