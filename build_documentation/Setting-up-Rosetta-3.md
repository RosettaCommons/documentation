#Setting up Rosetta 3

This page describes how to install, compile, and test Rosetta 3 [(formerly called "Mini")|RosettaTimeline] on a [supported platform](https://wiki.rosettacommons.org/index.php/Supported_Platforms "Supported Platforms") .

##Basic Installation
-------------------
Installation instructions for most situations can be found on the [Getting Started|Getting-Started#local-installation-and-use-of-rosetta] page. 

##Additional Build Information for Individual Workstations
-------------------

The current build system is based on the tool [SCons](https://wiki.rosettacommons.org/index.php/Tools:SCons "Tools:SCons") ("Software Constructor") with some extensions. `     scons.py    ` is implemented as a Python script.

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

Writing Code
------------

Please see the [Coding Conventions and Examples](https://wiki.rosettacommons.org/index.php/Coding_Convention_and_Examples "Coding Convention and Examples") page before adding code to Rosetta.

### Functions

To add a function, simply declare it in a header file and define it in a cc file. All functions declared must be defined or the PyRosetta build will break. You may want to consider adding a [unit test](https://wiki.rosettacommons.org/index.php/Unit_tests "Unit tests") for your functions.

### Classes

To add a class, follow the header and cc of other classes. Header files should have ifdefs as described in the coding conventions. Classes added will need to be added to a corresponding .settings file in source/src. These correspond to whole Rosetta directories, usually having all subdirectories in the same .setting file.

Please see the library\_level section in the Builds section for more information on rules governing these settings files. You may want to consider adding a [unit test](https://wiki.rosettacommons.org/index.php/Unit_tests "Unit tests") for your classes.

### Pilot apps

#### Creating

A pilot application is an executable that you create to test and debug new code or modifications that you have added to Rosetta.

1.  From the `      rosetta     ` directory, using SVN, create a new directory for any pilot apps you create.
    `        mkdir source/src/apps/pilot/<your_user_name>       `
    `        git add source/src/apps/pilot/<your_user_name>       `
2.  Create a new C++ source code file in your new directory, `      <filename_of_pilot_app>.cc     ` .
3.  Add the new file to the git index.
    `        git add source/src/apps/pilot/<your_user_name>/<filename_of_pilot_app>.cc       `

At the most basic level, a pilot app should look something like this:

    // -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
    // vi: set ts=2 noet:
    // :noTabs=false:tabSize=4:indentSize=4:
    //
    // (c) Copyright Rosetta Commons Member Institutions.
    // (c) This file is part of the Rosetta software suite and is made available
    // (c) under license.
    // (c) The Rosetta software is developed by the contributing members of the
    // (c) Rosetta Commons.
    // (c) For more information, see http://www.rosettacommons.org.
    // (c) Questions about this can be addressed to University of Washington UW
    // (c) TechTransfer, email: license@u.washington.edu.

    /// @file   <filename_of_pilot_app>.cc
    /// @brief  This is simply a generic pilot app for testing changes.
    /// @author <your_name>

    // includes
    #include <iostream>

    #include <devel/init.hh>
    #include <core/pose/Pose.hh>
    #include <core/import_pose/import_pose.hh>

    int main(int argc, char *argv[])
    {
        using namespace core;
        using namespace import_pose;
        using namespace pose;

        // initialize core
        devel::init(argc, argv);

        // declare variables
        Pose test_pose;

        // import a test pose
        pose_from_pdb(test_pose, "test.pdb");

        std::cout << "Hello, Rosetta World!" << std::endl;
        std::cout << "I just imported my first pose into Rosetta." << std::endl;
        std::cout << "It has " << test_pose.total_residue() << " total residues." << std::endl;
    }

However, if you are developing protocols, it is standard practice to make your pilot apps call your Mover through the JobDistributor:

    // -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
    // vi: set ts=2 noet:
    // :noTabs=false:tabSize=4:indentSize=4:
    //
    // (c) Copyright Rosetta Commons Member Institutions.
    // (c) This file is part of the Rosetta software suite and is made available
    // (c) under license.
    // (c) The Rosetta software is developed by the contributing members of the
    // (c) Rosetta Commons.
    // (c) For more information, see http://www.rosettacommons.org.
    // (c) Questions about this can be addressed to University of Washington UW
    // (c) TechTransfer, email: license@u.washington.edu.

    /// @file   <filename_of_pilot_app>.cc
    /// @brief  This is a pilot app for testing MyMover.
    /// @author <your_name>

    // includes
    #include <protocols/MyMover.hh>

    #include <devel/init.hh>
    #include <protocols/jd2/JobDistributor.hh>
    #include <utility/excn/Exceptions.hh>

    int main(int argc, char *argv[])
    {
        using namespace protocols;
        using namespace protocols::jd2;

        try {
            // initialize core
            devel::init(argc, argv);

            // distribute the mover
            MyMoverOP my_mover = new MyMover();
            JobDistributor::get_instance()->go(my_mover);

        } catch(utility::excn::EXCN_Base & excn){
            std::cout << "Exception: "<<std::endl;
            excn.show(std::cerr);
        }
        return(0);

    }

See [this page](https://wiki.rosettacommons.org/index.php/Pilot_apps "Pilot apps") for more information on creating your own pilot apps.

An [Eclipse](https://wiki.rosettacommons.org/index.php/Tools:Eclipse "Tools:Eclipse") template for pilot apps can be found here: [Pilot application source file template for Eclipse](https://wiki.rosettacommons.org/index.php/Pilot_application_source_file_template_for_Eclipse "Pilot application source file template for Eclipse")

#### Compiling

1.  Edit `      /src/pilot_apps.src.settings.all     ` and add yourself to the list (a Python dictionary) of developers and add your pilot app. (Be careful to maintain the correct file format! For example, leave extensions off the filenames you are adding.) This file will instuct the complier to create your executable file.
2.  Edit any .settings files to include any classes you have added and that are required by your app (basic, protocols, etc.)
3.  Compile Rosetta in debug mode as shown above:
    `        ./scons.py -j<number_of_processors_to_use> bin       `

#### Running

1.  Change directory to `      /source/bin     ` . You should find two or more versions of your pilot app in the list of files with extensions indicating the operating system and the compile mode.
2.  Run your new executable file:
    `        ./<compiled_pilot_app_filename> -database <path_to_the_rosetta_database>       `

If your new code runs, it may be time to run the tests above and commit the changes to SVN.

Think about using the `     -show_simulation_in_pymol [send structure every x sec (float) ]    ` and `     -keep_pymol_simulation_history    ` flags to help debug your pilot app through the PyMOLMover. Note that This requires the PyMOLPyRosettaServer.py script from source/src/python/bindings to be run in PyMOL first ( `     run path_to/PyMOLPyRosettaServer.py    ` ). This can be added to \$HOME/.pymolrc or typed in the PyMOL console.

Testing Rosetta 3
-----------------

There are two sets of tests to run to ensure everything is working properly, unit tests and integration tests. (See [Testing Rosetta](https://wiki.rosettacommons.org/index.php/Testing_Rosetta "Testing Rosetta") .) The unit tests require a compile in debug mode as well as a special build of the tests themselves, whereas the integration test requires a compile in release mode. (The commands below assume that you are still in the `     main/source    ` directory.) See [this page](https://wiki.rosettacommons.org/index.php/Unit_tests "Unit tests") for information on how to write your own unit tests.

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

### Builds

#### PyRosetta

In order to keep the PyRosetta build from breaking, make sure to define all functions that are declared. If you will not be defining them for a while, comment them out to fix the build. If your break is more serious, and you are unsure how to proceed, email Sergey at sergey.lyskov@gmail.com.

#### library\_levels

Rosetta is broken into libraries and levels. For example, there are currently 6 levels in protocols (see src/protocols.x.settings). Directories in [higher] levels, for example 1, can not include any files from directories in the lower levels (6). When adding directories for the first time, it would be wise to run the library\_levels.py script located in tools/python\_cc\_reader. Run the script from source/src and will tell you of any illegal dependancies.

To fix these issues, you may have to tediously rearrange things until the script clears. Note that if the class that breaks it is in protocols/antibody/design and you move the directory to a lower level(6), you will need to move ALL of protocols/antibody to the new settings file.

#### static

All I know is that if a .settings file is empty of directories, this build will fail.

Miscellaneous
-------------

### Cleaning Rosetta 3

    ./scons.py -c 
    rm .sconsign.dblite

*or*

    rm -rf build/src; rm .sconsign.dblite  