#Writing Unit tests

_If you aren't a developer, you may have wanted to learn [[how to run unit tests|run-unit-test]]._

The purpose of [[unit testing|http://en.wikipedia.org/wiki/Unit_testing]] (wikipedia link) is to ensure that small chunks of code run _correctly_. 
Writing good unit tests is very important, but something the community has traditionally failed at—our unit test coverage is very poor, and many of the tests we do have are shallow. 
Good unit tests become easy when using [[test-driven development|http://en.wikipedia.org/wiki/Test-driven_development]] (wikipedia link), but this sort of skill at programming is a challenge for the professional biophysicists / amateur programmers who make up our developer base.

TODO: Andrew LF has given presentations on the importance of unit tests / test-driven development - they would be excellent to include here (planned for XRW2015, but ran out of time.

Actually writing unit tests in Rosetta uses the **CXXTEST** framework. 

Rosetta-specific unit test tools:
=================================

### UTracers for integration-test style output capture comparison
[[Utracer]]s are a two-edged sword: it makes it easy to have a "test" of "compare all this output X to this reference output Y".
These are easy to write but are often not testing units.
If you "unit" is not **completely deterministic** across **all architectures**, this is go down in flames and you should have written an [[integration test|integration tests]].

### UMoverTest
The [[UMoverTest|mover-test]] is a tool for testing [[Mover]] classes.
It can't test their `apply` function, but if you write your Mover cleverly this will still do a good job.

### TS_ASSERTs to test file comparisons

Literally compare files, line by line: `TS_ASSERT_FILE_EQ`. 
This assert will pass if files are equal and generate unit test error otherwise. 
This has the same caveats as UTracers above: great if you just want to compare 20 things with little C++, but dangerous if you are really integration testing protocols.

Example:

```
#include <cxxtest/TestSuite.h>
...
TS_ASSERT_FILE_EQ( "original.pdb" , "new.pdb" ); // will generate error if files are different
```

Compare files as a string of double numbers: `TS_ASSERT_FILE_EQ_AS_DOUBLE`. This command reads two text files, converts each to a vector of doubles (using space as separator), and compares the vectors of doubles using specified absolute and relative tolerance. Example:

```
#include <cxxtest/TestSuite.h>
...
// comparing files "original_score.txt" and "new_score.txt" as vectors of double with abs. tolerance .001 and relative tolerance .1
TS_ASSERT_FILE_EQ_AS_DOUBLE( "original_score.txt" , "new_score.txt" ,
                             .001, // absolute tolerance
                             .1); // relative tolerance
```

Dealing with the option system
==============================

Rosetta is unfortunately quite dependent on its command line options system, but running unit tests does not offer much in the way of command line interaction.
`test/run.py` certainly won't let you run different tests under different option environments.
This section explains how you can set the option environment on a per-test basis, with this magic:

`inline void core_init_with_additional_options( std::string const & commandline_in )` 

Reinitialize the option system in the middle of the test with additional arguments. The actual command line that will be used is equal to the original command line (which was supplied to the unit test executable) + new arguments supplied to the function.

Please note that this function does not delete any singletons that were already allocated (for example ResidueSet). If you need to reinitialize such singletons, delete them by hand before calling this function.


```
#include <test/core/init_util.hh>
...
// calling core::init with a new command line = old cm.line + "-score_only -out:file:fullatom"
core_init_with_additional_options( "-score_only -out:file:fullatom" );
```

##See Also

* [[UTracer]], a tool to simplify writing unit tests
* [[Writing unit tests for movers using UMoverTest|mover-test]]
* [[Running unit tests|run-unit-test]]
* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]