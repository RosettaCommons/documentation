#Integration Tests

Rosetta's *integration tests* are a set of testing tools that test short protocol runs before and after changes to the code, and compare the protocols' output to check for unexpected changes. 
They are useful for determining whether code behavior **changes** but not whether it is **correct**. 
The tests live in `{Rosetta}/main/tests/integration`: the main repository, but not directly with the code.
**Developers are expected to run these tests before merging code to `master`.**
Non-developers should have no interest in the integration tests, unless they want to examine them as short demos.

[[_TOC_]]

What integration tests do and do not do
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
 * This is the goal of [[scientific tests|Scientific-Benchmarks]]
 * Runtime in an absolute sense is checked by [[performance tests|Performance-Benchmarks]]
* check that the code works right
 * Integration tests only check that it runs the same as before, not that it's right
 * This is the goal of [[unit tests]]

When to run integration tests
=============================
**Developers are expected to run integration tests before merging to `master`.**
Just run the whole set of tests before you merge, as part of the [[before you merge|before-commit-check]] protocol.
Remember that it is perfectly ok if there are expected integration test changes due to code you changed: if you've rewritten your protocol, of course its tests will change!
The purpose of the tests in this fashion is to ensure that there are not *unexpected* changed, and that the changes that are expected are *explicable* from the code that changed.

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
`integration.py` also accepts --mode and --extras flags analogous to [[scons|Scons-Overview-and-Specifics]] when building, to help it look for the right executables.
`integration.py --help` prints a useful help list, and there is a `README` in its directory that can help as well.
If all else fails, ask the mailing list.

Generating the `ref` from the same copy of Rosetta
--------------------------------------------------
If you only have one copy of Rosetta installed, you are in the unfortunate position of needing two sets of binaries from one copy of the code.
You're just stuck with recompiling between `ref` and `new` generation.
Follow the same instructions as above - just be careful you have no local uncommitted changes before checking out `master`.

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

If you need to re-run the tests repeatedly, `integration.py` takes the names of individual test directories as arguments, so you need not run all many hundred each time: `integration.py test1 test2 test3...`

Expected breaks
---------------
If the only test result changes are ones that you expect from your code changes, you're in great shape!
You can merge your code to `master`, or be confident that you understand your code works, etc.
Be sure to mark expected integration test changes in the [[commit message|before-commit-check]] when you merge to `master`.

Unexpected changes
------------------
If there are unexpected changes, you'll have to examine the test diffs to determine what they are, and figure out where they come from.
Presumably you understand your own code well enough to determine their source.
It is common for unexpected changes to result from accidental dissimilarities between the `new` and `ref` runs - like the two tested branches are based off different versions of `master`.

An unfortunately common change case is scattered "trajectory changes" - where small early numerical changes led to trajectory differences that ultimately resulted in hugely changed output log files.
These are usually due to different inlining, differently initialized variables, or something else subtle.
On very rare occasion it's "just a compiler thing" and not the fault of the developer.
The community has struggled mightily over the years with unstable integration tests that show pernicious occasional changes.
If you're uncertain, don't merge!
Just [[pull request]] and get help from  the experts.

Trivial changes
-----------------
Some changes are trivial - like if you get reports of different file paths that are obviously due to your having generated `ref` in a separate copy of Rosetta.
Ignore these.
Another set of unimportant changes are if you get messages about writing database binaries.
These occur the first time Rosetta is run (like if you got a new copy for separate `ref` generation).

Cosmetic changes versus trajectory changes
------------------------------------------
"Cosmetic changes" usually means the output is different in form but not content.
For example, maybe you changed the name of a Tracer - many lines will differ because of the Tracer tag but not in their information content - this is "cosmetic". 
These are never concerning.

"Trajectory changes" is when the result is different - for example, the coordinates of the resulting PDB are altered, and the scores reported are different.
These need to be understood.

.test_did_not_run.log
---------------------
Sometimes you get a file `.test_did_not_run.log`. 
The system is set up so that if this file exists, the test **ALWAYS** fails.
It means the test did not run because the executable didn't exist, or it crashed and exited improperly. 

Running MPI integration tests
=============================
We now have the ability to run integration tests in [[MPI]], mostly for for testing the integration of components with the parallel [[JobDistributors|jd2]].  Instructions for running tests are as before, except you need `-extras=mpi` as an argument to `scons` and `-mpi-tests` as an argument to `integration.py`.

1.  Compile in *full application release* mode with **-extras=mpi**.
    `./scons.py -j<number_of_processors_to_use> mode=release bin -extras=mpi`
2.  Change directories. `cd ../tests/integration`
3.  Run the test with the **--mpi-tests** flag.
    `./integration.py -j<num_procs> -c <compiler> --mpi-tests`

Writing MPI tests is discussed [[elsewhere|Writing-MPI-Integration-Tests]].

Writing integration tests
=========================
An integration test is simply a shell script with a Rosetta command line with appropriate options stored in a flags file.
The folder `main/tests/integration/tests/HOW_TO_MAKE_TESTS` describes how to do it.
* Create a new folder/subdirectory for your test.
* Create a file named command in that directory from the `HOW_TO_MAKE_TESTS` template.  It will check for the existence of the executable it needs, run it, and sanitize the output (to remove several classes of common irrelevant diffs like timing reports).
* Add the inputs and flags files your script needs.
* Don't forget to add everything to `git`.
* Do ensure your test is **short**, less than 30 seconds - we have many hundred, and we don't have all day.  Many tests (and therefore executables) respect a `-run:test_cycles` rosetta option for this purpose.

Writing MPI tests is discussed [[elsewhere|Writing-MPI-Integration-Tests]].

A note on the name
==================
They are [[integration tests|https://en.wikipedia.org/wiki/Integration_testing]] in the software testing sense in spirit, but [[regression tests|https://en.wikipedia.org/wiki/Regression_testing]] in their actual functionality.

##See Also

* [[Writing MPI Integration Tests]]: Writing special tests for testing parallelized components of Rosetta
* [[Testing server]]: Server that can be used to run Rosetta integration tests automatically
  * [[Running Tests on the Test Server]]: Instructions for using the testing server
* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
* [[RosettaEncyclopedia]]
* [[Glossary]]