#Centroid score terms and score functions in Rosetta

###Please expand this page if you have more information!

##Score terms

###Base terms

The following information is adapted from [[Rohl et al. 2004|Rosetta-canon#scoring]]:


##### env
The `env` score term is a context-dependent one-body energy term that describes the solvation of a particular residue (based on the hydrophobic effect). It is based on the probability of a residue having the specified type given its number of neighboring residues.

##### pair
The `pair` score term is a two-body energy term for residue pair interactions (electrostatics and disulfide bonds). For each pair of residues, it is based on the probability that *both* of these two residues will have their specified types given their sequence separation and the physical distance between them, normalized by the product of the probabilities that *each* residue will have its specified type given the same information.

##### ss_pair
The ss_pair term describes hydrogen bonding between beta strands.

##### sheet
The sheet term favors the arrangement of individual beta strands into sheets. It is derived from the probability that a structure with a given number of beta strands will have the current number of beta sheets and lone beta strands.

##### hs_pair
The hs_pair term describes packing between strands and helices. It is based on the probability that two pairs of residues (1 pair in the sheet and 1 pair in the helix) will have their current dihedral angles given the separation (in sequence and physical distance) between the helix and the strand.

##### rg
The rg term favors compact structures and is calculated as the root mean square distance between residue centroids.

##### cbeta
The cbeta term is another solvation term intended to correct for the excluded volume effect introduced by the simulation and favor compact structures. It is based on the ratio of probabilities of a residue having a given number of neighbors in a compact structure vs. random coil and summed over all residues.

#####vdw
The vdw term represents **only steric repulsion** and not attractive van der Waals forces (those are modeled in terms rewarding compact structures, such as the rg term; local interactions are implicitly included from [[fragments|fragment-file]]). It is calculated over pairs of atoms only in cases where:
1. the interatomic distance is less than the sum of the atoms' van der Waals radii, and 
2. the interatomic distance does not depend on the torsion angles of a single residue.



The following information is adapted from [[Shmygelska and Levitt 2008|http://www.pnas.org/content/106/5/1415.full.pdf]]:

#####rsigma
Scores strand pairs based on the distance between them and the register of the two strands.


#####co
Contact order


#####rama
As in full-atom scoring, the rama term describes the probability of a residue having a given set of torsion angles given its identity.


#####hb_srbb
Short-range backbone-backbone hydrogen bonding energy term

#####hb_lrbb
Long-range backbone-backbone hydrogen bonding energy term

#####rg_local

#####cenpack

#####STRAND_STRAND_WEIGHTS
First value:  Set to 0 or 1 (all values > 0.5 treated as 1). If 1, includes a distance score term for strand pairing. 

Second value: cutoff *sequence* distance between strands to be considered nonlocal (local strands get less of a score bonus for pairing).

###"Smooth" terms
Centroid score terms that have been optimized with smoothed data and a larger dataset than the original.
#####cen_env_smooth
#####cen_pair_smooth
#####cenpack_smooth
#####cbeta_smooth

###"Interchain" terms
These terms are commonly used in centroid docking protocols.

#####interchain_env
#####interchain_pair
#####interchain_vdw
#####interchain_contact

###Cen_rot terms
These terms are used in conjunction with centroid rotamer modeling (see the [[CenRotModel]] page). **NOTE**: To use these terms, you must load the centroid rotamer library using the `-corrections:score:cenrot` flag.
#####cen_rot_env
See [[env|centroid-score-terms#env]]
#####cen_rot_pair
See [[pair|centroid-score-terms#pair]]
#####cen_rot_pair_ang
???
#####cen_rot_cbeta
See [[cbeta|centroid-score-terms#cbeta]]
#####cen_rot_dun
Dunbrack term for centroid rotamer modeling. Scores internal energy of centroid rotamers.


###Membrane centroid score terms
These score terms are specialized for use with membrane proteins and appear in membrane-specific score functions.
#####mp_pair
See pair term above.
#####mp_env
See env term above.
#####mp_cbeta
See cbeta term above.
#####*mp_nonhelix*
#####*mp_termini*
#####*mp_tmproj*

###RNA centroid score terms
These score terms are used in coarse-grained modeling of RNA.
#####rna_rg
See the rg term above.
#####rna_vdw
See the vdw term above.
#####rna_data_backbone
#####rna_base_pair
#####rna_base_axis
#####rna_base_stagger
#####rna_base_stack
#####rna_base_stack_axis
#####rna_base_backbone
#####rna_backbone_backbone
#####rna_repulsive

##Centroid score functions

###Base score functions

#####cen_std
Centroid score function that uses only the env, pair, cbeta, and vdw score terms with equal weights. 
#####score0
Score function used in the first stage of the ClassicAbInitio protocol. It is intended for use with fragment insertion; the only active term is a low vdw (repulsive) weight to penalize clashes, and the fragments themselves are intended to provide the majority of the information.

#####score1
Score function used in the second stage of the ClassicAbInitio protocol. 
#####score2
Score function used in the third stage of the ClassicAbInitio protocol. 
#####score3
Score function used in the fourth stage of the ClassicAbInitio protocol. Upweights the cbeta and cenpack terms and turns on the rg and rsigma terms. Sets the value of ss_lowstrand (from STRAND_STRAND_WEIGHTS) to 0 (no distance score for strand pairs).
#####score4
While there is no base score4 score function, it is available as a patch and in smooth and cenrot versions. It introduces hydrogen bonding terms (hbond_lr_bb and hbond_sr_bb) and a rama term (ramachandran probability-based scores for residues based on phi/psi angles).
#####score5
Score function used in the third stage of the ClassicAbInitio protocol. Nearly identical to score2, but uses different STRAND_STRAND_WEIGHTS cutoff (see above)
#####RS_centroid
#####abinitio_remodel_cen
#####remodel_cen
#####fldsgn_cen
#####interchain_cen
#####loop_fragsample

###Special cases

####RNA

#####coarse_rna

#####rna_lowres

####Membranes

#####mpdocking_cen_14-7-23_no-penalties
#####mpdocking_cen_14-7-25_low-penalties
#####mpframework_docking_cen_2015
Used for centroid docking of membrane proteins
#####mpframework_symdock_cen_2015
Used for centroid symmetric docking of membrane proteins
###Modifiers
These may be seen as suffixes appended to the name of a score function. Some other suffixes (relax, design, etc.) may also appear; these indicate the protocol for which the score function is intended.
#####smooth
These score functions use the optimized "smooth" centroid weights described above.
#####cenrot
These score functions are intended for use with centroid rotamer modeling (see the cen_rot terms section above).
#####rob
These score functions/patches have increased repulsive (vdw) weights.
#####cartmin/cart
These score functions/patches are intended for use with cartesian minimization and have the cart_bonded weight set.

###Patches

##See Also

* [[Scoring explained]]
* [[Score types]]
* [[Centroid vs fullatom]]
* [[CenRotModel]]