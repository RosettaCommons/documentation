# Design-centric guidance terms

Page created by Vikram K. Mulligan (vmullig@uw.edu) on 27 December 2017.

[[_TOC_]]

## Design-centric guidance terms

Traditionally, Rosetta's scoring function has been thought of as a function intended to approximate the conformational energy of a protein or other macromolecule.  While this is appropriate for structure prediction, it is not necessarily the most useful paradigm for design.  There are two reasons for this.

First, although structure prediction aims to find the lowest-energy conformation given a sequence, design is _not_ the inverse problem: simply finding the sequence that minimizes the energy of a desired conformation will not necessarily work.  This is because such a sequence could very well have alternative conformations that are isoenergetic, or even lower in energy.  Although design algorithms, such as the packer, seek to find a sequence that minimizes the energy of the designed conformation, ideally we _want_ to find the sequence that maximizes the energy _gap_ between the designed conformation and all alternative conformations.  Doing this explicitly is generally not possible due to the computational expense of considering astronomical numbers of alternative conformations during design.  We will see how one can do this implicitly, though.

Second, often a designer does not have the simple goal of designing for folding alone.  Instead, he or she likely wants to design for some set of functions in addition -- binding, catalysis, assembly into quaternary structures, evasion of the immune system, resistance to proteases, ease of expression, ease of study, ease of chemical synthesis, _etc_.  Single-mindedly optimizing the conformational energy fails to permit other desired properties to be optimized.

Historically, both problems were addressed by a guess-and-check approach, in which energies were exclusively optimized during design and then desired features were selected for in an after-the-fact filtering step.  Folding propensity would be evaluated last, based on _ab initio_ structure prediction.  This, of course, was an inefficient process that resulted in many designs being discarded, and even the designs that passed filters and _ab initio_ forward folding were often poorly optimized for the non-energetic features of interest.  Fortunately, both problems may be better addressed by altering the function that the packer optimizes during design.  Rather than simply optimizing a sum of energetic terms, we can optimize a sum of energetic terms _plus_ a sum of guidance terms.  These guidance terms allow a designer to impose additional constraints on the design process.  For example, he or she might impose prior knowledge (_e.g._ about amino acid composition or structural features that promote folding) that will guide the packer to solutions more likely to have a large energy gap.  Alternatively, he or she might impose requirements about features that do _not_ aid folding but which are required for production, experimental characterization, resiliancy in the environment in which the design must function, or desired function.

This page summarizes the design-centric guidance terms that are available in Rosetta.

## A note about pairwise-decomposability

Historically, the Rosetta energy function was required to be residue-level pairwise decomposable in order to be compatible with the packer.  This meant that it was a sum of energy terms, each of which was a sum of pairwise interaction energies between pairs of residues.  Although this limited its physical realism (preventing, for example, the medium between two residues involved in an electrostatic interaction from being considered explicitly), it made the energy function very fast to evaluate and faster still to update when a single residue substitution was made by the packer: rather than re-evaluating the whole energy function, the packer needed only to update those terms involving the altered residue.  Better still, pairwise interaction energies for every possible pair of residues could be computed in a precalculation, allowing a substitution during a packer trajectory to be handled by a very fast table lookup.  This allowed the packer to consider millions of substitutions over the course of a simulated annealing trajectory.

However, there exist many conceivable guidance terms that are _not_ pairwise-decomposible, but which are nonetheless fast to compute and fast to update.  One example would be a term penalizing deviation from a desired amino acid composition.  Such a term would need to count the number of amino acids of each type, determine the difference from the desired counts, and impose a penalty based on that difference -- a calculation which is fast, but which cannot be decomposed into terms based on pairs of residues.  Alex Ford and Vikram Mulligan worked to alter the packer to allow it to accept non-pairwise terms provided they could be computed quickly or updated quickly on the fly during a packer trajectory.

## User control

Typically, guidance terms can be turned on by reweighting them to non-zero weights.  This can be accomplished either by providing a custom weights file (```.wts``` extension) or by reweighting terms at scorefunction declaration in [[RosettaScripts|RosettaScripts#scorefunctions]] or PyRosetta.  Certain guidance terms, such as ```aa_composition``` and ```netcharge``` have additional options that can be set at scorefunction declaration or by appending data to a Pose using special movers, and these are described in the documentation for these guidance terms.

## Typical usage and best practices

Guidance terms are best used during design steps in a protocol, especially with protocols like [[FastDesign|FastDesignMover]] which include alternating rounds of packing and minimization.   A given guidance term might coax the packer into accepting rotamers that it would otherwise have rejected due to small steric clashes that can be relieved during minimization.  However, the relative weight given to each guidance term determines the extent to which it influences the design process.  If the weight is too low, a guidance term might have very little effect.  If it is too high, on the other hand, it might promote the desired feature at the expense of reasonable geometry, resulting in worse designs.  There is typically an intermediate range over which a guidance term improves design.  Optimizing the weights given to different guidance terms is a trial-and-error process that depends on the particular design problem.

It is recommended that, following design, each design be subjected to a round of relaxation (_e.g._ using the [[FastRelax mover|FastRelaxMover]] with the standard energy function, _without_ added guidance terms, in order to ensure that the guidance terms have not resulted in undesirably strained geometry due to over-weighting.  Applying the same filters that would have been applied in the absence of the guidance terms is also recommended: if the terms are weighted properly, they should result in a much higher rate at which filters pass.

## Available guidance terms in Rosetta

Currently, the following guidance terms are available in Rosetta:

| Name in weights file (Class name)        | Description | Pairwise-decomposible? |  Differentiable? |
| ---------------------------------------- | ----------- | ---------------------- | ---------------- |
| aa_composition ([[AACompositionEnergy]]) | A guidance term that penalizes deviation from a user-defined desired amino acid composition in a pose or sub-region selected by a residue selector.  This allows a user to apply prior information about the amino acid composition likely to promote folding (_e.g._ discouraging too many alanine residues in a core), needed for expression (_e.g._ discourage too many methionine residues to avoid alternative AUG start sites), or needed for function (_e.g._ promote 50/50 polar/hydrophobic composition in a binding interface).  Desired composition can be set by residue type and/or by properties. | No. (Term is packer-compatible, though). | No -- no spatial derivatives possible.  (Term is disregarded by minimizer.) |
| aa_repeat ([[AARepeatEnergy|Repeat-stretch-energy]]) | A term that discourages repeat sequences.  Useful for designing when structural characterization is to be carried out by NMR spectroscopy, since repeat sequences are difficult to assign. | No.  (Term is packer-compatible, though). | No -- no spatial derivatives possible.  (Term is disregarded by minimizer.) |
| aspartimide_penalty ([[AspartimidePenaltyEnergy|NC-scorefunction-info#useful-terms-that-can-be-appended-to-scorefunctions_penalty-function-for-aspartimide-promoting-sequences-aspartimide_penalty]]) | A term that discourages pairs of residues adjacent in linear sequence that promote formation of undesirable aspartimide side-products during peptide synthesis.  Useful when designing molecules to be synthesized chemically. | Yes. | No -- no spatial derivatives possible.  (Term is disregarded by minimizer.) |
| approximate_buried_unsatsified_penalty ([[ApproximateBuriedUnsatPenalty]]) | A term that approximately penalizes buried unsatisfied hydrogen bond donors and acceptors during design.  See page for more details | Sort-of.  (Performs an N-body precalculation, but then decomposes into two-body and one-body terms). | No. |
| buried_unsatisfied_penalty ([[BuriedUnsatPenalty]]) | A term that penalizes buried unsatisfied hydrogen bond donors and acceptors during design.  This complements the `hbnet` term, below. | No.  (Term is packer-compatible, though). | No.  (Spacial derivatives are possible, but not yet defined.  Term is currently ignored by minimizer.) |
| hbnet ([[HBNetEnergy]]) | A term that promotes hydrogen bond networks during design through a nonlinear bonus based on the size (_i.e._ number of residues in) each network.  A complementary approach to Scott Boyken's [[HBNetMover]]. | No.  (Term is packer-compatible, though). | No.  (Spacial derivatives are possible, but not yet defined.  Term is currently ignored by minimizer.) |
| mhc_epitope ([[MHCEpitopeEnergy]]) | A scoreterm to penalize immunogenic sequences.  A number of configuration options allows different de-immunization approaches to be used. | No. (Term is packer-compatible, though). | No -- no spatial derivatives possible.  (Term is disregarded by minimizer.) |
| netcharge ([[NetChargeEnergy]]) | A term to penalize deviation from a user-defined desired net charge in a whole pose or sub-region selected by a residue selector.  Multiple net charge constraints can be specified. | No.  (Term is packer-compatible, though). | No -- no spatial derivatives possible.  (Term is disregarded by minimizer.) |
| voids_penalty ([[VoidsPenaltyEnergy]]) | A term to penalize voids or holes in the core during packing, promoting voids-free design solutions.  Much of the computational expense is handled in a precalculation. | No, through trivially so (due to squaring a sum of terms).  Fully packer-compatible, however. | No, though spacial derivatives might be implemented in the future.  For now, this term is ignored by the minimizer. |

##See Also

* [[Scoring explained]]
* [[Score types]]
* [[Centroid vs fullatom]]
* [[Scorefunction history]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[AACompositionEnergy]]
* [[AARepeatEnergy|Repeat-stretch-energy]]
* [[NetChargeEnergy]]
* [[AddCompositionConstraintMover]]
* [[AddNetChargeConstraintMover]]
* [[ClearCompositionConstraintsMover]]
* [[AddHelixSequenceConstraints mover|AddHelixSequenceConstraintsMover]]
* [[HBNet mover|HBNetMover]]
* [[VoidsPenaltyEnergy]]
* [[MHCEpitopeEnergy]]
* [[mhc-energy-tools]]
* [[AddMHCEpitopeConstraintMover]]