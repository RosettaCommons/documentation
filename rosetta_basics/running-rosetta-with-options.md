#How to use Run Rosetta

The command line is composed of two major parts. First, a path to an application executable is required, while the second part is a list of options for the particular Rosetta simulation.

Location of Rosetta Executables
=======================
After Rosetta is [[compiled | build_documentation/Build-Documentation ]], links to binary executables are copied to the Rosetta/main/bin directory.  Full paths to these executables need to be given when running Rosetta, unless this directory is added paths in your shell profile (~/.bashrc (linux), ~/.bash_profile (mac), etc). <code> export PATH=$PATH:/path/to/rosetta/bin </code>

The -Database flag
========================
The -database flag is the only option which must be given for every Rosetta run.  The database flag specifies the path to the Rosetta database (Rosetta/main/database) and is included so that Rosetta may be run from any directory on the file system.  Rosetta will also attempt to use the ROSETTA3_DB environment variable as well if the -database flag is not set or the path given to -database is incorrect.

Options listed on the command line
==================================

```
fixbb.macgccrelease -in:file:s myinput.pdb -database mypath
```

Options and arguments to the options, are separated by whitespace. A single or double colon is using to clarify options via OptionGroups when there are multiple separate options with the same name. Multiple layers of colons may be needed.



Options listed in a file
========================

Options can also be written in a flag file. In this file, put one option on each line, still using the colon or double colon is using to specify the layers. An example options file appears below.

```
 -database /home/yiliu/Programing/branches/rosetta_database
 -in:file:s 1l2y_centroid.pdb
 -in:centroid_input
 -score:weights centroid_des.wts
```

If this file were called “flags”, then it would be used like this (notice the @ symbol):

```
fixbb.macgccrelease @ flags
```

Note that other options can still be set before or after the flags file is specified


Running Rosetta via MPI
========================
If the Rosetta MPI executables were compiled, then in the executable directory there will be an extra set of executables specifically for MPI, for example fixbb.mpi.linuxgccrelease.  To run these executables, simply run them via mpirun for example: 

<code> mpirun -np 16 fixbb.mpi.linuxgccrelease -database /path/to/database @ flags </code>

Although typically used on large computer clusters, MPI can be installed on multiprocessor linux and mac machines.  If you have a shiny new 8 core desktop, use should be able to use MPI.  There are many different flavors of MPI, but openmpi seems to work well on both Ubuntu and MacOSX.

Most applications are currently compatible with MPI through [[The Job Distributor | rosetta_basics/jd2]]. See the MPI JobDistributor section for fine control over how Rosetta will use MPI with your run.

A useful option to use when running Rosetta via mpi is <code> -mpi_tracer_to_file path/to/log/dir </code>.  This will separate the output of each processor into separate files.  

Options Groups and Layers
=========================

Options in Rosetta are grouped by their functional and protocol usages. Each group has at least one layer, the parent layer. Most of the groups have one or more sub-layers holding multiple options. It is good to specify the whole set of layers when you use options since there might be two options have the same name but in different groups. You can use single or double colon to separate the layers.

For example:

```
fixbb.linuxgccrelease -in:file:s myinput.pdb -out:file:o myoutput
fixbb.linuxgccrelease -in::file::s myinput.pdb -packing::ex1
```

Option Types
============

All the option types are pre-defined, and you can figure out the the type of parameters of each option by reading the option types. Here is a list of Rosetta options types:

1.  Boolean, BooleanVector
2.  Integer, IntegerVector
3.  Real, RealVector
4.  String, StringVector
5.  File, FileVector
6.  Path, PathVector

For Example: Option "database" is a Path type option, so it is followed by path format parameters as

```
-database yourpath/rosetta_database
```

Option "ex1" is a Boolean type option and set to be false by default, so you can activate it as

```
-packing:ex1
```

Option "nstruct" is a Integer type option, you can use it as

```
-nstruct 10
```

Getting help with options
=========================

There are a few good places to look for help. First, the documentation. Second, if you pass -help as a flag on the command line, Rosetta will spit out all existing options and then quit (ignoring other flags).
