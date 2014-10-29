#Energy Terms In Rosetta 

Standard Weights File
=====================

The default score function in Rosetta for scoring full-atom structures is currently **talaris2013**.  The energy function and its corrections were tested in the paper [Leaver-Fay et al., Methods in Enzymology 2013](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3724755/).  A full description of the changes this energy function introduces can be found [here](https://www.rosettacommons.org/node/3508#comment-6946).  The **talaris2013** energy function is suitable for scoring canonical L-amino acids, their D-amino acid mirror images, and some rigid ligands (_e.g._ metal ions, phosphate, _etc._).  It can also work with noncanonical alpha-amino acid residues, provided that their params files are set up properly.  Backbone conformation terms will ignore beta-amino acids, flexible ligands, nucleic acids, _etc._

Energy terms used in talaris2013.wts
-------------------------------------

```html
fa_atr                                     Lennard-Jones attractive between atoms in different residues
fa_rep                                     Lennard-Jones repulsive between atoms in different residues
fa_sol                                     Lazaridis-Karplus solvation energy
fa_intra_rep                               Lennard-Jones repulsive between atoms in the same residue
fa_elec                                    Coulombic electrostatic potential with a distance-dependant dielectric   
pro_close                                  Proline ring closure energy
hbond_sr_bb                                Backbone-backbone hbonds close in primary sequence
hbond_lr_bb                                Backbone-backbone hbonds distant in primary sequence
hbond_bb_sc                                Sidechain-backbone hydrogen bond energy
hbond_sc                                   Sidechain-sidechain hydrogen bond energy
dslf_fa13                                  Disulfide geometry potential
rama                                       Ramachandran preferences
omega                                      Omega dihedral in the backbone. A Harmonic constraint on planarity with standard deviation of ~6 deg.
fa_dun                                     Internal energy of sidechain rotamers as derived from Dunbrack's statistics (2010 Rotamer Library used in Talaris2013)
p_aa_pp                                    Probability of amino acid at Φ/Ψ
ref                                        Reference energy for each amino acid. Balances internal energy of amino acid terms.  Plays role in design.
METHOD_WEIGHTS                             Not an energy term itself, but the parameters for each amino acid used by the ref energy term. 
```

Additional energy terms for score12
-----------------------------------

Previous versions of Rosetta used the score12 energy function as the default full atom energy function. Many of the energy terms are the same as talaris2013 (though at different weights, and with different parameters), although other terms were also used:

```html
fa_pair                                    Statistics-based pair term, favors salt bridges (replaced by fa_elec in talaris2013)
fa_plane                                   π-π interaction between aromatic groups, by default = 0
dslf_ss_dst                                Distance score in current disulfide (replaced by dslf_fa13 in talaris2013)
dslf_cs_ang                                Csangles score in current disulfide (replaced by dslf_fa13 in talaris2013)
dslf_ss_dih                                Dihedral score in current disulfide (replaced by dslf_fa13 in talaris2013)
dslf_ca_dih                                Cα dihedral score in current disulfide (replaced by dslf_fa13 in talaris2013)
```

The score12 energy function can be used in current Rosetta versions, but the option <code> -restore_pre_talaris_2013_behavior</code> must be passed.