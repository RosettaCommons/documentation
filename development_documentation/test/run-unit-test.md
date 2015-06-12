#Running unit tests.

There are three ways to run unit tests:

-   Run all unit test suites at once.
-   Run an individual test suite (a set of tests for a class, usually)
-   Run an individual unit test.

Organization of unit test code
================================
Unlike other Rosetta tests, unit tests are **compiled**, extra code baked directly into the codebase, at `Rosetta/main/source/test`. 
The inside of this test directory mirrors the `src` directory, so that code on particular classes lives in a similar place. 
`test/run.py` is the master script that RUNS the unit tests.

Compiling unit tests
====================
Unit tests are C++ code and must be compiled. 
Simply add `cat=test` to your `scons` command line to build the unit tests. 
The underlying Rosetta libraries must exist (you must have built WITHOUT `cat=test` first).
The binaries are NOT important.
Tests are intended to be built and run in `debug` mode, because this catches more errors.
Test compiling is at least an order of magnitude faster than the main codebase (a bad sign that we don't have good unit test coverage).
Broadly, compiling should look like:

```
cd Rosetta/main/source
scons.py -j #numproc mode=debug
scons.py -j #numproc mode=debug cat=test
```

Run all unit test suites at once.
================================

This is the preferred method for running the Unit Tests before committing changes to Rosetta, or verifying that Rosetta has been installed correctly. To do this, use the following command:

```
cd Rosetta/main/source
python test/run.py <optional command line args>
```

Important optional command line arguments include:

-   **-d, --database** Specifies the path to the Rosetta database.

-   **-j, --jobs** Specifies the number of jobs (unit tests) to run simultaneously. For example, if the machine has 8 cores, use -j 8 to have maximum performance.

-   **--mode** Specifies which 'mode' (eg. debug, release) to pass to scons to identify the platform path.

-   **--extras** Specifies which 'extras' settings (e.g. mpi) to pass to scons to identify the platform path.

-   **-c, --compiler** Specifies which 'compiler' setting to pass to scons to identify the platform path.

-   **--mute** Specifies which tracer channels to mute.

-   **--unmute** Specifies which tracer channels to unmute.

-   **-1, --one** Specifies to run just one unit test or test suite.

Currently, the run.py script executes the following tests: apps, core, demo, devel, numeric, ObjexxFCL , protocols and utility.

###Successful output
A successful set of tests ends with something like this:
```
-------- Unit test summary --------
Total number of tests: 1749
  number tests passed: 1749
  number tests failed: 0
Success rate: 100%
---------- End of Unit test summary
Done!
```

###Unsuccessful output

```
-------- Unit test summary --------
Total number of tests: 1692
  number tests passed: 1688
  number tests failed: 4
  failed tests:
    core.test: CartesianBondedEnergyBBDepTests:test_eval_energy
    core.test: CartesianBondedEnergyTests:test_eval_energy
    core.test: CartesianBondedEnergyTests:test_cartbonded_start_score_start_func_match_w_total_flexibility
    core.test: CartesianBondedEnergyBBDepTests:test_cartbonded_start_score_start_func_match_w_total_flexibility
Success rate: 99%
---------- End of Unit test summary
Done!
```

For this run, a user would need to determine what they'd broken in the CartesianBondedEnergy code.

###Tests broken globally
If no tests at all run, or all tests fail, there is probably a configuration issue.
Usually you compiled in release instead of debug mode and forgot to inform `test/run.py` of that fact or something similar.

Run A Single Unit Test or Test Suite
====================================

This method is useful if you are working on unit test debugging and want to save time by skipping some tests. To run all tests from a single test suite, use the `  --one  ` option to `  test/run.py  ` .

Sometimes it is necessary to run a test by hand. To do this, you need first to locate its executable. Currently all unit test executables are located in the `build/test/...` directory; executable files are named by adding .test to the unit test suite name. Note: the path may vary depending on the platform you working on: for example, for 32-bit Linux compiled with gcc it will be: 'build/test/debug/linux/2.6/32/x86/gcc'.

**The test executable should be running from the build directory.** This is important since some unit tests will try to locate additional files needed using relative paths. For example, here is a command to run only the core test executable:

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test –database /path/to/rosetta/main/database --mute core      `

If you want to run only one test or just one suite, you will need to supply the name of the test function or name of the suite as the **first** argument to the test executable. Here are examples of running only test\_simple\_min and suite MyTestSuite from core tests:

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test test_simple_min --database /path/to/rosetta/main/database --mute core      `

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test MyTestSuite –database /path/to/rosetta/main/database --mute core      `

##See Also

* [[Guide to writing unit tests|test]]
* [[UTracer]], a tool to simplify writing unit tests
* [[Writing unit tests for movers using UMoverTest|mover-test]]
* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
