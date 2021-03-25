GlycanDock
===========

[[_TOC_]]

MetaData
========

Application created by Morgan Nance (morganlnance(at)gmail(dot)com) with the original version created by Dr. Jason Labonte (JWLabonte@jhu.edu). See https://doi.org/10.1002/jcc.24679 for the details on the original `glycan_dock` application.

PIs: Dr. Jeffrey Gray (jgray@jhu.edu)


Description
===========

App: `GlycanDock`

`GlycanDock` is a high-resolution (_i.e._, full-atom only), Monte Carlo-plus-Minimization protein–glycoligand docking protocol. `GlycanDock` treats glycan chains (glycoligands) as flexible oligosaccharides (rather than as a small-molecule-type ligand with discrete "rotamers"). The `GlycanDock` algorithm begins with an input glycoligand conformation and randomly perturbs it in both rigid-body and glycosidic torsion angle space to promote conformational diversity in each independent docking trajectory. Next, a set of inner refinement cycles alternates between rigid-body and glycosidic torsion angle sampling followed by protein and sugar side chain optimization at the interface and full-complex energy minimization. To promote thorough sampling of local conformational space, the inner refinement cycles are wrapped in a set of outer cycles that ramp down the van der Waals attractive weight and ramp up the Lennard–Jones repulsive weight of the REF2015 scoring function. Thus, the initial search allows clashes and promotes diversification, while the late stages enforce rigid sterics—a strategy shown to be effective in [[FlexPepDock | flex-pep-dock]], Rosetta's protein–peptide docking algorithm.

`GlycanDock` can dock mono-, oligo-, and polysaccharides to protein receptors of interest. Glycoligands with branched or exocyclic glycosidic linkages and/or various chemical modifications (_e.g._, _N_-acetylation, methylation) are tolerated. `GlycanDock` using the the CHI (CarboHydrate Intrinsic) energy term to ensure that glycosidic dihedrals falls within known energetically-favorable torsion space. `GlycanDock` can refine a putative protein–glycoligand complex with relatively high confidence in the initial orientation of the glycoligand with respect to the binding site (via the `-refine_only` flag, which enables small perturbations during glycoligand docking refinement). `GlycanDock` can also be used to find both the orientation and the conformation of the glycoligand if only the relative protein binding site is known (default behavior). `GlycanDock` is **not** a global docking protocol, meaning `GlycanDock` only searches local conformational space around the starting position of the glycoligand.

See [[Working With Glycans | WorkingWithGlycans ]] for more information on carbohydrate modeling in Rosetta.

<!--- BEGIN_INTERNAL -->

Algorithm
=======
`GlycanDock` employs ten inner cycles of Monte Carlo sampling and optimization of the glycoligand conformation at the protein receptor interface. The inner refinement cycles are wrapped by ten outer cycles that ramp the weights of the attractive (`fa_atr`) and repulsive (`fa_rep`) terms in the Rosetta scoring function. Each of the ten inner cycles performs two sets of sampling and optimization procedures on the glycoligand: a set of eight rigid-body perturbations and a set of eight glycosidic torsion angle perturbations (performed in either order every cycle). Every perturbation is followed by interfacial side-chain rotamer optimization, and every other perturbation is followed by full-structure energy minimization.

Rigid-body sampling consists of uniform perturbations to the glycoligands center-of-mass as well as occasional translation of the glycoligand toward the protein receptor’s center-of-mass. This latter “sliding” step ensures that the glycoligand does not drift far away from the protein during the docking trajectory. Glycosidic-linkage sampling includes performing uniform and non-uniform perturbations of various magnitudes on randomly selected glycosidic torsion angles. 

Full Description:
MLN TODO–
```
///@brief Main mover for GlycanDock
///
/// Outer cycles controlling score term ramping
///   Cycle 1: fa_atr XXX  fa_rep XXX
///   ...
///.  Cycle 10: fa_atr 1.0  fa_rep 0.55 (default REF2015 values as of Feb 2021)
///
/// Inner cycles controlling glycoligand sampling and optimization
///   Cycle 1-10: Either
///                 8 rigid-body perturbations followed by 8 glycosidic torsion angle perturbations
///              or 8 glycosidic torsion angle perturbations followed by 8 rigid-body perturbations
///             After each single perturbation
///               packing
///                 First 7 perturbations call RotamerTrialsMover for packing
///                 PackRotamersMover called after the 8th perturbation
///             After every other perturbation
///               minimization
///                 MinMover
///             
///   Weights and Movers for rigid-body sampling
///    0.67 RigidBodyPerturbMover (rot = X, ang = Y)
///    0.33 the above and followed by FaDockingSlideIntoContact
///
///   Weights and Movers for glycosidic torsion angle sampling
///    .XX Phi/Psi Sugar BB Sampling
///    .YY abc
///    .ZZ Small BB Sampling - equal weight to phi, psi, or omega
///      -> .XX +/- 15 degrees
///      -> .YY +/- 45 degrees
///      -> .ZZ +/- 90 degrees
///
```

Options
=======

 - Option Group: ```carbohydrates:GlycanDock```
 
```
MLN TODO–GlycanRelax example flag
-glycan_relax_test, 'Boolean',
    default = false
    desc = Indicates to go into testing mode for Glycan Relax.  
           Will try all torsions in a given PDB in a linear fashion

```

Tips
====
MLN TODO–Lessons from benchmarking


Typical Use
===========
Here, the input `prot_glyc_complex.pdb` is a putative complex of a protein (chain A) and a glycoligand (chain X) where the lines defining the coordinates for each atom of the glycoligand is found at the bottom of the PDB file (this is to ensure proper setup of the [[FoldTree | FoldTree-file]]. The `-refine_only` flag is used to allow for only "small" perturbations of the glycosidic torsion angles during local docking. for The `-auto_detect_glycan_connections` flag tells Rosetta to determine the connections (_i.e._, the atomic bonds) between each carbohydrate residue of the glycoligand. In this way, Rosetta will create the necessary `HETNAM` and `LINK` records for the .pdb file.

```
GlycanDock.default.macosclangrelease -include_sugars -auto_detect_glycan_connections
-in:file:s prot_glyc_complex.pdb -nstruct 10 -carbohydrates:GlycanDock:refine_only true
```

Scripting
=========
MLN TODO–RosettaScripts? PyRosetta?

<!--- END_INTERNAL -->

## See Also
* [[WorkingWithGlycans]]

- ### Apps
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlycanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.
* [[GlycanRelax]] - Sample potential conformational states of a glycan chain, either attached to a protein or free.

- ### RosettaScript Components
* [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees.  
* [[GlycanTreeSelector]] - Select individual glcyan trees or all of them
* [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

- ### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files