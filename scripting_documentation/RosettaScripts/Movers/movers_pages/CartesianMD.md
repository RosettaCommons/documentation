# CartesianMD
*Back to [[Mover|Movers-RosettaScripts]] page.*
## CartesianMD

CartesianMD calls Molecular Dynamics simulation in Rosetta with user-defined energy function. Runs NVT simulation (constant volume and temperature) with Berendsen thermostat. Integrator uses Velocity Verlet algorithm. Strongly recommended to use the Mover with Rosetta version since February 2016; there was certain issues with the Mover in previous versions.

```xml
<CartesianMD name="&string"
       rattle="(true &false)"
       scorefxn="('' &string)"
       scorefxn_obj="('' &string)"
       nstep="(100 &Size)"
       temp="(300.0 &Real)"
       premin="(50 &Size)"
       postmin="(200 &Size)"
       report="(100 &Size)"
       report_scorecomp="(false &bool)"
       selectmode="('final' &string)"
       schfile="('' &string)" />
```

-   rattle: Use Rattle algorithm to constraint hydrogen locations. This automatically sets integration step = 2fs. Otherwise uses integration step = 1fs.
-   scorefxn: Specify a scorefunction to run MD simulation with.
-   scorefxn\_obj: Optional, identical to scorefxn unless specified. Specify a scorefunction to use as objective function for selecting a pose from trajectory. This will be used only when selectmode="minobj". 
-   nstep: Number of steps to simulate. With Rattle on (default) each step is 2fs, and hence, nstep=10000 will be 20ps.
-   temp: Reference temperature for constant temperature simulation. Recommended values: 150~200K for talaris2014_cart and ~250 for beta_nov15_cart.
-   premin: Steps of Cartesian minimization before MD simulation
-   postmin: Steps of Cartesian minimization after MD simulation
-   report: By how often the mover reports the simulation status to log.
-   report\_scorecomp: Whether to report score components to log.
-   selectmode: How to select single pose from the trajectory. "final" to take the final pose, "minobj" to take the lowest objective function (by scorefxn\_obj) pose. 
-   schfile: Use user-defined schedule file. This overrides any other flags or options. 
Syntax: "sch [temperature] [nsteps]" to run simulation, or "repack" to repack side-chains.
An example schedule file to run simulated annealing:
```
sch 300 10000 
sch 250 10000 
sch 200 10000 
sch 150 10000 
```

This mover can also take an optional MoveMap (see [[FastRelax|FastRelaxMover]] documentation for details) to define the residue subset to which it should be applied. In the absence of the MoveMap, the mover is applied to the whole pose.



