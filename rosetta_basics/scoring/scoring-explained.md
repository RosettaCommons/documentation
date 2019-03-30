An introductory tutorial on how to score biomolecules using Rosetta can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/scoring/scoring). This page is intended to be broadly useful for understanding how Rosetta scores macromolecule conformations.


## Necessary classes ##

### EnergyMethod ###

An energy method is the workhorse of scoring in Rosetta.

One EnergyMethod can map to multiple ScoreTypes.  For example, the [[hydrogen bonding EnergyMethod|hbonds]] maps to several [[score types]] including hbond_sr_bb, hbond_lr_bb, hbond_bb_sc, and hbond_sc.

* `EnergyGraph`: Stores the inter-residue energies for interacting residue pairs.

* `EnergyEdge`: Each edge stores interactions for an individual pair of residues

* `EnergyMap`: Maps score types to their values

* `ScoreFunction`: The main class responsible for scoring a Pose. 

##EnergyMethod-related definitions

* **One-body energies**: Intra-residue energies. These are stored separately from the EnergyGraph.

* **Two-body energies**: Inter-residue energies evaluated between pairs of residues. These are stored in the EnergyGraph.

* **Whole structure energies**: These energies apply to (you guessed it) the whole structure.

* **Context dependent**: The energy for a residue or pair of residues depends on the conformation of surrounding residues. For example, the strength of a [[hydrogen bond|hbonds]] between two residues depends on the number of neighbors each residue has.

* **Context independent**: The energy for a residue or residue pair does not depend on the surroundings (e.g. the Lennard-Jones energy).

* **Short range**: There is some distance cutoff beyond which this energy is considered to be zero (i.e. the energy is not evaluated between two residues unless they are within this distance cutoff).  For example, [[hydrogen bonds energies|hbonds]] are short range.

* **Long range**: There is no distance cutoff; the energy is evaluated for all applicable pairs of residues.  They are typically only evaluated between certain pairs of residues (e.g. [[AtomPairConstraints|constraint-file]]

##EnergyMethods Hierchy

###One Body Energies

####Context-independent one body energies

####Context-dependent one body energies

###Two Body Energies

####Short-range two body energies

######Context independent short-range two body energies

######Context-dependent short-range two body energies

####Long-range two body energies

######Context independent long-range two body energies

######Context-dependent long-range two body energies

###Whole Structure Energies

##Overview of the scoring algorithm

1. Determine which energies will need to be rescored:
   1. For pairs of residues that have moved with respect to each other, drop the EnergyEdge for that pair from the EnergyGraph (those energies need to be re-evaluated).
   2. Detect which pairs of residues are near each other (within the cutoff for short range two body energies)
   3. For pairs of residues which a) are within the distance cutoff and b) the distance between them has changed, add an edge for that pair to the EnergyGraph.
2. For each pair of residues, evaluate the *short range* energies:
   1. Score context-dependent two-body energies
   2. If the residues have moved with respect to each other, score the context-independent two-body energies
3. For each residue:
   1. Score context-dependent one-body energies
   2. If the residue has had internal DOF changes (e.g. if its side chain has been repacked), score context-independent one-body energies
4. Score the long-range two-body energies if they are context-dependent and/or if the residues have moved with respect to each other.
5. Score the whole-structure energies



##See Also

* [Scoring Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scoring/scoring)
* [[Rosetta overview]]
* [[Units in Rosetta]]: Gives a description of Rosetta energy units
* [[Score functions and score terms|score-types]]
* [[Additional score terms|score-types-additional]]
* [[Design-centric guidance terms|design-guidance-terms]]
* [[Hydrogen bond energy term|hbonds]]
* [[AACompositionEnergy]]
* [[Scorefunctions for noncanonical residues and molecules|NC-scorefunction-info]]
* [[Adding new score terms|new-energy-method]]
