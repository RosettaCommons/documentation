#Scorefunctions that work well with protein and non-protein residues and molecules

With the addition of the [[talaris2013 scorefunction | score-types]], most non-protein residues and molecules can be scored, however other scorefunctions exist that work well with protein and non-protein residues and molecules.  In July 2017, the default scorefunction was updated to the newer [[ref2015 scorefunction|Overview of Seattle Group energy function optimization project]] which has been calibrated against small-molecule liquid simulations in addition to protein crystal structures, improving performance for noncanonical scoring further.

[[_TOC_]]

## Useful scorefunctions

### MM Standard Scorefunction <a name="MM-Standard-Scorefunction" />
Creator Names:
* P. Douglas Renfrew (doug.renfrew@gmail.com)
* Bonneau Lab

Description:
* Developed to score non-canonical alpha-amino acid side chains, and used in the generation of rotamer libraries for NCAA
* Currently being used to score peptoids, and oligo-oxypiperizines (OOPs), and hydogen-bond surrogets (HBSs)
* Removes knowledge-based terms that are evaluated based on residue type identity

* *  *fa\_dun*, *rama*, *pair*, *ref*
* Adds a MM torsion and MM Lennard-Jones terms that are evaluated **intra**-residue

* *  *mm\_intra\_lj\_rep*, *mm\_intra\_lj\_atr*, *mm\_twist*
* Adds an explicit unfolded state energy term based on pdb fragments

* *  *unfolded*

Preliminary Results:
* Testing done in [Renfrew et. al., PLOS ONE 2012](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0032637)

* * rotamer libraries produced are comparable to dun02
* * rotamer recovery is comparable to score12
* * sequence recovery not as good as score12
* * 5 peptides were designed to target the calpain/calpastatin interface that had disassociation constants (Kd) less than or equal to the wild type peptide fragment
* Testing done in [Drew et. al., PLOS ONE 2013](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0067051)
* * Designed ROSIE servers to work with non-canonical backbones (NCBBs)
* Used to design 9 OOPs against he P53/MDM2 interface (Kevin Drew, to be published soon)
* * 4 OOPs had nM Kd and 4 had uM Kd and 1 did not bind

Caveats:
* Has not received as much testing as score12
* No long-range electrostatics
* Formulation of unfolded energy under-estimates the attractive component of energy function which lead to the over incorporation of large side chains

How to use:
* Flags (assuming protocol respects command-line options)
<pre>
 -score::weights mm_std
</pre>
* Weight set
 <code>mm_std.wts</code>

Note that you might also want to provide a custom weights file that turns on the **ring\_close** term, if you are working with cyclic noncanonicals (e.g. sugars).  See below for details on **ring\_close**.

###Partial Covalent Interactions Energy Function (Orbitals)
Creator Names:
* Steven Combs (steven.combs1@gmail.com)
* Meiler Lab

Description:
* Developed to score salt bridges, cation-pi, pi-pi, and hbonds more accurately
* Not typed on residue types, but on orbital types associated with atoms. Allows for extensibility to ligands and non-canonical amino acids

Preliminary Results:
* Performs as well as talaris2013 in design.
* Improves geometry of saltbridges, cation-pi, pi-pi, and hbond interactions at the acceptor/donor interface
* Works for all residuetypes (ligands, DNA, RNA) because it is typed on orbitals
* Recapitulates average number of hbonds, salt bridges, cation-pi, pi-pi interactions better than talaris2013

Caveats: 
* Slightly slower than talaris2013
* Just changed the names of all the scoreterms so that they match those in the soon to be published paper
* Adjustment of individual terms (cation\_pi, pi\_pi, hbond, salt\_bridge) is now easier by directly manipulating the respective term (pci\_cation\_pi, pci\_pi\_pi, pci\_hbond, pci\_salt\_bridge)
* Still uses the hbond backbone-backbone scfxn to score backbone-backbone interactions

How to Use:
* Flags (assuming protocol respects command-line options)
<pre>
 -score::weights orbitals_talaris2013
 -add_orbitals
 -output_orbitals (optional. Outputs the orbitals in the pdb file)
</pre>
* Weight Set

 <code>orbitals.wts </code>(for pre-talaris2013 defaults), <code>orbitals_talaris2013.wts</code>, <code>orbitals_talaris2013_softrep.wts</code> (analogous to soft_rep/soft_rep_design scorefunction but not rigorously tested)

## Useful terms that can be appended to scorefunctions

### General ring closure term (**ring\_close**)
Creator: Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory

Although not a full scorefunction itself, the **ring\_close** score term is meant to be a generalized version of the **pro\_close** term (which holds the proline ring closed during minimization).  Unlike **pro\_close**, though, which is proline-specific, **ring\_close** is intended to work with any canonical or noncanonical residue with a ring.  Since Rosetta thinks about molecules as a branching tree of atoms (the AtomTree), rings cannot be properly represented during minimization, meaning that there must be a cutpoint in any cyclic chain of atoms.  This could result in rings drifting open during minimization.  The **pro\_close** term creates a harmonic potential between proline's delta carbon and a virtual atom ("shadow atom") attached to the mainchain nitrogen.  This holds the proline ring closed.  The **ring\_close** score term does the same for any "shadow atom" and its real counterpart, on any residue type.

Shadow atoms are defined in the params file for a ResidueType with **VIRTUAL\_SHADOW** lines.  Typically, one wants to have two such lines in order to enforce closure of a ring.  For example, in the cis-ACPC params file, we have:

```
VIRTUAL_SHADOW VCM CM
VIRTUAL_SHADOW VCD CD
```

The above lines indicate that the VCM virtual atom (which is attached to the CD atom that is part of the cis-ACPC ring) is expected to "shadow", or match the position of the mainchain CM atom, and the VCD virtual atom (which is attached to the mainchain CM atom) is expected to "shadow" the CD atom.  In order to enforce this, a scorefunction with the **ring\_close** score term turned on must be used.

Note that there are three scoring terms that all enforce closure of proline: **ring\_close**, **pro\_close**, and **cart\_bonded**.  To avoid double-counting, these functions should not be used together.  The **ring\_close** term is intended for use in situations in which the minimizer can move only the torsional degrees of freedom, so that it would be unduly expensive to use the **cart\_bonded** scoring term.

Note also that **pro\_close** has two behaviours: in addition to enforcing ring closure of proline residues, it also imposes torsional constraints on the omega torsion angle of the preceding residue.  If one wishes to continue to use **pro\_close** for the latter purpose, but have **ring\_close** handle ring closure, you can disable the ring closure part of **pro\_close** with the **-score:no\_pro\_close\_ring\_closure** flag.  The two score terms, **pro\_close** and **ring\_close** should <i>only</i> be used together if this flag is set.  If **ring\_close** is given the same weighting as **pro\_close**, it enforces closure with the same strength.  More commonly, though, **ring\_close** is probably going to be used with the MM scoring function.

As a final note, there are situations in which it is not necessary to substitute **ring\_close** for **pro\_close**.  The **pro\_close** term supports L-proline, D-proline, and L- and D-oligourea-proline ("OU3\_PRO" and "DOU3\_PRO", in Rosetta).

### Residue type composition control score term (aa\_composition)
Creator: Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory

This is a specialized scoring term intended for use during design (appended to a scoring function like talaris2014 or ref2015), which penalizes deviations from a desired amino acid composition (or, more generally, residue type composition) to guide the packer to "good" sequences.  For example, a user could specify that he or she wants a sequence that's 50% hydrophobic, contains exactly 1 tryptophan residue, and has no more than 4 alanine residues.  Full documentation is available [[here|AACompositionEnergy]].

### Net charge control score term (netcharge)
Creator Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory

This score term penalizes deviations from a desired net charge during design.  Like aa\_composition, it can be appended to a scoring function like talaris2014 or ref2015.  The term can operate on the whole pose or on selected sub-regions, where the selection is controlled with a residue selector.  This allows a user to specify, for example, that a pose should have a net neutral charge, but a binding pocket with a net negative charge (-1 or less) and a protein-protein interaction region with a net charge of exactly +2.  Full documentation is available [[here|NetChargeEnergy]].

### Voids penalty score term (voids\_penalty)
Creator Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory

This score term penalizes packer solutions that have buried cavities or voids.  This is another design-centric score term that is not pairwise decomposable, but is fast to compute and fast to update during the simulated annealing search performed by the packer.  This means that it can guide the packer to packed solutions with few buried voids.  Full documentation is available [[here|VoidsPenaltyEnergy]].

### Penalty function for aspartimide-promoting sequences (aspartimide\_penalty)
Creator: Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory

This is another specialized scoring term that can be appended to an existing scoring function during design, in the special case of designing peptides for solid-phase synthesis.  It penalizes certain sequences that promote the formation of the undesirable aspartimide side-product(s) during peptide synthesis.  The penalized sequences are:

| First position | Second position |
|----------------|-----------------|
| L-aspartate    | glycine, L-threonine, L-serine, L-asparagine, or any D-amino acid residue |
| D-aspartate    | glycine, D-threonine, D-serine, D-asparagine, or any L-amino acid residue |

When weighted with a scoring weight of 1.0, the term adds a 25-point penalty for each aspartimide-promoting two-residue sequence found.  This term is pairwise-decomposable, and fully packer compatible, so it can serve as a constraint on the optimization problem that the packer solves, ensuring that it produces a low-energy sequence subject to the condition that no aspartimide-promoting subsequence is found within the sequence.  The "-score:aspartimide\_penalty\_value <float>" flag can be used to set the penalty value added for each aspartimide-promoting sequence (default 25 Rosetta energy units).  Alternatively, the weight on the term can be used to set the penalty.

### Bonus function for hydrogen bond networks (hbnet)
Creator:  Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory

This is another specialized scoring term that can be appended to improve designs.  This score term adds a bonus (_i.e._ a negative value) for networks of hydrogen-bonded residues, with the size of the bonus scaling quadratically with the size (_i.e._ number of residues in) the network.  Although detecting networks is a fundamentally non-pairwise-decomposible problem, this score term is compatible with the packer, and can guide any design protocol that invokes the packer towards solutions with hydrogen bond networks.  Full documentation is available [[here|HBNetEnergy]].

### Penalty function for repeat sequences (aa\_repeat)
Creator:  Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory

The [[`aa_repeat`|Repeat-stretch-energy]] score term can be turned on during design to penalize repeats of more than two of the same residue type.  This is particularly useful when designing proteins or peptides whose structures are to be solved by NMR spectroscopy, since repeat sequences make assignments very difficult.  The score term is fundamentally non-pairwise-decomposible, but is packer-compatible, so it guides the design process to solutions lacking repeat sequeces.  Full documentation is available [[here|Repeat-stretch-energy]].

##See Also

* [[Scoring explained]]
* [[Score terms and score functions|score-types]]
* [[Additional score terms|score-types-additional]]
* [[Hydrogen bond energy term|HBNetEnergy]]
* [[AARepeatEnergy|Repeat-stretch-energy]]
* [[AACompositionEnergy]]
* [[VoidsPenaltyEnergy]]
* [[Guides for non-protein inputs|non-protein-residues]]
* [[Scoring options|score-options]]
* [[Design-centric guidance terms|design-guidance-terms]]
