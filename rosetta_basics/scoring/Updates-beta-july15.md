**Note:** this parameterization has been superseded by [[beta_nov15|Updates-beta-nov15]].

An overview of this energy function optimization effort is available [[here|Overview-of-Seattle-Group-energy-function-optimization-project]].

### Using the beta_july15 energy function parameters

For most protocols (those that use _getScoreFunction_ to set the protocol score function), the flag **-beta_july15** will load this version of the beta energy function.

For _RosettaScripts_ protocols, the flag **-beta_july15** must be provided, and the following scorefunction declaration must be made:

**\<beta weights=beta_july15/\>**

### Optimized parameters 

**LK_ball model**

The most significant change in beta_july15 is the addition of an anisotropic polar solvation model for polar sidechain atoms.  This uses Phil Bradley's lk_ball model, where -- for polar sidechain atoms -- virtual water sites are placed in ideal geometry, and the solvation model uses a weighted sum of the distance to the virtual water site and the distance to the heavyatom when calculating how desolvated a polar sidechain atom is.  The net effect is increased desolvation cost when placing an occluding atom near one of these virtual waters.

**LK parameters (fa_sol)**

Following introduction of the lk_ball anisotropic polar solvation model, the LK parameters were refit following our energy function optimization scheme.  Initially, several manual modifications were manually made:
* LK_VOLUMES were recalculated using the Rosetta VDW radii using the formula from the original paper (different from original paper)
* Several mistyped atoms in Rosetta were corrected: CYS SG, ARG CZ, TRP CE2, and aromatic CGs
* LK_LAMBDAs for charged atoms were reduced from 6.0Å to 3.5Å; due to the 6Å truncation of Rosetta, these were oddly behaved
* Finally, many polar atoms were further divided into subtypes

Then, using the LK-ball anisotropic solvation model, the DGFREEs of all atom types were refit following our optimization criteria.  As with the original LK paper, agreement to liquid-vapor transfer free energies was used as a strong constraint on optimization.

**LJ parameters (fa_atr/fa_rep)**

The LJ parameters (both LJ_RADIUS and LJ_WDEPTH) for all atom types were refit during energy function optimization.  Three strong constraints were employs to keep these parameters physically realistic:
* Agreement to small molecule heats of vaporization and liquid density
* Agreement of atom pair distance distributions of relaxed structures and high-resolution crystal structures
* Minimization of forcefield gradients following crystallographic refinement

**Electrostatics dielectric model (fa_elec)**

A sigmoidal dielectric model was used in place of the default distance-dependent dielectic.  Three parameters control the short range dielectric, long range dielectric, and the fade between the two.  Initially these parameters were chosen to match the original dielectric as closely as possible; they were subsequently included as free parameters in optimization.

**Hydrogen bond strengths**

Per-donor and per-acceptor hydrogen bond weights were optimized following our optimization criteria.  A weak tethering constraint in our "energy function goodness" target function was used to keep these weights uniform.

**Miscellaneous**

Several minor modifications were made to the energy function as well:
* The artificial OCbb-OCbb repulsive force was removed (**-unmodifypot**)
* Reference energies were refit following these changes


##See Also

* [[Scoring explained]]
* [[Scorefunction history]]
* [[RosettaEncyclopedia]]