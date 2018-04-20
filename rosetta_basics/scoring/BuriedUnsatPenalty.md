# Buried Unsatisfied Penalty (buried_unsatisfied_penalty) 
Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory, on 19 April 2018.

<i>Note:  This documentation is for the `buried_unsatisfied_penalty` design-centric score term, which guides design to eliminate buried unsatisfied hydrogen bond donors and acceptors.  For information on the BuriedUnsatHbonds filter, which is useful for </i>post-hoc<i> filtering of designs with buried unsatisfied hydrogen bond donors or acceptors, please see [[this page|BuriedUnsatHbondsFilter]].</i>

[[_TOC_]]

## Purpose

This scoring term, called `buried_unsatisfied_penalty`, is intended for use during design, to provide a penalty for buried hydrogen bond donors or acceptors that are unsatisfied.  This guides design algorithms to fully satisfy or eliminate buried hydrogen bond donors and acceptors.  It can be appended to the scoring function used for design, and can be used in conjunction with other design-centric terms like the [[voids_penalty term|VoidsPenaltyEnergy]] or the [[hbnet term|HBNetEnergy]].

While the pairwise hydrogen bonding terms can encourage residue-residue hydrogen bonding, these terms cannot penalize the absence of any hydrogen bond to a given donor or acceptor.  This is because the task of determining whether a donor or acceptor is participating in zero hydrogen bonds is fundamentally non-pairwise decomposable.  The `buried_unsatisfied_penalty` is a non-pairwise scoring term that is nonetheless compatible with the packer.

## Algorithm

The `buried_unsatisfied_penalty` scoreterm uses a graph representation of hydrogen bond networks that is precomputed prior to a packing trajectory.  In this representation, nodes correspond to rotamers and edges correspond to hydrogen bonding interactions between rotamers.  Each node stores a list of hydrogen bond donors and acceptors for that rotamer, and the burial of each donor and acceptor is also pre-computed using the method of sidechain neighbours pioneered by Gabe Rocklin.  Each edge stores a list of hydrogen bonding interactions (since two rotamers may share multiple hydrogen bonds), and the donor acceptor group for each hydrogen bond is also stored in the edge.  During the pre-computation, the full hydrogen bond scoring machinery is used to ensure that the definition of a hydrogen bond matches Rosetta's definition.

At each step during a packer trajectory, a sub-graph is generated from the precomputed graph, with one node per pose position.  The sub-graph consists only of those nodes corresponding to the current rotamers being considered, and those edges connecting those nodes.  It is then a simple matter to iterate over all hydrogen bond donors and acceptors in the nodes of the sub-graph and count, based on the connected edges to that node, the number of hydrogen bonds in which that group is participating.  Once these tallies are computed, the number of groups for which the tally is zero can be determined with a second pass through the donor and acceptor groups.  Although there is some computational cost to this, it is small enough that design trajectories are still quite fast.

### Definition of a hydrogen-bonding group

For the purposes of this scoreterm, hydrogen-bonding groups consist a single polar heavyatom, and possibly one or more polar hydrogen atoms that are bonded to the heavyatom.  The heavyatom must either be able to accept hydrogen bonds, or must possess one or more protons that it can donate to hydrogen bonds.

### Precise rules for group satisfaction

In order to be satisfied:
- A group that can donate hydrogen bonds, but which cannot accept hydrogen bonds, must donate at least one hydrogen bond (regardless the number of protons in the group).  That is, an NH2 group donating a single hydrogen bond is _not_ considered unsatisfied.
- A group that can accept hydrogen bonds, but which cannot donate hydrogen bonds, must accept at least one hydrogen bond.  That is, a carbonyl oxygen that accepts a single hydrogen bond is _not_ considered unsatisfied.
- A group that can both donate and accept hydrogen bonds must _either_ donate a hydrogen bond _or_ accept a hydrogen bond.  Thus, a hydroxyl group must be involved in at least one hydrogen bonding interaction in order to be considered satisfied.

### A note about oversaturated acceptors (or donors)

The pairwise-decomposability of Rosetta's default hydrogen bond terms leads to another pathology as well: oversaturated hydrogen bond acceptors (and, occasionally, donors).  For example, one sometimes sees three protons hydrogen bonding to the same oxygen atom in Rosetta designs, and the software naïvely scores this very well.  When counting unsatisfied hydrogen bond donors and acceptors, it is trivial to simultaneously count oversaturated donors and acceptors, and to penalize these simultaneously, with next to no additional computational cost.  By default, this term penalizes both unsatisfied and oversaturated donors and acceptors.

## Usage

To use the `buried_unsatisfied_penalty` score term in design, simply follow the following steps:

1.  Turn on (reweight to a nonzero value) the `buried_unsatisfied_penalty` score term in the scorefunction used for design.  A value between 0.1 and 1.0 is recommended.  Higher values will more aggressively penalize buried unsaturated polar groups at the expense of other score terms.  Activation of the `buried_unsatisfied_penalty` score term can be done with a weights file, or in RosettaScripts as follows:

```xml
<SCOREFXNS>
	<ScoreFunction name="r15" weights="ref2015.wts" >
		<Reweight scoretype="buried_unsatisfied_penalty" weight="1.0" />
	</ScoreFunction>
</SCOREFXNS>
```

2.  Design with any mover or protocol that invokes the packer, using the scorefunction defined above.  Ensure that the task operations passed to the packer allow polar-containing residues at the relevant design positions (or there will be no buried hydrogen bond donors or acceptors, satisfied or otherwise).  [[FastDesign|FastDesignMover]] is particularly advantageous since the rounds of minimization with the softened force field can pull hydrogen bond donors and acceptors into better hydrogen bond-forming positions.

3.  (Recommended).  Perform a final round of minimization or relaxation with the `buried_unsatisfied_penalty` score term turned _off_.  This ensures that the score term is not forcing unrealistic rotamers that would not be held in place given the hydrogen bonding.

## Use with symmetry
The `buried_unsatisfied_penalty` score term is currently incompatible with symmetry, and will throw an error if applied to a symmetric pose.  Symmetry support is expected within the week. 

## Organization of the code

* The score term is defined in namespace `core::pack::guidance_scoreterms:buried_unsat_penalty`, and is located in `source/src/core/pack/guidance_scoreterms/buried_unsat_penalty/BuriedUnsatPenalty.cc/hh`.
* The score term uses a graph class that is defined in namespace `core::pack::guidance_scoreterms:buried_unsat_penalty::graph` and located in `source/src/core/pack/guidance_scoreterms/buried_unsat_penalty/graph/BuriedUnsatPenaltyGraph.cc/hh`.
* Unit tests are located in `source/test/core/pack/guidance_scoreterms/buried_unsat_penalty/BuriedUnsatPenaltyTests.cxxtest.hh` and `source/test/core/pack/guidance_scoreterms/buried_unsat_penalty/graph/BuriedUnsatPenaltyGraphTests.cxxtest.hh`.
* Symmetric unit tests are located in `source/test/core/pack/guidance_scoreterms/buried_unsat_penalty/BuriedUnsatPenaltySymmetricTests.cxxtest.hh` and `source/test/core/pack/guidance_scoreterms/buried_unsat_penalty/graph/BuriedUnsatPenaltyGraphSymmetricTests.cxxtest.hh`.

##See Also

* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[AACompositionEnergy]]
* [[AARepeatEnergy|Repeat-stretch-energy]]
* [[NetChargeEnergy]]
* [[HBNetEnergy]]
* [[AddCompositionConstraintMover]]
* [[AddNetChargeConstraintMover]]
* [[ClearCompositionConstraintsMover]]
* [[AddHelixSequenceConstraints mover|AddHelixSequenceConstraintsMover]]
* [[VoidsPenaltyEnergy]]
