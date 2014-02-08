<!-- --- title: Building Rosetta -->
##A Guide to Using SCons to Build Rosetta
Author: Kristian Kaufmann

last modified: 2/7/2014 Jared Adolf-Bryfogle

Rosetta uses a custom SCons builder. The builder allows multiple build configurations. This page demonstrates some simple features of the build system followed by a more detailed discussion of the build system structure and how it can be extended.

Note that scons-local is packaged with Rosetta3. Thus if scons is not installed on your system replace all the folllowing "scons" calls with "python external/scons-local/scons.py"

Building
========

In order to build release executables, add the flag 'mode=release' like this:

`       scons bin mode=release      `

In order to build debug executables, add the flag 'mode=debug'. These executables will run slower and should be only be used for debugging an application or protocol. If you have problems with an app, please first see the the moderated forum at    [rosettacommons](https://www.rosettacommons.org/forum)

`       scons bin mode=debug      `

To compile using 4 processors:

`       scons bin mode=release -j4      `

To build MPI executables, add the flag "extras=mpi". 
 
`       scons bin mode=release extras=mpi      `


If the default settings result in compile errors, copy source/tools/build/site.settings.topsail to site.settings (within the same directory) and edit to reflect your environment.  This is most useful for very specific cluster settings.  Your cluster admin should be able to help, and many common issues encountered while building mpi are covered on the [forum](https://www.rosettacommons.org/forum).   

Clang compiler instead of gcc default:

`       scons bin mode=release cxx=clang      `


To display more rosetta specific build options call scons -h To display general scons build options call scons -H

Additional Build Environment Options
====================================

Automatic location of other compilers (assuming they are already in your path) such as Intel C/C++ may be enabled by uncommenting the "program\_path" line in 'tools/build/user.settings'.

A user can restrict compilation of the the devel and pilot\_apps. On issuing the call

`       scons bin my      `

or

`       scons bin my_pilot_apps      `

SCons will read from src/devel.src.settings and src/pilot\_apps.src.settings rather than src/devel.src.settings.all and src/pilot\_apps.src.settings.all This cuase SCons to build only the sources listed in src/devel.src.settings and src/pilot\_apps.src.settings with the needed dependencies.

Common build calls that may be useful
=====================================

Build the default projects with default settings (debug mode, shared libraries)

`       scons      `

Build the target \<project\> with default settings

`       scons <project> scons core scons protocols      `

Build only the sources of \<project\> in \<subdirectory\>

`       scons <project>/<subdirectory> scons core/chemical      `

Build only \<objectfile\>. Note that the extension is "os" for a shared object. For a static build this would "o".

`       scons <project>/<path/<objectfile> scons protocols/rna/RNA_ProtocolUtil.os      `

Build and install executables in bin/ directory

`       scons bin      `

Build and install executables in bin/ directory if current working directory is a sub-directory of source. -D options tells scons to iteratively search towards the root for SConstruct file. The \# sign is an alias for the top build directory.

`       scons -D #bin      `

Build all pilot\_apps listed in src/pilot\_apps.src.settings.all and sources in src/devel.src.settings as well as the core, numeric and utility libraries

`       scons bin scons bin pilot_apps_all      `

Build restricted set of pilot\_apps and devel sources listed in src/pilot\_apps.src.settings.my and src/devel.src.settings.my

`       scons bin my scons bin my_pilot_apps      `

Build and install a particular executable in the bin directory

`       scons bin/exec scons bin/benchmark.linuxgccdebug scons mode=release bin/benchmark.linuxgccrelease      `

Build in release mode (\~10x faster executable)

`       scons mode=release      `

Build static libraries and exectuables instead of shared libraries.

`       scons extras=static      `

Build and run unit tests. (Note the sources must be built first.)

`       scons cat=test python test/run.py      `

Parallelize build into 3 threads (faster on multiproc. machine). In fact some source recommend starting twice as many threads as available processors (Not quite sure this makes sense or a difference).

`       scons -j3      `

Use the version of scons that is distributed with Rosetta. Useful for when scons is not installed on system

`       python external/scons-local/scons.py      `

# See Also

- Additional [[build]] documentation.
- An out-dated list of [[platforms]] supported by Rosetta.