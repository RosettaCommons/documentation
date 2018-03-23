## Overview

The GALigandDock mover is meant to be used in combination with the [[Updates-beta-genpot||generic-potential]. 

An example usage is given below:
```xml
    <GALigandDock name="dock" scorefxn="relaxscore" grid_step="0.25" padding="5.0" hashsize="8.0" subhash="3" nativepdb="holo.pdb" final_exact_minimize="bbsc1" init_oversample="10" rotprob="0.9" rotEcut="100" altcrossover="0" sidechains="auto" initial_pool="holo.pdb" >
        <Stage repeats="20" npool="50" pmut="0.2" smoothing="0.375" rmsdthreshold="1.5" maxiter="50" pack_cycles="100" ramp_schedule="0.1,1.0"/>
    </GALigandDock>
```
