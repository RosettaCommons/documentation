#Writing Unit tests

_If you aren't a developer, you may have wanted to learn [[how to run unit tests|run-unit-test]]._

Before writing unit tests, be sure you understand [[what they are|unit tests]].

TODO: The content that should populate this page is still largely hosted on the wiki.rosettacommons.org mediawiki, and can be moved as soon as convenient.  DO leave mediawiki links in place until the text is moved.

Unit tests in Rosetta use the **CxxTest** framework.  If you are interested in why we chose this framework: https://wiki.rosettacommons.org/index.php/DecidingOnCxxTest.  (TODO: move this.)

Ultra-brief advice on writing unit tests: find one related to what you are testing, and write something similar to what it is doing. 
Code duplication is not too much of a concern in unit tests (testing Mover X and Mover Y may end up doing a lot of the same things), although obviously avoid it when you can.

Longer instructions on writing unit tests can be found on the old wiki here: https://wiki.rosettacommons.org/index.php/Tools:Unit_Tests (TODO: move this.)

Rosetta-specific unit test tools:
=================================

### UTracers for integration-test style output capture comparison
[[Utracer]]s are a two-edged sword: it makes it easy to have a "test" of "compare all this output X to this reference output Y".
These are easy to write but are often not testing units.
If you "unit" is not **completely deterministic** across **all architectures**, this is go down in flames and you should have written an [[integration test|integration tests]].

### UMoverTest
The [[UMoverTest|mover-test]] is a tool for testing [[Mover|Glossary#mover]] classes.
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

* [[Unit Test|unit tests]] overview/philosophy
* [[Running unit tests|run-unit-test]]
* [[UMoverTest|mover-test]], a tool for unit testing Mover classes
* [[UTracer]], a tool to simplify writing unit tests by comparing text _en masse_

* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]