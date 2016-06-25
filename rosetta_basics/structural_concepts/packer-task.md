#How to use the PackerTask

Author: Steven Lewis

This page describes how the PackerTask (actually the PackerTask\_, because the former is an interface class) is intended to be used. Andrew LF built it so that it would be "commutative": the order in which you alter the PackerTask has no effect on its ultimate state (this is like a state function in thermodynamics). As a corollary, you are not allowed to arbitrarily modify the PackerTask; you can alter it generally only through commutative setters. Also, much of the real information in the PackerTask is contained within its ResidueLevelTasks (ResidueLevelTask\_), which allows position-level control of behavior. Most of this documentation applies to either; a call to the\_task.residue\_task(resid) returns the ResidueLevelTask you want.

An introductory tutorial on the Packer can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/Optimizing_Sidechains_The_Packer/Optimizing_Sidechains_The_Packer).

Commutativity
=============

There are two types of commutativity: "and" + "or". and commutativity means that a behavior will be true if and only if all inputs are consistently true, it means:

-   state = (input1 && input2 && input3 && input4)

This is used for behaviors that default to being turned "on", and will therefore stay on until they are explicitly turned off. The notable PackerTask behaviors here are the packability and designability of residues, which both start on, as well as the residue types list, which starts with all canonicals (both his tautomers; not disulfides) allowed at all positions.

The other type of commutativity is or, which functions as:

-   state = (input1 || input2 || input3 || input4)

This is used for behaviors which default "off" and must be turned on. Notable examples include anything related to rotamers and inclusion of noncanonical amino acids.

How to make calls changing the PackerTask
=========================================

The PackerTask\_ documentation (PackerTask is an interface class) contains the documentation for individual functions. Typically, calls to functions that start with or\_ will be an or-commutative behavior; calls that start with and (or those like restrict\_to\_repacking or prevent\_repacking) will have and-commutative behavior, and calls that are not obviously either are probably get functions.

How to chain calls
==================

PackerTask calls that modify the task usually return the task. This allows you to chain calls together:

```
the_task.initialize_from_command_line().read_resfile();
```

This will cause the PackerTask to have all its member data set to match the commutative "solution" to the behaviors defined by the command line and resfile.
