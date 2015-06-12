#core::conformation::idealization Namespace

**This namespace no longer exists**

Ideal values for bond length, bond angles, and torsion angles.

Detailed Description
--------------------

Ideal values for bond length, bond angles, and torsion angles.

Idealization is the subset of the conformation layer used to assign ideal values for bond lengths, bond angles, and torsion angles within each amino acid.

Ideal bond angle values were determined from the paper Engh, R.A. and Huber, R., 1991. Accurate bond and angle parameters for X-ray protein structure refinement. Acta Cryst. A 47: 392-400. When available, the more accurate CNS value was used.

Each atom of an amino acid is assigned an ideal key identified by the CSD parameterization type from the Engh and Huber paper and terminus atoms are distinguished from non-terminus atoms. An ideal bond table maps ideal key pairs to ideal bond lengths. Similarly, an ideal bond angle table maps ideal key triplets to ideal bond angles. In the case of ideal torsion angles, the table consists of two collections: one which maps ideal atom key quartets to ideal torsion angles (for generic backbone torsion angle values) and one which maps amino acid key, quad key pairs to torsion angles (for non-generic backbone torsion angle values and specific sidechain torsion angle values). The lookup in these cases checks for specific values before generic values.

A call to idealize either the backbone or a specific sidechain will assign ideal values to bond lengths, bond angles, and torsion angles and tetrads in that order. (Note that the idealization of tetrads involves the conversion from an equivalent torsion angle). The positions of the atoms, however, are not updated until a refold occurs. Since the system operates under high precision, the idealization of the HIS, PHE, PRO, TRP, TYR sidechains leaves their rings in an inconsistent state and refold would detect this as an error. To avoid this situation, the idealization of those rings repairs the rings by reassigning several bond lengths and angles which idealization has made inconsistent. The current approach is simple and only intended to maintain a consistent state - it is intended that future versions of idealization will optimally adjusts the ideal ring parameters so that they are self-consistent. Note that in the current code, the reassigned values will require updating if any dependent ideal value is modified.

Finally, when refolding after idealization, an anchor point within the protein must first be established from which to refold. Currently, functions are provided to initialize the N, CA, and C atoms of either terminus to positions which match the ideal geometries.

* [[src Index Page]]: Explains the organization of Rosetta code in the `src` directory
* More namespaces in core:
  * [[core::conformation namespace|namespace-core-conformation]]
  * [[core::chemical|namespace-core-chemical]]
  * [[core::fragments|namespace-core-fragments]]
  * [[core::io::pdb|namespace-core-io-pdb]]
  * [[core::scoring|namespace-core-scoring]]
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page