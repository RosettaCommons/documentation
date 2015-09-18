#Centroid score terms and score functions in Rosetta

###Please expand this page if you have more information!

##Score terms

###Base terms
These centroid score terms appear in the score0-score5 score functions used in the Abinitio protocol.

##### env
The `env` score term is a context-dependent one-body energy term that describes the solvation of a particular residue (based on the hydrophobic effect). It is based on the probability of a residue having the specified type given its number of neighboring residues. ([[Rohl et al. 2004|Rosetta-canon#scoring]])

##### pair
The `pair` score term is a two-body energy term for residue pair interactions (electrostatics and disulfide bonds). For each pair of residues, it is based on the probability that *both* of these two residues will have their specified types given their sequence separation and the physical distance between them, normalized by the product of the probabilities that *each* residue will have its specified type given the same information. ([[Rohl et al. 2004|Rosetta-canon#scoring]])

##### cbeta
The cbeta term is another solvation term intended to correct for the excluded volume effect introduced by the simulation and favor compact structures. It is based on the ratio of probabilities of a residue having a given number of neighbors in a compact structure vs. random coil and summed over all residues. ([[Rohl et al. 2004|Rosetta-canon#scoring]])

#####vdw
The vdw term represents **only steric repulsion** and not attractive van der Waals forces (those are modeled in terms rewarding compact structures, such as the rg term; local interactions are implicitly included from [[fragments|fragment-file]]). It is calculated over pairs of atoms only in cases where:
1. the interatomic distance is less than the sum of the atoms' van der Waals radii, and 
2. the interatomic distance does not depend on the torsion angles of a single residue. ([[Rohl et al. 2004|Rosetta-canon#scoring]])

#####rg
The rg term favors compact structures and is calculated as the root mean square distance between residue centroids. ([[Rohl et al. 2004|Rosetta-canon#scoring]])

#####cenpack

##### hs_pair
The hs_pair term describes packing between strands and helices. It is based on the probability that two pairs of residues (1 pair in the sheet and 1 pair in the helix) will have their current dihedral angles given the separation (in sequence and physical distance) between the helix and the strand. ([[Rohl et al. 2004|Rosetta-canon#scoring]])

##### ss_pair
The ss_pair term describes hydrogen bonding between beta strands. 
It is often used with the STRAND_STRAND_WEIGHTS statement (e.g. `STRAND_STRAND_WEIGHTS 1 6`):
* First value:  Set to 0 or 1 (all values > 0.5 treated as 1). If 1, includes a distance score term for strand pairing. 
* Second value: cutoff *sequence* distance between strands to be considered nonlocal (local strands get less of a score bonus for pairing). ([[Rohl et al. 2004|Rosetta-canon#scoring]])

##### sheet
The sheet term favors the arrangement of individual beta strands into sheets. It is derived from the probability that a structure with a given number of beta strands will have the current number of beta sheets and lone beta strands. ([[Rohl et al. 2004|Rosetta-canon#scoring]])

###Other common centroid score terms

#####rsigma
Scores strand pairs based on the distance between them and the register of the two strands. ([[Shmygelska and Levitt 2008|http://www.pnas.org/content/106/5/1415.full.pdf]])


#####co
Contact order ([[Shmygelska and Levitt 2008|http://www.pnas.org/content/106/5/1415.full.pdf]])


#####rama
As in full-atom scoring, the rama term describes the probability of a residue having a given set of torsion angles given its identity. ([[Shmygelska and Levitt 2008|http://www.pnas.org/content/106/5/1415.full.pdf]])


#####hb_srbb
Short-range backbone-backbone hydrogen bonding energy term ([[Shmygelska and Levitt 2008|http://www.pnas.org/content/106/5/1415.full.pdf]])

#####hb_lrbb
Long-range backbone-backbone hydrogen bonding energy term ([[Shmygelska and Levitt 2008|http://www.pnas.org/content/106/5/1415.full.pdf]])

#####rg_local



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
These score terms are specialized for use with membrane proteins and appear in membrane-specific score functions.  Descriptions from [[Alford et al. 2015|http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004398]]. 
#####mp_pair
Knowledge-based pairwise interaction potential between two residues some distance apart at a given depth in the membrane. Originally published in [[Yarov-Yarovoy et al. 2006|http://onlinelibrary.wiley.com/doi/10.1002/prot.20817/full]] (see E<sub>pair</sub> description).
#####mp_env
Knowledge-based potential describing propensity for a single residue to be at a given depth in the membrane and burial by residues. Originally published in [[Yarov-Yarovoy et al. 2006|http://onlinelibrary.wiley.com/doi/10.1002/prot.20817/full]] (see E<sub>env</sub> description).
#####mp_cbeta
Knowledge-based residue density potential based on number of neighbor residues and conditional upon number of transmembrane helices.  Originally published in [[Yarov-Yarovoy et al. 2006|http://onlinelibrary.wiley.com/doi/10.1002/prot.20817/full]] (see E<sub>density</sub> description). See also [[Rohl et al. 2004|Rosetta-canon#scoring]] for more information on residue density calculation. 
#####mp_lipo
Scores agreement between predicted lipophilicity (from [[LIPS server|http://gila.bioe.uic.edu/lab/lips/]]) and the model. See [[Adamian et al. 2005|http://onlinelibrary.wiley.com/doi/10.1002/prot.20456/full]] for additional information on lipophilicity predictions.
#####mp_nonhelix
Penalty for non-helical secondary structure in the membrane. Originally published in [[Yarov-Yarovoy et al. 2006|http://onlinelibrary.wiley.com/doi/10.1002/prot.20817/full]] (see "Search for Embeddings" section).
#####mp_termini
Penalty for residues outside of the hydrophobic layer of the membrane. Originally published in [[Yarov-Yarovoy et al. 2006|http://onlinelibrary.wiley.com/doi/10.1002/prot.20817/full]] (see "Search for Embeddings" section).
#####mp_tmproj
Penalty for transmembrane helices that project outside of the membrane. Originally published in [[Yarov-Yarovoy et al. 2006|http://onlinelibrary.wiley.com/doi/10.1002/prot.20817/full]] (see "Search for Embeddings" section).

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
Score function used in the second stage of the ClassicAbInitio protocol. Uses the env, pair, vdw, hs_pair, and sheet terms with equal weights and the ss_pair term with a lower weight.
#####score2
Score function used in the third stage of the ClassicAbInitio protocol. Relative to score1, it turns on the cbeta and cenpack terms at low weights and upweights the ss_pair term. It also decreases the sequence distance cutoff for STRAND_STRAND_WEIGHTS from 11 to 6.
#####score3
Score function used in the fourth stage of the ClassicAbInitio protocol. Upweights the cbeta and cenpack terms and turns on the rg and rsigma terms. Sets the value of ss_lowstrand (from STRAND_STRAND_WEIGHTS) to 0 (no distance score for strand pairs).
#####score4
While there is no base score4 score function, it is available as a patch and in smooth and cenrot versions. It introduces hydrogen bonding terms (hbond_lr_bb and hbond_sr_bb) and a rama term (ramachandran probability-based scores for residues based on phi/psi angles).
#####score5
Score function used in the third stage of the ClassicAbInitio protocol. Nearly identical to score2, but uses different STRAND_STRAND_WEIGHTS cutoff (see above)
#####RS_centroid
Formerly score6. Introduces a rama term, turns off scoring of rg, rsigma, sheet, and hs_pair, and reweights several terms (increases cenpack and cbeta; decreases pair, ss_pair, and vdw).
###Application-specific
These score functions are intended for use with a particular protocol or type of sampling.
#####interchain_cen
Commonly used in centroid docking; basically cen_std, but only evaluated between two chains and not within a single chain.
#####loop_fragsample
Very coarse score function used in SlidingWindowLoopClosure. Includes only env, pair, and vdw centroid terms plus the linear_chainbreak and overlap_chainbreak terms.
#####remodel_cen
#####abinitio_remodel_cen
#####fldsgn_cen

###Special cases

####RNA

#####coarse_rna

#####rna_lowres

####Membranes

#####mpframework_cen_2006
Standard weight set for the low-resolution membrane score function.
#####mpframework_docking_cen_2015
Used for centroid docking of membrane proteins (MP_Dock protocol)
#####mpframework_symdock_cen_2015
Used for centroid symmetric docking of membrane proteins (MP_SymDock protocol)
#####mpdocking_cen_14-7-23_no-penalties
Formerly used by the MPDockingMover (replaced by mpframework_docking_cen_2015).
#####mpdocking_cen_14-7-25_low-penalties

###Variants

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

#####abinitio_rob
Doubles the repulsive (vdw) weight of the score function.
#####docking_cen
Sets all of the interchain weights to the values that they have in the interchain_cen score function. Does not affect other score terms.
#####score4L
Turns on scoring for short-range and long-range backbone hydrogen bonding, a ramachandran term (phi/psi given residue type), and a chainbreak term; sets rg weight to 2. L is for loop.
#####score0, score1_smooth, score2_smooth, etc.
Sets all of the standard centroid score term weights to their values in the listed score function. (Interestingly, the vdw weight in the score0 patch is 1.0, while in the main score0 score function, it is 0.1. Is this a bug??)


##Which score function should I use?
The best centroid score function for your protocol will (of course) be protocol-dependent.
* Cen_std is the default centroid score function. It is a simple base score function and is often used with the score4L patch, especially for loop modeling.
* Score3 is commonly used and includes most of the common centroid score terms. 
* Centroid docking should use the interchain_cen score function or the docking_cen patch. 
* Centroid score functions/patches with a rama term (e.g. RS_centroid or the score4L patch) are especially useful for protocols that are not heavily dependent on fragment insertion (e.g. RS_centroid is used in the CentroidRelaxMover).





##See Also

* [[Scoring explained]]
* [[Score types]]
* [[Centroid vs fullatom]]
* [[CenRotModel]]
* [[Scorefunction history]]: history of the Rosetta scorefunction