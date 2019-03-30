Supported Compiler Versions
===================

### Testing your compiler

To assist in determining which compilers are able to support Rosetta, we have put together a test script, 
downloadable from <https://raw.githubusercontent.com/RosettaCommons/rosetta_clone_tools/master/rosetta_compiler_test.py> 
Run with the `-h` option for help on how to use.

This will run the designated compiler through a few tests to see if the compiler (and associated library) are able to compile C++11 constructs used by Rosetta.
If your compiler fails any of the "Main Tests", that compiler is too old to successfully compile Rosetta.

### Compiler versions

Rosetta requires a compiler new enough to have C++11 support.

To see if your compiler has C++11 support, run it with just the `--version` option
to get a print out of the version number. Do this for whichever compiler(s) you wish to use with Rosetta.

```
g++ --version
clang++ --version
icc++ --version
mpiCC --version
```

Acceptable versions:

* GCC/g++: Version 4.8 or later
* Clang/llvm on Linux: Version 3.3 or later (with caveats. See Standard Library support below)
* Apple clang/llvm on Macs: Version 5.0 or later (The Apple provided clang has a different versioning scheme than "mainline" clang.)
* Intel/ICC: Version 14 or later (Version 15 or later if you need threading support).
* Other compilers: consult your compiler documentation for information about C++11 support.

### Standard Library Support

C++11 support by a compiler comes in two separate but related forms. Not only must the compiler itself support C++11,
but the C++ standard library it uses must also support C++11. 
The version numbers above are strictly for the compiler itself, and may or may not represent support in the standard library they use.

Generally speaking, GCC-based compilers come with their own C++ standard library, and so a supported compiler will have a supported standard library. Other compilers (such as clang and ICC) may use an external C++ standard library, and so a supported version might use an older, unsupported C++ standard library. (They may use the standard library of the compiler they themselves were compiled with, so to get a fully C++11 compliant Clang installation on Linux, one generally needs to install and compile clang itself with a fully C++11 compliant GCC installation.)

There are currently two major standard C++ libraries in use on the systems Rosetta typically runs on. 

* `libstdc++` - made by the GCC developers and comes with GCC. Also used by Clang and ICC compilers on Linux systems, when they are installed with gcc (the default). Rosetta requires the version associated with gcc version 4.8 or later.
* `libc++` - made by the Clang developers. The default on Mac systems. (Can also be used with clang on Linux systems, through special compilation.) Rosetta requires the version associated with clang version 3.3 or later.


What to do if your compiler is too old
---------------------------------------

### Use the pre-compiled binaries (Best, if they work for your system)

On the Rosetta download page, RosettaCommons provides pre-compiled versions of Rosetta for some (but not all) of the major operating systems Rosetta supports. 
These downloads should already be compiled in release mode, and are ready to run. 
Unfortunately, due to the variation in operating systems, not every distribution and version can be provided. 

### Use a different compiler already installed on your machine. (Best)

The easiest course of action is simply to use another compiler which is already installed. For example, if your gcc compiler is too old, your clang compiler may be acceptable (but see the section "Standard Library Support" for caveats).

Often, computers will have multiple different versions of the same type of compiler. For example, if the default gcc is too old, there may be a newer version of gcc installed elsewhere on the system. You may be able to find these with the `which -a` command (`which -a g++`), or you can ask your system administrator if another version is available.

Particularly with cluster systems, newer compiler version are often available through "modules" or "packages" which can be loaded and unloaded with commandline commands (e.g. `module load gcc_4.8` or `setpkg -a gcc_compiler_4.9.0`). Each cluster system has different mechanisms for loading packages. Consult the documentation for your cluster or talk to your cluster administrator to see which compilers are available on your system.

### Install a different compiler. (Good)

If all of the currently installed compilers are insufficient, the easiest course of action is to submit a request to your system administrator to install an updated compiler. The updated compiler need not be installed as the default compiler for the system. Installing as a module or in a non-default directory is also acceptable for use with Rosetta.

(NOTE: When submitting the request, be sure to mention the issue regarding standard library support, particularly if they are installing an updated version of Clang or ICC. Installation proceedures may need to be adjusted such that the appropriately updated standard library is also installed.)

### I can't get my system administrator to install a newer compiler (Okay)

Rosetta does not require that the compiler be installed in a central location. It is perfectly acceptable to install a compiler into your home directory. (Also, once the compiler is installed on one user's directory, other users with access to that directory can also use it. This way not every member of a lab needs to install the compiler.)

* GCC - the final installation directory can be specified with the `--prefix` option to the GCC configuration script.
* Clang - the final installation directory can be specified with the `-DCMAKE_INSTALL_PREFIX` option to the CMake command during compilation. - Note that the latest versions of Clang also require quite new compilers to install. You may wish to install version 3.3 or 3.4.2 instead

Again, having a compiler of the appropriate version is insufficient - you need to install it in such a way it has full C++11 library support too.

#### Installing pre-compiled compiler binaries (Might work, might not)

Clang provides pre-compiled binaries of it's compiler for certain systems. [Download page](http://llvm.org/releases/download.html) Some of these pre-compiled version have libc++ installed, although some do not. (Look for output from the command `find <clang_directory> -name 'cstddef'` and from `find <clang_directory> -name '*libc++*'`) You may need to use the compiler from one download and the standard library from another.

To determine which distribution and operating system you're working with, try running the command `sw_vers; lsb_release -a; uname -a; cat /etc/*release; cat /etc/*version; cat /proc/version;` You may need to "translate" one distribution/version into a related version. (e.g. Linux Mint is based on Ubuntu; CentOS, Scientific Linux, and Red Hat are related to Fedora, etc.)

### Installation of any compiler is not possible on the system (Okay)

If you cannot (or do not want to) install a newer compiler on a system, there is always the possibility of compiling Rosetta statically on another (similar) machine, and then copy the compiled programs and database to the new computer.

Add "extras=static" to the scons commandline to build the static version of Rosetta. 

Specifying the use of a non-default compiler
-------------------------------------------

If you're compiling with Scons, you need to adjust your user.settings file.

Copy rosetta/main/source/tools/build/user.settings.template to rosetta/main/source/tools/build/user.settings

To specify a non-default compiler, you will need to override the cxx and cc settings

```
        "overrides" : {
                "cxx" : "/home/user/downloaded_clang/bin/clang++",
                "cc" : "/home/user/downloaded_clang/bin/clang",
        },
```

Your compiler may or may not be able to locate the associated standard library. (GCC and system-installed clang versions tend to be fine with this, pre-compiled clang versions definitely need assistance.) If it is not found automatically, you'll need to add the path to the libraries in the prepends block.

```
        "prepends" : {
                "include_path" : ["/home/user/downloaded_clang/include/c++/v1/", ],
                "library_path" : ["/home/user/downloaded_clang/lib/"],
                "flags" : {
                        "link" : ["Wl,-rpath=/home/user/downloaded_clang/lib/"]
                }
        },
```

The include_path directory is where files like `cstddef` are located. The library_path and link directories are where files like libc++.so or libstdc++.so are found.