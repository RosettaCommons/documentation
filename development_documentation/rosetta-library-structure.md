<!-- --- title: Rosetta Library Structure -->A Guide to the Structure of the Rosetta Library

The rosetta/rosetta\_source directory contains seven top level directories of which every developer should be aware.

-   src/ The src directory contains all the source files for the rosetta library. See [[An overview page for the src directory of the Rosetta|src-index-page]] for more information.
-   test/ The test directory contains source files for rosetta's unit tests. The integration, and scientific tests now live in rosetta/rosetta\_tests. Together, these two sets of tests are used to verify that the rosetta library is functioning correctly. See [[A Guide to Running and Writing Tests for Rosetta|rosetta-tests]] for more information on Rosetta Tests.
-   bin/ The bin directory contains soft links to all the rosetta applications. Currently seperate softlinks are stored for each combination of operating system (linux,moacos), compiler(gcc,icc), and build mode (debug, release, release\_debug). See the [[A Guide to Using SCons to Build Rosetta|using-scons]] page for further information of the build system.
-   build/ The build directory is where all the object files and shared libraries for build configuration are stored. The directory structure is automatically created by the scons build system. See [[A Guide to Using SCons to Build Rosetta|using-scons]] page for further information of the build system.
-   doc/ The doc directory contains all the stand alone doxygen pages. See [[Tips for writing doxygen documentation|doxygen-tips]] for tips on writing documentation using Doxygen.
-   tools/ The tools directory contains the files for the custom SCons Builder for the rosetta library. See [[A Guide to Using SCons to Build Rosetta|using-scons]] page for further information of the build system.
-   demo/ The demo directory is intended to contains files for running test case or demo of particular applications. On a side note integration tests form a demo of sorts see [[A Guide to Running and Writing Tests for Rosetta|rosetta-tests]] for information on integration tests.

