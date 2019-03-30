### Energy function optimization overview

This energy function optimization aims to reparameterize the Rosetta energy function subject to several different constraints:

* Performance on various structure prediction tasks, including rotamer recovery, protein-protein docking, and decoy discrimination
* Performance on protein design, assessed using fixed backbone sequence profile recovery
* Agreement to biophysical data, including liquid vapor transfer free energies, and heats of vaporization and density of small molecules in liquid state
* Agreement to high-resolution structural data, by assessing agreement of atom-pair distance distribution to high-resolution natives, and the magnitude of forcefield gradients following crystallographic re-refinement

These constraints are encoded as an "energy function goodness" target function and derivative free optimization of a relevant subset of energy function parameters is performed, maximizing this function.  The relative weights of each of the criteria listed above are selected in an ad hoc manner; ideally, weights are chosen such that no individual test worsens following optimization.

Many rounds of optimization have been performed, optimizing different subsets of energy function parameters.  Periodically, these optimized parameter sets are tested on independent data. Large improvements are added as a flag to Rosetta.

These flags include (more details of specific improvements can be seen by following the links below):
* [[beta_july15|Updates-beta-july15]] - optimization of solvation and LJ parameters, introduction of anisotropic polar solvation (LK-ball)
* [[beta_nov15|Updates-beta-nov15]] - optimization of electrostatic parameters, updated torsion parameters, updated bonded parameters, enabling LJ attraction for hydrogens
* [[beta_nov16|Updates-beta-nov16]] - enabling all intra-residue etable and electrostatics, adding an implicit bridging water potential
    * [[WaterBoxMover]] - a protocol specific to beta_nov16, adding a method for conformational sampling of ordered "bridging" water molecules
* [[beta_genpot|Updates-beta-genpot]] - a generic all-atom potential is used for ligands

For brief explanation of new terms (e.g. rama_prepro and so on), follow this [[link|score-types#references_additional-energy-terms-for-beta-energy-functions]]

### Using the updated energy function

For most protocols (those that use _getScoreFunction_ to set the protocol score function), the flag **-beta** will load the _latest version_ of the beta energy function.

For _RosettaScripts_ protocols, the flag **-beta** must be provided, and the following scorefunction declaration must be made:

**\<beta weights=beta/\>**

Additionally, variants of the scorefunction may be specified through RosettaScripts or through the flag **-score::weights**:

* **beta_cart.wts** - for non-ideal or Cartesian refinement
* **beta_cst.wts** - for protocols which need constraint energies enabled
* **beta_soft.wts** - a "soft repulsive" version (analogous to soft_rep for score12)

## See Also

* [[Scoring explained]]: Overview of scoring in Rosetta
* [[Scorefunction History]]
* [[RosettaEncyclopedia]]