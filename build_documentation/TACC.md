Using Rosetta and PyRosetta on TACC/Stampede
============================================

TACC/Stampede
-------------

As part of the Extreme Science and Engineering Discovery Environment project (XSEDE <https://www.xsede.org/>), both Rosetta and PyRosetta are installed on the Stampede system at the Texas Advanced Computing Center (TACC <https://www.tacc.utexas.edu/>).
XSEDE is a project to provide US researchers a single virtual system with access to computational resources from across the United States. See the XSEDE website (<https://www.xsede.org/>) for more information, and details on how to obtain access.

Obtaining access to Rosetta and PyRosetta
-----------------------------------------

Access to Rosetta and PyRosetta on TACC/Stampede is limited to academic users for non-commercial usage only. Before using Rosetta and PyRosetta on TACC/Stampede, you should first obtain a (free) academic license for the program(s) you wish to use. (If you wish to use both Rosetta and PyRosetta, please sign both licensing agreements.) Licenses for Rosetta and PyRosetta can be obtained from <https://www.rosettacommons.org/software/license-and-download>. Turnaround for academic licenses should be rapid, and soon after filling out the licensing agreements proof of licensing will be emailed to you. (Check your junk mail folder and email filtering if you do not receive the conformation email.)

Once you receive confirmation of licensing, you must obtain authorization from TACC to access the locally installed Rosetta and PyRosetta module. (Current instructions on obtaining authorization should be printed to the terminal when you run "module load rosetta" or "module load pyrosetta" as an non-authorized user.) Authorization can be obtained through the XSEDE help system at <https://portal.xsede.org/group/xup/help-desk> - simply select Category:Software System:Stampede, and provide proof of licensing for Rosetta and/or PyRosetta in the Problem Description box. 

Contacting the TACC administrator through the XSEDE help system is sufficient for gaining access. Rosetta and PyRosetta are provided as a precompiled modules, and no additional license file, key, hash or password is needed to run Rosetta and PyRosetta on TACC/Stampede, once you've verified your license with TACC staff. (Licensing will also allow you to download and install the programs to your own local systems, if you wish. You will need the username and password provided with the license confirmation email if you wish to download and install Rosetta and PyRosetta to a local systems.)

If you are interested in commercial use of Rosetta and PyRosetta, please see <http://www.rosettacommons.org> for licensing information. Note that that XSEDE policies prohibit use of TACC/Stampede resources for commercial purposes.


The difference between Rosetta and PyRosetta
--------------------------------------------

Both Rosetta and PyRosetta are comprehensive software suites for design and modeling of macromolecular structures. Both make use of a library of macromolecular modeling tools written in C++. Rosetta provides an interface to those libraries with compiled command-line executables, while PyRosetta provides access through a Python programming language 
interface. 

Both Rosetta and PyRosetta are capable of achieving similar design and modeling results. The choice of which to use is up to personal preference. The standard Rosetta interface is good for those looking to incorporate macromolecular modeling into a command-line-oriented workflow, whereas PyRosetta is the choice for those who prefer using a Python scripting workflow, or who need the flexibility which a more direct library interface can bring.

Running Rosetta commands on TACC/Stampede
=========================================

A pre-compiled version of Rosetta is provided for users on the TACC/Stampede cluster. (See the XSEDE user guide <https://www.xsede.org/using-xsede> about how to log into Stampede. Currently, the recommended way is to ssh into the central login point login.xsede.org and then log into the Stampede system from there.)

To initialize your Stampede command-line environment for Rosetta usage, use the standard XSEDE module loading facility (<https://www.xsede.org/software-environments>):

    module load rosetta

It may be necessary to load specific versions of the compiler and MPI libraries prior to loading rosetta:

    module load intel/14.0.1.106
    module load mvapich2/2.0b
    module load rosetta

Run `module spider rosetta` to see a current list of dependencies. `module spider rosetta` is can also be used to discover if there are alternative versions of Rosetta available. Once Rosetta is loaded, `module list rosetta` will tell you which version is being used currently.

*Note: As of January, 2015, the current default version of Rosetta on Stampede is Rosetta-3.5* 

Loading the rosetta module will place the Rosetta executables into your path, and also set the TACC_ROSETTA_BIN and TACC_ROSETTA_DATABASE environment variables, allow you to run Rosetta executables:

    ${TACC_ROSETTA_BIN}/rosetta_scripts.default.linuxiccrelease -database ${TACC_ROSETTA_DATABASE} @rosetta.options

*Note: As of January, 2015, the current installation of Rosetta on TACC is for MPI only - the "default" series of builds do not exist.*

Note that you will want to run executables via the standard TACC/Stampede batch submission system (SLURM). See <https://www.xsede.org/web/guest/tacc-stampede#running> for details.

See the main Rosetta documentation at <https://www.rosettacommons.org/docs/latest/> for more information on which applications to use for particular modeling purposes, and for details on how to set up the appropriate options files.

Multiprocessor runs with Rosetta
--------------------------------

### MPI

As TACC charges for access to the complete node, regardless of the number of processors being used, it's best to have Rosetta automatically distribute output structures to the various processors. Additionally, certain protocols require more extensive internal communication, and as such cannot be parallelized trivially.

For these purposes, Rosetta has an MPI parallelization mode. MPI support is already available in the Rosetta application loaded with `module load rosetta`. Rosetta MPI on TACC/Stampede has been compiled with the mvapich2 MPI libraries, and a Rosetta MPI run can be started on TACC/Stampede with 

    ibrun ${TACC_ROSETTA_BIN}/rosetta_scripts.mpiomp.linuxiccrelease -database ${TACC_ROSETTA_DATABASE} @rosetta.options

Of course, you should be launching your jobs on TACC/Stampede via the SLURM batch management system:

Example SLURM file for an MPI Rosetta run:

```
#!/bin/bash
#SBATCH -J RosettaRun_%j   # job name
#SBATCH -o myMPI.o%j       # output and error file name (%j expands to jobID)
#SBATCH -n 32              # total number of mpi tasks requested
#SBATCH -p normal          # queue (partition) -- normal, development, etc. 
#SBATCH -t 01:30:00        # run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=username@example.com
#SBATCH --mail-type=fail   # email me if the job fails
#SBATCH -A A-yourproject   # Allocation to charge time against.

module load intel/14.0.1.106
module load mvapich2/2.0b
module load rosetta

#Alter the job control above as desired and then use "ibrun" to launch your jobs

ibrun ${TACC_ROSETTA_BIN}/rosetta_scripts.mpiomp.linuxiccrelease -database ${TACC_ROSETTA_DATABASE} @rosetta.options &>> rosetta.log
```

Certain protocols will require additional flags to control MPI behavior. Please see the Rosetta documentation at <https://www.rosettacommons.org/docs/latest/> for more details on MPI, including which protocols support MPI, and how to set up the options file for it.

### Trivial parallelization

*Note: As of January, 2015, the current installation of Rosetta on TACC must be run through MPI, and cannot be run in "trivially parallel" mode through the launcher.*

Normal Rosetta runs typically involve creation of an large number (often hundreds or thousands) of output structures, each one from an independent trajectory. As each trajectory is independent, the output of these multiple trajectories can be manually divided among multiple processors. How exactly to do this is somewhat protocol dependent, but most often can accomplished by splitting input files into separate runs, and/or by doing multiple runs each with a smaller number of output structures (e.g. doing ten runs with -nstruct 100 rather than one run with -nstruct 1000 ). The multiple output structures can then be combined with a post processing command.

Note that TACC deducts CPU hours for the use of an entire 16 core node, even if only a single process is run on it. For this reason, you will want to run multiples of 16 processes at once. To help manage multiple runs, TACC provides a parametric job launcher. This takes a parameter file with one line for each command to be run. See ```module help launcher``` and ```module load launcher; less $TACC_LAUNCHER_DIR/README.launcher```, as well as the example run at `$TACC_LAUNCHER_DIR/launcher.slurm` and `$TACC_LAUNCHER_DIR/paramlist` for more details.

Keep in mind that there can be performance issues with multiple processes trying to write to the same files and directories simultaneously. For this reason it's recommended when using trivial parallelization to make a separate working directory for each separate command you list in the running queue. 

### Intel Xenon Phi

Work with providing better support for the Phi coprocessor is ongoing, but Rosetta is not currently configured to take full advantage of the Phi coprocessor. 

### GPU 

There are a limited number of accessory protocols which can use GPUs, but for the most part Rosetta is not configured to take advantage of GPU capabilities. 

### Shared memory (threading)

While certain limited protocols have multithreading support, Rosetta is not currently set up for general shared-memory parallelism (multithreading). Use the distributed-memory MPI parallelism instead.

Running PyRosetta
=================

PyRosetta can be setup for runs on Stampede with
 
    module load pyrosetta

This will set up your Python environment such that PyRosetta can be loaded from the default python. Scripts using PyRosetta can then be run from within a SLURM batch file with:

    python your_script_name.py [options]

Note that TACC will charge you for a full (16-processor) node, even if you are only running a single thread. For this reason, you will want to run multiples of 16 processes at once. To help manage multiple runs, TACC provides a parametric job launcher. This takes a parameter file with one line for each command to be run. See `module help launcher` and `module load launcher; less $TACC_LAUNCHER_DIR/README.launcher`, as well as the example run at `$TACC_LAUNCHER_DIR/launcher.slurm` and `$TACC_LAUNCHER_DIR/paramlist` for more details. Alternatively, you may want to use the multiprocessor job distributor in PyRosetta (see below).

Interactive sessions with PyRosetta (e.g. in a node allocated with the ``idev`` command) can also be used from within the Python interpreter.

    idev                   # Request an interactive node
    module load pyrosetta  # Setup PyRosetta on the interactive node
    python                 # Start python on the interactive node

For more information on how to use PyRosetta, see the main PyRosetta documentation at <http://www.pyrosetta.org/>

Multiprocessor runs with PyRosetta
-----------------------------------

The underlying Rosetta libraries from PyRosetta have not been compiled with MPI, and so cannot support protocols at the Rosetta level which require MPI support.

However, the Python layer of PyRosetta does have MPI support. To enable MPI on python, one must first do a `module load python` and `module load mpi4py` in addition to the `module load pyrosetta`. Additionally, use the `rosetta.mpi_init()` function instead of `rosetta.init()` to initialize Rosetta. You would then use `ibrun python myscript.py` to launch the run (again, in a SLURM script).

```
#!/bin/bash
#SBATCH -J RosettaRun_%j   # job name
#SBATCH -o myMPI.o%j       # output and error file name (%j expands to jobID)
#SBATCH -n 32              # total number of mpi tasks requested
#SBATCH -p normal          # queue (partition) -- normal, development, etc. 
#SBATCH -t 01:30:00        # run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=username@example.com
#SBATCH --mail-type=fail   # email me if the job fails
#SBATCH -A A-yourproject   # Allocation to charge time against.

module load python
module load mpi4py
module load pyrosetta

#Alter the job control above as desired and then use "ibrun" to launch your jobs

ibrun python myPyRosettaScript.py
```

In the main rosetta namespace, there is an `MPIJobDistributor` function which can facilitate setting up MPI runs. To use, call `MPIJobDistributor(nstruct, fun)` where `nstruct` is the number of total jobs to run, and `fun` is a function object taking a single integer in the range of 0 to (nstruct-1), which identifies which job to run. How that integer is translated to a job is entirely up to the user-defined function to control.

*Note: As of January, 2015, there is a bug in the current version of PyRosetta installed on TACC/Stampede which results in an error when running the default MPIJobDistributor.*
*Until it is fixed, people who are interested can re-implement the function in the troubleshooting section below.*

Troubleshooting issues with Rosetta and PyRosetta on TACC/Stampede
------------------------------------------------------------------

Rosetta and PyRosetta will typically print out diagnostic error messages to the standard output and standard error. If you're having difficulties with your Rosetta and PyRosetta runs, make sure that you haven't muted any of the output channels, and examine the output for any Warning or Error messages. Most commonly the presence of these messages indicate that there is an issue with the formatting of an input file.

If you're running Rosetta with MPI, adding the option "-mpi_tracer_to_file <prefix>" to the command line may help in readability, as it will save the tracer output to separate files in the current directory, rather than interleaving them on the standard output.

Further help with debugging Rosetta and PyRosetta error messages is available at the Rosetta and PyRosetta forums: <https://www.rosettacommons.org/forum>

### Known issues

* If you're getting an error regarding "mkstemp", either add the flag `-dont_rewrite_dunbrack_database` to the command line, or make a personal copy the Rosetta database (in a directory writable by you) and supply that with the `-database` command-line option instead of the `${TACC_ROSETTA_DATABASE}` directory.

* If you're getting error messages about the Rosetta executable not being found, check the extensions being used. For example, if you're trying to use the relax executable, do a `ls ${TACC_ROSETTA_BIN}/relax.*` to examine the current naming conventions. You may need to adjust the extensions.

* If you're getting error messages about "TR" when attempting to use the PyRosetta MPIJobDistributor, you're using a version with a known bug. Add the following function redefinition to your script file after any `from rosetta import *` statements.

```python
def MPIJobDistributor(njobs, fun):
    from rosetta import logger
    from mpi4py import MPI

    comm = MPI.COMM_WORLD

    rank = comm.Get_rank()
    size = comm.Get_size()

    myjobs = []

    if rank == 0:
        jobs = range(njobs)
        jobs.extend( [None]*(size - njobs % size) )
        n = len(jobs)/size
        for i in range(size):
            queue = []  # list of jobs for individual cpu
            for j in range(n):
                queue.append(jobs[j*size+i])

            if( i == 0 ):
                myjobs = queue
            else:
                # now sending the queue to the process
                logger.info('Sending %s to node %s' % (queue, i) )
                comm.send(queue, dest=i)
    else:
        # getting decoy lists
        myjobs = comm.recv(source=0)

    logger.info('Node %s, got queue:%s' % (rank, myjobs) )

    for j in myjobs:
        if j is not None: fun(j)
```

##See Also

* [[Running Rosetta with options]]: General instructions for running Rosetta command lines
* [[Platforms]]: Supported platforms for Rosetta

* [[Commands collection]]: Example command lines for Rosetta applications
* [[Application documentation]]: Descriptions of Rosetta apps
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta