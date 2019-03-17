## Overview

The GALigandDock mover is meant to be used in combination with the [[generic-potential|Updates-beta-genpot]]. It uses a genetic algorithm to sample/evolve a population of ligand conformers, and takes advantage of pre-computation of scoreterms on a grid to speed up docking.

### Mover

The docking mover is exposed through the [[RosettaScripts]] application, and the XML format is quite flexible. 
 An example usage using "runmode" arguement is given below:
```xml
    <ScoreFunction name="dockscore" weights="beta">
      <Reweight scoretype="fa_rep" weight="0.2"/>
      <Reweight scoretype="coordinate_constraint" weight="0.1"/>
    </ScoreFunction>
    <ScoreFunction name="relaxscore" weights="beta_cart"/>
    <GALigandDock name="dock" scorefxn="dockscore" scorefxn_relax="relaxscore" runmode="dockflex" nativepdb="holo.pdb"/>
```

or, an example with more detailed control:
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

The tag `<GALigandDock>` defines several options associated with the mover, mostly dealing with properties of the grid computation, but several "global" protocol options as well:

* **scorefxn** - the scorefunction used in docking.  _gen_bonded_ should be on with weight 1.0!
* **scorefxn_relax** - the scorefunction used in final relaxation.  _gen_bonded_ should be on with weight 1.0!
* **runmode** - supports 4 umbrella modes which calles pre-defined parameters for purposes:

* "dockflex" [default]: Run docking with flexible ligand and _receptor_ (upto backbone flexibilty)
* "dockrigid": Run docking with flexible ligand only 
* "VSH": High-accuracy virtual screening. Run docking with flexible ligand & receptor sidechains followed by entropy estimation.  
* "VSX": Express virtual screening. Run docking with flexible ligand only & simple scheduling followed by faster entropy estimation.

More advanced options:
* **grid_step**, **padding** - when building a grid covering the binding pocket, use this grid spacing, and pad the area by this amount.  **0.25** and **5** is recommended.
* **hashsize**, **subhash** - Parameters controlling how the grid computation is handled.  At a grid_step of 0.25, **8** and **3**, respectively, lead to best performance
* **nativepdb** - if given, ligand RMS will be reported in the output
* **final_exact_minimize** - optionally perform a final off-grid optimization.  **none**: no optimization is performed. **sc**: sidechain optimization only is performed.  **bbsc**: cart-min of flexible residues is performed.  **bbscN**: cart-min of flexible residues *plus N residues up and downstream*
* **init_oversample** - oversample the initial population by this factor (recommended 10)
* **rotprob**, **rotEcut**, when generating rotamers to sample, use this cumulative probability and backround energy to trim set.  **0.9** and **100**, respectively, recommended
* **sidechains** - sidechain optimization strategy. **none**: only dock ligands.  **auto**: auto-select all pocket sidechains.  **aniso**: autoselection logic accounting for the shape (not just center of mass) of ligand in input conformation **\<residue specifier\>** (e.g. "22A,25A"): explicit sidechain flexibility specification
* **initial_pool** - manually specify a set of structures in the first generation.  A comma separated list of PDBs _or_ silent files.

A series of `<Stage>` tags defines the protocol.  These tags, when applied in order, define the flow of the genetic algorithm.  There are a few options in each stage:
* **repeats**, **npool** - the number of GA generations, and pool size for each generation.
* **pmut** - mutation probability (1-pmut gives crossover prob).  **0.2** recommended.
* **smoothing** - "soften" grid calculations by this value (in A).  For cross-docking, a value of 0.375 (with grid spacing of 0.25) gives notably better results.  Note this is distinct from the repulsive ramping option below.
* **rmsdthreshold** - maintain pool diversity by considering structures < this distance identical.  1.5A recommended.
* **maxiter**, **pack_cycles** - number of minimize steps and packer cycles at each generation (**50** and **100** seem to work well and run in reasonable time)
* **ramp_schedule** - the repulsive ramping schedule for each generation.  **"0.1,1.0"** seems to work well.

### Inputs and outputs

The input file should be a pdb with the ligand placed approximately in the pocket to be searched.  Only the _center-of-mass_ and _radius_ of this ligand is used by the protocol.

Outputs use the RosettaScripts multi-output framework, and thus recognize any RosettaScripts output flag for controlling output.  The entire ensemble is output by the mover (thus a single input will have many output structures).

**Possible tricky issues**:
* The code initially idealizes and minimizes the sidechain geometry of all flexible sidechains.  This can lead to two possible issues with structures that deviate significantly from ideality: 1) "initial_pool" structures that are not idealized will be slightly perturbed initially when added to the pool.  2) for input structures that are very non-ideal, this initial "correction" may lead to high energies for the input sidechain.
* Pocket radius is defined as the input ligand radius plus the **padding** parameter.  Caution should be paid when using very small or very large ligands, particularly with the **"auto"** sidechain option.  For large ligands, the **"aniso"** option may be preferred.