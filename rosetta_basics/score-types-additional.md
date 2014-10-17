#Additional Energy Terms In Rosetta 

Further Terms
=====================
This section supplements the main [[Score Types|rosetta_basics/score-types]] section with other energy terms available in Rosetta.

Short-ranged ci2b scores
------------------------

```
fa_intra_atr
fa_intra_sol
fa_intra_RNA_base_phos_atr                 RNA-specific score term
fa_intra_RNA_base_phos_rep                 RNA-specific score term
fa_intra_RNA_base_phos_sol                 RNA-specific score term
lk_hack
lk_ball
lk_ball_wtd
lk_ball_iso
coarse_fa_atr
coarse_fa_rep
coarse_fa_sol
coarse_beadlj
mm_lj_intra_rep
mm_lj_intra_atr
mm_lj_inter_rep
mm_lj_inter_atr
mm_twist                                   
mm_bend                                    Deviation of bond angles from the mean
mm_stretch                                 
lk_costheta
lk_polar
lk_nonpolar                                Lazaridis-Karplus solvation energy, over nonpolar atoms
lk_polar_intra_RNA                         RNA-specific score term
lk_nonpolar_intra_RNA                      RNA-specific score term
fa_elec_bb_bb
fa_elec_bb_sc
fa_elec_sc_sc
h2o_hbond
dna_dr
dna_bp
dna_bs
peptide_bond
pcs                                        Pseudo-contact Shift energy
pcs2                                       Pseudo-contact Shift energy version 2. This will replace pcs by the end of 2010
fastsaxs                                   Fastsaxs agreement using formulation of [[Stovgaard et al.|http://dx.doi.org/10.1186/1471-2105-11-429]]
saxs_score                                 Centroid SAXS asessment
saxs_cen_score
saxs_fa_score                              Full-atom SAXS score
pddf_score                                 Score based on pairwise distance distribution function
```