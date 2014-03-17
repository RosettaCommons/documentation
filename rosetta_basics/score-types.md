#Energy Terms In Rosetta 

Standard Weights File
=====================

Talaris2013 is currently the default score function in Rosetta for scoring full-atom structures.
The energy function and its corrections were tested in the paper [Leaver-Fay et al., Methods in Enzymology 2013](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3724755/).  A full description of the changes this energy function introduces can be found [here](https://www.rosettacommons.org/node/3508#comment-6946).

Energy terms used in talaris2013.wts
-------------------------------------

```
fa_atr                                     lennard-jones attractive
fa_rep                                     lennard-jones repulsive
fa_sol                                     lazaridis-jarplus solvation energy
fa_intra_rep                               lennard-jones repulsive between atoms in the same residue
fa_elec                                    coulombic electrostatic potential with a distance-dependant dielectric   
pro_close                                  proline ring closure energy
hbond_sr_bb                                backbone-backbone hbonds close in primary sequence
hbond_lr_bb                                backbone-backbone hbonds distant in primary sequence
hbond_bb_sc                                sidechain-backbone hydrogen bond energy
hbond_sc                                   sidechain-sidechain hydrogen bond energy
dslf_fa13                                  disulfide geometry potential 
rama                                       ramachandran preferences
omega                                      omega dihedral in the backbone
fa_dun                                     internal energy of sidechain rotamers as derived from Dunbrack's statistics
p_aa_pp                                    Probability of amino acid at phipsi
ref                                        reference energy for each amino acid
METHOD_WEIGHTS                             not an energy term itself, but the parameters for each amino acid used by the ref energy term 
```

Additional energy terms for score12
-----------------------------------

Previous versions of Rosetta used the score12 energy function as the default full atom energy function. Many of the energy terms are the same as talaris2013 (though at different weights, and with different parameters), although other terms were also used:

```
fa_pair                                    statistics based pair term, favors salt bridges. (Replaced by fa_elec)
fa_plane                                   pi-pi interaction between aromatic groups, by default = 0
dslf_ss_dst                                distance score in current disulfide (Replaced by dslf_fa13.)
dslf_cs_ang                                csangles score in current disulfide (Replaced by dslf_fa13.)
dslf_ss_dih                                dihedral score in current disulfide (Replaced by dslf_fa13.) 
dslf_ca_dih                                ca dihedral score in current disulfide (Replaced by dslf_fa13.)
```

The score12 energy function can be used in current Rosetta versions, but the option <code> -restore_pre_talaris_2013_behavior</code> must be passed.