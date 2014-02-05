#How to create and run scientific tests

Metadata
========

This document was edited by Yi Liu and Sergey Lyskov

Categories of Scientific tests
==============================

Currently we dividing our scientific tests in to three category:

-   Daily runs. Test that take less then 12h to run on single cpu. This test will be executed every day. SVN location for this tests is: rosetta/rosetta\_tests/scientific/tests. Daily tests organized similar way as integration tests, with the same template system. For example implementation please see: rosetta/rosetta\_tests/scientific/tests/sequence\_recovery
-   Weekly runs. Test that take less then 128h to run on single cpu. Will be executed approximately every week. SVN location for this tests is: rosetta/rosetta\_tests/scientific/biweekly\_tests. Weekly tests also organized similar way as integration tests, with the same template system. For example implementation please see: rosetta/rosetta\_tests/scientific/biweekly\_tests/ligand\_docking
-   Cluster runs. All other tests. Cluster will be \~80CPU, guided by condor. SVN location for this tests is: rosetta/rosetta\_tests/scientific/cluster. Cluster test different from daily and weekly in the way that it should provide two bash script instead of one: 'submit' and 'analyze' (with template scheme similar to integration script 'command' file). First 'submit' script will be called and it expected to prepare and submit appropriate number of condor jobs and exit after that (you may terminate early if something goes wrong and return error code).When condor jobs are done, the second script ('analyze') will be called, which should create proper log file and the yaml file, and place them in to '/output' folder. Any additional files that you want to save as 'results' should be placed there.For example implementation of 'submit' script please take a look at: rosetta/rosetta\_tests/scientific/cluster/docking/submit

Cluster and Weekly tests should document way to run them in debug mode with reduced number of decoys generated. So running test in debug mode should take less then a day to finish for Weekly tests and less then \~200CPU hours for cluster tests.

Create new tests
================

If your test require to create new application, please commit it to this location: rosetta/rosetta\_source/src/apps/benchmark/scientific

Also, each individual test can have following subdirectories:

-   /input : store all input data. If your test required limited amount of data (\~10-20M) - commit it in to svn. If size of data is larger, then it will not be stored in svn, and put here 'by hands'.
-   /output : store important output data, contents of this folder will stored along with log and yaml in database, and will be assessable from the web.
-   /tmp : place for temporary files (like \~1000 decoys, if you need it). Contents of this folder will be ignored by testing daemon and not stored anywhere. (You can store temp files in /input too if you really need too, just make sure it not overwriting any input files).

Results output. Each test should save results in to two files:

-   '.results.log' - for human readable text based results and logs.
-   '.results.yaml' - for results with metadata stored in YAML form.

