## Metadata

The AmbRose python module was developed by Kristin Blacklock (Khare Lab) and Hai Nguyen (Case Lab) at Rutgers University.

Last updated Aug 18, 2016. 

For questions please contact: 
- Kristin Blacklock ([kristin.blacklock@gmail.com](kristin.blacklock@gmail.com))
- Corresponding PI: Sagar D. Khare ([khare@chem.rutgers.edu](khare@chem.rutgers.edu))

## Description
This module enables the interconverstion of a Rosetta pose to an Amber trajectory, and can perform minimization of poses using the Amber FF or Amber minimization engine (sander).

## System Requirements
AmberTools (version >= 16) with pytraj (python module), sander (command-line executable), and tLeap (command-line executable)

Python 2.7

[[PyRosetta|http://www.pyrosetta.org/]]

The [[mmpi4py|https://mpi4py.readthedocs.io/en/stable/install.html]] Python module


## How to Use AmbRose

Preliminary import statements:
```
>>> import AmbRose
>>> from glob import glob
>>> import os
>>> import pytraj as pt
```

### If starting from a pose object

Use the following method to convert a Rosetta pose to an Amber trajectory for the first time:
```
>>> amber_trajectory, coordinate_map = AmbRose.initial_pose_to_traj(pose)
```
Under the hood, this command has generated an rst7 (coordinates) file and a parm7 (parameter/topology) file, which have been output as "pose.{date/time}.rst7" and "pose.{date/time}.parm7" files, respectively. The filename for the parm7 file has also been stored in the pose object's `pdb_info().modeltag()` property.

To retrieve the parm7 file name for later, retrieve the pose's modeltag information:
```
>>> pose_parm7file = pose.pdb_info().modeltag()
```

To retrieve the initial total energy for this Amber trajectory before minimization, use the following method:
```
>>> total_energy = AmbRose.get_energy_term(amber_trajectory, 'TOTAL_ENERGY')
```

To see all of the Amber energies available, use the `get_energies` method, where the first argument is the Amber trajectory to analyze, and the second argument is a description of that state:
```
>>> energy_data = AmbRose.get_energies(amber_trajectory, "Rosetta Pose -> Amber Traj, No Minimization")
>>> AmbRose.print_energies(energy_data)
```

It is also possible to write these energies to a file:
```
>>> AmbRose.write_energies(energy_data, "name_of_ouputfile")
```

Next, perform minimization on the trajectory made from the initial Rosetta pose:
```
>>> AmbRose.batch_minimization_with_sander(pose_parmfile, [pose_parmfile.replace('.parm7','.rst7')], 1, 0)
```
* The first argument is the parm7 filename.
* The second argument is a list of the rst7files to be minimized.
* The third argument is the number of cores to use for minimization.
* The fourth argument is whether or not overwriting is allowed (if ==1, previously generated files with the same names will be overwritten).

Once finished, make an Amber trajectory object from the minimized trajectory: 
```
>>> minimized_amber_trajectory = pt.iterload("min_"+pose_parmfile.replace('.parm7','.rst7'), pose.parmfile)
```

And get the new energies:
```
>>> minimized_energy_data = AmbRose.get_energies(minimized_amber_trajectory, "Amber-Minimized Trajectory")
>>> AmbRose.print_energies(minimized_energy_data)
```

To convert the minimized trajectory back to a Rosetta pose, use:
```
>>> AmbRose.traj_to_pose_version1(pose, minimized_amber_trajectory, coordinate_map)
```
This command sets the coordinates of the original pose to the new coordinates of the minimized amber trajectory.

### If starting from PDBs:

Make a list of input PDB files:
```
>>> pdbfiles = glob("*.pdb")
```

And create the rst7 and parm7 files using the following command:
```
>>> rst7files, parmfiles = AmbRose.convert_pdbs_to_rst7_parm7_files( pdbfiles, 1 )
```
* The first argument is the list of pdbfile names. 
* The second argument can be set to `0` (where a parm7 file will be made for each rst7 file) or `1` (where one parm7 file will be made/used for all rst7 files). In this example, let's assume both input PDBs have the same amino acid sequence so the same parm7 file can be used for both rst7s.


Next, use AmbRose to minimize the rst7/parm7 files with sander:
```
>>> AmbRose.batch_minimize_with_sander(parmfiles[0], rst7files, 1, 0)
```
* The first argument is the parmfile to use for this minimization. Currently, only one parmfile can be specified. 
* The second argument is a list of rst7files. 
* The third argument is the number of cores to use for the batch minimization. 
* The fourth argument is the overwrite option. If set to `1`, previously generated data with the same output names will be overwritten.

Once this command has run, you can gather your minimized Amber rst7 files and create the new minimized Amber trajectories:
```
>>> minimized_rst7s = glob("min*.rst7")
>>> minimized_traj = pt.iterload(minimized_rst7s, parmfiles[0])
```

And perform energy analysis on the minimized structures:
```
>>> energy_data = AmbRose.get_energies(minimized_traj, minimized_rst7s)
>>> AmbRose.print_energies(energy_data)
>>> AmbRose.write(energies(energy_data, "amber_energies.sc")
```

## Example

An example of how to use the AmbRose Python module with input files and expected outputs can be found in the Rosetta/tools/AmbRose/ directory.