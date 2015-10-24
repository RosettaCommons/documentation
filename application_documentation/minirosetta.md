#Boinc minirosetta application usage and overview

Metadata
========

The relevant Mini-Rosetta code is in minirosetta.cc This document was written 22 Jan 2008 by David E. Kim and last updated 24 October 2015 by Vikram K. Mulligan (vmullig@uw.edu).

General Information
===================

This document contains an overview of the "minirosetta" application and its usage. Similar to the rosetta++ "all in one" application, "minirosetta" runs different modes or protocols depending on command line arguments. "minirosetta" is developed for running large scale distributed tasks on [Rosetta@home](http://boinc.bakerlab.org/rosetta) using [Boinc](http://boinc.berkeley.edu) .

Building
========

Command line application
------------------------

To build "minirosetta" as a command line application that can be run on local clusters (does not depend on Boinc), use the following scons commands as examples. General rosetta scons build options apply. Use "scons -h" for build system usage information.

-   Debug build

    ```
    scons bin/minirosetta.gcclinuxdebug
    ```

-   Release build

    ```
    scons mode=release bin/minirosetta.gcclinuxrelease
    ```

Boinc application
-----------------

To build "minirosetta" as a Boinc application, use the following scons commands as examples. Note: extras=boinc,static must be used to create a static application for running on Boinc.

- Debug build

   ```
   scons extras=boinc, static bin/minirosetta.gcclinuxdebug
   ```

- Release build

   ```
   scons extras=boinc, static mode=release bin/minirosetta.gcclinuxrelease
   ```

Boinc optional arguments
========================

```
[-in::file::zip <zipped archive>]
```

A zipped archive file. Unzips contents into the run directory using the boinc\_zip library from BOINC before running the rosetta protocol. This is useful for input files and directories like the minirosetta database. For example, all input files can be zipped into one compressed archive file.

Protocols
=========

The following protocols can be run.

Classic Abinitio and Relax ( -protocol abrelax )
------------------------------------------------

This protocol runs classic abinitio and relax for de novo protein fold prediction. The relevant code is in classic_abinitio_relax_impl.cc

### Basic Usage

```
minirosetta [-protocol abrelax] [-fasta <fasta file> or -native <native pdb>] [-frag3 <3mer frag file>] [-frag9 <9mer frag file>] [options..]
```

### Optional arguments

Additional standard minirosetta and protocol specific arguments also apply.

```
[-nstruct <int>]
```

number of decoys (default 1).

```
[-increase_cycles <float>]
```

Increase number of cycles at each stage by this factor.

```
[-abinitio::relax]
```

Do relax after abinitio.

```
[-out::file::silent <silent file name>]
```

Name of silent output file. Default is "default.out".

```
[-out::silent_gz]
```

Gzip silent output file.

```
[-checkpoint]
```

Turn checkpointing on with default time interval (5 minutes).

```
[-checkpoint_interval <int>]
```

Turn checkpointing on with given time interval in seconds.

Simple Cyclic Peptide Prediction ( -protocol simple_cycpep_predict )
------------------------------------------------

Full documentation for this application is available on the [[Simple Cyclic Peptide Prediction Application|simple_cycpep_predict]] page.  (The simple_cycpep_predict BOINC graphics are particularly nice, though, if I do say so myself.)

Ligand Dock ( -protocol ligand\_dock )
--------------------------------------

Under construction......


##See Also

* [[Minirosetta comparative modeling]]: Using the minirosetta application for comparative modeling
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[RosettaScripts]]: The RosettaScripts home page