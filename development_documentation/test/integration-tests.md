Rosetta's *integration tests* are a set of testing tools that test short protocol runs before and after changes to the code, and compare the protocols' output to check for unexpected changes. 
They are useful for determining whether code behavior **changes** but not whether it is **correct**. 
The tests live in `{Rosetta}/main/tests/integration`: the main repository, but not directly with the code.
**Developers are expected to run these tests before merging code to `master`.**

What integration tests do and not do
====================================

The integration tests are "black box tests" that examine the results of big chunks of code.

Generally, an integration test:
* runs one executeable with a reasonable set of inputs and flags
* finishes within 30 seconds
* runs to completion without an error message 
* ensures that code has not changed accidentally from one revision to the next
* compares, [[byte-for-byte|https://en.wikipedia.org/wiki/Diff_utility]], the results of a command AFTER your changes and BEFORE your changes

They do not:
* Run the same on all machines
 * They are long enough to have numerical noise and processor difference effects (which are grabbed by Monte Carlo and blown into full trajectory differences).  This is a known weakness and just the way it is.
* Produce scientifically useful results
 * The short runtime is more important than result validity
 * This is the goal of [[scientific tests]]
 * Runtime in an absolute sense is checked by [[performance tests]]
* check that the code works right
 * Integration tests only check that it runs the same as before, not that it's right
 * This is the goal of [[unit tests]]

When to run integration tests
=============================
**Developers are expected to run integration tests before merging to `master`.**
Just run the whole set of tests before you merge, as part of the [[before you merge]] protocol.
Remember that it is perfectly ok if there are expected integration test changes due to code you changed: if you've rewritten your protocol, of course its tests will change!
The purpose of the tests in this fashion is to ensure that there are not *unexpected* changed, and that the changes that are expected are *explicable* from the code that changed.

You can also get into the habit of [[test-driven development|https://en.wikipedia.org/wiki/Test-driven_development]] as [[described below|#using-integration-tests-as-a-development-tool]]. 

Running integration tests
==========================
Unfortunately, the integration tests uniquely require you to run them on code **without** the changes you intend to verify.
Integration tests function by literally comparing Rosetta output from two runs of Rosetta: one compiled with your changes, one compiled without your changes.
Astute readers have realized this means you either need two parallel compiled copies of Rosetta, or you need to compile twice to do the tests.
The results from the runs of "unmodified" Rosetta are called the `ref` data.
The results from the runs of Rosetta with your changes are called the `new` data.

`ref` and `new` are so named because these are the names of the subdirectories created within `{Rosetta}/main/tests/integration` holding the two sets of data.

Generating the `ref` from an separate copy of Rosetta
-----------------------------------------------------

Generating the `ref` from the same copy of Rosetta
--------------------------------------------------

Generating the `new` and getting the test results
-------------------------------------------------

Writing integration tests
=========================

Using integration tests as a development tool
=============================================



A note on the name
==================
They are [[integration tests|https://en.wikipedia.org/wiki/Integration_testing]] in the software testing sense in spirit, but [[regression tests|https://en.wikipedia.org/wiki/Regression_testing]] in their actual functionality.