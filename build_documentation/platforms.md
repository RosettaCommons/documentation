Supported Platforms
===================

Rosetta should be able to be able to be built on most modern Linux and Mac systems.
Development of Rosetta happens by a number of different people on a wide variety of systems,
therefore, many of the up-to-date configurations have been tested by developers.
We are aware that user's ability to update compilers on clusters is limited, and therefore
endevor to keep Rosetta compatible with most systems in common use.

At this point we do not have a list of officially supported platforms. 
Instead, below are listed some of the configurations used by the Rosetta developer community.
Omission from this list is not a statement that Rosetta will not run on that platform,
merely that it is a configuration that is not actively tested. 

Testing server configuration
------------------------------

The following is the configuration of the internal testing servers.
All released have been validated to run on these systems.

(As of May 2015)

- CentOS 7.0 and 7.1
  - clang 3.4
  - gcc 4.8

- Ubuntu 12.04 "Precise Pangolin"
  - gcc 4.6

- MacOS 10.9.5 "Mavericks" (Darwin 13.4)
  - clang 6.0 (LLVM version 3.5)


Developer machine configurations
--------------------------------

The following systems are used by the Rosetta development community,  
either during the development of Rosetta or for cluster runs.

(As of May 2015)

- MacOS X.9 ("Mavericks") & X.10 ("Yosemite")
    - clang 4.1 (llvm 3.1), 6.1(llvm 3.6) 

- CentOS 4.5 to 7.0
    - gcc 4.4 to 4.8
    - clang 3.3 to 3.4
    - icc 10 to 14

- Redhat Enterprise Linux 6.4
    - gcc 4.7
    - icc 11 to 15

- Scientific Linux 
    - gcc 4.4
    - clang 3.4

- Ubuntu 12.04, 14.04, and 15.04
    - gcc 4.4 to 4.9
    - clang 3.0 to 3.6

- Debian
    - gcc 4.7 to 4.9
    - clang 3.5  

Known unsupported configurations
--------------------------------

The following systems are known not to work with Rosetta,
and are unlikely to be made to do so in the forseeable future.

- Windows
    - Compilation of Rosetta on all versions of Windows is unsupported.

##See Also

* [[Getting Started]]: A page for people new to Rosetta
* [[Build Documentation]]: Instructions for building Rosetta
* [[TACC]]: Information for running Rosetta on the TACC/Stampede cluster.
* [[Rosetta Servers]]: Web-based servers for Rosetta applications