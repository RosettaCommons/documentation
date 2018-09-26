<!-- --- title: Setting up Rosetta 3 -->

###If you are new to Rosetta, start [[here|Getting-Started]].

This page describes how to install, compile, and test Rosetta 3 (formerly called "Mini") on one's own workstation, or to a user directory on a scientific cluster.

Setting up Rosetta 3
====================

This page describes how to install, compile, and test Rosetta 3 [[formerly called "Mini"|Rosetta-Timeline]] on a [[supported platform|platforms]].

[[_TOC_]]

##Basic Setup
Build environment setup instructions for most situations can be found on the [[Getting Started|Getting-Started#local-installation-and-use-of-rosetta]] page. 

## Publicly accessible clusters with Rosetta pre-installed

* As part of the XSEDE initiative, the [[TACC/Stampede|TACC]] cluster has Rosetta and PyRosetta centrally installed for authorized users. See the [[TACC]] page for more details.

##Alternative Setup for Individual Workstations

The current build system is based on the tool [[SCons|Scons-Overview-and-Specifics]] ("Software Constructor") with some extensions. `     scons.py    ` is implemented as a Python script.

###SCons (Mac/Linux)

You have multiple options for compiling Rosetta 3 with SCons. You can build either only the core libraries or both the libraries and the executables. Rosetta 3 can be compiled in two major modes:

-   Debug mode — for development — no `      mode     ` option, or `mode=debug`
-   Release mode — faster/tested and ready to go &mdashl `      mode=release     `

1.  Change directory to `      main/source     ` .
2.  Type one of the following commands:

    -    Build all binaries

        -   `          ./scons.py -j<number_of_processors_to_use> bin         `
        -   `          ./scons.py -j<number_of_processors_to_use> mode=release bin         `

    -    Build a specific binary

        -   `          ./scons.py -j<number_of_processors_to_use> bin/rosetta_scripts.linuxgccdebug         `
        -   `          ./scons.py -j<number_of_processors_to_use> mode=release bin/rosetta_scripts.linuxgccrelease         `

    - Build libraries only

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

If you get an error like `     /usr/bin/ld: cannot find -lz    `, SCons may be looking for 32 bit libraries on a 64 bit machine. Look up how to install the missing dependency; in this case `     sudo apt-get install lib32z1-dev    ` installs the required library.

<!--- BEGIN_INTERNAL -->
#### Pilot Apps
You can compile only the pilot apps you want by copying (in the <code>src</code> directory,   <code>pilot_apps.src.settings.template</code> to <code>pilot_apps.src.settings.my</code> and then filling out the paths to your apps just like what is in the <code>pilot_apps.src.settings.all</code> file. You might need to create a <code>src/devel.src.settings.my</code> file (can copy from <code>devel.src.settings.template</code>).

##### Scons
You will need to pass a 'my' after 'bin' for the build machinery to use this file, for example:
<code>python scons.py bin my mode=release -j7 cxx=clang</code>

##### CMake
From what I understand, Cmake should automatically detect your my file and use it. 

<!--- END_INTERNAL -->

###Build Rosetta using the Rosetta Xcode Project (Mac)

> If you update Xcode, make sure to re-install the commandline-tools:  
> ```xcode-select --install```

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

There have been some reports of success in using the precompiled Linux binaries with Windows 10's Linux subsystem. Such use should be viewed as "highly experimental".

You _may_ be able to compile Rosetta by using cygwin for windows ( [http://www.cygwin.com/](http://www.cygwin.com/) ). Such usage is not tested by Rosetta developers though, and may not work.

### CMake

Rosetta can also be built with CMake. Currently it is less widely tested and does not support some features such as "extras" flags. However, CMake is faster than SCons, which can be advantageous for rapid compile-debug cycles.

To build with CMake...

1.  Change to the CMake build directory from the base Rosetta 3 directory and create the CMake build files:

        cd cmake       
        ./make_project.py all

2.  Next, change to a build directory

        cd build_<mode>   

3.  and build Rosetta 3

        cmake -G Ninja
        ninja       

    If you don't have ninja, you can get it via 

        git clone git://github.com/martine/ninja.git

    Or you can use `make` which is slightly slower for recompiling:

        cmake .       
        make -j`nproc` # replace `nproc` with number of cores to use


The currently available modes are debug and release, in combination with various extras and compilers. Creating a new type of build can be done by copying an existing `CMakeLists.txt` file from a build directory and modifying compiler settings and flags appropriately. In particular, users wanting to build only the libraries or a subset of the applications should remove these lines in `CMakeLists.txt`:

    INCLUDE( ../build/apps.all.cmake )
    INCLUDE( ../build/pilot_apps.all.cmake )

These can be replaced with an explicit list of applications, such as:

    INCLUDE( ../build/apps/minirosetta.cmake)

The `     make_project.py    ` and `     cmake    ` commands should be run whenever files are added or removed from the `     rosetta_source/src/*.src.settings    ` files. The `     -j8    ` flag for `     cmake    ` has the same interpretation as the `     -j8    ` flag for `     scons    ` . The command `     cmake .    ` generates a "makefile", which means that alternate programs such as [distcc](https://wiki.rosettacommons.org/index.php/Distcc "Distcc") can be used for building Rosetta 3. (The `     ninja_build.py     ` script in `     rosetta_source     ` automatex the combined cmake/ninja process and responds to build abbreviations like 'r' for 'release'.)

Alternate C++ compilers (such as Clang++ or distcc) can be specified on the command-line by replacing this command,

`      cmake .     `

with this command,

``       cmake . -DCMAKE_CXX_COMPILER=`which clang++`      ``

If you want to build Rosetta with an IDE such as CLion, just import Rosetta and choose one of the build directories under source/cmake/build/<build_directory> (e.g. build_debug) as your root.

###Message Passing Interface (MPI)

MPI (the **M**essage **P**assing **I**nterface) is a standard for process-level parallelization. Independent processes can coordinate what they're doing by sending messages to one another, but cannot access the same memory space or directly interfere with one another's execution. Although most of Rosetta has not been parallelized, some apps (such as rosetta\_scripts) are set up for at least job-level parallelism (permitting automatic distribution of jobs over available processes), and some specialized pilot apps (such as vmullig/design\_cycpeptide\_MPI) take advantage of parallel processing in a non-trivial way.

To build MPI executables, add the flag "extras=mpi" and copy main/source/tools/build/site.settings.topsail to main/source/tools/build/site.settings. You may need to make additional edits to the site.settings file if your MPI libraries are not in the standard locations. See this post for help with setting up MPI for Ubuntu linux. Then compile with extras=mpi:

```
./scons.py bin mode=release extras=mpi
```

####Installing MPI
You need to install MPI, of course.  What that looks like will vary from system to system.  For ubuntu, you will need probably ```sudo apt-get install openmpi openmpi-dev``` or similar.  The -dev package is necessary to install *before* trying to compile MPI Rosetta.

##Dependencies/Troubleshooting

<a name="dependencies"/>
Rosetta requires a compiler (most recent gcc or clang are fine, but see [[Cxx11Support]] for details) and the zlib compression library development package. Instructions for acquiring either are below, sorted by what sorts of error messages they give if you are missing them.

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

Rosetta requires a compiler with C++11 support. Most recent compiler versions include C++11 support, but older compilers may not. See [[Cxx11Support]] for more details.

For Macs, install the XCode development packages. Even though you won't be compiling Rosetta through XCode, installing it will also install a compiler. (Clang, for recent versions of MacOS.)

For Linux, you will want to install the compiler package from your package management system. For Ubuntu and similar systems, the package "build-essential" installed with a command like `sudo apt-get install build-essential` will set your system up for compilation.

**"error: unrecognized command line option "-std=c++11""**

Rosetta requires a compiler with C++11 support. This message is due to insufficient support of C++11 in the compiler you're currently using. See [[Cxx11Support]] for more details about compilers to use, or see the "sh: 1: o: not found" regarding changing your compiler.

**"error: '...' names constructor"/"

GCC 4.7, while it supports many of the features of C++11, doesn't support all of them - this message is coming from a feature we use which is not supported by GCC 4.7. See [[Cxx11Support]] for more details about compilers to use, or see the "sh: 1: o: not found" regarding changing your compiler.

**"no member named 'declval' in namespace 'std'"**
**"error: unknown type name 'type_info'"**

Rosetta requires a compiler and C++ standard library with C++11 support. These messages indicate that while your compiler might have C++11 support, the standard library it's using may not. See [[Cxx11Support]] for more details about compiler and standard libraries, or see the "sh: 1: o: not found" regarding changing your compiler.

**"cannot find -lz"**

Rosetta requires the zlib compression library to be installed on your computer in order to properly compile. Talk to your system administrator about installing the development version of the zlib library. (The "development" version of the library is needed so that Rosetta can compile against the library.) 

For Ubuntu and related distributions, install the zlib1g-dev package (e.g. with `sudo apt-get install zlib1g-dev`)

##Testing

There are two sets of tests to run to ensure everything is working properly, unit tests and integration tests. (See [[Testing Rosetta|rosetta-tests]].)

####MPI
Compilation in MPI mode permits specialized JobDistributors to be used; the function of these JobDistributors, and their integration with other components of Rosetta, can only be tested by running special integration tests in MPI mode by passing the ```--mpi-tests``` flag to integration.py. Selective failure of these tests will probably mean that the parallel JobDistributors have been broken in some way.

The MPI-mode build test simply tries to compile Rosetta with the ```-extras=mpi``` flag passed to scons. Selective failure of this build means that code surrounded by ```#ifdef USEMPI ... #endif``` lines has errors in it.

##Cleaning 
`cd Rosetta/main/source/ && rm -r build/* && rm .sconsign.dblite` will remove old binaries.

## Obtaining additional files

#### PDB Chemical Components Dictionary 

To help automatically load unrecognized residues from files, the `-in:file:load_PDB_components` option triggers a lookup of an mmCIF-formatted version of the Chemical Components Dictionary. Starting in late 2017, a version of this file is being distributed with Rosetta, split into chunks that stay under the GitHub 50 Mb file size limit. 

If you are working with an earlier version of Rosetta without files in `database/chemical/components/*cif.gz`, or if you wish to get the latest weekly release from the PDB, the file can be downloaded from the [wwwPDB](http://www.wwpdb.org/data/ccd). (Alternatively for RosettaCommons members, you can talk your lab's gatekeeper for the RosettaCommons git-lfs).

To use with Rosetta, download the components file and place it in the Rosetta database directory (Rosetta/main/database/):

```
ftp -o $ROSETTA_DATABASE/chemical/components.cif.gz ftp://ftp.wwpdb.org/pub/pdb/data/monomers/components.cif.gz
```

Pass the file `components.cif` or the absolute path to the file to the `-in:file:PDB_components_file` option. The "Protonation Variants Companion Dictionary" and "Chemical Component Model data file" are not required. 


## See Also

* [[Getting Started]]
* [[Platforms]]: Supported platforms for Rosetta
* [[Scons Overview and Specifics]]: Detailed information on the Scons compiling system