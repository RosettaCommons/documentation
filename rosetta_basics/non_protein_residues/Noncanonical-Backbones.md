# Working with noncanonical backbones in Rosetta
Documentation added by Andrew Watkins (XRW3), adapted in part from a protocol capture from Renfrew et al. (2012).

Summary
==================
Using specialized movers and protocols, Rosetta can sample the conformations of peptidomimetic polymers with geometry similar enough to peptides to be covered using the same sorts of movers.
These protocols are not broadly intercompatible, and the dock-design protocols largely rely on starting from a good conformation, meaning that external knowledge can be helpful.

Peptoids
==================
The peptoid structures used in Rosetta are typically cyclized (and this linkage can be maintained by the CyclizationMover), but the backbone geometry is only rigorously sampled for linear peptoids, which are harder to structurally resolve in the first place (the RandomTorsionMover and RandomOmegaFlipMover are good choices).
Peptoids can be repacked, docked, and designed using the peptoid_design app and separate docking protocols or via RosettaScripts.

Oligooxopiperazines
==================
Ordinary sequences of amino acids can be transformed into oligooxopiperazines by adding the relevant patches using the OopCreatorMover (or the oop_creator application).
In particular, with either the application or the mover you can specify which OOP rings ought to have the "plus" and which the "minus" ring conformer."
Subsequently, they can be designed in a fixed context with the oop_design application or in a dock-design-minimize protocol using the oop_dock_design application or OopDockDesignProtocol mover.

Hydrogen Bond Surrogate helices
==================
Ordinary sequences of amino acids can be transformed into hydrogen bond surrogate helices by adding the relevant patches at the n-terminal first residue and the third residues using the HbsCreatorMover (or the hbs_creator application).
Subsequently, they can be designed in a fixed context with the hbs_design application or in a dock-design-minimize protocol using the hbs_dock_design application or NcbbDockDesignProtocol mover.
In principle, the NcbbDockDesignProtocol can actually be used to do dock-design simulations of arbitrary combinations of oligooxopiperazines, beta amino acids, peptoids, alpha amino acids, and even HBS constraints.
The specific levels of sampling necessary, given that such a composite peptidomimetic has never been synthesized, let alone crystallized, cannot be precisely determined, but it's a safe bet to substantially increase the number of dock-design loops and individual perturbations for large, complex peptidomimetics.

Beta Peptides
==================
Beta amino acids have an extra mainchain carbon atom.
Beta-3 amino acids have the side chain coming off the beta carbon, while beta-2 amino acids have the side chain coming off the alpha carbon.
The latter are considerably harder to synthesize and thus yet integrated into Rosetta, while beta-3 amino acids are well studied. 
The beta_peptide_modeling application can model all-beta complexes using specialized scoring functions, and in principle they can be used with any Rosetta application so long as any explicit backbone moves account for the extra mainchain torsion (so RandomTorsionMover is superior to SmallMover in this capacity).
