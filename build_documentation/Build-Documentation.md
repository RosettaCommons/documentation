<!-- --- title: Setting up Rosetta 3 -->
This page describes how to install, compile, and test Rosetta 3 (formerly called "Mini") on one's own workstation.

Compiling Rosetta 3
-------------------

The current build system is based on the tool [SCons](https://wiki.rosettacommons.org/index.php/Tools:SCons "Tools:SCons") ("Software Constructor") with some extensions. `     scons.py    ` is implemented as a Python script.  Scons can be called directly by the command <code>scons</code> if installed locally, or via the python script.

### SCons

You have multiple options for compiling Rosetta 3 with SCons. You can build either only the core libraries or both the libraries and the executables. Rosetta 3 can be compiled in two modes:

-   Debug mode — for development — no `      mode     ` option
-   Release mode — faster/tested and ready to go &mdashl `      mode=release     `

1.  Change directory to `      main/source     ` .
2.  Type one of the following commands:
    -    complete   

        -   `          ./scons.py -j<number_of_processors_to_use> bin         `
        -   `          ./scons.py -j<number_of_processors_to_use> mode=release bin         `

         libraries only   

        -   `          ./scons.py -j<number_of_processors_to_use>         `
        -   `          ./scons.py -j<number_of_processors_to_use> mode=release         `

The `     -j8    ` flag would mean, "use at most 8 processes for building," and can be reasonably set as the number of free processors on your machine. Be aware that setting `     -j    ` to a very high value will cause the operating system to have difficulty scheduling jobs.

By default scons hashes and processes every file in the tree before performing a build. On a large tree (e.g. rosetta) and filesystem with high io latency (e.g. a NFS or GPFS filesystem) this causes ridiculously slow build times. In order to improve build times disable file hashing and allow caching of build dependency metadata. Add the follow lines to the project's root SConscript file:

    Decider('MD5-timestamp')
    SetOption('implicit_cache', 1)

These settings are described on the [scons gofast](http://www.scons.org/wiki/GoFastButton) page.

 **More useful build commands:**

By default, `     scons    ` uses GCC to compile. To use an alternate compiler, such as CLang, use the `     cxx    ` option:

`      ./scons.py -j<number_of_processors_to_use> cxx=clang     `

NOTE: Use `     clang    ` if you can. It is quicker and gives better error messages. Win/Win. You will save yourself a lot of time trying to reverse engineer GCC compiler errors. And there are binaries to install it. Triple win.

To use an alternate version of the compiler, you can use the option `     cxx_ver    ` option with whatever version you have (here 4.5):

`      ./scons.py -j<number_of_processors_to_use> cxx=clang cxx_ver=4.5     `

To build MPI executables, add the flag "extras=mpi" and copy source/tools/build/site.settings.topsail to site.settings. Edit until compile successful:

`      ./scons.py bin mode=release extras=mpi     `

To build OpenMPI executables for local MPI runs, add the flag "extras=omp"

`      ./scons.py bin mode=release extras=omp     `

To build static executables, add the flag "extras=static":

`      ./scons.py bin mode=release extras=static     `

To skip svn versioning script from running add this flag (only after svn\_version.cc already exists)

`      ./scons.py  --nover     `

To display more rosetta specific build options call

`      ./scons.py -h     `

To display general Scons build options call

`      ./scons -H     `

One can edit his or her `     main/source/tools/build/user.options    ` file to include options such as preferred compiler ( `     cxx    ` ).

For more build options, such as only compiling only one executable or apbs - Please take a look at the SConstruct File in rosetta\_source

### CMake

Rosetta can also be built with CMake. Currently it is less widely tested and does not support some features such as "extras" flags. However, CMake is faster than SCons, which can be advantageous for rapid compile-debug cycles.

To build with CMake...

1.  Change to the CMake build directory from the base Rosetta 3 directory and create the CMake build files:
    `        cd cmake       `
    `        ./make_project.py all       `
2.  Next, change to a build directory
    `        cd build_<mode>       `
3.  and build Rosetta 3
    `        cmake -G Ninja       `
    `        ninja       `
    If you don't have ninja, you can get it via `        git clone                 git://github.com/martine/ninja.git               ` . Or you can use `        make       ` which is slower for recompiling:
    `        cmake .       `
    `        make -j8       `

The currently available modes are debug and release. Creating a new type of build can be done by copying an existing `     CMakeLists.txt    ` file from a build directory and modifying compiler settings and flags appropriately. In particular, users wanting to build only the libraries or a subset of the applications should remove these lines in `     CMakeLists.txt:    `

    INCLUDE( ../build/apps.all.cmake )
    INCLUDE( ../build/pilot_apps.all.cmake )

These can be replaced with an explicit list of applications, such as:

    INCLUDE( ../build/apps/minirosetta.cmake)

The `     make_project.py    ` and `     cmake    ` commands should be run whenever files are added or removed from the `     rosetta_source/src/*.src.settings    ` files. The `     -j8    ` flag for `     cmake    ` has the same interpretation as the `     -j8    ` flag for `     scons    ` . The command `     cmake .    ` generates a "makefile", which means that alternate programs such as [distcc](https://wiki.rosettacommons.org/index.php/Distcc "Distcc") can be used for building Rosetta 3.

Alternate C++ compilers (such as Clang++ or distcc) can be specified on the command-line by replacing this command,

`      cmake .     `

with this command,

``       cmake . -DCMAKE_CXX_COMPILER=`which clang++`      ``


Testing Rosetta 3
-----------------
This should not be necessary outside of the developers version, but is here in case it is needed by the community.

There are two sets of tests to run to ensure everything is working properly, unit tests and integration tests.  The unit tests require a compile in debug mode as well as a special build of the tests themselves, whereas the integration test requires a compile in release mode. (The commands below assume that you are still in the `     main/source    ` directory.) 

### Unit tests

Compile in debug mode, as shown above(You only need to compile the libraries.) along with the tests.

`        ./scons.py -j<number_of_processors_to_use> && ./scons.py -j<number_of_processors_to_use> cat=test       `

Run the test with one of the following commands:

-   `        test/run.py -j<number_of_processors_to_use> -d ../database -c <optional_compiler_specification>       `

...to watch the details displayed in standard output,...

-   `        test/run.py -j<number_of_processors_to_use> -d ../database -c <optional_compiler_specification> --mute all       `

...to silence the details and simply see the current test and the final results, **or** ...

-   `        test/run.py -j<number_of_processors_to_use> -d ../database -c <optional_compiler_specification>       ` -1 ClassNameOfMyUnitTestSuite

...to run a single unit test suite.

### Integration tests

Running `     integration.py    ` for the first time will generate a folder called `     ref    ` in `     rosetta/rosetta_tests/integration    ` . Whenever you make a change, run the integration test and compare your new test output (located in the `     new    ` folder) with that in the `     ref    ` folder.

Run the test as follows:

1.  Compile in *full application release* mode, as shown above.
    `        ./scons.py -j<number_of_processors_to_use> mode=release bin       `
2.  Change directories.
    `        cd ../tests/integration       `
3.  Run the test.
    `        ./integration.py -j<number_of_processors_to_use> -d ../../database -c <optional_compiler_specification>       `

(To generate a fresh `     ref    ` folder, simply delete it and re-run the integration test to generate a new `     ref    ` folder. When you are running the test for the first time, some of the database binaries get made. But this process is not required for the subsequent runs, so regenerating the `     ref    ` folder will fix this problem.)

To compare the two directories, type: `     diff -r new ref    `

To run one test:

`      ./integration.py my_test -d ../../database -c <optional_compiler_specification>     `


Miscellaneous
-------------

### Cleaning Rosetta 3

    ./scons.py -c 
    rm .sconsign.dblite

*or*

    rm -rf build/src; rm .sconsign.dblite  
# See Also

- Additional [[build]] documentation.
- An out-dated list of [[platforms]] supported by Rosetta.