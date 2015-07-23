# Residue type composition energy (aa_composition)
Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
Last edited 23 July 2015.

## Purpose and algorithm

This scoring term is intended for use during design, to penalize deviations from a desired residue type composition.  For example, a user could specify that the protein was to have no more than 5% alanines, no more than 3 glycines, at least 4 prolines, and be 40% to 50% hydrophobic with 5% aromatics.  Calculating a score based on residue type composition is easy and fast, but is inherently not pairwise-decomposable.  This scoring term is intended to work with Alex Ford's recent changes to the packer that permit fast-to-calculate but non-pairwise-decomposable scoring terms to be used during packing or design.

## Organization of the code

- The scoring term lives in ```core/scoring/methods/AACompositionEnergy.cc``` and ```core/scoring/methods/AACompositionEnergy.hh```.
- Like any whole-body energy, the **AACompositionEnergy** class implements a ```finalize_total_energy()``` function that takes a pose.  This calculates the score.  Internally, it calls ```calculate_aa_composition_energy()```, which takes a vector of owning pointers to Residues (which can be called directly during packing).
- On initialization, the term creates an internal AACompositionEnergySetup object that stores the user-defined settings for the desired residue type composition.  This class is defined in ```core/scoring/methods/AACompositionEnergySetup.cc``` and ```core/scoring/methods/AACompositionEnergySetup.hh```.  At a future date, I might try associating setup objects with poses so that at different points in a protocol, a user could score with different settings.