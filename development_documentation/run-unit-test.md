#Running unit tests.

Metadata
========

Last edited 10/10/10. Matthew O'Meara (mattjomeara@gmail.com)

There is two option to run unit test:

-   Run all unit test suits at once.
-   Run individual test suit.
-   Run individual unit test.

Run all unit test suits at once.
================================

This is the preferred method for running the Unit Tests before committing changes to Rosetta. To do this,

```
python test/run.py <optional command line args>
```

Important optional command line arguments include:

-   **-d, --database** Specifies the path to the rosetta\_database.

-   **-j, --jobs** Specifies the number of jobs (unit tests) to run simultaneously. For example if the machine has 8 cores use -j 8 to have maximum performance.

-   **--mode** Specifies which 'mode' (eg. debug, release) to pass to scons to identify platform path.

-   **--extras** Specifies which 'extras' settings to pass to scons to identify platform path.

-   **-c, --compiler** Specifies which 'compiler' setting to pass to scons to identify platform path.

-   **--mute** Specifies which tracer channels to mute.

-   **--unmute** Specifies which tracer channels to unmute.

-   **-1, --one** Specifies to run just one unit test or test suite.

Currently run script execute following tests: apps, core, demo, devel, numeric, ObjexxFCL , protocols and utility.

Run A Single Unit Test or Test Suite
====================================

This method is useful if you working on unit test debugging, and want to save time by skipping some tests. To run all tests from a single test suite, use the `       --one      ` option to `       test/run.py      ` .

Sometimes it is necessary to run a test by hand. To do this, you need first to locate it executable. Currently all quilted unit test executable located in: build/test/... directory, executable files named by adding .test to the unit test suite name. Note: path may vary depending on platform you working on, for example for 32 bit Linux compiled with gcc it will be: 'build/test/debug/linux/2.6/32/x86/gcc'.

Test executable should be running from the build directory, this is important since some unit test will try to locate additional files needed using relative path. Example of command to run only core test executable:

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test –database ~/rosetta_database --mute core      `

If you want to run only one test or just one suite - you will need to supply name of the test function or name of the suite as a *first* argument to the test executable. Here the example of running only test\_simple\_min and suite MyTestSuite from core tests:

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test test_simple_min --database ~/rosetta_database --mute core      `

`       cd build/test/debug/linux/2.6/32/x86/gcc      `

`       ./core.test MyTestSuite –database ~/rosetta_database --mute core      `
