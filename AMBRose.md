## Metadata

The AMBRose python module was developed by mszegedy (Khare Lab), Kristin Blacklock (Khare Lab), and Hai Nguyen (Case Lab) at Rutgers University.

Last updated April 23, 2019. 

For questions please contact: 
- [mszegedy](https://github.com/mszegedy) ([mszegedy2@gmail.com](mszegedy2@gmail.com))
- Corresponding PI: Sagar D. Khare ([khare@chem.rutgers.edu](khare@chem.rutgers.edu))

## Description
This module provides several functions for intercompatibility between AMBER and Rosetta, with major functions being:
- The conversion of a pose to starting coordinates for sander/PMEMD
- The dumping of LEaP-safe PDB files from poses
- The minimization and simulation of poses in sander/PMEMD without having to explicitly work with AMBER constructs
- The conversion of trajectories to series of poses
For the full API, see the docstrings of AMBRose's modules and objects. These will be turned into readthedocs.io documentation eventually.

## System Requirements
AmberTools (version >= 16) with pytraj (python module), sander (command-line executable), and tLeap (command-line executable)

Python 3.5+

[[PyRosetta|http://www.pyrosetta.org/]]

### For legacy only (but also planned for future versions):

The [[mpi4py|https://mpi4py.readthedocs.io/en/stable/install.html]] Python module

## The limitations of AMBRose

AMBRose can work with (i.e. convert from one medium to another) any of three things:
- Canonical proteins
- Canonical RNAs
- Canonical DNAs
Anything beyond this (ligands, noncanonical residues, most post-translational modifications) will almost certainly fail to be converted.

AMBRose also currently only runs on one core, including any of its sander/PMEMD calls. This issue is currently priority number one in AMBRose development, because MD is very slow when it's only running on one core.

## How to install AMBRose
### Automatically
Currently, you can install AMBRose with anything capable of handling a `setup.py` script, such as `pip`. If you are taking this route, you must be in the directory [`tools/AmbRose`](https://github.com/RosettaCommons/tools/tree/master/AmbRose). Here, run

```
$ pip install . --user
```

which will copy the folder `ambrose` to the correct place in your `PYTHONPATH`.

### Manually

If you know where in your `PYTHONPATH` you want to keep AMBRose, you can copy the directory [`tools/AmbRose/ambrose`](https://github.com/RosettaCommons/tools/tree/master/AmbRose/ambrose) directly to wherever you need it to be. Just make sure it's somewhere in one of the folders in your `PYTHONPATH`.

## How to use AMBRose

First, import PyRosetta and AMBRose:

```
>>> import pyrosetta as pr; pr.init()
>>> import ambrose
```

### Exploring the AMBRose API

AMBRose's API is currently best explored through its docstrings. These are accessible through the `help()` function:

```
>>> help(ambrose)
```

If you want to read the docstrings in a specific submodule or pertaining to a specific object, that can be `help()`ed too:

```
>>> help(ambrose.pose_selectors)
>>> help(ambrose.AMBERSimulateMover)
```

### Turning poses into input files

AMBRose can turn a pose into input files for sander/PMEMD. To do this, use the function `pose_to_amber_params`:

```
>>> pose = pr.pose_from_file('my-protein.pdb')
>>> ambrose.pose_to_amber_params(pose,
...                              crd_path='my-protein.rst7',
...                              top_path='my-protein.parm7')
```

This will create the files `my-protein.rst7` and `my-protein.parm7`, which can be used as starting coordinates for sander/PMEMD. Additional arguments may be given to control the solvation of the pose; see the output of the command `help(ambrose.pose_to_amber_params)`.

### Turning trajectories into poses

AMBRose can read a trajectory and output the frames as poses. To do this, you must first import the AmberTools module pytraj, and read in your trajectory as a `Trajectory` object. Then, you can use AMBRose's `TrajToPoses` object to turn it into a sequence of poses:

```
>>> import pytraj as pt
>>> traj = pt.iterload('my-protein.rst7', 'my-protein.parm7')
>>> poses = ambrose.TrajToPoses(traj)
```

`TrajToPoses` objects can be indexed and sliced like any sequence. Their elements are poses corresponding to each successive frame of the trajectory that they were made from. For example, to get a pose corresponding to the last frame of a trajectory, you can run the previous code, and then:

```
>>> pose = poses[-1]
```

### Simulating a pose without touching AMBER

AMBRose's "movers" (which aren't real movers, but are built to function like them) are intended to abstract away the entire process of converting to AMBER, simulating a pose, converting the frames back, and selecting a frame. `AMBERSimulateMover` does exactly this. When its `apply()` is called on a pose, it creates and runs a simulation with the parameters you have specified, and replaces the pose with the last frame of the simulation's trajectory. Here is an example where we simulate a pose for 10 ps at 303 K (but starting from 273 K), with an explicit solvent, and replace it with the last frame of the simulation:

```
>>> pose = pr.pose_from_file('my-protein.pdb')
>>> mover = ambrose.AMBERSimulateMover()
>>> mover.duration = 10.     # 10 picoseconds
>>> mover.temperature = 303. # 303 kelvin
>>> mover.starting_temperature = 273.
>>> mover.solvent = ambrose.Solvents.SPCE_WATER
>>> mover.working_dir = 'my-simulation-dir'
>>> mover.prefix = 'my-simulation'
>>> mover.apply(pose) # overwrites pose and creates many files in my-simulation-dir
```

You can change which pose is selected by overwriting the mover's `pose_selector`. See the submodule `ambrose.pose_selectors` for what pose selector functions should look like.