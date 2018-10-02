# Rosetta Graphics output and Graphical User Interfaces

[[_TOC_]]

#Graphics Output
##[[OpenGL Graphics mode|graphics]]
Native graphics mode (or the "viewer") in Rosetta allows viewing any given pose in real-time.

[[images/graphics_mode.png]]

##[[Pymol Mover|PyMOL]]
###Background
The PyMOL Mover is a way to visualize your decoy (PDB) in PyMOL. One of its most powerful features is that it can color your decoy by score or some component of the total score, as well as observe changes in real-time during a Rosetta protocol.

The PyMOL Mover can be controlled through [[RosettaScripts]], [[PyRosetta]], or through the command line.

The PyMOL Mover creates a PyMolObserver and attaches it to a particular Pose.  This can be accomplished programmatically by making a call to protocols::moves::AddPyMolObserver.  The command line options listed below work only though JD2, but it is possible to programmatically activate the PyMol observer without using the command line at all.

Separately from the Rosetta execution, you will need to launch PyMol on the computer where you will run your Rosetta executable.  Within the PyMol session, run the script /path/to/Rosetta/main/source/src/python/bindings/PyMOLPyRosettaServer.py:

    run /path/to/Rosetta/main/source/src/python/bindings/PyMOLPyRosettaServer.py

which will prime your PyMol session to receive and display the coordinates sent to it from Rosetta.

**TIP**: It is extremely useful to add this line to your $HOME/.pymolrc file.  That way, every time PyMOL is launched, the PyMOLPyRosettaServer.py script will be called.  Note also that you may have to create this file in the first place.  See the [pymolrc](http://www.pymolwiki.org/index.php/Pymolrc) section in the PyMOLWiki for more information on this awesome file.


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

-keep_pymol_simulation_history               Keep the history of the simulation as separate frames in pymol

```
###Drawbacks and workarounds
If Length changes are occurring during the run, the PyMOL Mover may segfault as it tries to send the pose before certain components of the conformation object are updated.  In this case, use the option <code> -update_pymol_on_energy_changes_only </code> to prevent the segfault.

#Graphical User Interfaces

##Fold-It

##PyRosetta Toolkit
See [[PyRosetta Toolkit GUI]]


[[images/pyrosetta_toolkit_main.png]]

##Cyrus Bench
Cyrus Biotechnology is a spin-out from the Baker lab and Rosetta Commons offering a Rosetta GUI (a graphical user interface) on the cloud, Cyrus Bench, with included bioinformatics and small molecule and other dependencies for Rosetta. Bench was developed by some of the previous members of RosettaCommons labs and in close collaboration with a number of Rosetta academic labs.

Bench is designed for users in industry and academia for the following features: homology modeling, protein design, protein/protein interface design and affinity design, free energy of mutation calculations, protein design with a flexible backbone, protein stabilization, and immune epitope prediction (MHC II immunogenicity). Note that Bench does not offer every feature in command line Rosetta 3. Available at https://cyrusbio.com/.  <sub><sup>(Cyrus Biotechnology is a commercial Rosetta licensee offering a web-based graphical user interface for Rosetta to its customers.  Licensing fees paid by commercial Rosetta licensees to the University of Washington are used to support the RosettaCommons, investing in the maintenance and further development of Rosetta.)</sup></sub>

[[/images/cyrus_bench.png]]

##See Also

* [[PyMOL website (external)|http://www.pymol.org]]
* [[Comparing structures]]: Essay on comparing structures
* [[Rosetta Servers]]: Web-based interfaces for certain Rosetta features
* [[Extending the PyMol Viewer]]: How to add new functionality to Rosetta's PyMOL Mover
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
