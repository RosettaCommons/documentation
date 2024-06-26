<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
CartesianMD calls Molecular Dynamics simulation in Rosetta with user-defined energy function. Runs NVT simulation (constant volume and temperature) with Berendsen thermostat. Integrator uses Velocity Verlet algorithm

```xml
<CartesianMD name="(&string;)" rattle="(&bool;)" scorefxn="(&string;)"
        scorefxn_obj="(&string;)" nstep="(&integer;)" temp="(&real;)"
        premin="(&integer;)" postmin="(&integer;)" report="(&integer;)"
        report_scorecomp="(&bool;)" selectmode="(&string;)" schfile="(&string;)" />
```

-   **rattle**: Use Rattle algorithm to constraint hydrogen locations. This automatically sets integration step = 2fs. Otherwise uses integration step = 1fs
-   **scorefxn**: Specify a scorefunction to run MD simulation with
-   **scorefxn_obj**: Optional, identical to scorefxn unless specified. Specify a scorefunction to use as objective function for selecting a pose from trajectory. This will be used only when selectmode="minobj"
-   **nstep**: Number of steps to simulate. With Rattle on (default) each step is 2fs, and hence, nstep=10000 will be 20ps
-   **temp**: Reference temperature for constant temperature simulation. Recommended values: 150~200K for talaris2014_cart and ~250 for beta_nov15_cart
-   **premin**: Steps of Cartesian minimization before MD simulation
-   **postmin**: Steps of Cartesian minimization after MD simulation
-   **report**: By how often the mover reports the simulation status to log
-   **report_scorecomp**: Whether to report score components to log
-   **selectmode**: How to select single pose from the trajectory. "final" to take the final pose, "minobj" to take the lowest objective function (by scorefxn_obj) pose
-   **schfile**: Use user-defined schedule file. This overrides any other flags or options. Syntax: "sch [temperature] [nsteps]" to run simulation, or "repack" to repack side-chains

---
