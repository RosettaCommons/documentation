<!-- --- title: Command Options -->How to use Rosetta Options and the command line

The command line is composed of two major parts. First, a path to an application executable is required. Second part is a list of options for the particular Rosetta simulation.

Options listed on the command line
==================================

Options can be listed with the command. Options, and arguments to the options, are separated by whitespace. A single or double colon is using to clarify options when there are multiple separate options with the same name. Multiple layers of colons may be needed.

```
fixbb.macgccrelease -in:file:s myinput.pdb -database mypath
```

Options listed in a file
========================

Options can also be written in a flag file. In this file, put one option on each line, still using the colon or double colon is using to specify the layers. An example options file appears below.

```
 -database /home/yiliu/Programing/branches/rosetta_database
 -in:file:s 1l2y_centroid.pdb
 -in:centroid_input
 -score:weights centroid_des.wts
```

If this file were called “option”, then it would be used like this (notice the @ symbol):

```
fixbb.macgccrelease @option
```

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
