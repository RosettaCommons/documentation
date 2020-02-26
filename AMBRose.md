## Metadata

The AMBRose python module was developed by Maria Szegedy (Khare Lab), Kristin Blacklock (Khare Lab), and Hai Nguyen (Case Lab) at Rutgers University.

Last updated August 28, 2019. 

For questions please contact: 
- [Maria Szegedy](https://github.com/mszegedy) ([mszegedy2@gmail.com](mszegedy2@gmail.com))
- Corresponding PI: Sagar D. Khare ([khare@chem.rutgers.edu](khare@chem.rutgers.edu))

## Why AMBRose?
Have you ever wanted Rosetta to seamlessly make an MD simulation of your structure and use frames from it in your protocol? Or just wished you could automate the creation of MD input files? If so, AMBRose is the PyRosetta companion module for you. With AMBRose, obtaining MD data can be as easy as setting up a mover! Download AMBRose today and see what MD can do for _your_ project. (No actual movers were harmed in the making of this software.)

## Description
This module provides several functions for intercompatibility between AMBER and Rosetta, with major functions being:
- The conversion of a pose to starting coordinates for sander/PMEMD
- The dumping of LEaP-safe PDB files from poses
- The minimization and simulation of poses in sander/PMEMD without having to explicitly work with AMBER constructs
- The conversion of trajectories to series of poses

For the full API, see the docstrings of AMBRose's modules and objects. These will be turned into readthedocs.io documentation eventually.

## System Requirements
- Python 3.6+
- [[PyRosetta|http://www.pyrosetta.org/]] (Python module)
- AmberTools (version >= 16) with [[pytraj|https://amber-md.github.io/pytraj/latest/installation.html#install]] (Python module)
- Working versions of some [[AMBER16+|http://ambermd.org/GetAmber.php]] executables, particularly:
  - pmemd.cuda
  - tleap

Make sure your environment variable `$AMBERHOME` is set to the directory where AMBER lives. (This is the directory where `bin/pmemd.CUDA` lives, where `amber.sh` lives, et cetera.)

### For legacy only:
- AmberTools (version >= 16) with pytraj and sander (Python module)
- [[mpi4py|https://mpi4py.readthedocs.io/en/stable/install.html]] (Python module)


## The limitations of AMBRose

AMBRose can work with (i.e. convert from one medium to another) any of three things:
- Canonical proteins
- Canonical RNAs
- Canonical DNAs

Anything beyond this (ligands, noncanonical residues, most post-translational modifications) will almost certainly fail to be converted.

AMBRose's movers currently only run minimizations and simulations on the GPU, with pmemd.cuda. This is not a huge problem, because GPU computation is the state of the art for AMBER, and all the AMBER devs are currently focused on it. However, if for whatever reason you need CPU computation instead, they can be set to do that, but they will only be able to run on one core in most cases. This issue is not likely to be solved.

## How to install AMBRose
### Automatically
Currently, you can install AMBRose with anything capable of handling a `setup.py` script, such as `pip`. If you are taking this route, you must first clone [RosettaCommons/tools,](https://github.com/RosettaCommons/tools) and then navigate to the directory [`tools/AmbRose`](https://github.com/RosettaCommons/tools/tree/master/AmbRose). Here, run

```
$ pip install --user .
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