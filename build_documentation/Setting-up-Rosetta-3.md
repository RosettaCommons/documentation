#Setting up Rosetta 3

This page describes how to install, compile, and test Rosetta 3 \( [formerly called "Mini"] (RosettaTimeline) \) on a [supported platform](https://wiki.rosettacommons.org/index.php/Supported_Platforms "Supported Platforms") .

##Basic Installation
====================
Installation instructions for most situations can be found on the [[Getting Started|Getting-Started#local-installation-and-use-of-rosetta]] page. 

##Alternative Build Environment Setup for Individual Workstations
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

###More useful build commands (Mac/Linux)

By default, `     scons    ` uses GCC to compile. To use an alternate compiler, such as CLang, use the `     cxx    ` option:

`      ./scons.py -j<number_of_processors_to_use> cxx=clang     `


To use an alternate version of the compiler, you can use the option `     cxx_ver    ` option with whatever version you have (here 4.5):

`      ./scons.py -j<number_of_processors_to_use> cxx=clang cxx_ver=4.5     `

For more build options, such as only compiling only one executable or apbs - Please take a look at the SConstruct File in rosetta\_source

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


##Testing
====================

There are two sets of tests to run to ensure everything is working properly, unit tests and integration tests. (See [Testing Rosetta](xxxx) .)

### Cleaning 

    rm -rf build/src; rm .sconsign.dblite  