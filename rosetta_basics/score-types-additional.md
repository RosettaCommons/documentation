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
fastsaxs                                   Fastsaxs agreement using formulation of Stovgaard et al. [1]
saxs_score                                 Centroid SAXS asessment
saxs_cen_score
saxs_fa_score                              Full-atom SAXS score
pddf_score                                 Score based on pairwise distance distribution function
```

[1] [[Calculation of accurate small angle X-ray scattering curves from coarse-grained protein models |http://dx.doi.org/10.1186/1471-2105-11-429]], Stovgaard et al., BMC Bioinformatics 2010, 11:429.

pba Membrane all atom terms
---------------------------

```
fa_mbenv                                   Depth-dependent reference term
fa_mbsolv                                  Burial + depth dependent term
```

Split out fa_elec for RNA
-------------------------

```
fa_elec_rna_phos_phos
fa_elec_rna_phos_sugr
fa_elec_rna_phos_base
fa_elec_rna_sugr_sugr
fa_elec_rna_sugr_base
fa_elec_rna_base_base
fa_elec_rna_phos_phos_fast
fa_elec_rna_phos_sugr_fast
fa_elec_rna_phos_base_fast
fa_elec_rna_sugr_sugr_fast
fa_elec_rna_sugr_base_fast
fa_elec_rna_base_base_fast
fa_elec_aro_aro
fa_elec_aro_all
hack_aro
rna_fa_atr_base
rna_fa_rep_base
rna_data_backbone                          Using chemical accessibility data for RNA
```

Carbon hydrogen bonds
---------------------

```
ch_bond                                    
ch_bond_bb_bb
ch_bond_sc_sc
ch_bond_bb_sc
```

Proline closure energy
----------------------

```
rama2b
vdw                                        Centroid
cenpack                                    Centroid
cenpack_smooth                             fpd smooth cenpack
cen_hb                                     fpd centroid bb hbonding
hybrid_vdw                                 Hybrid centroid+fa
```

Gaussian overlap
----------------

```
gauss
rna_vdw                                    Low res clash check for RNA
rna_base_backbone                          Bases to 2'-OH, phosphates, etc
rna_backbone_backbone                      2'-OH to 2'-OH, phosphates, etc
rna_repulsive                              Mainly phosphate-phosphate repulsion
rna_base_pair_pairwise                     Base-base interactions (Watson-Crick and non-Watson-Crick)
rna_base_axis_pairwise                     Force base normals to be parallel
rna_base_stagger_pairwise                  Force base pairs to be in same plane
rna_base_stack_pairwise                    Stacking interactions
rna_base_stack_axis_pairwise               Stacking interactions should involve parallel bases
rna_data_base                              Using chemical accessibility data for RNA
```
