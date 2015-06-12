There are special [[integration tests]] for testing the workings of parallelized components of Rosetta with the MPI JobDistributors. 
These can be run by passing the `--mpi-tests` flag to integration.py. 
These tests require Rosetta to be compiled first with the `-extras=mpi` flag passed to scons.  

Where standard integration tests are set up based on the `command` files in the `tests/integration/tests/<testname>/` directories, MPI integration tests are defined in `command.mpi` files.
Where a typical `command` file runs the Rosetta executable directly, `command.mpi` files call `mpirun`, specify the number of processes to launch, and pass the Rosetta executable to `mpirun`.
Note that MPI-level parallelism is inherently stochastic: any slave process may finish its work before any other, meaning that one needs to set up integration tests carefully to test only for unexpected variation and not for this normal variation.

A few things can help you to do this:

1.  The -jd2:sequential_mpi_job_distribution flag tells the MPI JobDistributors that slave processes are to request jobs in sequential order (i.e. slave 1 first, then slave 2, then slave 3).
This ensures that the same job is always assigned to the same slave, yielding consistent trajectories.
*Note that this should **NOT** be used for production runs, since this can result in idle processes, particularly on massively-parallel systems.*

2.  The output log can be split by grepping '(0)', '(1)', '(2)', etc. 
While the master process (process 0) is expected to produce a log with some variability in its output, slave processes (process 1, 2, 3, etc.) should have consistent output.

3.  Scorefiles may need to be re-sorted, since they will be written in the order in which jobs complete, which could vary from run to run.

For examples of how to set up MPI integration tests, see tests/integration/tests/bundlegridsampler_design_nstruct_mode/.

As a final note, most integration tests do not run when the `--mpi-tests` flag is passed to integration.py. 
Only those tests that have a `command.mpi` file will run in this mode.

##See Also

* [[Integration tests]]: General information on Rosetta's integration tests
* [[Running Rosetta in MPI mode|running-rosetta-with-options#mpi]]
* [[Build Documentation]]: Find instructions for building Rosetta mpi executables here
* [[Testing server]]: Server that can be used to run Rosetta integration tests automatically
  * [[Running Tests on the Test Server]]: Instructions for using the testing server
* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
* [[RosettaEncyclopedia]]
* [[Glossary]]