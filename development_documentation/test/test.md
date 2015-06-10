#Writing Unit tests

-   [[How to run unit tests.|run-unit-test]]
-   [[Using UTracer for simplifying writings of unit tests|UTracer]]
-   [[Mover test HowTo|mover-test]]

Additional asserts.
===================

Literally compare files, line by line: `TS_ASSERT_FILE_EQ`. This assert will pass if files are equal and generate unit test error otherwise. Example:

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
Additional functions
=====================

`inline void core_init_with_additional_options( std::string const & commandline_in )` 

Reinitialize the option system in the middle of the test with additional arguments. The actual command line that will be used is equal to the original command line (which was supplied to the unit test executable) + new arguments supplied to the function.

Please note that this function does not delete any singletons that were already allocated (for example ResidueSet). If you need to reinitialize such singletons, delete them by hand before calling this function.


```
#include <test/core/init_util.hh>
...
// calling core::init with a new command line = old cm.line + "-score_only -out:file:fullatom"
core_init_with_additional_options( "-score_only -out:file:fullatom" );
```