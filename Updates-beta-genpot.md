An overview of this energy function optimization effort is available [[here|Overview-of-Seattle-Group-energy-function-optimization-project]].

For information on the previous set of updates to this score function, see the beta nov16 score function page [[here|Updates beta nov16]].

For most protocols (those that use _getScoreFunction_ to set the protocol score function), the flag **-gen_potential** _or_ simply **-beta** (which will always load the latest beta energy function) will load this version of the beta energy function.

For _RosettaScripts_ protocols, the flag **-gen_potential** _or_ **-beta** must be provided, and the following scorefunction declaration must be made:

**\<ScoreFunction name="beta" weights="beta_genpot"/\>** _or_ **\<ScoreFunction name="beta" weights="beta"/\>**

### New atom typing

An alternate atom typing scheme has been introduced.  An alternate param file generation app, _scripts/python/public/generic_potential/mol2genparams.py_ has been added to handle parameter generation with the new atom typing. NOTE: this new typing is completely separate from protein atom typing. Fore more information how thse atom types are defined and how this works, see [[here|GenericAtomtypes]].
* A generic torsional potential, _gen_bonded_ has been added using these new types. This potential is _undefined (returning 0) for non-ligand residues_. 
* LK and LJ parameters have been fit for these new atom types using a combination of small molecule crystal data and ligand-bound protein structures.

## Ligand docking

A new ligand docking protocol has been added, [[GALigandDock]], that takes advantage of this new generic potential. It combines fast scoring on a precomputed grid with a genetic algorithm to allow very accurate ligand docking in 3-10 CPU minutes total per target (fixed sidechain) or 10-30 CPU minutes total (flexible sidechain).

### Ligand preparation
Whole process preparing for GALigandDock runs starting from SMILES string or a mol2 file and assigning proper Generalized atom types through mol2genparams.py can be found [[here|GALigandDockpreprocessing]].
