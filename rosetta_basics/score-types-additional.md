#Additional Energy Terms In Rosetta 

Further Terms
=====================
This section supplements the main [[Score Types|rosetta_basics/score-types]] section with other energy terms available in Rosetta.

Context-independent two-body energy terms
=========================================

Short-ranged context-independent two-body score terms
-----------------------------------------------------

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

RNA terms
---------

This is a filtered version of the pairwise RNA low-resolution terms above, disallows a base edge to form more than one base pair, and disallows two bases to both stack and pair. 

_This is not really pair-wise_ but is calculated in a finalize_energy step at the end of a 2-body score function.

```
rna_base_pair                              Base-base interactions (Watson-Crick and non-Watson-Crick)
rna_base_axis                              Force base normals to be parallel
rna_base_stagger                           Force base pairs to be in same plane
rna_base_stack                             Stacking interactions
rna_base_stack_axis                        Stacking interactions should involve parallel bases
rna_mg                                     Knowledge-based term for mg(2+)RNA interactions for use in low res modeling
rna_mg_rep                                 Ad-hoc, empirically validated term to prevent uncommon mg(2+)atom interactions
rna_mg_indirect                            Knowledge-based term for mg(2+)RNA interactions for use in low res modeling
```

High-resolution RNA terms
-------------------------

```
rna_torsion                                RNA torsional potential
rna_sugar_close                            Constraints to keep RNA sugar closed, and with reasonably ideal geometry
fa_stack                                   Stacking interaction modeled as pairwise atom-atom interactions
fa_stack_aro
stack_elec                                 Distance dependent dielectric between base atoms (attenuated parallel to plane)
stack_elec_base_base
stack_elec_base_bb
```

DNA constraints-based torsional potentials
------------------------------------------

```
dna_bb_torsion
dna_sugar_close
dna_base_distance
geom_sol_fast                              Context independent version. Currently tested only for RNA case
geom_sol_fast_intra_RNA                    RNA specific score term
fa_cust_pair_dist                          Custom short range 2b
custom_atom_pair
```

All the orbitals scoretypes
---------------------------

```
orbitals_hpol_bb
pci_cation_pi
pci_pi_pi
pci_salt_bridge
pci_hbond
```

Context-dependent two-body energy terms
=======================================

Short-ranged context-independent two-body score terms
-----------------------------------------------------

```
fa_pair_aro_aro
fa_pair_aro_pol
fa_pair_pol_pol
hbond_sr_bb_sc
hbond_lr_bb_sc
hbond_intra                                Currently effects only RNA
```

Protein-protein interface scores
--------------------------------

```
interface_dd_pair
```

Geometric solvation
-------------------

```
geom_sol                                   Geometric solvation energy for polar atoms
geom_sol_intra_RNA                         RNA-specific score term
occ_sol_fitted
occ_sol_fitted_onebody
occ_sol_exact
```

Centroid rotamer pair, P(r,ang,dih|aa)
--------------------------------------

```
cen_rot_pair                               P(r|aa)
cen_rot_pair_ang                           P(ang|r,aa)
cen_rot_pair_dih                           P(dih|r,aa)
pair                                       Centroid
cen_pair_smooth                            fpd smooth centroid pair
Mpair
```

Sucker atom energy
------------------

```
suck
```

RNA low-resolution terms
------------------------

```
rna_rg                                     Radius of gyration for RNA
```

Nucleotide resolution thermodynamics
------------------------------------

```
loop_close                                 Loop closure terms - attempting to model full RNA folding free energy
```

FACTS solvation model
---------------------

```
facts_elec
facts_solv
facts_sasa
```

Centroid inter-chain one body (docking) scores
---------------------------------------

```
interchain_pair
interchain_vdw
```

Other energy terms
=======================================

Miscellaneous
-------------

```
gb_elec
```

Full-atom disulfide terms
-------------------------

```
dslf_cbs_ds                                Rreplaced by dslf_fa13 in talaris2013
```


Centroid disulfide terms
------------------------

```
dslfc_cen_dst
dslfc_cb_dst
dslfc_ang
dslfc_cb_dih
dslfc_bb_dih
```

Disulfide matching terms
------------------------

```
dslfc_rot
dslfc_trans
dslfc_RT

Constraint terms
----------------

atom_pair_constraint                       Harmonic constraints between atoms involved in Watson-Crick base pairs specified by the user in the params file
constant_constraint
coordinate_constraint
angle_constraint
dihedral_constraint
big_bin_constraint
dunbrack_constraint
site_constraint
metalhash_constraint                       Rigid body, metal binding constraints for centroid mode
rna_bond_geometry                          Deviations from ideal geometry

Miscellaneous
-------------

```
fa_dun_dev
fa_dun_rot
fa_dun_semi
dna_chi
p_aa_pp_offset
yhh_planarity
h2o_intra
ref_nc
seqdep_ref
nmer_ref
nmer_pssm
nmer_svm
envsmooth
e_pH
rna_bulge
mg_ref                                     Chemical potential for mg(2+) ('reference weight' in Rosetta lingo)
free_suite                                 Bonus for virtualizing RNA suite
free_2HOprime                              Bonus for virtualizing RNA 2'-OH
intermol                                   Cost of instantiating a chain form 1 M std state
special_rot
other_pose                                 In preparation for multi-pose stuff
```
