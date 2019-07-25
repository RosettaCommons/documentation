#Multithreading

This page was created on 25 July 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

##Introduction

Historically, Rosetta has operated around a paradigm using only a single CPU core.  Systems with many cores per node could run many, entirely independent instances of Rosetta in order to increase sampling, but the speed at which an individual sample was generated could not be increased with more CPU cores.

More recently, effort has been made to ensure that Rosetta's core is fully threadsafe, and to implement infrastructure to facilitate multithreaded protocol development.  At the time of this writing (25 July 2019), very little of Rosetta actually supports multithreading, but we anticipate that much more will in the near future.

This document serves to describe how to build Rosetta with multithreading support, the core infrastructure for thread safety and for threaded code execution, and the modules that currently take advantage of multithreading.

##Compiling multithreaded builds of Rosetta

To compile Rosetta with support for multithreading, append the `extras=cxx11thread` statement to your `scons` command.  For example, to build all binaries in the bin directory in release mode with multi-threading support, use the following:

```bash
./scons.py -j 8 mode=release bin extras=cxx11threads
```

##Infrastructure

###The RosettaThreadManager class

The [[RosettaThreadManager]] is a global singleton that maintains a pool of threads which persist for the entire Rosetta session, to which work can be assigned.  This avoids the overhead of repeatedly launching and destroying threads, and also ensures that nested requests for threading don't result in explosions in the number of running threads.  All multithreaded code should assign work to threads by passing it to the RosettaThreadManager.  For more information, see the [[documentation page|RosettaThreadManager]] for this class.

Note that a handful of multithreaded classes existed prior to the implementation of the RosettaThreadManager, and these launch threads of their own.  We plan to switch these to use the RosettaThreadManager in the near future.

###Threadsafe infrastructure

####The ScoringManager

**TODO**

####Rotamer library code

**TODO**

##Current code that supports multithreading

###The JD3 MultiThreadedJobDistributor

Version 3 of our job distribution system (JD3) includes a multithreaded job distributor class, called `MultiThreadedJobDistributor`.  Currently, this maintains a thread pool of its own, but will soon be switched to use the [[RosettaThreadManager]].

###The simple_cycpep_predict application's job distributor

The [[simple_cycpep_predict]] application, which is used for peptide macrocycle structure prediction, has a hybrid MPI/thread-based job distributor.  At present, this launches threads of its own, but will soon be switched to use the [[RosettaThreadManager]].

###StepWise

The [[StepWise|stepwise]] protocol is able to parallelize its work.  Currently, it maintains its own thread pool, but will be switched to use the [[RosettaThreadManager]] in the near future.

##Code that will support multithreading in the near future

### The Packer

Work is currently underway to parallelize the interaction graph precalculation performed by the Rosetta Packer.  Since the packer is called by many or most Rosetta protocols, we believe that this will represent a significant performance advantage.
