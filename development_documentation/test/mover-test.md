#Unit tests for movers using UMoverTest

The test::UMoverTest package provides a system to quickly and simply add new unit tests for Mover classes.

The purpose of this document is to provide users with a guide for creating new unit tests using this package.

##Requirements

-   The class to be tested inherits from Mover and has an `apply` function that modifies the Pose object (i.e. not a tool mover like RepeatMover etc). For the rest of the document we will refer to the class to be tested as 'NewMover'.
-   NewMover should implement the virtual function `void test_move(core::pose::Pose & pose)`.

##Instructions
1) *Decide on a location for the unit test.* In most cases, if NewMover does not require any special initialization, then a good location for adding the unit test will be the existing file: source/test/protocols/moves/MoversTest.cxxtest.hh.

2) *Create the unit test macro*. In the function `test_AllMovers` in MoversTest.cxxtest.hh, add the following line: 

```
TEST_MOVER(NewMover, "protocols/moves/test_in.pdb", "protocols/moves/newmover_out.pdb");
```

3) Compile rosetta and its unit tests by running: `scons -j8 && scons -j8 cat=test`. Make sure that both compilations finished without errors.

4) Run the unit test to create the pdb file on which NewMover will be applied: 

```
python test/run.py -database path/to/rosetta/main/database
```

5) Unit test for `test_AllMovers` will fail - that is to be expected. The fail message will be something like:

```
Test suite: MoversTest (test/protocols/moves/MoversTest.cxxtest.hh) File: ./test/protocols/moves/MoversTest.cxxtest.hh Line:47 MoversTest::NewMoverFiles are not equal! CXXTEST_ERROR: test_AllMovers:NewMover Failed!
In MoversTest::test_AllMovers: ./test/protocols/moves/MoversTest.cxxtest.hh:47: Error: Test failed: test_AllMovers CXXTEST_ERROR: test_AllMovers Failed!
````

6) Check if the resulting PDB file is correct. Find the output PDB file in the test build folder inside protocols/moves. File name will be: 'newmover_out.pdb._tmp_' (Note: depending on your platform and compiler, the path to the PDB may vary. For example, for the gcc build on Linux it may be:'build/test/debug/linux/2.6/32/x86/gcc/protocols/moves'.) Load the output PDB in PyMOL or otherwise check if it is correct.

7) Rename and copy the output pdb file to test/protocols/moves/newmover\_out.pdb.

8) Modify test/protocols.test.settings by adding the line: `moves/newmoves_out.pdb`, into the `testinputfiles = [ "moves/test_in.pdb", ].... ` group.

9) Recompile Rosetta's unit tests. Note: you will need to modify the file MoversTest.cxxtest.hh to trigger copy file mechanics.

10) Run the unit test and make sure it completes without errors.

##See Also
* [[Unit Test|unit tests]] overview/philosophy
* [[Running unit tests|run-unit-test]]
* [[Writing unit tests|writing-unit-tests]]
* [[UTracer]], a tool to simplify writing unit tests by comparing text _en masse_

* [[Mover description|Rosetta-overview#mover]]

* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]