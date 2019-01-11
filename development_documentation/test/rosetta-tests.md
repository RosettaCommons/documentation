#A Guide to Running and Writing Tests for Rosetta

Rosetta has 4 sets of tests:
* __Unit tests__ check particular functions of the Rosetta library. These are granular tests for the correctness of functions and classes. These are occasionally used to verify Rosetta is installed correctly.
* __Integration tests__ (really regression tests) track behavior of applications as the code changes to ensure changes only occur when expected, but do not test for intended behavior. These are occasionally used as demos.
* __Performance tests__ and __profile tests__ monitor speed and memory usage of Rosetta applications. 
* __Scientific tests__ monitor the intended behavior of Rosetta applications with regard to their scientifically defined objectives. 

Information on reading and writing these tests can be found in the pages linked below. We have an excellent
[[Testing server]] that runs all of these tests for us on a regular basis.

-   [[Unit Tests]]
    -   [[Running unit tests|run-unit-test]]
    -	[[Writing unit tests|writing-unit-tests]]
    	-   [[UMoverTest|mover-test]], a tool for unit testing Mover classes
    	-   [[UTracer]], a tool to simplify writing unit tests by comparing text _en masse_

-   [[Integration Tests]]
    - [[Writing MPI Integration Tests]]

-   [[Performance Benchmarks]]
-   [[Profile tests]]

-   [[How to create and run scientific tests|Scientific-Benchmarks]]
    - [[Legacy page for scientific tests before 2018|Legacy-Scientific-Benchmarks]]
        - [[Legacy: Detailed Balance scientific tests|DetailedBalanceScientificBenchmark]]
        - [[Legacy: Docking scientific tests|DockingScientificBenchmark]]

-   [[Testing server]]
    - [[Running tests on the test server]]

##See Also

* [[Development Documentation]]: The main development documentation page
* [[Development tutorials|devel-tutorials]]: Tutorials for developers