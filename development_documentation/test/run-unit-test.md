#Running unit tests.

Metadata
========

Last edited 10/10/10. Matthew O'Meara (mattjomeara@gmail.com)

There are three ways to run unit test:

-   Run all unit test suites at once.
-   Run an individual test suit.
-   Run an individual unit test.

Run all unit test suites at once.
================================

This is the preferred method for running the Unit Tests before committing changes to Rosetta. To do this, use the following command:

```
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

Run A Single Unit Test or Test Suite
====================================

This method is useful if you are working on unit test debugging and want to save time by skipping some tests. To run all tests from a single test suite, use the `  --one  ` option to `  test/run.py  ` .

Sometimes it is necessary to run a test by hand. To do this, you need first to locate its executable. Currently all unit test executables are located in the `build/test/...` directory; executable files are named by adding .test to the unit test suite name. Note: the path may vary depending on the platform you working on: for example, for 32-bit Linux compiled with gcc it will be: 'build/test/debug/linux/2.6/32/x86/gcc'.

**The test executable should be running from the build directory.** This is important since some unit tests will try to locate additional files needed using relative paths. For example, here is a command to run only the core test executable:

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test –database ~/rosetta_database --mute core      `

If you want to run only one test or just one suite, you will need to supply the name of the test function or name of the suite as the **first** argument to the test executable. Here are examples of running only test\_simple\_min and suite MyTestSuite from core tests:

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test test_simple_min --database ~/rosetta_database --mute core      `

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test MyTestSuite –database ~/rosetta_database --mute core      `
