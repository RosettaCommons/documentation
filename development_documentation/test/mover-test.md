#Mover test Howto

The test::UMoverTest package provides a system for quickly and simple way to add new Unit test for Movers classes using UMoverTest class and macros.

The purpose of this document is to provide user with HowTo document to help create new unit tests.

Requirements:

-   descended of Mover class with apply that modify Pose object (ie not a tool mover like RepeatMover etc). For the rest of document we will Mover that we want to test as 'NewMover'.
-   NewMover should implement virtual function: void test\_move(core::pose::Pose & pose).

1. Deciding on location for Unit Test. In most cases, if NewMover is not require any special initialization, then good location for adding unit test will be existing file: test/protocols/moves/MoversTest.cxxtest.hh
2.  creating unit test macro. In function MoversTest.cxxtest.hh:test\_AllMovers: add following line: TEST\_MOVER(NewMover, "protocols/moves/test\_in.pdb", "protocols/moves/newmover\_out.pdb");
3.  Compile rosetta and its unit test by running: 'scons -j8 && scons -j8 cat=test'. Make sure that both compilation finished without error.
4.  Run unit test to create pdb file on which NewMover was applied: 'python test/run.py -database \~/rosetta\_database'
5.  Unit test for test\_AllMovers will fail - that to be expected. Failing message will be something like:

    ```
    Test suite: MoversTest (test/protocols/moves/MoversTest.cxxtest.hh) File: ./test/protocols/moves/MoversTest.cxxtest.hh Line:47 MoversTest::NewMoverFiles are not equal! CXXTEST\_ERROR: test\_AllMovers:NewMover Failed!
    In MoversTest::test\_AllMovers: ./test/protocols/moves/MoversTest.cxxtest.hh:47: Error: Test failed: test\_AllMovers CXXTEST\_ERROR: test\_AllMovers Failed!
    ````

6.  Check if the result PDB file is correct. Find output PDB file in the test build folder inside protocols/moves. File name will be: 'newmover\_out.pdb.\_tmp\_' (Note; depending of the platform path to PDB may vary. For example for gcc build on Linux it may be:'build/test/debug/linux/2.6/32/x86/gcc/protocols/moves') Load output PDB in to pymol or otherwise check if output PDB is correct.
7.  Rename and copy output pdb file to test/protocols/moves/newmover\_out.pdb.
8.  Modify test/protocols.test.settings by adding line: "moves/newmoves\_out.pdb", in to 'testinputfiles = [ "moves/test\_in.pdb", ' group.
9.  Recompile rosetta's unit tests. Note: you will need to modify file MoversTest.cxxtest.hh to trigger copy file mechanics.
10.  Run unit test, make sure it complete without errors.

