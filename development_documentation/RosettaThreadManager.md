#The RosettaThreadManager

This page was created on 25 July 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

##Introduction

The RosettaThreadManager is a global singleton that manages a pool of threads, and allows modules at many different levels in the Rosetta hierarchy to assign work to threads, while avoidng deadlock, thread explosions, or other problems as described below.

##The problem

Historically, Rosetta has been built around a single-threaded paradigm: a given instance of Rosetta would run on one CPU, and would execute a series of instructions in linear sequence, producing an output.  Multiple CPUs could only be harnessed by running entirely separate, parallel instances of Rosetta.  This creates several problems.

First, it exaggerates the memory footprint of Rosetta, for each instance on a compute node must load its own, independent copy of the Rosetta database and maintain it in memory.  Given that the base memory footprint for a single instance of Rosetta is about 1 GB, his means that, for example, a 64-core node must hold at least 64 GB of data in memory at all times to fully exploit CPU resources -- and this isn't counting whatever protocol-specific memory requirements there are.  On limited-memory systems, this can necessitate launching fewer Rosetta instances than there are CPU cores.

Second, this fails to harness computing resources in the most useful way, especially during the process of developing, debugging, and testing a new protocol (e.g. in the RosettaScripts scripting language).  Given 64 CPUs and, say, a design task that produces one output in an hour, one can produce 64 designs in an hour -- but if one stops the process after fifteen minutes, or half an hour, or forty-five minutes, one has 64 partially-completed jobs and no output at all.  It would be far more useful if more cores meant that a _single_ job could run N times _faster_ -- that is, that one could produce 1 design in just under a minute using all 64 cores.  Similarly, in a production environment, given 10,000 CPUs, one might not want 10,000 samples -- one might prefer 2,500 samples in a quarter of the time.  With independent processes, this is not possible.

If the slowest and most CPU-intensive parts of Rosetta protocols can be parallelized, perhaps we can achieve a many-fold increase in the speed with which individual jobs can be completed with many therads working in tandem on a _single_ job.

**CONTINUE HERE**

##Structure of the RosettaThreadManager

### API

#### Basic work vector interface

**TODO**

#### Advanced parallel function interface

**TODO**

##### RosettaThreadManagerAdvancedAPIKey class

### Internal workings

Note that most developers will never need to concern themselves with the internal workings of the RosettaThreadManager.  They are documented here only for completeness.

#### RosettaThread class

**TODO**

#### RosettaThreadPool class

**TODO**

#### RosettaThreadManager class

**TODO**

##Example of work distribution over threads in a typical Rosetta session

**TODO**

##See also

* [[Multithreading]]
* [[PackRotamersMover]]
* [[FastRelaxMover]]
* [[FastDesignMover]]
