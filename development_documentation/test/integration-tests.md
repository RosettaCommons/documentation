Rosetta's *integration tests* are a set of testing tools that test short protocol runs before and after changes to the code, and compare the protocols' output to check for unexpected changes. 
They are useful for determining whether code behavior **changes** but not whether it is **correct**. 
The tests live in `{Rosetta}/main/tests/integration`: the main repository, but not directly with the code.
**Developers are expected to run these tests before merging code to `master`.**

What integration tests do and not do
====================================

The integration tests are "black box tests" that examine the results of big chunks of code.

Generally, an integration test:
* runs one executable with a reasonable set of inputs and flags
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

TODO fix this link

Running tests on the server
===========================
The [[testing server]] can run the integration tests for you! This is fantastic if you are developing on a computer with limited resources, or don't have time and want a computer to do things for you. See [[this page|Running-Tests-on-the-Test-Server]] for details.

Running integration tests
==========================
Unfortunately, the integration tests uniquely require you to run them on code **without** the changes you intend to verify.
Integration tests function by literally comparing Rosetta output from two runs of Rosetta: one compiled with your changes, one compiled without your changes.
Astute readers have realized this means you either need two parallel compiled copies of Rosetta, or you need to compile twice to do the tests.
The results from the runs of "unmodified" Rosetta are called the `ref` data.
The results from the runs of Rosetta with your changes are called the `new` data.

`ref` and `new` are so named because these are the names of the subdirectories created within `{Rosetta}/main/tests/integration` holding the two sets of data.  The instructions for the runs themselves are in the `tests` subfolder (of integration, so `tests/integration/tests`).

Generating the `ref` from an separate copy of Rosetta
-----------------------------------------------------
If you have two copies of Rosetta on your hard drive, you can generate the `ref` in one that's checked out to `master`.

1. Make sure `master` is up to date. You could choose to compare to any revision, especially for tracking down bugs, but for most purposes, comparing to the most recent master is correct.
    `cd /path/to/Rosetta/main/source && git checkout master && git pull  `
2. Compile in **full application release** mode - obviously this blows away any old compile
    `  ./scons.py -j<number_of_processors_to_use> mode=release bin  `
3. Change to the testing directory.
    `  cd ../tests/integration  `
4. Make sure there are no integration test results already (delete the `new` and `ref` from any previous run).
    `  rm -r new/ ref/  `
5. Run the test.
    `  ./integration.py -j<number_of_processors_to_use>  `
6. You should see this for a successful run:
```
Just generated 'ref' results [renamed 'new' to 'ref'];  run again after making changes.
```

###If `integration.py` failed to run tests
If most/all of the tests failed, you may have something misconfigured.
The most likely problem is that your compilation failed in step 2 above.
If you compiled with clang, pass `-c clang` to inform `integration.py` to look for your clang executables. 
`integration.py` also accepts --mode and --extras flags analogous to [[scons]] when building, to help it look for the right executables.
`integration.py --help` prints a useful help list, and there is a `README` in its directory that can help as well.
If all else fails, ask the mailing list.

Generating the `ref` from the same copy of Rosetta
--------------------------------------------------
If you only have one copy of Rosetta installed, you are in the unfortunate position of needing two sets of binaries from one copy of the code.
You're just stuck with recompiling between `ref` and `new` generation.
Follow the same instructions [[as above]] - just be careful you have no local uncommitted changes before checking out `master`.

Generating the `new` and getting the test results
-------------------------------------------------
So far, you've 'run the integration tests' but not tested anything - you just made the `ref`.
Generating the `new` to compare it with is concurrent with checking the differences.
You must generate the `new` results from a copy of Rosetta with the changes you need to test.

If you generated your `ref` from a _different_ copy of Rosetta, you need to copy the ref directory from that location to your copy of Rosetta with changes: 
```
cp -a /path/to/vanilla_Rosetta/main/tests/integration/tests/ref /path/to/development_Rosetta/main/tests/integration
```

(You may wish to use `mv` over `cp` for speed, with the obvious caveat that it won't be in the old location anymore).

If you generated your `ref` in one copy of the code, your `ref` is already in place.

To actually run the tests:

1. Make sure your branch is up to date. Generally you want to merge in from `master` immediately before testing (you probably pulled `master` before generating `ref`). This ensures you are testing only the differences introduced by **your** changes. This might not be a trivial merge step!
    `cd /path/to/Rosetta/main/source && git checkout {MYBRANCH} && git merge master `
2. Compile in **full application release** mode - obviously this blows away any old compile
    `  ./scons.py -j<number_of_processors_to_use> mode=release bin  `
3. Change to the testing directory.
    `  cd ../tests/integration  `
4. Check to make sure you have the `ref` data you generated recently.
5. Run the test. Notice this is the exact same command as before - integration.py does the same work, and just puts the results in `new` if `ref` already exists.
    `  ./integration.py -j<number_of_processors_to_use>  `
6. For a successful run, you'll see: :
```
Running Test HOW_TO_MAKE_TESTS
bash /home/smlewis/Rosetta/main/tests/integration/new/HOW_TO_MAKE_TESTS/command.sh
Finished HOW_TO_MAKE_TESTS                        in   0 seconds	 [~   1 test (100%) started,    0 in queue,    0 running]

ok   HOW_TO_MAKE_TESTS
All tests passed.
```

The parts about HOW_TO_MAKE_TESTS will be repeated for each test (all several hundred of them).  All tests passed will appear once at the bottom.

If tests fail, you will get 
```
FAIL AnchoredDesign
    nonempty diff ref/AnchoredDesign/SOMEFILENAME new/AnchoredDesign/SOMEFILENAME

345 test(s) failed.  Use 'diff' to compare results.
```

What to do when an integration test breaks
===========================================

You can check the changes with `diff` - either run `diff` manually, or `integration.py --compareonly --fulldiff` to automatically diff all integration test results.

Expected breaks
---------------
If the only test result changes are ones that you expect from your code changes, you're in great shape!
You can merge your code to `master`, or be confident that you understand your code works, etc.
Be sure to mark expected integration test changes in the [[commit message|before you commit]] when you merge to `master`.

Unexpected changes
------------------
If there are unexpected changes, you'll have to examine the test diffs to determine what they are, and figure out where they come from.
Presumably you understand your own code well enough to determine their source.
It is common for unexpected changes to result from accidental dissimilarities between the `new` and `ref` runs - like the two tested branches are based off different versions of `master`.

Trivial changes
-----------------
Some changes are trivial - like if you get reports of different file paths that are obviously due to your having generated `ref` in a separate copy of Rosetta.
Ignore these.
Another set of unimportant changes are if you get messages about writing database binaries.
These occur the first time Rosetta is run (like if you got a new copy for separate `ref` generation).

Running MPI integration tests
=============================



Writing integration tests
=========================



Using integration tests as a development tool
=============================================



A note on the name
==================
They are [[integration tests|https://en.wikipedia.org/wiki/Integration_testing]] in the software testing sense in spirit, but [[regression tests|https://en.wikipedia.org/wiki/Regression_testing]] in their actual functionality.