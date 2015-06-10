Rosetta's *integration tests* are a set of testing tools that test short protocol runs before and after changes to the code, and compare the protocols' output to check for unexpected changes. 
They are useful for determining whether code behavior **changes** but not whether it is **correct**. 
The tests live in `{Rosetta}/main/tests/integration`: the main repository, but not directly with the code.

What integration tests do and not do
====================================

The integration tests are "black box tests" that examine the results of big chunks of code.

Generally, an integration test:
*runs one executeable with a reasonable set of inputs and flags
*finishes within 30 seconds
*runs to completion without an error message 
*ensures that code has not changed accidentally from one revision to the next
*compares, [[byte-for-byte|https://en.wikipedia.org/wiki/Diff_utility]], the results of a command AFTER your changes and BEFORE your changes

They do not:
*Run the same on all machines
**They are long enough to have numerical noise and processor difference effects (which are grabbed by Monte Carlo and blown into full trajectory differences).  This is a known weakness and just the way it is
*Produce scientifically useful results
**The short runtime is more important than result validity
**This is the goal of [[scientific tests]]
**Runtime in an absolute sense is checked by [[performance tests]]
*check that the code works right
**Integration tests only check that it runs the same as before, not that it's right
**This is the goal of [[unit tests]]

Running integration tests
==========================


A note on the name
-------------------
They are [[integration tests|https://en.wikipedia.org/wiki/Integration_testing]] in the software testing sense in spirit, but [[regression tests|https://en.wikipedia.org/wiki/Regression_testing]] in their actual functionality.