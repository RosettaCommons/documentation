<!-- --- title: Test -->Unit test and Performance test Mini Rosetta Documentation

-   [[HowTo run unit tests.|run-unit-test]]
-   [[Using UTracer for simplifying writings of unit tests|UTracer]]
-   [[Mover test HowTo|mover-test]]
-   Score test HowTo

Additional asserts.
===================

Literally compare files, line by line: TS\_ASSERT\_FILE\_EQ. This assert will pass if files are equal and generate unit test error otherwise. Example:

\#include \<cxxtest/TestSuite.h\>

...

TS\_ASSERT\_FILE\_EQ( "original.pdb" , "new.pdb" ); // will generate error if files are different

 Compare files as a string of double numbers: TS\_ASSERT\_FILE\_EQ\_AS\_DOUBLE. This command read two text file convert them to a vector of doubles (using space as separator) and compare vector of doubles using specified absolute and relative tolerance. Example:

\#include \<cxxtest/TestSuite.h\>

...

// comapring files "original\_score.txt" and "new\_score.txt" as vectors of double with abs. tolerance .001 and relative tolerance .1

TS\_ASSERT\_FILE\_EQ\_AS\_DOUBLE( "original\_score.txt" , "new\_score.txt" ,

.001, // absolute tolerance

.1); // relative tolerance

Additional functions.
=====================

inline void core\_init\_with\_additional\_options( std::string const & commandline\_in ) Reinitialize option system in middle of the test with additional arguments. Actual command line that will be used is equal original command line (which was supplied to unit test executable) + new arguments supplied to the function.

```
 Please note that this function do not delete any singletons that already was allocated (for example ResidueSet). If you need to re-initialize  such singleton  - delete them by hand before  calling this function.
```

\#include \<test/core/init\_util.hh\>

...

// calling core::init with a new command line = old cm.line + "-score\_only -out:file:fullatom"

core\_init\_with\_additional\_options( "-score\_only -out:file:fullatom" );
