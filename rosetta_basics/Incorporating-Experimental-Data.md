#Incorporating Experimental Data

Potentially useful experimental data takes many forms.
The very nature of Monte Carlo simulation strongly supports the incorporation of any type of experimental constraint, because all you need it to do is allow it to influence the distribution of generated structures. 

##Constraints vs. Restraints
Rosetta calls _constraints_ what other computational packages refer to as _restraints_.
In Rosetta, a constraint does not fix a degree of freedom and remove it from sampling and scoring.
Rather, we are adding a scoring term that penalizes deviations from particular values of that degree of freedom.
Restraints have no particular name - it's just making sure that degree of freedom is not free, for example in a [[MoveMap|Glossary#movemap]].

## Input structures

Truly, the largest experimentally derived sampling bias to a biological problem is any input structures that might be available.
After all, you are using those structures precisely because you trust them enough _not_ to want to perform _ab initio_ structure prediction, so you want the bias that starting from them provides.
At the same time, input structures are not perfect:
* Crystal structures are of variable resolution and frequently lack hydrogens.
* Crystal structures are of shockingly high quality variation within a single structure.
* At the resolution where hydrogens cannot be visualized (at least 90% of the PDB) asparagine and glutamine oxygens and nitrogens cannot be distinguished from each other (ditto histidine tautomers) and are frequently misassigned.
* NMR structures are frequently resolved via a few hundred constraints, rather than the thousands upon thousands in crystal structures.

Most of all, the force fields used in these optimization efforts are arithmetically and algorithmically distinct from the Rosetta energy function.
It is critical to obtain structures that are geometrically similar to the starting structure but that exist closer to a local minimum of the scoring function.
This is important because every unit of strain energy in your starting structure can inappropriately bias sampling: bad moves can be accepted that would otherwise have been rejected because they relieve strain that already should have been addressed.
There is a [[complete write-up|preparing-structures]] of preparing starting structures appropriately.

## Specialized Rosetta executables

Rosetta has individual modules to handle particular forms of experimental constraint:

* [[mr_protocols|mr-protocols]] is typically used _alongside_ Phaser; it uses Rosetta's comparative modeling to rebuild gaps and insertions in the template, as well as missing density, from fragments, followed by relaxation with constraints to experimental density.
You can then use Phaser again to re-score against crystallographic data.
* [[ERRASER]] refines RNA structures from electron density (crystallographic data); it constitutes a workflow of _erraser_minimize_, _swa_rna_analytical_closure_, and _swa_rna_main.
It requires the use of the refinement program PHENIX.
* [[loops from density|loops-from-density]] is a script to take badly fit electron data and a cutoff suggesting how much of the pose you're willing to rebuild and to generate input "loops" files for loop modeling. 
* [[Chemical shift files|chemical-shift-file]] provide data to a variety of protocols often collectively referred to as CSROSETTA that incorporate NMR constraints to refine structures

## Experimental constraints  

Frequently, you will encounter situations where you have knowledge about the experimental system that does not neatly fit into any of the above situations, or which provides very sparse or even conflicting information.
This is all right: Rosetta's capacity for [[working with constraints|constraint-file] will help to encode these sorts of weak information.
In particular:
* AmbiguousNMRDistance constraints encode distances between two atoms; importantly, rotationally equivalent/experimentally indistinguishable hydrogens are not distinguished.
* SiteConstraint constraints penalize or reward the proximity of a residue in one chain to another chain.
	* Internally, these operate as AmbiguousConstraints (discussed below) wrapping AtomPair constraints
	* A subtype called SiteConstraintResidues constrains that a residue be near at least one of two other residues
	* FabConstraint penalizes the presence of non-CDR H3 loop residues at an antibody-antigen interface
* BigBin constraints allow you to place broad requirements on residue conformations (for example, you may specify any residues known to have cis dihedrals or to be near left handed helix conformations).
So, if you know that a residue has a large ddG upon mutation to alanine, you can probably apply a correspondingly large SiteConstraint to require that it be in the binding site.
(Though, notably, you may not want it to have the same magnitude as the ddG.)
* You can group constraints in a number of ways to accomodate mutually inconsistent data:
    * An AmbiguousConstraint only applies the lowest energy penalty of several constraints.
Thus, if you know that two distant residues both ought to have a SiteConstraint applied, but they can't both bind at once, wrap them in an AmbiguousConstraint and you'll only evaluate the one your pose best satisfies.
    * Similarly, a KofNConstraint will apply the lowest k of n constraints.
* You may simply have a limited amount of structural information that you need to encode without the formality of using an NMR structure solution module.
(For example, your experimental collaborator knows that some NOE data suggests that a given residue is helical or otherwise that two atoms within the structure are proximal, but doesn't necessarily have data for you).
    * Encode these as AtomPairConstraints and DihedralConstraints.
	You may want to evaluate multiple possible well widths/flexibilities for the corresponding functions for those constraints.

Remember that in these situations you are using constraints to _improve your sampling_.
You are facing a titanic, terrifying configuration space and a number of structures that is, in comparison, pitiably small.
Your aim is to enrich your nstruct as best you can with the _true_ free energy minimum (because we assume the experimental data is largely good).
This means that the structures that come out of your protocol should be fairly robust.
Suppose you have a small set of good-scoring decoys that come out of your protocol.
You should be able to apply the same sampling protocol to those good-scoring decoys _without the constraints_ and the structure should not "blow up."
Heuristics for determining the precise meaning of "blowing up" are case-dependent, but it is essential that you remove constraints and observe the behavior of your putative "good models." 

##See Also

* [[I want to do x]]: Guides to specific types of structural perturbations using RosettaScripts
* [[Resources for learning biophysics and computational modeling]]
* [[CS-Rosetta]]: Uses RNA chemical shift data with Rosetta for structure prediction
* [[Solving a Biological Problem]]
* [[Getting Started]]: A page for people new to Rosetta 
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
