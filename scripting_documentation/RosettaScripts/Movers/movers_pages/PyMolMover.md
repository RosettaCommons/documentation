# PyMolMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PyMOLMover

PyMOLMover will send a pose to an instance of the PyMol molecular visualization software running on the local host. Each call of the mover overwrites the object in PyMol. It is not a full featured as the version built in to PyRosetta but is extremely useful for visualizing the flow of a protocol or generating a frames for a movie of a protocol.

```xml
<PyMOLMover name="&string" keep_history="(0 &bool)" />
```
- keep\_history: each call to the mover stores the pose in a new state/frame of an object in PyMol rather than overwriting it. Frames can then be played back like a movie to visualize the flow of a protocol.

The following example would send the pose to PyMol before and after packing and store the structure in 2 states/frames of the same object.
```xml
  <MOVERS>
    <PyMOLMover name="pmm" keep_history="1"/>
    <PackRotamersMover name="pack"/>
  </MOVERS>

  <PROTOCOLS>
    <Add mover_name="pmm"/>
    <Add mover_name="pack"/>
    <Add mover_name="pmm"/>
  </PROTOCOLS>
```

**Prerequisites**

To allow PyMol to listen for new poses, you need to run the following script from within PyMol, where *$PATH_TO_ROSETTA* is replaced by the path to you Rosetta installation.
```sh
run $PATH_TO_ROSETTA/Rosetta/main/source/src/python/PyRosetta/src/PyMOL-RosettaServer.py
```


##See Also

* [[PyMOL]]: More information on Rosetta's interface with PyMOL
* [[PyMOL website (external)|http://www.pymol.org]]
* [[Graphics and GUIs]]: Home page for graphical interfaces with Rosetta
* [[Extending the PyMol Viewer]]: How to add new functionality to Rosetta's PyMOL Mover
