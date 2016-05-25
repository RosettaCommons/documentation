PyMOL
=====

[PyMOL](http://www.pymol.org/) is a molecular visualization tool widely
used by the Rosetta community.

The [PyMOL Wiki](http://www.pymolwiki.org/index.php/Main_Page) contains
documentation on the program methods and numerous examples. Beginners
should start
[here](http://www.pymolwiki.org/index.php/Practical_Pymol_for_Beginners).
A simple [workshop](http://pyrosetta.org/tutorial.html) is part of the
[PyRosetta](/index.php/PyRosetta "PyRosetta") tutorials.

If you are building PyMOL from source on Linux (this does not take long
and is explained
[here](http://www.pymolwiki.org/index.php/Linux_Install)) then you may
need to install the python-dev and glutg3-dev packages and possibly the
mesa-common-dev package as well.

Information on making movies in PyMOL can be found at  [http://www.pymolwiki.org/index.php/PLoS](http://www.pymolwiki.org/index.php/PLoS).

PyMOL\_Mover
------------

PyMOL is so popular in the community, we developed a Mover to send
Rosetta data directly to PyMOL.

### PyMOL Side

#### *Setting Up PyMOL*

In PyMOL, run the PyMOLPyRosettaServer.py scripts found in
main/source/src/python/bindings or the main directory of PyRosetta. This will
start the listener and output information about the connection
established. No further work should be required to view PyMOL\_Mover
output from the same computer. We recommend adding

` run /path/to/~/PyMOLPyRosettaServer.py`

to your .pymolrc (and to make a .pymolrc if you don't have one).

#### *Changing PyMOL Listener IP*

` start_rosetta_server`

Its that simple. This method of the Server script automatically connects
to the machine's current IP. This IP address can be set manually and the
Server script defaultly connects at 127.0.0.1. Make sure that the
connection is to an accessible IP and that the PyMOL\_Mover is
outputting to that IP. To change the IP manually use either command
below:

` start_rosetta_server 187.1.3.37, 9001`\
\
` cmd.start_rosetta_server("187.1.3.37","9001")`

### Rosetta Usage

Here are the options for observing a Rosetta simulation (Through JD2, rosettas job manager). 
See below for PyRosetta code. 

```
-show_simulation_in_pymol 'Real'
```

 - default='5.0', 
 -  Attach PyMOL observer to pose at the beginning of the simulation. Waits until at least every [argument] seconds before sending pose if something has changed, default 5. A value of 0 indicates to not skip any packets from sending! Don't forget to run the PyMOLPyRosettaServer.py script within PyMOL!

```
-update_pymol_on_energy_changes_only 'Boolean'
```
 - default = 'false', 
 - 'Only Update the simulation in on energy change.  Useful if pymol observer is segfaulting on length changes.

```
-update_pymol_on_conformation_changes_only 'Boolean'
```
 - default = 'false'
 - Only update the simulation in pymol on conformation change.

```
-keep_pymol_simulation_history, 'Boolean'
```
 - default = 'false'
 - Keep history when using show_simulation_in_pymol flag?


### PyRosetta Usage

#### *Sending Structures*

Application of the mover sends pose coordinate data to PyMOL rendering
an image of the structure. Simply apply the mover to a pose. You can
achieve the same results by using dump\_pdb to produce a .pdb of the
pose and load it into PyMOL...but the mover is much faster and avoids
unnecessary file writing.\
\
 ` pymover = PyMOL_Mover() pymover.apply(pose)`

#### *Sending Energy*

Use the send\_energy method to color the structure in PyMOL based on the
residue relative energies. Currently, the color spectrum spans from blue
(low energy=happy) to red (high energy=sad). Make sure the pose has been
scored first. The send\_energy can accept a ScoreType name and color
residues in PyMOL based on this score term of the last score function
applied.

` pymover.send_energy(pose) pymover.send_energy(pose,"fa_atr") pymover.update_energy=True pymover.apply(pose) pymover.energy_type="fa_sol" pymover.apply(pose)`

The PyMOL\_Mover features a update\_energy option which, when True,
automatically colors residues by energy when the Mover is applied. The
score term sent can be set with the PyMOL\_Mover.energy\_type option.

#### *Changing Mover IP*

To send PyMOL\_Mover output to a new IP address, simply change the
PyMOL\_Mover options as specified below:

` pymover.link.udp_ip = '127.0.0.1' pymover.link.udp_port = 65000 pymover.apply(pose)`

#### *Keeping History*

Another useful PyMOL\_Mover feature is the keep\_history flag. When
marked True, poses with the same "name" (see below) are loaded into new
states of the associated PyMOL object ie. applying the PyMOL\_Mover does
not overwrite the structure in PyMOL but instead loads it into the next
state. Protocol movies can be created easily using PyMOL's movie
building features and these output states.

` pymover.keep_history=True pymover.apply(pose) other_mover.apply(pose) pymover.apply(pose)`

To accurately view intermediate changes, you can change the pose name.
This will result in a different object when the pose data is loaded into
PyMOL. To change a pose name use: ` pose.pdb_info().name("new_name")`
Remember, color in PyMOL is per object NOT per state so any successive
coloring will erase the old coloring (another reason you may want to
change the pose name when inspecting a protocol).

#### *PyMOL Observer*

The PyMOL\_Observer object waits for "events" to happen on the pose and
when triggered, applies its own PyMOL\_Mover to the structure. This is
ideal for situations where you don't want to apply the mover directly,
such as lengthy protocols or quick inspection. Since a PyMOL\_Observer
has a PyMOL\_Mover, all the options above can be set on its mover
(called pymol) including keep\_history, link.udp\_ip, and
update\_energy.

` pyobs = PyMOL_Observer() pyobs.add_observer(pose) pyobs.pymol.update_energy=True`

##See Also

* [[PyMOL website (external)|http://www.pymol.org]]
* [[PyMolMover]]: RosettaScripts PyMolMover documentation
* [[Graphics and GUIs]]: Home page for graphical interfaces with Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Extending the PyMol Viewer]]: How to add new functionality to Rosetta's PyMOL Mover
* [[PyRosetta Toolkit]]: Tutorials for using/modifying the PyRosetta Toolkit GUI
* [[PyRosetta Toolkit GUI]]: Information on the PyRosetta Toolkit user interface