#Extending the PyMol Viewer

## Metadata
Authors: Rebecca Alford (rfalford12@gmail.com) & Evan Baugh (ehb250@nyu.edu)

Last Updated: 7/10/14

##Overview
Rosetta includes various tools for running interactive and visual simulations including Foldit, the PyRosetta toolkit and the PyMol viewer. All of these tools are discussed broadly [[here|graphics-and-guis]], but this page will specifically focus on extending features in the PyMol viewer. 

The PyMolViewer enables real-time and interactive visualization of Rosetta simulations. Both Rosetta3 (C++) and PyMol use the PyMolMover: A mover that extracts information from the pose and sends it over a network. This information is then received in an active session of PyMol by running a script `PyMolPyRosettaServer.py`. This server script will parse the message received and run the appropriate PyMol commands for visualization. 

## Running the PyMol Mover
The PyMol viewer can be run via the following steps: 

1. Open a new session of PyMol. Run the `PyMolPyRosettaServer.py` server script which can be found in `source/src/python/bindings/`

2. In your Rosetta application, pass the flag `-show_simulation_in_pymol (Real)` where the integer specifies the frequency at which updates should be send to pymol. The default is 1. 

3. Run your simulation and you will see conformation & energy updates sent to PyMol!


## Extending the PyMol Mover
Both the C++ and PyRosetta versions of the PyMol viewer contain a variety of features for updating the Pose. These include coloring by energies, showing hydrogen bonding networks, secondary structure, etc. It is very easy to extend the PyMol viewer to send over new information. Below are the basic steps: 

1. Add a method "send_xxx" to the `PyMolMover`, where "xxx" describes your feature. This method should extract information from the Pose or elsewhere needed to run PyMol commands. For example, visualization of secondary structure might require sending DSSP annotations (H, L, E, etc). 

2. The send_xxx method should compress information into a string method and sent via link_.send_message( my_msg ). Messages should start with a unique 3-letter string, contain a message length and name variable for parsing, and be .gzip or .bz2 compressed. 

3. In the apply method of the PyMolMover, add a call to your send_xxx method to send information upon update. You might want to add flags to control this behavior - the more information Rosetta needs to communicate to PyMol in a given step, the longer the simulation will take. 

4. In the PyMolPyRosettaServer.py script, write a new else if statement that will process a data packet starting with your unique string. After unpacking the message (there is example code for this in that script), execute your desired PyMol commands given this data. PyMol commands can be executed via the cmd interface. 

5. Go ahead and run the PyMol viewer as is (along with any new flags added to invoke your behavior). You should see your structure updating with your new included features.  

The PyMol viewer can be extended both in C++ and PyRosetta.  

## References
Baugh EH, Lyskov S, Weitzner BD, Gray JJ (2011) Real-Time PyMOL Visualization for Rosetta and PyRosetta. PLoS ONE 6(8): e21931.


##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[PyMOL]]: Wiki page for PyMOL and the PyMOL Mover
* [[PyMolMover]]: RosettaScripts PyMolMover page
* [[PyMOL website (external)|http://www.pymol.org]]
* [[Graphics and GUIs]]: Home page for graphical interfaces with Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[PyRosetta Toolkit]]: Tutorials for using/modifying the PyRosetta Toolkit GUI
* [[PyRosetta Toolkit GUI]]: Information on the PyRosetta Toolkit user interface