# CrankshaftFlipMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## CrankshaftFlip Mover

This mover performs crankshaft flip moves, a backbone sampling move based on analysis of MD simulations of cyclic peptoids, where an inversion of a phi dihedral is compatible with the following omega flipping between cis/trans with minimal perturbation to the rest of the backbone.

The mover is generalizable, on the hypothesis that similar pairs of large, correlated backbone movements may be useful in sampling other tightly constrained systems (e.g. beta turns).

In lattice-based polymer simulations, crankshaft flips are moves that involve two adjacent monomers in a loop moving together (http://aip.scitation.org/doi/abs/10.1063/1.431297). In peptides, the equivalent is two backbone atoms, C_i and N_(i+1) moving by correlated rotations in psi_i, phi_(i+1). This move has been observed in several experimental contexts, including in crystal structures of antibody loops(http://doi.org/10.1016/j.jmb.2010.10.030) and in simulations of cyclic peptides (https://pubs.acs.org/doi/10.1021/acs.jctc.6b00193). It should be useful in loop modeling. We are interested in using a more general case to model macrocycles with noncanonical backbones. You can read more about it in our paper: git https://pubs.acs.org/doi/full/10.1021/acs.jpcb.2c01669

This mover is designed to be general and compatible with both homo- and hetero-polymers of the following type: peptides (not Gly or Pro), peptoids, glycine, proline, and N-methylated amino acids. The perturbations that are allowed for different combinations at the i and i+1 positions and compatible conformations are described in the table below.


| residue i    | residue i+1            | Action                                                                               | Nickname  |
|--------------|------------------------|--------------------------------------------------------------------------------------|-----------|
| Peptoid, Gly | Peptoid, Pro, N-Methyl | phi_i negate, psi_i negate, omg_i flip by 180                                        | "Peptoid" |
| Any(?)       | Gly                    | psi_i 0<->(-30,180), phi_i+1 180<->(-90,+-60)                                        | "Pre-Gly" |
| Peptide      | Peptide (not P)        | if psi_i/phi_i+1 near -120/-60 or 120/60: psi_i negate, omg_i negate, phi_i+1 negate | "Peptide" |

```xml
<CrankshaftFlipMover name="&string"
    residue_selector="('' &string)"
    allow_peptoid_flips="(1 &bool)"
    allow_peptide_flips="(1 &bool)"
    allow_pre_gly_flips="(1 &bool)"
    tolerance="(20.0 &real)"
</CrankshaftFlipMover>
```

- **residue\_selector**: An optional, previously-defined [[ResidueSelector|ResidueSelectors]], specifying the subset of residues to which the mover will be applied.  If not provided, the mover is applied to the whole pose. The allowed residue indicies are randomized and the mover is applied to the first residue position that meets the criteria. 

- **allow_peptoid_flips**: Allow peptoid type crankshaft flips
- **allow_peptide_flips**: Allow peptide type crankshaft flips
- **allow_pre_gly_flips**: Allow pre_gly type crankshaft flips
- **tolerance**: The value (in degrees) that a givens residues dihedral angle value can be off from the bin centers described above to still be allowed to flip



##See Also

* [[SmallMover]]
* [[ShearMover]]
* [[SetTemperatureFactorMover]]
* [[SetSecStructEnergiesMover]]
* [[I want to do x]]: Guide to choosing a mover
