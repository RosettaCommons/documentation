# Rosetta Graphics output and Graphical User Interfaces

#Graphics Output
##OpenGL Graphics mode

##Pymol Mover
###Background
The PyMOL Mover is a way to visualize your decoy (PDB) in PyMOL. One of its most powerful features is that it can color your decoy by score, or some component of the total score, as well. 

The PyMOL Mover can be controlled through RosettaScripts, PyRosetta, or through the command line.

###Usage
####RosettaScripts
[[See RosettaScripts Documentation | Movers-RosettaScripts#PyMolMover]]

####PyRosetta
[See PyRosetta Documentation](http://www.pyrosetta.org/tutorials#TOC-PyMOL_Mover)

####Command Line

```
-show_simulation_in_pymol [Real, default=5]   Both turns on show simulation view to output frames into 
                                               pymol when the pose has changed AND indicates the time
                                               interval (in seconds) before another frame can be sent to pymol.
                                               0 indicates that no packets are skipped!

-update_pymol_on_energy_changes_only         Only update pymol on energy changes.  Useful if protein length
                                              changes are occurring.

-update_pymol_on_conformation_changes_only   Only update pymol when the conformation object is changed.  
                                              Aka changes in XYZ, residuetype, lengths, etc.
  
-keep_pymol_simulation_history               Keep the history of the simulation as seperate frames in pymol

```
###Drawbacks and workarounds
If Length changes are occurring during the run, the PyMOL Mover may segfault as it tries to send the pose before certain components of the conformation object are updated.  In this case, use the option <code> -update_pymol_on_energy_changes_only </code> to prevent the segfault.

#Graphical User Interfaces

##Fold-It

##PyRosetta Toolkit