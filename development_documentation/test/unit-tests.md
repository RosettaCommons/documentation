#What are unit tests?

The purpose of [[unit testing|http://en.wikipedia.org/wiki/Unit_testing]] (wikipedia link) is to ensure that small chunks of code run _correctly_. 
Writing good unit tests is very important, but something the community has traditionally failed at—our unit test coverage is very poor, and many of the tests we do have are shallow. 
Good unit tests become easy when using [[test-driven development|http://en.wikipedia.org/wiki/Test-driven_development]] (wikipedia link), but this sort of skill at programming is a challenge for the professional biophysicists / amateur programmers who make up our developer base.

TODO: Andrew LF has given presentations on the importance of unit tests / test-driven development - they would be excellent to include here (planned for XRW2015, but ran out of time.)

##Why is the test coverage bad and what can we do about it?
_this section is converted from an email SML wrote to JJ about unit testing the FloppyTail code._

Lots of Rosetta code can't be unit tested because it doesn't have any testably sized units.
 Unit tests are meant to examine short, provably correct functions. 
Unit tests are for when you can calculate the expected result of the code by hand and program that in as
comparison data. 
(We have some number of unit tests that don't work that way, and instead "capture" output and compare it run-to-run - those are really regression [[[integration] tests|integration tests]]).

Many [[Mover]]s, especially protocol-scale movers, have only two types of functions: giant monster functions
(init_on_new_input/initialize/etc and apply) and trivial getters/setters.
Writing unit tests for the trivial functions is certainly possible and has some value. 

Let's imagine that apply() creates a large number of Movers, then dumps them into a SequenceMover which it calls repeatedly under Monte Carlo control as the main protocol loop. 
Let's imagine that init_on_new_input reads from the option system / other inputs to build MoveMaps, FoldTrees, PackerTasks/TaskFactories that depend on PoseMetricCalculators, ScoreFunctions, and whatever else apply() will need.

Writing a unit test for apply as it stands is not possible: it's full of Monte Carlo decisions and its results cannot be precalculated. 
It is properly tested with an integration test.

Writing a unit test (really a series of several unit tests) for init_on_new_input is plausible. 
The purpose of the function is to build the underlying calculators, MoveMaps, etc. 
You could manually construct the objects init_on_new_input is supposed to make under a variety of circumstances, then let init_on_new_input run and see if it makes the SAME MoveMap, the SAME PackerTaskFactory (with embedded TaskOperations...with embedded PoseMetricCalculators....), etc. 
This would certainly be very valuable. 

You could instead refactor this code in such a way that it has testably sized functions -
refactoring init_on_new_input into separate functions for the separate objects it creates (or the separate flows for how it chooses what to move), refactoring apply() so that the Mover creation is separate from
the Monte Carlo for loops. 
This refactor would make writing unit tests MUCH simpler and leave you with better code. 
Of course, it also leaves you in the unenviable position of performing a major refactor without test coverage backing your changes (except the integration test). 
The integration test would be expected to have lots of "cosmetic" changes but no "trajectory" changes after a refactor.

So, in summary, **write small, granular functions** from the beginning, and unit testing is easy. 
Writing good unit tests for code without such functions is impossible.

##See Also
* [[Running unit tests|run-unit-test]]
* [[Writing unit tests|writing-unit-tests]]
* [[UMoverTest|mover-test]], a tool for unit testing Mover classes
* [[UTracer]], a tool to simplify writing unit tests by comparing text _en masse_

* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
