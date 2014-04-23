# Rosetta Graphics output and Graphical User Interfaces

#Graphics Output
##OpenGL Graphics mode

##Pymol Mover
###Background
The PyMOL Mover is a way to visualize your decoy (PDB) in PyMOL. One of its most powerful features is that it can color your decoy by score, or some component of the total score, as well. 

The PyMOL Mover can be accessed through RosettaScripts, PyRosetta, or at the command line.

###Usage
####RosettaScripts
Relevant Flags:

####PyRosetta

####Command Line

```
-show_simulation_in_pymol [Real]     Both turns on show simulation and indicates the frequency a pose 
                                      is sent to pymol in seconds

-keep_pymol_simulation_history       Keep the history of the simulation as seperate frames in pymol

```
###Drawbacks and workarounds
If Length changes are occurring during the run, the PyMOL Mover may segfault as it tries to send the pose before certain components of the conformation are updated.  There is currently no work around to this.  

#Graphical User Interfaces

##Fold-It

##PyRosetta Toolkit