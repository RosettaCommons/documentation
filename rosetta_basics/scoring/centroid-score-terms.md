#Centroid score terms in Rosetta

###NOTE: This is not a complete listing of centroid score terms. Please expand if you have more information!

The following information is adapted from [[Rohl et al. 2004|Rosetta-canon#scoring]]:


#####env
The `env` score term is a context-dependent one-body energy term that describes the solvation of a particular residue (based on the hydrophobic effect). It is based on the probability of a residue having the specified type given its number of neighboring residues.

#####pair
The `pair` score term is a two-body energy term for residue pair interactions (electrostatics and disulfide bonds). For each pair of residues, it is based on the probability that *both* of these two residues will have their specified types given their sequence separation and the physical distance between them, normalized by the product of the probabilities that *each* residue will have its specified type given the same information.

#####ss_pair
The ss_pair term describes hydrogen bonding between beta strands.

#####sheet
The sheet term favors the arrangement of individual beta strands into sheets. It is derived from the probability that a structure with a given number of beta strands will have the current number of beta sheets and lone beta strands.

#####hs_pair
The hs_pair term describes packing between strands and helices. It is based on the probability that two pairs of residues (1 pair in the sheet and 1 pair in the helix) will have their current dihedral angles given the separation (in sequence and physical distance) between the helix and the strand.

#####rg
The rg term favors compact structures and is calculated as the root mean square distance between residue centroids.

#####cbeta
The cbeta term is another solvation term intended to correct for the excluded volume effect introduced by the simulation and favor compact structures. It is based on the ratio of probabilities of a residue having a given number of neighbors in a compact structure vs. random coil and summed over all residues.

#####vdw
The vdw term represents **only steric repulsion** and not attractive van der Waals forces (those are modeled in terms rewarding compact structures, such as the rg term; local interactions are implicitly included from [[fragments|fragments-file]]). It is calculated over pairs of atoms only in cases where:
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


#####cen_env_smooth
#####cen_pair_smooth
#####cenpack_smooth
#####cbeta_smooth
#####rg_local

##See Also

* [[Scoring explained]]
* [[Score types]]
* [[Centroid vs fullatom]]