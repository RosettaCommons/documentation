Author: Jeliazko Jeliazkov and Andrew Watkins 

[[_TOC_]]

#Types of Biological Problems

**Note: others should feel free to add in their expertise to this article.**

There are many biological problems which can be approached with Rosetta. 
These topics often stem from the central idea that **sequence** confers **structure** which in turn confers **function**.
For example, Rosetta was initially utilized for _de novo_ protein structure prediction (sequence->function), while current applications can be as extensive as enzyme design (structure->function).

Generally speaking (for most biological problems), the computational challenges faced are two-fold. 
First, can we adequately sample the space where the solution to our problem lives.
Second, can we identify said solution, if we have sampled it.
This should be kept in mind when deciding on which protocol to apply to your problem, how many models to generate, and which score function to use.

## Protein Structure Prediction

The general question to be answered below: given a sequence, can I predict the protein structure?
There are two approaches to predicting protein structure from sequence alone: _de novo_ and comparative or homology modeling.
There are also other, more specialized, approaches for particular tasks such as antibody homology modeling, symmetric homooligomer modeling, and membrane protein modeling.

### De Novo Modeling

_De novo_ structure prediction is useful when modeling a protein with low homology. 
In the _de novo_ algorithm, the protein sequence is initiated in an extended conformation and "folded" by changes in phi/psi angles sampled from n-mer fragment libraries.
_De novo_ structure prediction is accurate when modeling a small (<100 residues), globular protein.

See: [[Ab initio|abinitio-relax]].

### Comparative Modeling (Homology Modeling)

Comparative modeling on the other hand tends to be successful when the target sequence (sequence of interest) has a high degree of sequence homology (>50%) with a protein whose structure has been determined.

See: [[Comparative Modeling|minirosetta-comparative-modeling]] (potentially out of date) and [[Comparative Modeling via RosettaScripts|http://www.ncbi.nlm.nih.gov/pubmed/24035711]] (uses RosettaScripts) for more information.

### Specialized Protocols

* [[Symmetric folding and docking of homooligomeric proteins.|fold-and-dock]]
* [[Homology modeling of antibody variable fragments.|antibody-protocol]]
* [[Ab initio modeling of membrane proteins.|membrane-abinitio]]

## Protein–Protein Docking

Another general question which can be interrogated by Rosetta is: given protein A and protein B, can I generate a plausible model for protein–protein interactions?
This problem can be conflated with the protein structure prediction problem when the structure of either protein A, protein B, or both are unknown.
Protein flexibility can play a role in protein docking by increasing the degrees of freedom. 
For example, high RMSD between the bound and unbound states makes prediction of the bound state from the unbound states difficult. 
On the other hand, biochemical information can be implemented as constraints [[(see below)|Solving-a-Biological-Problem#Incorporating-Experimental-Data]] in the scoring function during docking to (hopefully) improve model accuracy.

In general, there are three types of docking: global, local, and local refine. 
These are all run via the [[docking protocol|docking-protocol]], but differ in flags.

**Global docking** entails a random initial placement of both partners, a low-resolution centroid phase with (relatively) large rigid-body translations, and a high-resolution, full-atom phase with smaller perturbations and side-chain repacking/minimization.

**Local docking** is identical to global docking except the initial placement of the partners is not random thereby ensuring that interactions are sampled about the initial configuration.

**Local refinement docking** only uses the high-resolution, full-atom phase.

See the [[docking protocol|docking-protocol]] for more information on how to run a docking simulation.
**Note:** side-chains should be [[pre-packed|docking-prepack-protocol]] prior to docking to globally minimize side-chain energies since docking only packs side-chains at the interface.

### Docking Two Partners With Known Structures

In this case, (near) atomic-resolution structures have been determined for both interacting partners. 
The structures should be prepared for docking in the standard manner (see [[preparing structures|preparing-structures]], [[pre-packed|docking-prepack-protocol]]).
The [[docking protocol|docking-protocol]] would then search for the complex structure with minimal energy.

Docking can emulate several biophysical models of protein–protein interactions which are enumerated below.

#### Docking According to the Lock and Key Model

The lock and key model assumes that proteins interact in a rigid fashion; two proteins must have shape complemenetarity to interact.
Assuming the two protein partners are not expected to have backbone motions upon binding, the problem can be approached with rigid-backbone docking.

#### Docking According to the Conformer Selection Model

Under the conformer selection model, proteins are viewed as a statistical ensemble of conformations including the bound and unbound conformations of each partner.
For the bound complex to form, the bound conformations of each partner must encounter each other. 
To computationally model this behaviour, an ensemble of structures can be generated for that partner (or both) using the [[relax protocol|relax]]. 
To be useful for docking, an ensemble of structure should not deviate further than one Angstrom RMSD from the initial model.
These ensembles of structures can be sampled during the docking protocol.

#### Docking According to the Induced Fit Model

The induced fit model offers an alternative to the prior two models.
Induced fit holds that upon an encounter, proteins mutually affect each other.
This is computationally modeled by minimizing backbone degrees of freedom (in addition to the typical minimization of side-chain degrees of freedom) in the high-resolution phase of the docking protocol.
As of June 9th, 2015, there is a `-bb_min_res` flag which can be used to specify residues with backbone degrees of freedom during minimization, but backbone minimization during docking has not been thoroughly tested.

#### Docking According to the Conformer Selection and Induced Fit Model

This is simply a combination of the prior two models.
Computationally, an ensemble of structures and backbone minimization are both implemented.

### Docking Two Partners Where One Structure Is Unknown

This problem is slightly more complicated and more difficult.
Results are less accurate due to the added necessity of homology or _de novo_ modeling one protein.
The best approach is to input an ensemble of models for the protein of unknown structure.
There is a caveat as ensemble docking swap models according to the Metropolis criterion and so the ensemble cannot have too much diversity or else it will be utterly useless.

### Docking Two Partners With Two Unknown Structures 

Plausible, but this is **not recommended**. 
Success would be extremely unlikely due to the large amount of sampling needed to (A) accurately model one partner, (B) accurately model the other partner, and (C) accurately model the interaction between the two partners.

### Docking Homooligomers

[[Symmetric Docking|sym-dock]] is useful for assembling multiple subunits according to a specific symmetry defined in a [[symmetry file|make-symmdef-file-denovo]].

## Protein–Peptide Docking

Protein–peptide docking is useful for determining the structure of a short, flexible peptide in the context of a receptor.
Rosetta has [protein–peptide docking](application_documentation/flex_pep_dock) methods that work best starting from an approximate model with a starting position near to the peptide–binding site; within five Angstroms backbone RMSD is ideal.
Thus, it is not generally tractable to concurrently sample peptide conformations and all the possible binding sites on the surface of the protein.
Rosetta also has the capacity to sample conformations of peptidomimetic molecules, such as oligooxopiperazines, hydrogen bond surrogate helices, stapled peptides, peptoids, beta peptides, and more.

## Protein–Ligand Docking 

Can I predict how a small molecule will interact with my protein? 
As with protein–protein docking, the better your initial structures are, the more likely you are to produce an accurate model (see above).
[[RosettaLigand|ligand-dock]] or [[RosettaLigand via RosettaScripts||http://dx.doi.org/10.1007%2F978-1-61779-465-0_10]] can be used to predict protein–ligand interactions.
RosettaLigand run via the executable (is currently outdated).
It is preferred to dock ligands via RosettaScripts. 
An alternative method, is to use [[Docking Approach using Ray Casting (DARC)|DARC]]. 
Unlike RosettaLigand, which explores protein–ligand interactions in a biological manner via translations and rotations (correct me if this is wrong), DARC evaluates the shape complementarity of a ligand for a pocket on the protein surface.

## Protein Design

While protein structure prediction seeks to identify low energy structures in space, protein design seeks to identify amino acid identities in sequence space.
Protein design can be used to study both how sequence confers structure (i.e. predicting the amino acid sequence of a given fold) or how structure confers function (i.e. predicting the amino acid sequence for a given function).
Due to the breadth of these challenges, protocols are either specific or custom generated using one of the [[Rosetta scripting interfaces|Scripting-Documentation]].


### Protein Redesign

One could envision a simple design problem where they seek to stabilize a known protein structure.
A reasonable assumption to make is that there will not be large changes in protein fold.
Hence, this problem is approached with [[fixed backbone design|fixbb]] where side-chain amino acid identities are sampled to identify those which minimize energy on the current backbone. 
Further, if design is yield an amino acid sequence favoring hydrophobic residues then [[fixed backbone design can be run with consideration of hydrophobic surface patches|fixbb-with-hpatch]].
However, new score functions have limited this problem.

Other design problems of interest may include: 
- scanning for [[stabilizing point mutations|pmut-scan-parallel]], 
- specificity prediction and library design with [[sequence tolerance|sequence-tolerance]]
- [[multistate design|mpi-msd]] of different functions in different contexts
- [[RosettaRemodel|rosettaremodel]] is a generalized framework for flexible backbone design
    - [[More RosettaRemodel documentation|Remodel]]
- improving solubility and reversibility of folding with [[surface charge|supercharge]]
- improving hydrophobic packing by [[void identification and packing|vip-app]]

### Protein Interface Design

[[Anchored Design|anchored-design]]
[[Peptide Design|pepspec]]

### Enzyme Design

[[Enzyme Design|enzyme-design]]

## Protein Loop Modeling

Loop modeling is a complex and central element of protein structure prediction and design.
There are two typical biological problems:
- modeling loops into regions of low electron density in crystal structures
- modeling loops into regions of low homology or with no secondary structure in homology models
There exist a variety of tools for approaching these tasks.
For an overview of loop modeling in Rosetta, please see [[this|loopmodel]].

### Modeling Loops in Regions of Low Electron Density

For explicit refinement of crystallography data, see [[here|density-map-scoring]].

For modeling of missing loops on existent protein structures, you can use any of the methods in the section below.

### Modeling Loops in Regions of Low Homology or with No Secondary Structure

What if I am building a homology model and there are regions with low homology or no predicted secondary structure?
These are the typical problems solved by loop modeling algorithms.
Most loop modeling algorithms in Rosetta are contained within a single executable and run by setting different flags.
The fastest, but least accurate method is cyclic coordinate descent ([[CCD|loopmodel-ccd]]).
CCD closes a loop by iteratively solving for phi/psi angles which position the mobile terminus closer to the target anchor after fragment insertion.
CCD is generally not recommended but can be used in specific cases (e.g. when time is a limiting factor).
The currently (June 10th, 2015) accepted method of loop modeling is next-generation KIC ([[NGK|next-generation-KIC]]).
NGK sampling can be enhanced/concerted with fragments ([[KIC with fragments|KIC_with_fragments]]).
There also exists an alternative, Monte Carlo stepwise, loop modeling method which can be applied to proteins and **RNA**.
Unfortunately, stepwise loop modeling (for [[proteins|swa-protein-main]] and [[RNA|stepwise]]) tends to be slow.

See the [[Kortemme Lab benchmark server|https://guybrush.ucsf.edu/benchmarks/benchmarks/loop_modeling]] for a comparison.

#### What if I am modeling a protein with a disordered region?

You probably should not be doing this using Rosetta, if at all. 
Disordered proteins are dynamic in the context of a cell.
It is unlikely that any static, _in silico_, model of a disordered protein or protein region will be very accurate.
However, if you have a specific question, such as "can my disordered tail of 20 residues plausibly interact with this other region of my protein?"
Then you may begin to approach this question with [[FloppyTail|floppy-tail]].

## Solving Crystal Structures

For explicit refinement of crystallography data, see [[here|density-map-scoring]].

## What If My Question Is Unanswered? 

[[i-want-to-do-x]]

## General Rosetta Caveats

## Publicly Available Resources (Servers)

* [[http://rosie.rosettacommons.org/]]
* [[http://robetta.bakerlab.org/]]

#Incorporating Experimental Data

Potentially useful experimental data takes many forms.
The very nature of Monte Carlo simulation strongly supports the incorporation of any type of experimental constraint, because all you need it to do is allow it to influence the distribution of generated structures. 
(Important note: Rosetta, historically, calls _constraints_ what other computational packages refer to as _restraints_.
That is, we are not fixing a degree of freedom and removing it from sampling and scoring.
Rather, we are adding a scoring term that penalizes deviations from particular values of that degree of freedom.)

## Input structures

Truly, the largest experimentally derived sampling bias to a biological problem is any input structures that might be available.
After all, you are using those structures precisely because you trust them enough _not_ to want to perform _ab initio_ structure prediction, so you want the bias that starting from them provides.
At the same time, input structures are not perfect:
* Crystal structures are of variable resolution and frequently lack hydrogens.
* At the resolution where hydrogens cannot be visualized (at least 90% of the PDB) asparagine and glutamine oxygens and nitrogens cannot be distinguished from each other (ditto histidine tautomers) and are frequently misassigned.
* NMR structures are frequently resolved via a few hundred constraints, rather than the thousands upon thousands in crystal structures.

Most of all, the force fields used in these optimization efforts are arithmetically distinct from the Rosetta energy function.
It is critical to obtain structures that are geometrically similar to the starting structure but that exist closer to a local minimum of the scoring function.
This is important because every unit of strain energy in your starting structure can inappropriately bias sampling: bad moves can be accepted that would otherwise have been rejected because they relieve strain that already should have been addressed.
There is a [[complete write-up|preparing-structures]] of preparing starting structures appropriately.

## Specialized Rosetta executables

Rosetta has individual modules to handle particular forms of experimental constraint:

* [mr_protocols](application_documentation/mr-protocols) is typically used _alongside_ Phaser; it uses Rosetta's comparative modeling to rebuild gaps and insertions in the template, as well as missing density, from fragments, followed by relaxation with constraints to experimental density.
You can then use Phaser again to re-score against crystallographic data.
* [ERRASER](application_documentation/erraser) refines RNA structures from electron density (crystallographic data); it constitutes a workflow of _erraser_minimize_, _swa_rna_analytical_closure_, and _swa_rna_main.
It requires the use of the refinement program PHENIX.
* [loops from density](application_documentation/loops-from-density) is a script to take badly fit electron data and a cutoff suggesting how much of the pose you're willing to rebuild and to generate input "loops" files for loop modeling. 
* [Chemical shift files](rosetta_basics/chemical-shift-file) provide data to a variety of protocols often collectively referred to as CSROSETTA that incorporate NMR constraints to refine structures

## Experimental constraints  

Frequently, you will encounter situations where you have knowledge about the experimental system that does not neatly fit into any of the above situations, or which provides very sparse or even conflicting information.
This is all right: Rosetta's capacity for [working with constraints](rosetta_basics/constraint-file) will help to encode these sorts of weak information.
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
