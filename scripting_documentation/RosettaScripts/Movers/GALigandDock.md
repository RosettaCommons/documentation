## Overview

The GALigandDock mover is meant to be used in combination with the [[generic-potential|Updates-beta-genpot]]. It uses a genetic algorithm to sample/evolve a population of ligand conformers, and takes advantage of pre-computation of scoreterms on a grid to speed up docking.

### Mover

The docking mover is exposed through the [[RosettaScripts]] application, and the XML format is quite flexible. 
The tag `<GALigandDock>` defines several options associated with the mover, mostly dealing with properties of the grid computation, but several "global" protocol options as well:

* **scorefxn** - the scorefunction used in docking.  _gen_bonded_ should be on with weight 1.0!
* **scorefxn_relax** - the scorefunction used in final relaxation.  _gen_bonded_ should be on with weight 1.0!
* **runmode** - supports 4 runmodes each of which calls pre-defined parameters for own purpose:

An example script:
```xml
    <ScoreFunction name="dockscore" weights="beta">
      <Reweight scoretype="fa_rep" weight="0.2"/>
      <Reweight scoretype="coordinate_constraint" weight="0.1"/>
    </ScoreFunction>
    <ScoreFunction name="relaxscore" weights="beta_cart"/>
    <GALigandDock name="dock" runmode="%%runmode%%" scorefxn="dockscore" scorefxn_relax="relaxscore" />

```

Example xml scripts using "runmode" argument are provided below.

**Self docking**
Self docking, when no change in receptor conformation is expected. 1~5 repeats recommended, each takes 3~10 minutes:
```xml
    <GALigandDock name="dock" runmode="dockrigid" scorefxn="dockscore" scorefxn_relax="relaxscore" />
```
**Cross docking**
When change in receptor conformation is expected. 5~10 repeats recommended, each takes 15~30 minutes:
```xml
    <GALigandDock name="dock" runmode="dockflex" scorefxn="dockscore" scorefxn_relax="relaxscore"/>
```
**Virtual screening-High accracy** 
Allow receptor flexibility and more rigorous entropy calculation. Single run recommended for efficiency. Each takes 10~15 minutes.
```xml
    <GALigandDock name="dock" runmode="VSH" scorefxn="dockscore" scorefxn_relax="relaxscore" nativepdb="holo.pdb"/>
```

**Virtual screening, fast version** 
Without receptor flexibility and simpler entropy calculation. Single run recommended for efficiency. Don't use this mode now -- under development. 
```xml
    <GALigandDock name="dock" runmode="VSX" scorefxn="dockscore" scorefxn_relax="relaxscore" nativepdb="holo.pdb"/>
```

### More advanced options:

An example shown below:
```xml    
    <ScoreFunction name="dockscore" weights="beta">
      <Reweight scoretype="fa_rep" weight="0.2"/>
      <Reweight scoretype="coordinate_constraint" weight="0.1"/>
    </ScoreFunction>
    <ScoreFunction name="relaxscore" weights="beta_cart"/>
    <GALigandDock name="dock" scorefxn="dockscore" scorefxn_relax="dock" grid_step="0.25" padding="5.0" hashsize="8.0" subhash="3" nativepdb="holo.pdb" final_exact_minimize="sc" random_oversample="10" rotprob="0.9" rotEcut="100"  sidechains="aniso" initial_pool="holo.pdb" >
        <Stage repeats="100" npool="50" pmut="0.2" smoothing="0.375" rmsdthreshold="2.0" maxiter="50" pack_cycles="100" ramp_schedule="0.1,1.0"/>
    </GALigandDock>
```

#### Global protocol parameters
Arguments called inside GALigandDock line:

**Grid setup**

* **grid_step**, **padding** - when building a grid covering the binding pocket, use this grid spacing, and pad the area by this amount.  **0.25** and **5** is recommended.
* **hashsize**, **subhash** - Parameters controlling how the grid computation is handled.  At a grid_step of 0.25, **8** and **3**, respectively, lead to best performance

**General parameters**

* **random_oversample** - oversample the initial population by this factor (recommended 10)
* **nativepdb** - if given, ligand RMS will be reported in the output
* **multiple_ligands** - comma-separated, provides name of ligands (appears in params file) to dock sequentially

**Receptor flexibility setup**

* **sidechains** - sidechain optimization strategy. **none**: only dock ligands.  **auto**: auto-select all pocket sidechains.  **aniso**: autoselection logic accounting for the shape (not just center of mass) of ligand in input conformation **\<residue specifier\>** (e.g. "22A,25A"): explicit sidechain flexibility specification
* **rotprob**, **rotEcut**, when generating rotamers to sample, use this cumulative probability and backround energy to trim set.  **0.9** and **100**, respectively, recommended
* **favor_native** - bonus score to the input rotamer (only in grid stage), helps to preseve input sidechain rotamer
* **optimize_input_H** - run optimize_H before/after docking.

**Final processing**
* **final_exact_minimize** - optionally perform a final off-grid optimization.  **none**: no optimization is performed. **sc**: sidechain optimization only is performed.  **bbsc**: cart-min of flexible residues is performed.  **bbscN**: cart-min of flexible residues *plus N residues up and downstream*
* **cartmin_lig** - run quick cartmin on ligand-only before and after final_exact_relax
* **min_neighbor** - also minimize neighbors while doing cartmin_lig
* **move_water** - allow water molecules to move during final_exact_relax
* **fastrelax_script** - provide user-custom fast relax script for final exact_minimize.
* **estimate_dG** - run entropy correction at the end of run.

**Reference-guided docking**

* **initial_pool** - manually specify a set of structures in the first generation.  A comma separated list of PDBs _or_ silent files.
* **reference_pool** - either "input" or ligand pdbname(s) (separated by comma). Assigning "input" will invoke pharmacophore detection. Assigning ligand pdb(s) will allow to run reference-aligned docking.
* **reference_oversample** - Sets how many times to sample over npool*reference_frac.
* **reference_frac** - What fraction of npool is sampled from reference_pool.
* **reference_frac_auto** - [Only for pharmacophore docking] Automatically sets reference_frac based on problem complexity. 
* **use_pharmacophore** - Run pharmacophore-guided docking. Input arguments with reference_pool should be compatatible.
A series of `<Stage>` tags defines the protocol.  These tags, when applied in order, define the flow of the genetic algorithm.  

####Per-stage control
Arguments called with separate "Stage" tags.
* **repeats**, **npool** - the number of GA generations, and pool size for each generation.
* **pmut** - mutation probability (1-pmut gives crossover prob).  **0.2** recommended.
* **smoothing** - "soften" grid calculations by this value (in A).  For cross-docking, a value of 0.375 (with grid spacing of 0.25) gives notably better results.  Note this is distinct from the repulsive ramping option below.
* **rmsdthreshold** - maintain pool diversity by considering structures < this distance identical.  1.5A recommended.
* **maxiter**, **pack_cycles** - number of minimize steps and packer cycles at each generation (**50** and **100** seem to work well and run in reasonable time)
* **ramp_schedule** - the repulsive ramping schedule for each generation.  **"0.1,1.0"** seems to work well.

### Inputs and outputs

The input file should be a pdb with the ligand placed approximately in the pocket to be searched.  Only the _center-of-mass_ and _radius_ of this ligand is used by the protocol. More information can be found [[here|GALigandDock-Preprocessing]].

Outputs use the RosettaScripts multi-output framework, and thus recognize any RosettaScripts output flag for controlling output.  The entire ensemble is output by the mover (thus a single input will have many output structures).

**Possible tricky issues**:
* The code initially idealizes and minimizes the sidechain geometry of all flexible sidechains.  This can lead to two possible issues with structures that deviate significantly from ideality: 1) "initial_pool" structures that are not idealized will be slightly perturbed initially when added to the pool.  2) for input structures that are very non-ideal, this initial "correction" may lead to high energies for the input sidechain.
* Pocket radius is defined as the input ligand radius plus the **padding** parameter.  Caution should be paid when using very small or very large ligands, particularly with the **"auto"** sidechain option.  For large ligands, the **"aniso"** option may be preferred.