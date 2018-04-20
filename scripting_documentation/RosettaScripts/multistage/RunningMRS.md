#MultistageRosettaScripts

#Running Multistage Rosetta Scripts

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

##Compiling M.R.S. With MPI

In order to run with mpi, you must also compile with serialization:

```sh
./scons.py -j<number of cores> mode=release extras=mpi,serialization bin
```

The executable will look something like `multistage_rosetta_scripts.mpiserialization.linuxgccrelease`

##Relevant Commandline Flags

###job_definition_file

`-in:file:job_definition_file <filename>`

This similar to `-parser:protocol` in traditional RosettaScripts.
This is how you pass your script to Rosetta.

###n_archive_nodes

`-jd3:n_archive_nodes <int>` (default is 0, meaning the archives are stored on the master node)

Not all of the CPUs you use will actually be running your script.
One will be the "master" and control job distribution and result storing.
You may find that you have too many job results to fit in this node's memory.
If so, you can request additional archive nodes using this flag.

It is hard to know ahead of time how much memory you will need.
M.R.S. has an [[archive memory estimation utility|MRSTools#estimate-memory]],
but that is still experimental and usually underestimates the memory requirements.
The next option was introduced because of this difficulty:

###archive_on_disk

`-jd3:archive_on_disk <directory name>`

Archive memory requirements (see previous section) are hard to predict
and will kill the program if you underestimate.
Because of this unfriendly behavior,
we added the option to store job results on the disk.
You just need to create an empty directory and pass the
path to that directory as the argument to this option as shown in the example below.

Accessing information on the disk is much slower than accessing elements in memory.
This slowdown is negligible in this case because these elements are accessed very infrequently.
Additionally, this allows you to have more CPUs
running your protocol instead of being archive nodes
(you can greatly reduce your value for `n_archive_nodes` when archiving on disk).

##Examples

###Archiving on disk

```sh
mkdir archives
mpirun -n 200 multistage_rosetta_scripts.mpiserialization.linuxgccrelease -job_definition_file job_def.xml -n_archive_nodes 1 -archive_on_disk archives @other_flags
rm -rf archives
```
You may not want to delete the archives immediately.
They can be useful for the [[time machine feature|TimeMachineExample]]
and for loading from checkpoints (whenever that feature is implemented).

###Archiving in memory

```sh
mpirun -n 200 multistage_rosetta_scripts.mpiserialization.linuxgccrelease -job_definition_file job_def.xml -n_archive_nodes 10 @other_flags
```


##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
