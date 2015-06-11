#A Guide to Running and Writing Tests for Rosetta

Rosetta has 4 sets of tests. Unit tests check particular functions of the Rosetta library. Integration tests track behavior of applications one individual cases. Performance tests monitor speed of Rosetta applications. Scientific tests monitor the behavior of Rosetta applications on a larger scale than Integration tests and with scientifically defined objectives. Information on reading and writing these tests can be found in the pages linked below.


-   Unit Tests
    -	[[Writing unit tests|test]]
    	-   [[Writing unit tests for movers using UMoverTest|mover-test]]
    	-   [[UTracer]], a tool to simplify writing unit tests
    -   [[Running unit tests|run-unit-test]]
-   [[How to create and run scientific tests|Scientific-Benchmarks]]
    - [[Detailed Balance scientific tests|DetailedBalanceScientificBenchmark]]
    - [[Docking scientific tests|DockingScientificBenchmark]]
-   [[Performance Benchmarks]]
-   [[Integration Tests]]
    - [[Writing MPI Integration Tests]]
-   [[Testing server]]
    - [[Running tests on the test server]]

##See Also

* [[Development Documentation]]: The main development documentation page
* [[Development tutorials|devel-tutorials]]: Tutorials for developers