#Setting up Rosetta 3

This page describes how to install, compile, and test Rosetta 3 \( [formerly called "Mini"] (RosettaTimeline) \) on a [supported platform](https://wiki.rosettacommons.org/index.php/Supported_Platforms "Supported Platforms") .

##Basic Installation
====================
Installation instructions for most situations can be found on the [[Getting Started|Getting-Started#local-installation-and-use-of-rosetta]] page. 

##Additional Build Information for Individual Workstations
====================

The current build system is based on the tool [SCons](https://wiki.rosettacommons.org/index.php/Tools:SCons "Tools:SCons") ("Software Constructor") with some extensions. `     scons.py    ` is implemented as a Python script.

###SCons

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

###More useful build commands

By default, `     scons    ` uses GCC to compile. To use an alternate compiler, such as CLang, use the `     cxx    ` option:

`      ./scons.py -j<number_of_processors_to_use> cxx=clang     `


To use an alternate version of the compiler, you can use the option `     cxx_ver    ` option with whatever version you have (here 4.5):

`      ./scons.py -j<number_of_processors_to_use> cxx=clang cxx_ver=4.5     `

For more build options, such as only compiling only one executable or apbs - Please take a look at the SConstruct File in rosetta\_source

##Testing
====================

There are two sets of tests to run to ensure everything is working properly, unit tests and integration tests. (See [Testing Rosetta](xxxx) .)

### Cleaning 

    rm -rf build/src; rm .sconsign.dblite  