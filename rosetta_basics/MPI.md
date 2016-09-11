# MPI
## Using Rosetta with MPI

MPI ([Message Passing Interface](https://en.wikipedia.org/wiki/Message_Passing_Interface)) is a method to coordinate processing runs across multiple processors and multiple machines. Many of the large computational clusters use MPI to manage running jobs.

MPI is intended for programs which require frequent coordination between processors during the run. Most Rosetta protocols are considered to be "trivially parallelizable" - each output structure is generated in isolation from other output structures. Therefore, there is little distinction between a single multiprocessor run with MPI and multiple single processor runs. In these protocols, MPI is only used to coordinate outputting structures between the processors. The two advantages of an MPI run is slightly better handling of output (multiple single processor runs require post-processing to combine outputs), and the ability to run on clusters which require running with MPI.

Certain protocols (listed below) use MPI non-trivially. These protocols do use (semi-)frequent communication between the processors to coordinate processing. These do require running in an MPI context.

## Building Rosetta with MPI

* See Also [[Build Documentation]]

In order to enable MPI runs, you need to have Rosetta compiled with MPI support.

To do this, compile with the "extras=mpi" option:

    ./scons.py bin mode=release extras=mpi

This will create new versions of the application in the bin directory, named like `minirosetta.mpi.linuxgccrelease`. The central "mpi" (rather than "default") in the application name indicates that the application was compiled with "extras=mpi" and has MPI support.

Compilation of MPI mode Rosetta requires access to the MPI libraries and headers. These libraries are highly system dependent - the type and location of these files varies based on the computer system and cluster you're compiling for. Ask your cluster administrator about the settings you need for your cluster.

The location of MPI libraries and headers need to be specified in the file `main/source/tools/build/site.settings`. There are a number of examples for various clusters in that directory in the `main/source/tools/build/site.settings.*` files. `main/source/tools/build/site.settings.topsail` is a good starting point. Simply copy it to `main/source/tools/build/site.settings`. Further adjustment may be needed.

### Installing MPI itself
We cannot support installing MPI itself on all possible systems, but for Linux systems, the package `openmpi-bin` is usually the right place to start.

## Running Rosetta with MPI

### Launching MPI jobs

Launching Rosetta MPI runs is cluster-dependent. Talk to your cluster administrator about the preferred way of launching MPI jobs on your cluster.

Generally, there is an MPI launcher script (normally called something like "mpirun" or "mpiexec") which is used to initialize the Rosetta MPI program on the multiple processors of the cluster.

    mpirun minirosetta.mpi.linuxiccrelease ...

How to specify how many processors to run and on which machines is cluster dependent. Again, talk to your cluster administrator for details about your particular cluster.

### Running serial jobs with MPI

* See Also: [[Running Rosetta via MPI|running-rosetta-with-options#running-rosetta-via-mpi]], [[MPI Job Distributors|jd2#mpi-job-distributors]]

TODO

### Running intrinsically parallel protocols with MPI

TODO

## Protocols using MPI non-trivially.

* [[MPI MSD]] - Multistate design. MPI is used to coordinate the multiple generations of the sequence in the genetic algorithm used.
* [[pmut scan parallel]] - Parallel mutation scan.
* [[optE_parallel|opt-e-parallel-doc]] - Optimize energy functions, in particular reference energies.
* [[Loopmodel MPI|loopmodel#loopmodel-mpi]] - Parallelize loop modeling.
* [[ParallelTempering|Tempering-MetropolisHastings]] - 

##See Also

* [[JD2]]: The Job Distributor, commonly used when running MPI protocols
* [[Running Rosetta with options]]
* [[Build Documentation]]: Information on building Rosetta
* [[Rosetta Basics]]