#How to Run Rosetta

[[_TOC_]]

## Starting References

You may be interested in reading [[Getting Started]]. 
More similar recommendations can be found scrolling to the bottom of this page, in the See Also section.

Leaver-Fay, A., et al., ROSETTA3: an object-oriented software suite for the simulation and design of macromolecules. Methods in enzymology, 2011. 487: p. 545.

Kaufmann, K.W., et al., Practically useful: what the Rosetta protein modeling
suite can do for you. Biochemistry, 2010. 49(14): p. 2987-98.

##Servers 
Many servers exist to run various Rosetta protocols. Descriptions of these
servers can be found on the [[Rosetta Servers]] page.

* [ROSIE](http://rosie.rosettacommons.org)
* [Robetta](http://robetta.bakerlab.org)

##Command Line Example
Rosetta applications (including RosettaScripts) are typically run through a terminal window. The command line is composed of two major parts. First, a path to an application executable is required, while the second part is a list of options for the particular Rosetta simulation. For example:

```
path_to/some_rosetta_app.linuxgccrelease -database path/to/rosetta/Rosetta/main/database other\_flags
```

For a few examples, see the [[commands collection]] page.

##Location of Rosetta Executables
After Rosetta is [[compiled | build_documentation/Build-Documentation ]], links to binary executables are copied to the Rosetta/main/source/bin directory. (This is the bin/ directory off of the directory where you compiled the code.) **Full paths** to these executables need to be given when running Rosetta, _unless_ this directory is added to the **PATH** variable in your shell profile (~/.bashrc (linux), ~/.bash_profile (mac), etc). <code> export PATH=$PATH:/path/to/rosetta/bin </code>


##[[Rosetta Database|database]]
The Rosetta database contains important data files used by Rosetta during runs (for example, the definitions of what atoms are in alanine, atomic charges, Lennard-Jones radii, scorefunction weight files, ideal bond lengths and angles, rotamer libaries, etc).  Rosetta must in some way know the path to this directory. 

### Autodetermination of database path

If you have the Rosetta code and database directories laid out in the standard fashion (e.g. main/source/bin/ and main/database/), Rosetta can often automatically determine where the database directory should. If this does not work for you, or if you relocate or symlink the executables and/or database, you may need to explicitly set the database, as described below. Explicitly setting the database path on the commandline or with an environment variable will take precedence over the autodetermined database path.

### Set DB for a _single_ Rosetta run

If you are using an older Rosetta build and the ROSETTA3_DB environment variable is not set (or your database has been moved from the typical relative install), you must specify the path to this database directory in the command line to run Rosetta simulations. For example: 
* <code>rosetta.linuxgccrelease -database path/to/rosetta/main/database other\_flags</code>

As with all Rosetta options, this can also be provided with an options file.

### Set DB for _multiple_ Rosetta runs

Rosetta will automatically check the <code>$ROSETTA3_DB</code> environment variable.  If this is present, the <code>-database</code> option need not be set. To set it temporarily in your shell session: 

* <code>ROSETTA3_DB=path_to_rosetta_db</code>

Set the variable in your shell's user settings file (which will run every time you open a terminal), such as for the default shell bash: <code>$HOME/.bashrc</code> for linux and <code>$HOME/.bash_profile</code> for mac.  Make sure to source this file <code> $HOME/.bashrc </code> or open a new tab so that the variable is set.  

If the -database option is present on the commandline or in an options file, the value specified there will override any ROSETTA3_DB environment variable setting.

#Specifying Options

##On the Command-Line
```
fixbb.macgccrelease -in:file:s myinput.pdb -database mypath
```

Options and arguments to the options, are separated by whitespace. A single or double colon is using to clarify options via OptionGroups when there are multiple separate options with the same name. Multiple layers of colons may be needed.


##On the Command-line via an Options File

Options can also be written in a options file (also called a flags file). In this file, put one option on each line, still using the colon or double colon is using to specify the layers. An example options file appears below.

```
 -database /home/yiliu/Programing/branches/Rosetta/main/database
 -in:file:s 1l2y_centroid.pdb
 -in:centroid_input
 -score:weights centroid_des.wts

```

If this file were called “flags”, then it would be used like this (notice the @ symbol): <code> fixbb.macgccrelease @ flags </code>

Note that other options can still be set before or after the flags file is specified, and MULTIPLE flag files can be used - for example <code> @ flags1 @ flags2 @ flags3 </code>.  This will essentially combine flags1 through three - each time overiding any options set in the previous flags.  For setting multiple flag files through a _batch_ run, see the <code> -run:batches </code> option described in the run options.

Common Options and Default User Configuration
=============================================
As of March 2018, Rosetta can now be run with a user configuration file. 
This file is basically an options file that is loaded at the start of each Rosetta run. 
To start with, go to your home directory and create a directory that will be home to any Rosetta configurations. 
`mkdir .rosetta && mkdir .rosetta/flags`

Rosetta will now look in that directory each time it is run. If a file named `common` is found in `$HOME/.rosetta/flags` or if it/they are in the current working directory, we use that instead. You can set any number of flag configurations with the `-fconfig` option. By default (you do not need to pass this), we have:
```
   -fconfig common
```

 This `-fconfig` option is also useful if you have a set of flags for different purposes - like design, glycans, and antibodies, so you could do something like:

```
  -fconfig common antibody 
```

 That would load both the common and antibody configurations (which again, are flag files in `.rosetta/flags`


 If you have a common flag file which you wish to ignore for a particular run, you skip loading through an option
```
  -no_fconfig  
```

Finally, the options that are loaded from these files are output to the Rosetta log on startup.  

Running Rosetta via MPI <a name="mpi" />
========================
In order to run Rosetta on a computational cluster or locally on many cores, most Rosetta protocols support parallel execution via MPI. If the Rosetta MPI executables were compiled, then in the executable directory there will be an extra set of executables specifically for MPI, for example <code>fixbb.mpi.linuxgccrelease </code>.  If these have not yet been compiled, please refer to the [[Setting Up Rosetta 3| Build-Documentation#MPI]] page for more information. To run these executables, simply run them via mpiexec (or mpirun for older mpi implementations): 

<code> mpiexec -np 16 fixbb.mpi.linuxgccrelease -database /path/to/database @ flags </code>

Although typically used on large computer clusters, MPI can be installed on multiprocessor linux and mac machines.  If you have a shiny new 8 core desktop, use should be able to use MPI.  There are many different flavors of MPI, but openmpi seems to work well on both Ubuntu and MacOSX.


Most applications are currently compatible with MPI through [[The Job Distributor |jd2]]. See the MPI JobDistributor section for fine control over how Rosetta will use MPI with your run.

A useful option to use when running Rosetta via mpi is <code> -mpi_tracer_to_file path/to/log/dir </code>.  This will separate the output of each processor into separate files.  

Here is an example of the general command I put in a bash script to run via Qsub using environment variables for cluster runs:

<pre>
mpiexec -np $np --machinefile $HOME/dna.machinefile $program.mpi.linuxgccrelease -database
$ROSETTA3/database -nstruct $nstruct -ex1 -add_orbitals -ex2 -use_input_sc -ignore_unrecognized_res @
$flag -mpi_tracer_to_file $HOME/rosetta_run_logs/debug/$debug_log
</pre>

Option Groups and Layers
=========================

Options in Rosetta are grouped by their functional and protocol usages. Each group has at least one layer, the parent layer. Most of the groups have one or more sub-layers holding multiple options. You can use single or double colon to separate the layers.  If the option is unique, such as _nstruct_, one does not need to specify the groups and Rosetta will warn you if this is done, but there are indeed multiple options with the same name.

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
-database yourpath/Rosetta/main/database
```

Option "ex1" is a Boolean type option and set to be false by default, so you can activate it as

```
-packing:ex1
```

Option "nstruct" is a Integer type option, you can use it as

```
-nstruct 10
```

Option "backrub:pivot_residues" is a IntegerVector type option, so

```
-backrub:pivot_residues 10 11 12 13
```

Getting help with options
=========================

There are a few good places to look for help. 

1. Both the [[general documentation | rosetta_basics/Rosetta-Basics]] and [[app-specific docs |application_documentation/Application-Documentation]] are extremely helpful.

2. If you pass <code>-help</code> as a flag on the command line, Rosetta will spit out all existing options and then quit (ignoring other flags).  

3. Be sure to check out the demos and protocol captures for help with specific apps.  These are curated demonstrations of how to use a particular app, with options, general recommendations, input files, etc.  These demos are especially helpful for protocols that use RosettaScripts.

4. Supplemental material of newer Rosetta papers should have the full command-line to use and all the options that were used to generate whatever data the paper is referring to.  Though there may be some option-name-drift through time, these research articles are a great place to start.  

5. If you still require help to run a particular Rosetta application or protocol, checkout www.rosettacommons.org/forum for more information.  The corresponding author of the application or protocol may be able to help as well.

General tips for running Rosetta
=========================
* Most applications use the -s and -l options to specify a single input PDB or a file that lists PDBs, commonly called a PDBLIST.  The PDBList file should specify the full path to the PDB (one on each line), unless <code>-in:path:pdb directory/to/pdb/files</code> is specified.  See [[this page | input-options]] for more common input options.
<br>
<br>
* If you have a score file output and want to find the lowest energy structure, use the <code>sort</code> command.  You can sort on a particular column using the -kx option. See [this page](http://www.skorks.com/2010/05/sort-files-like-a-master-with-the-linux-sort-command-bash/) for more.
 - Sort by total score: <code>sort my_score_file.sc</code> 
 - Sort by energy term: <code>sort -k5 my_score_file.sc</code>, which would sort by the 5th column, or the 4th score term.
<br>
<br>
* By default, Rosetta will ignore atoms from an input PDB whose occupancy is 0.  If you are missing residues or atoms during a run, this is most likely the cause.  To have Rosetta read these atoms anyway, pass the option <code>-ignore_zero_occupancy false</code>
<br>
<br>
* By default, Rosetta will fail to load a PDB on residues/ligands it does not recognize, although parameters for these residue types may exist.  This is due to the memory needed to understand all of these residue types and their potential chemical modifications (yes, ligands are a residue type.  Rosetta is residue-centric).  Rosetta probably has parameters for your particular residue type. To enable these residue types, see [[this page | How-to-turn-on-residue-types-that-are-off-by-default]].  To ignore these, pass the option <code>-ignore_unrecognized_res</code>
<br>
<br>
* By default, Rosetta will fail to load a PDB with waters.  This is intentional, as most of the Rosetta applications do not deal with water molecules well and the default scorefunction uses implicit solvation. To have Rosetta read the common WAT type, pass the option <code>-ignore_waters false</code>


[[Common/Useful Rosetta Options|options-overview]]
=========================

Rosetta is a highly versatile piece of software, and both its options system and scripting system help give it this versatility. Many Rosetta applications share common options, especially in regard to input and output (as most share a common Job Distributor, JD2).  It is a good idea to review some of these options and see how they can be of use to you. 

- [[Input options]]
- [[Output options]]
- [[Relational Database options | Database-options]]
- [[Run options]]
- [[Score options]]
- [[Packing options]]
- [[Renamed and Deprecated Options]]


##See Also

* [[Fixing errors]]: Troubleshooting common errors in Rosetta
* [[Getting Started]]: A page for people new to Rosetta. New users start here.
* [[Build Documentation]]: Information on setting up Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[TACC]]: Information for running Rosetta on the TACC/Stampede cluster.
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[I want to do x]]: Guide to making specific structural perturbations using RosettaScripts
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[Resources for learning biophysics and computational modeling]]
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Using the ResourceManager|ResourceManager]]
* [[Non-protein Residues]]: Information on running Rosetta with non-protein residues and ligands