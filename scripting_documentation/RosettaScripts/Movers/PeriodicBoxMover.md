# PeriodicBoxMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PeriodicBoxMover

This mover runs Monte Carlo (MC) simulation in isothermal-isobaric (NPT) condition on a periodic boundary box. Can be applied to a broad range of (small molecules) to extract their thermodynamic properties. Currently it has been applied to running liquid-state simulation of small molecules; see Park et al (2016), "Simultaneous optimization of biomolecular energy function on features from small molecules and macromolecules", _JCTC_. Details will be added more in near future. 

    <PeriodicBoxMover name=(&string) scorefxn=(&string)
                      nmol_side=(5 &Size) nsteps_equilibrate=(500000 &Size) nsteps_sim=(1000000 &Size) 
                      vol_step=(40.0 &Real) rot_step=(15.0 &Real) tor_step=(15.0 &Real) resize_vol_every=(&Size)
                      temp=(160.0 &Real) pressure=(1.0 &Real) correct_LJtruncation=(false &bool)
                      report_scorefile=(&string) dump_every=(0 &Size) report_every=(0 &Size) report_thermodynamics=(0 &Size)            
                      initial_density=(1.0 &Real) istart=(0 &Size) />

-  scorefxn - weights file for the simulation. 
-  nmol\_side - number of molecules per each dimension; total molecules = nmol\_side^3
-  steps\_equilibrate - number of MC steps for equilibration
-  steps\_sim - number of MC steps for production simulation
-  vol\_step - maximum magnitude of the total volume change movement of simulation box. Proper value may vary on nmol\_side.  
-  rot\_step - maximum magnitude of the rotational movement. 
-  tor\_step - maximum magnitude of the torsion movement. Will try to rotate the torsions given in the residue file.
-  resize\_vol\_every - how often volume movement is called during MC. otherwise will randomly call either rotation or torsion movement. 
-  temp - temperature in Kelvin
-  pressure - Pressure in atm.
-  correct\_LJtruncation - whether to add the correction coming from long-range LJ interaction (by integrating over the distance from fa_max_dis to infinity); **should be turned on for liquid simulation.**
-  report\_scorefile - name of the file to report energy components along the trajectory.
-  dump\_every  - how often will dump the silent file (if requested)
-  report\_every  - how often will dump the energy components to score file.
-  report\_thermodynamics  - how often will report thermodynamic properties -- currently not very useful.
-  initial\_density - initial density of small molecules in g/cm^3. initial guess is 1.0 from water, but in general other small molecules have lower densities.
-  istart - simulation step to begin with; used for continuing simulation.

### Restarting simulation
TBA

### Liquid simulation related
- All the example weights, options in xml, command line is provided in Park et al (2016).
- Analyzing the result:
 One can calculate liquid properties such as "heat of vaporization", "density", "heat capacity", and so on, by processing the report\_scorefile. For an example analysis script, please contact to Hahnbeom Park (hahnbeom@gmail.com). 

