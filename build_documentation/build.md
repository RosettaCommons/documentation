#Build Rosetta

For most of the following build commands you need to be in the home directory of Rosetta source.

General Instruction
===================

In order to build a release version of Rosetta executables, simply run scons:

-   Release Mode This command will build the defaults: libraries devel, protocols, core, numeric, utility and all applications listed in src/apps.src.settings or src/pilot\_apps.src.settings.all.

    `scons bin mode=release`

-   Debug Mode In order to build a debug version of executables, remove the flag 'mode=release'.

    `scons bin`

-   Other options To display more rosetta specific build options call

    `scons -h`

    To display general scons build options call

    `scons -H`
 
Advanced Build Environment Setup
================================

Automatic location of other compilers (assuming they are already in your path) such as Intel C/C++ may be enabled by uncommenting the "program\_path" line in 'tools/build/user.settings'.

You can restrict compilation of the the devel and pilot\_apps to build personal applications. On issuing the call

```
scons bin my
```
or
```
scons bin my_pilot_apps
```

SCons will read from src/devel.src.settings.my and src/pilot\_apps.src.settings.my rather than src/devel.src.settings and src/pilot\_apps.src.settings.all.

Common build calls that may be useful
=====================================

-   Build the default projects with default settings (debug mode, shared libs)

    `scons`

-   Build the target \<project\> with default settings

    `scons <project>`

-   Build only the sources of \<project\> in \<subdirectory\>

    `scons <project>/<subdirectory>`

-   Build only specified objectfile

    `scons <project>/<path/<objectfile>`

-   Build and install executables in bin directory

    `scons bin`

-   Build and install executables in bin directory if current working directory is a sub-directory of Rosetta. -D option tells SCons to iteratively search towards the root for SConstruct file. The \# sign is an alias for the top build directory.

    `scons -D #bin`

-   Build all pilot\_apps listed in src/pilot\_apps.src.settings.all and sources in src/devel.src.settings as well as the core, numeric and utility libraries

    ```
    scons bin
    scons bin pilot_apps_all
    ```

-   Build restricted set of pilot\_apps and devel sources listed in src/pilot\_apps.src.settings.my and src/devel.src.settings.my

    ```
    scons bin my
    scons bin my_pilot_apps
    ```

-   Build and install a particular executable in the bin directory e.g

      ```
      scons bin/exec
      scons bin/benchmark.linuxgccdebug
      scons mode=release bin/benchmark.linuxgccrelease
      ```

-   Build in release mode(around 10 times faster executable)

      `scons mode=release`

-   Static linking instead of shared libraries (portable to other computers, but larger file sizes)

    `scons extras=static`

-   Build and run unit tests. (Note the sources must be built with debug mode first.)

    ```
    scons cat=test
    python test/run.py
    ```

-   Parallelize build into 3 threads. Intended for multiprocessor machines.

    `scons -j3`

Build Rosetta on Mac OS X System
================================

Build Rosetta in Mac Terminals
------------------------------

The Rosetta installation on MacOS X system is the same as the installation on Linux system. You need to make sure that the Xcode is installed, which is also available free from Apple Developer Connection. [http://en.wikipedia.org/wiki/Apple\_Developer\_Connection](http://en.wikipedia.org/wiki/Apple_Developer_Connection)

Build Rosetta using the Rosetta Xcode Project
---------------------------------------------

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

Build Rosetta on Windows System
===============================

Building Rosetta directly on Windows systems is not recommended.

Alternatives:
* Install [[virtual machine|http://en.wikipedia.org/wiki/Virtual_machine]] software and run Linux within it.
* Use a pre-build version of [[PyRosetta]] instead.

You _may_ be able to compile Rosetta by using cygwin for windows ( [http://www.cygwin.com/](http://www.cygwin.com/) ). Such usage is not tested by Rosetta developers, though, and may not work.

