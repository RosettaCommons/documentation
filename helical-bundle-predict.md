# Helical Bundle Structure Prediction (helical_bundle_predict) Application

Back to [[Application Documentation]].

Created 21 August 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).<br/><br/>
<b><i>This application is currently unpublished!  If you use this application, please include the developer in the list of authors for your paper.</i><br/>

[[_TOC_]]

## Description

Rosetta's most widely-used structure prediction application, [[Rosetta ab initio|abinitio-relax]], relies on fragments of proteins of known structure to guide the search of the conformation space, and to limit the conformational search to the very small subset of the space that resembles known protein structures.  This works reasonably well for natural proteins, but prevents the prediction of structures built from non-natural building blocks.  In 2015, we introduced the [[simple_cycpep_predict]] application to allow the prediction of structures of small heteropolymers built from any mixture of chemical building-blocks, without any known template sequences.  The [[simple_cycpep_predict]] application uses the [[generalized kinematic closure|GeneralizedKIC]] algorithm to confine the search to closed conformations of a macrocycle, effectively limiting the search space without relying on databases of known structures.  Unfortunately, this only works for relatively small molecules (less than approx. 15 residues), molecules with regions of known secondary structure (less than approx. 10 residues of loop), or molecules with internal symmetry (less than approx. 8 residues in the repeating unit), and absolutely requires covalent linkage between the ends of the molecule.  A prediction strategy for larger, linear heteropolymers built from non-natural building-blocks is needed.

The helical_bundle_predict application was created to fill this niche.  Based on the hypothesis that fragments are primarily useful for sampling allowed bends of known secondary structures (which can be sampled using [[parametric approaches|MakeBundleMover]], given heteropolymer secondary structures that can be predicted _a priori_) or allowed loop conformations (which can be sampled using random perturbations or [[kinematic approaches|GeneralizedKIC]]), this application carries out a Monte Carlo search of conformation space in which allowed moves include:
- Randomization of a loop position (biased by the Ramachandran map for that residue).
- Small random perturbation of a loop position.
- Nucleation of a turn of helix (using the [[MakeBundle mover|MakeBundleMover]]).
- Elongation of a helical region (with possible merger of two helical regions).
- Contraction of a helical region.
- Small random perturbation of the Crick parameters describing a given helix (using the [[PerturbBundle mover|PerturbBundle]]), to allow helices to bend and supercoil.

![Allowed moves in the Monte Carlo search performed by the helical_bundle_predict application.](helical_bundle_predict_allowed_moves.png)

Note that, because strands are special cases of helices in which the turn per residue is about 180 degrees, this approach should be sufficiently general for any protein or heteropolymer secondary structure.

## See also
- [[Rosetta ab initio application|abinitio-relax]] -- Fragment-based protein structure prediction.
- [[Rosetta simple_cycpep_predict application|simple_cycpep_predict]] -- Structure prediction of macrocycles built from canonical or non-canonical building-blocks.
- [[Generalized kinematic closure|GeneralizedKIC]] -- A mover to sample conformations of a closed chain of atoms, without fragments.
- [[MakeBundle mover|MakeBundleMover]] -- A mover that generates a coiled-coil protein or heteropolymer parametrically, using the Crick equations.
- [[PerturbBundle mover|PerturbBundle]] -- A mover that alters Crick parameter values to perturb the conformation of a coiled-coil.
- [[BundleGridSampler mover|BundleGridSampler]] -- A mover that grid-samples Crick parameter space to identify favourable coiled-coil conformations.