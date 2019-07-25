#Multithreading

This page was created on 25 July 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

##Introduction

**TODO**

##Compiling multi-threaded builds of Rosetta

To compile Rosetta with support for multi-thraeding, append the `extras=cxx11thread` statement to your `scons` command.  For example, to build all binaries in the bin directory in release mode with multi-threading support, use the following:

```bash
./scons.py -j 8 mode=release bin extras=cxx11threads
```

##Infrastructure

###The RosettaThreadManager class

The [[RosettaThreadManager]] is a global singleton that maintains a pool of threads which persist for the entire Rosetta session, to which work can be assigned.  This avoids the overhead of repeatedly launching and destroying threads.  All multithreaded code should assign work to threads by passing it to the RosettaThreadManager.  For more information, see the [[documentation page|RosettaThreadManager]] for this class.

###Threadsafe infrastructure

####The ScoringManager

**TODO**

####Rotamer library code

**TODO**

##Current code that supports multithreading

###The JD3 MultiThreadedJobDistributor

**TODO**

##Code that will support multithreading in the near future
### The Packer 
