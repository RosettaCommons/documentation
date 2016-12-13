Supported Platforms
===================

Rosetta should be able to be able to be built on most modern Linux and Mac systems with a C++11-compatible compiler.
(See [[Cxx11Support]] for more details.)
Development of Rosetta happens by a number of different people on a wide variety of systems,
therefore, many of the up-to-date configurations have been tested by developers.
We are aware that user's ability to update compilers on clusters is limited, and therefore
endeavor to keep Rosetta compatible with most systems in common use.

At this point we do not have a list of officially supported platforms. 
Instead, below are listed some of the configurations used by the Rosetta developer community.
Omission from this list is not a statement that Rosetta will not run on that platform,
merely that it is a configuration that is not actively tested. 

Testing server configuration
------------------------------

The following is the configuration of the internal testing servers.
All releases have been validated to run on these systems.

(As of Jan 2016)

- CentOS 7.0 and 7.1
  - gcc 4.8.2 and 4.8.3
  - clang 3.4.2

- Ubuntu 14.04 "Trusty Tahr"
  - gcc 4.8

- MacOS 10.10.5 "Yosemite" (Darwin 14.5)
  - clang 7.0 (Apple version numbering) 

Developer machine configurations
--------------------------------

The following systems are used by the Rosetta development community,  
either during the development of Rosetta or for cluster runs.

(As of Jan 2016)

- MacOS X.9 ("Mavericks") & X.10 ("Yosemite")
    - clang 6.1 (llvm 3.6)

- CentOS 4.7 to 7.0
    - gcc 4.8
    - clang 3.3 to 3.4
    - icc 14 to 16

- Redhat Enterprise Linux 6.4
    - gcc 4.8
    - icc 14 to 15

- Scientific Linux 
    - clang 3.4

- Ubuntu 12.04, 14.04, and 15.04
    - gcc 4.8 to 4.9
    - clang 3.3 to 3.6

- Debian
    - gcc 4.8 to 4.9
    - clang 3.5  

Known unsupported configurations
--------------------------------

The following systems are known not to work with Rosetta,
and are unlikely to be made to do so in the foreseeable future.

Workarounds may be possible in extreme cases, but it is likely easier
to update to a more well supported platform/system.

- Windows
    - Compilation of Rosetta on all versions of Windows is unsupported.

- Compilers with insufficient C++11 support
    - GCC version 4.7 and before
    - Clang version 3.2 and before
    - Intel compiler (ICC) version 13 and before
    - (List is not exhaustive)

Note: The compiler version number is insufficient to determine compiler compatibility,
as C++11 compatible compilers may be using an older C++ standard library.
To assist in checking for compatibility, we have put together a small Python test script,
downloadable from <https://raw.githubusercontent.com/RosettaCommons/rosetta_clone_tools/master/rosetta_compiler_test.py>

Note: Even if the default compiler is a version without support, often there will be an updated compiler available on the system.
Talk to your system administrator for more details, and see [the build documentation](Build-Documentation#setting-up-rosetta-3_alternative-setup-for-individual-workstations_scons-mac-linux) 
for compiling with a non-default compiler.
In worse-case scenarios, the weekly releases of Rosetta 2015.39 and before may be compatible with older compilers.

##See Also

* [[Getting Started]]: A page for people new to Rosetta
* [[Build Documentation]]: Instructions for building Rosetta
* [[Scons Overview and Specifics]]: Advanced details on the Scons build system
* [[TACC]]: Information for running Rosetta on the TACC/Stampede cluster.
* [[Rosetta Servers]]: Web-based servers for Rosetta applications

