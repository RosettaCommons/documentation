<!-- --- title: Setting up Rosetta 3 -->

###If you are new to Rosetta, start [[here|Getting-Started]].

This page describes how to install, compile, and test Rosetta 3 (formerly called "Mini") on one's own workstation, or to a user directory on a scientific cluster.

Setting up Rosetta 3
====================

This page describes how to install, compile, and test Rosetta 3 [[formerly called "Mini"|Rosetta-Timeline]] on a [[supported platform|platforms]].

[[_TOC_]]

##Basic Setup
====================
Build environment setup instructions for most situations can be found on the [[Getting Started|Getting-Started#local-installation-and-use-of-rosetta]] page. 

## Publicly accessible clusters with Rosetta pre-installed
====================
* As part of the XSEDE initiative, the [[TACC/Stampede|TACC]] cluster has Rosetta and PyRosetta centrally installed for authorized users. See the [[TACC]] page for more details.

##Alternative Setup for Individual Workstations
====================

The current build system is based on the tool [SCons](https://wiki.rosettacommons.org/index.php/Tools:SCons "Tools:SCons") ("Software Constructor") with some extensions. `     scons.py    ` is implemented as a Python script.

###SCons (Mac/Linux)

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

By default, `     scons    ` uses GCC to compile. To use an alternate compiler, such as CLang, use the `     cxx    ` option:

`      ./scons.py -j<number_of_processors_to_use> cxx=clang     `


To use an alternate version of the compiler, you can use the option `     cxx_ver    ` option with whatever version you have (here 4.5):

`      ./scons.py -j<number_of_processors_to_use> cxx=clang cxx_ver=4.5     `

For more build options, such as only compiling only one executable or apbs - Please take a look at the SConstruct File in main/source

###Build Rosetta using the Rosetta Xcode Project (Mac)

The Rosetta Xcode project is compatible with Xcode versions 2.4 and later. You can use it to build, run, debug, browse, and edit the source code. There are four build targets to select from:

```
Libraries: Rosetta libraries upon which apps are based
Test: Unit tests for components of Rosetta Libraries & Test: Both of the above
Libraries & Apps: Libraries and executable apps in rosetta-X.X/main/source/bin
```

There are two primary configurations, Debug and Release. Each of those has two sub-configurations. The "static" mode builds static binaries, instead of those based on the shared libraries. This can be useful for copying and running the apps on other Mac OS X systems. The "graphics" mode enables OpenGL graphics for those apps that support it.

The Xcode build and clean commands tell scons to take the appropriate actions. Xcode will by default instruct scons to use 2 processors for compilation. To change that number, double click the "Rosetta" icon in the "Groups & Files" pane. Then switch to the "Build" tab and change the "NUM\_PROCESSORS" setting to the desired number of processors.

To run/debug Rosetta from within Xcode, you will need to add an executable to the project. To do so, select "New Custom Executable..." from the "Project" menu. Xcode will not allow you to specify the symbolic links in the

```
rosetta-X.X/main/source/bin
```

directory as the executable. Instead, you will have to reference the actual binaries deep inside the subdirectories of

```
rosetta-X.X/main/source/build
```
Please see the Xcode documentation for information about specifying the command line arguments and the working directory.

If you want to set breakpoints from within Xcode for debugging, you have to tell the debugger to load all user libraries. To do so, go to the "Run-\>Show-\>Shared Libraries..." menu item. Change the "User Libraries:" popup from "Default (External)" to "All".


###Build Rosetta on Windows
===============================

Building Rosetta directly on Windows systems is not recommended.

Alternatives:
* Install [[virtual machine|http://en.wikipedia.org/wiki/Virtual_machine]] software and run Linux within it. 
* Dual Boot with [Linux](https://help.ubuntu.com/community/WindowsDualBoot). (usually the best option) 

You _may_ be able to compile Rosetta by using cygwin for windows ( [http://www.cygwin.com/](http://www.cygwin.com/) ). Such usage is not tested by Rosetta developers though, and may not work.

###Message Passing Interface (MPI)

MPI (the **M**essage **P**assing **I**nterface) is a standard for process-level parallelization. Independent processes can coordinate what they're doing by sending messages to one another, but cannot access the same memory space or directly interfere with one another's execution. Although most of Rosetta has not been parallelized, some apps (such as rosetta\_scripts) are set up for at least job-level parallelism (permitting automatic distribution of jobs over available processes), and some specialized pilot apps (such as vmullig/design\_cycpeptide\_MPI) take advantage of parallel processing in a non-trivial way.

To build MPI executables, add the flag "extras=mpi" and copy main/source/tools/build/site.settings.topsail to main/source/tools/build/site.settings. You may need to make additional edits to the site.settings file if your MPI libraries are not in the standard locations. See this post for help with setting up MPI for Ubuntu linux. Then compile with extras=mpi:

```
./scons.py bin mode=release extras=mpi
```

##Troubleshooting
====================
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

<<<<<<< HEAD
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

Running `     integration.py    ` for the first time will generate a folder called `     ref    ` in `     rosetta/main/tests/integration    ` . Whenever you make a change, run the integration test and compare your new test output (located in the `     new    ` folder) with that in the `     ref    ` folder.

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

## See Also

- Additional [[build]] documentation.
- An out-dated list of [[platforms]] supported by Rosetta.
=======
##Testing
====================

There are two sets of tests to run to ensure everything is working properly, unit tests and integration tests. (See [Testing Rosetta](xxxx) .)

####MPI
Compilation in MPI mode permits specialized JobDistributors to be used; the function of these JobDistributors, and their integration with other components of Rosetta, can only be tested by running special integration tests in MPI mode by passing the ```--mpi-tests``` flag to integration.py. Selective failure of these tests will probably mean that the parallel JobDistributors have been broken in some way.

The MPI-mode build test simply tries to compile Rosetta with the ```-extras=mpi``` flag passed to scons. Selective failure of this build means that code surrounded by ```#ifdef USEMPI ... #endif``` lines has errors in it.

##Cleaning 
====================

```rm -rf build/src; rm .sconsign.dblite```
>>>>>>> picard
