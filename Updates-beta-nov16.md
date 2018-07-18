An overview of this energy function optimization effort is available [[here|Overview-of-Seattle-Group-energy-function-optimization-project]].

For information on the previous set of updates to this score function, see the beta nov15 score function page [[here|Updates beta nov15]].


For most protocols (those that use _getScoreFunction_ to set the protocol score function), the flag **-beta_nov16** _or_ simply **-beta** (which will always load the latest beta energy function) will load this version of the beta energy function.

For _RosettaScripts_ protocols, the flag **-beta_nov16** _or_ **-beta** must be provided, and the following scorefunction declaration must be made:

**\<beta weights=beta_nov16/\>** _or_ **\<beta weights=beta/\>**

### Optimized parameters 

Optimization followed the same scheme as [[beta_nov15|Updates beta nov16]], with new decoy sets for docking generated using beta_nov16.  Optimized parameters include:

* All LK dgfrees
* A set of terms controlling partial charges
* A set of terms controlling LK_ball geometry (e.g. distance/angle/torsion/fade to the ideal water position)
* A set of metaparameters controlling torsional "correction factors" applied to rama and fa_dun
* Weights on all torsional and LK subterms

Several rounds of refinement were carried out in which subsets of these terms were considered.

**Bridging water potential (lk_bridge and lk_bridge_uncpl)**

A term assessing the contribution of bridging water molecules has been incorporated into this scorefunction variant.  The term places ideal virtual waters on all polar groups, and the overlap between these virtual waters is provided as a bonus (the fade as the overlap decreases is fit as a parameter).  Additionally, the angle between the base atoms controls the strength of this bonus.  It is broken into two subterms:

* lk_bridge - the bonus is scaled by the desolvation of the two heavy atoms to each other
* lk_bridge_uncpl - the bonus is fixed

In beta_nov16, both terms are given equal weight, approximately **-0.3**.

**Intra-etable energies and torsional corrections**

In beta_nov16, all intra-res etable energies and intra-res fa_elec are enabled at the same weight as the corresponding intra-residue term.  All use Rhiju's xover4 variants to make count pair behavior consistent both intra- and inter-residue.  To avoid double counting, the torsional correction scheme of Conway and DiMaio (Prot. Sci. 2016) is applied to both fa_dun and rama.

Enabling these intra-res energies should (hopefully) improve interoperability with non-canonic amino acids as well as ligands/nucleic acids.

**sp3 hbond acceptors**

A modified potential for sp3 hbond acceptors has been implemented.  Rather than use an explicit torsional potential, it instead uses a "soft-max" potential between both "base atoms" (e.g. for serine, the angular term becomes soft-max(f_ang(CB-OG-Hdon),f_ang(HG-OG-Hdon) ).  This has been **enabled by default for water** since the previous potential was incorrect.  It is enabled for all sp3 acceptors in -beta_nov16.

**Reference weight fitting**

A new scheme for reference-weight fitting was used, where -- following fitting of all other terms -- we optimized the weighted sum of the following:
* One-at-a-time sequence profile recovery (similar to beta_nov15)
* One-at-a-time native-versus-design amino-acid distribution distance
* All-at-once sequence recovery
* All-at-once native-versus-design amino-acid distribution distance
* Prediction of protherm DDGs (following [[https://www.ncbi.nlm.nih.gov/pubmed/21287615]])
* Prediction of protease resistance of designs (from [[https://www.ncbi.nlm.nih.gov/pubmed/28706065]])

For the latter two metrics, rank correlation between experiment and simulation was used as the target function.  Weights on each set were chosen so that no individual test worsened significantly (>1% recovery or >0.01 correlation) during fitting.

**Other minor changes**

* The trie_vs_trie code in fa_elec has been refactored, eliminating mutable vars in the energy method.
* The default behavior of RRComparerElecDens has been updated following further visual inspection of its results
* The envdep_new code checked in as part of beta_nov15 has been removed (it was not used in beta_nov15 nor here)
* Small changes to rama_prepro param-file loading logic
* Hahnbeom's hxl_tors (from beta nov15 patch) has been incorporated, replacing the hydroxyl torsion potential from cart_bonded.


