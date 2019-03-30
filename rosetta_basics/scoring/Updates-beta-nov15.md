**Note:** this parameterization has been superseded by [[beta_nov16|Updates-beta-nov16]].

An overview of this energy function optimization effort is available [[here|Overview-of-Seattle-Group-energy-function-optimization-project]].

For information on the previous set of updates to this score function, see the beta july15 score function page [[here|Updates beta july15]].

For benchmark results of protocols, see [[here|beta-nov15-benchmark-results]].

### Using the beta_nov15 energy function parameters

For most protocols (those that use _getScoreFunction_ to set the protocol score function), the flag **-beta_nov15** will load this version of the beta energy function.

For _RosettaScripts_ protocols, the flag **-beta_nov15** must be provided, and the following scorefunction declaration must be made:

**\<beta weights=beta_nov15/\>**

### Optimized parameters 

Optimization followed the same scheme as [[beta_july15|Updates-beta-july15]], and used that function as a starting point.  However, in addition to optimizing several new parameters, modifications were made to the target function used during optimization:

* New docking and decoy discrimination sets were generated using beta_july15
* The distance distribution metric was modified to compute RMS error rather than error sum, and to weaken over-represented atom pairs, to address poor polar distance distributions in the July 2015 version

**Electrostatics & partial charges (fa_elec)**

In this optimization we considered optimizing individual atomic partial charges.  To reduce the number of parameters as well as maintain the overall charge of the molecules, we used the following scheme:
* Break each residue in 2 backbone and 1 sidechain group
* Maintain the overall charge of that group (-1/0/+1) but fit a group scalefactor that increases the overall range of partial charges within that group
* Group together all backbone groups (so there is only one NH group parameter and one CO group parameter) and all non-polar, non-aromatic sidechains

More importantly, an issue where the count-pair logic in Rosetta was splitting dipoles has been corrected.  This is fixed by specifying a "representative atom" for each atom that is used for countpair purposes.  This is specified using the flag **-elec_representative_cp** or **-elec_representative_cp_flip** which uses the minimum or maximum length within each group, respectively, when determining what count pair multiplier to apply.  The beta_nov15 energy function uses the maximum length (**-elec_representative_cp_flip**).

**Hatr (fa_atr for hydrogens)**

Attractive energies were enabled for hydrogen atoms (**-fa_Hatr**), and LJ parameters were refit.  Due to the significant changes this induces in the LJ parameters, this refitting was initially guided entirely by agreement to biophysical data using small molecule liquid simulations, then using the complete target function.

**Torsion library updates (fa_dun/rama_prepro/p_aa_pp)**

Several torsional updates were included before optimization:
* A new computed and smoothed version of the fa_dun and p_aa_pp energies was provided by Maxim Shapovalov and Roland Dunbrack
* Separate pre-proline and pre-non-proline rama potentials were computed and are now used, replacing **rama** with a new scoreterm **rama_prepro**
     * Note that **rama_prepro** was not initially compatible with noncanonicals, D-amino acid residues, or cyclic geometry.  As of 23 February 2016, it has been updated by Vikram K. Mulligan to work with all of these.
     * For fully noncanonical residues, the term returns 0 for the energy and the derivatives, unless the noncanonical specifies a canonical residue in a BACKBONE_AA line in its params file.  (In that case, the canonical residue's **rama_prepro** tables are used).
     * For D-residues with a canonical L-resiude equivalent, the L-residue **rama_prepro** tables are inverted and used.  The **-symmetric_gly_tables** option will symmetrize the **rama_prepro** tables for glyceine, and this flag is recommended for mixed D/L design.
     * The **rama_prepro** term no longer makes any assumptions about residue i being connected to residue i+1 or i-1.  It actually checks for connections, and is therefore compatible with cyclic geometry, now.
* Weights on all torsional terms were refit as part of the optimization process

**Bondlength, bondangle and planarity restraints (cart_bonded)**

Bondlength and bond angle parameters were updated in several ways.  Initially, several errors in the cart_bonded parameter file were corrected:

* Due to the way they were calculated initially from parameter files, several proline parameters from Rosetta were initially incorrect, particularly the CD-N-CA angle, but any angle/length involving the CD-N bond.  These have all been set to their Engh & Huber values.
* Due to a typo, PHE CB pseudotorsions were not calculated
* There were inconsistencies between HIS and HIS_D restraints

Secondly, optimization was carried out with the spring constants used in cart bonded.  All angles, lengths, and torsions were divided into 130 "classes", and a scaling factor was calculated for each class.  These scaling factors were optimized using two criteria:

* Landscape quality following Cartesian relax
* Gradient magnitude following crystallographic re-refinement

**Miscellaneous**

Several minor modifications were made to the energy function as well:

* The fade-width of LK-ball solvation was reduced slightly
* Reference weights were again refit

##See Also

* [[Scoring explained]]
* [[Scorefunction history]]
* [[RosettaEncyclopedia]]