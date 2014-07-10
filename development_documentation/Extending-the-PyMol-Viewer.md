## Metadata
Authors: Rebecca Alford (rfalford12@gmail.com) & Evan Baugh (ehb250@nyu.edu)

Last Updated: 7/10/14

##Overview
Rosetta includes various tools for running interactive and visual simulations including Foldit, the PyRosetta toolkit and the PyMol viewer. All of these tools are discussed broadly [here](https://www.rosettacommons.org/docs/latest/graphics-and-guis.html), but this page will specifically focus on extending features in the PyMol viewer. 

The PyMolViewer enables real-time and interactive visualization of Rosetta simulations. Both Rosetta3 (C++) and PyMol use the PyMolMover: A mover that extracts information from the pose and sends it over a network. This information is then received in an active sesison of PyMol by running a script `PyMolPyRosettaServer.py`. This server script will parse the message recieved and run the appropriate PyMol commands for visualization. 

## Running the PyMol Mover
The PyMol viewer can be run using the following steps: 
1. Open a new session of PyMol. Run the `PyMolPyRosetta.py` server script which can be found in `source/src/python/bindings/`
2. In your Rosetta application (which should be running in JD2), pass the flag `-show_simulation_in_pymol (Real)` where the integer specifies the frequency at which updates should be send to pymol. The default is 1. 
3. Run your simulation and you will see conformaiton & energy updates proactively sent to PyMol!

## Extending the PyMol Mover
Both the C++ and PyRosetta versions of the PyMol viewer contain a variety of features for updating the Pose. These include coloring by energies, showing hydrogen bonding networks, secondary structure, etc. It is very easy to extend the PyMol viewer to send over new information. Below are the basic steps: 

(1) Add a method "send_xxx" to the `PyMolMover`, where "xxx" describes your feature. This method should extract information from the Pose or elsewhere needed to run PyMol commands. For example, visualization of secondary structure might require sending DSSP annotations (H, L, E, etc). The send_xxx method should compress information into a string method and sent via link_.send_message( my_msg ). Messages should start with a unique 3-letter string, contain a message length and name variable for parsing, and be .gzip or .bz2 compressed. 

(2) In the apply method of the PyMolMover, add a call to your send_xxx method to send information upon update. You might want to add flags to control this behavior - the more information Rosetta needs to communicate to PyMol in a given step, the longer the simulation will take. 

(3) In the PyMolPyRosettaServer.py script, write a new else if statement that will process a data packet starting with your unique string. After unpacking the message (there is example code for this in that script), execute your desired PyMol commands given this data. PyMol commands can be executed via the cmd interface. 

(4) Once everything compiles, go ahead and run the PyMol viewer as is (along with any new flags added to invoke your behavior).  

Extending the PyMol viewer can be done on both the C++ and PyRosetta side. 

## References
Baugh EH, Lyskov S, Weitzner BD, Gray JJ (2011) Real-Time PyMOL Visualization for Rosetta and PyRosetta. PLoS ONE 6(8): e21931. doi:10.1371/journal.pone.0021931