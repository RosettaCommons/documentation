<!-- --- title: Setting up Rosetta 3 -->
This page describes how to install, compile, and test Rosetta 3 (formerly called "Mini") on one's own workstation, or to a user directory on a scientific cluster.

Clusters with Rosetta pre-installed
-----------------------------------

If you'll be running Rosetta on a scientific computation cluster, there may already be a version of Rosetta installed for general usage. Talk to your cluster administrator to see if there is a centrally-provided version available for your use.

If your cluster doesn't have Rosetta already installed, or you wish to use a different version than the centrally installed one, don't worry - Rosetta is designed to be compiled and installed by regular users without administrative rights. As long as commonly available compilation tools are available for your use, you should be able to build and run Rosetta in your user directory without cluster administrator involvement.

### Publicly accessible clusters with Rosetta pre-installed

* As part of the XSEDE initiative, the [[TACC/Stampede|TACC]] cluster has Rosetta and PyRosetta centrally installed for authorized users. See the [[TACC]] page for more details.

Compiling Rosetta 3
-------------------

The current build system is based on the tool [SCons](http://www.scons.org/) ("Software Constructor") with some extensions. Rosetta comes with a bundled version of Scons, accessible through the `main/source/scons.py` Python script. Scons can also be invoked from an external installation via the <code>scons</code> command.

[[_TOC_]]

### SCons

You have multiple options for compiling Rosetta 3 with SCons. You can build either only the core libraries or both the libraries and the executables. Rosetta 3 can be compiled in two modes:

-   Debug mode — for development — omit the `mode` option or supply `mode=debug`
    - Debug mode compiles activate a number of internal "sanity checks" and adds internal code labels, resulting in larger, slower executables, but ones that are easier to debug.
-   Release mode — for most usage and production run — supply `mode=release`
    - Activates optimizations, resulting in a smaller, faster executable.

To build:

1.  Change directory to `main/source`.
2.  Type one of the following commands:
    -    All executables   
        -   `./scons.py -j<number_of_processors_to_use> bin`
        -   `./scons.py -j<number_of_processors_to_use> mode=release bin`
    -    A specific executable (e.g. "relax") 
        -   `./scons.py -j<number_of_processors_to_use> <executable_name>`
        -   `./scons.py -j<number_of_processors_to_use> mode=release <executable_name>`
    -    libraries only   
        -   `./scons.py -j<number_of_processors_to_use>`
        -   `./scons.py -j<number_of_processors_to_use> mode=release`

The `-j8` flag would mean, "use at most 8 processes for building," and can be reasonably set as the number of free processors on your machine. Be aware that setting `-j` to a very high value will slow down the OS significantly.

The `extras=` flag is for specialty compiles such as MPI and static builds (See below).   If you want to have multiple extras, supply the extras flag only once, and separate the multiple extras options with a comma, e.g. `extras=mpi,static`.

By default scons hashes and processes every file in the tree before performing a build. On a large tree (e.g. rosetta) and filesystem with high IO latency (e.g. a NFS or GPFS filesystem) this causes ridiculously slow build times. In order to improve build times disable file hashing and allow caching of build dependency metadata. Add the follow lines to the project's root SConscript file:

    Decider('MD5-timestamp')
    SetOption('implicit_cache', 1)

These settings are described on the [scons gofast](http://www.scons.org/wiki/GoFastButton) page.

 **More useful build commands:**

By default, `scons` prefers to use GCC to compile. To force an alternate compiler, such as Clang, use the `cxx` option:

`./scons.py -j<number_of_processors_to_use> cxx=clang`

NOTE: Use `clang` if you can. It is quicker and gives better error messages. Win/Win. You will save yourself a lot of time trying to reverse engineer GCC compiler errors. And there are binaries to install it. Triple win.

To use an alternate version of the compiler, you can use the option `cxx_ver` option with whatever version you have (here 4.5):

`      ./scons.py -j<number_of_processors_to_use> cxx=clang cxx_ver=4.5     `


To build OpenMP executables (which is not fully supported) add the flag "extras=omp"

`      ./scons.py bin mode=release extras=omp     `

To build static executables, which can be moved to different computers with the same architecture/OS, add the flag "extras=static":

`      ./scons.py bin mode=release extras=static     `

To display more Rosetta specific build options call

`      ./scons.py -h     `

To display general Scons build options call

`      ./scons -H     `

You can edit your `main/source/tools/build/user.options` file to include options such as preferred compiler (`cxx`), to avoid having to always specify the option on the command-line.

More advanced build options are available - Details are hidden in the main/source./SConstruct file.

#### MPI

To build MPI executables, add the flag "extras=mpi" and copy <code>main/source/tools/build/site.settings.topsail</code> to <code>main/source/tools/build/site.settings</code>. You may need to make additional edits to the site.settings file if your MPI libraries are not in the standard locations. See [this post](https://www.rosettacommons.org/node/3931) for help with setting up MPI for Ubuntu linux.  Then compile with extras=mpi:

`      ./scons.py bin mode=release extras=mpi     `

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

The currently available modes are debug and release. Creating a new type of build can be done by copying an existing `CMakeLists.txt` file from a build directory and modifying compiler settings and flags appropriately. In particular, users wanting to build only the libraries or a subset of the applications should remove these lines in `CMakeLists.txt`:

    INCLUDE( ../build/apps.all.cmake )
    INCLUDE( ../build/pilot_apps.all.cmake )

These can be replaced with an explicit list of applications, such as:

    INCLUDE( ../build/apps/minirosetta.cmake)

The `     make_project.py    ` and `     cmake    ` commands should be run whenever files are added or removed from the `     rosetta_source/src/*.src.settings    ` files. The `     -j8    ` flag for `     cmake    ` has the same interpretation as the `     -j8    ` flag for `     scons    ` . The command `     cmake .    ` generates a "makefile", which means that alternate programs such as [distcc](https://wiki.rosettacommons.org/index.php/Distcc "Distcc") can be used for building Rosetta 3.

Alternate C++ compilers (such as Clang++ or distcc) can be specified on the command-line by replacing this command,

`      cmake .     `

with this command,

``       cmake . -DCMAKE_CXX_COMPILER=`which clang++`      ``


Troubleshooting
---------------

Here are some common issues seen with building Rosetta.

**"sh: 1: o: not found"**

This indicates that you either don't have a compiler installed, or Rosetta is not able to find the compiler that you do have installed.

At the commandline, execute `g++ --version` and `clang --version`. If one of them works, you can try specifying that compiler explicitly on the scons commandline with either `cxx=gcc` or `cxx=clang`. (This is a label, rather than the compiler command, so it cannot take arbitrary input.)

 --> **A compiler is already installed**:

If you know you have a compiler installed and it's in your path, you can copy `main/source/tools/build/site.settings.topsail` to `main/source/tools/build/site.settings`. You may also want to edit the lines:
```
"overrides" : {
},
```
to something like:
```
"overrides" : {
    "cc" : "<C compiler command>",
    "cxx" : "<C++ compiler command>",
},
```
where you substitute the compiler commands as appropriate.




 --> **Install a compiler**:


Many default installations of Mac and Linux do not come with a compiler installer, so you will need to install one separately. (Note that the following only applies if you have administrator rights to your machine. If you do not, talk to your sysadmin regarding the installation of a compiler.)

For Macs, install the XCode development packages. Even though you won't be compiling Rosetta through XCode, installing it will also install a compiler. (Clang, for recent versions of MacOS.)

For Linux, you will want to install the compiler package from your package management system. For Ubuntu and similar systems, the package "build-essential" installed with a command like `sudo apt-get install build-essential` will set your system up for compilation.

**"cannot find -lz"**

Rosetta requires the zlib compression library to be installed on your computer in order to properly compile. Talk to your system administrator about installing the development version of the zlib library. (The "development" version of the library is needed so that Rosetta can compile against the library.) 

For Ubuntu and related distributions, install the zlib1g-dev package (e.g. with `sudo apt-get install zlib1g-dev`)

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
