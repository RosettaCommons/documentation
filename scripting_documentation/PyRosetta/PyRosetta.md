# PyRosetta

PyRosetta is an interactive Python-based interface to Rosetta, allowing users to create custom molecular modeling algorithms with Rosetta sampling and scoring functions using Python scripting. PyRosetta was written for Python 2.6, while the newer PyRosetta-4 also works with Python 3+

PyRosetta is available as a separate download (independent of C++ Rosetta). See <http://www.pyrosetta.org/> for more details.  If you are a developer, it can also be compiled from source.

[[_TOC_]]

## Quick Start Guide for Linux/OS X
Note: Python 2.6 or better is required. Python 3 now works with the [PyRosetta-4](http://www.pyrosetta.org/news/pyrosetta-4released) version of PyRosetta.


1. Obtain a [[license|http://c4c.uwc4c.com/express_license_technologies/pyrosetta]] for PyRosetta.
2. Either download a copy of PyRosetta or checkout the repository.
    1. Download a copy of PyRosetta from [[here|http://www.pyrosetta.org/dow]].
        - Extract said copy with `$ tar -vjxf PyRosetta-<version>.tar.bz2`. Everything to run PyRosetta is contained within this directory.
    2. Alternatively, if you have a RosettaCommons GitHub account, you can checkout a PyRosetta repository (updated weekly) by running `$ git clone http://login@git-repository-address`. For example, to get the OS X namespace (see below for monolith vs. namespace) build one would run: 
        ```
        $ git clone http://login@graylab.jhu.edu/download/PyRosetta/git/release/PyRosetta.namespace.mac.release.git
        ```

### PyRosetta-4 ###
3. From the main PyRosetta directory, run `python setup.py install`

4.  __Be aware that running PyRosetta is now different than for PyRosetta-3:  See below__.

 ```
 from rosetta import *
 from pyrosetta import *
 rosetta.init("-list -of -options")
 ```

### PyRosetta-3 ###
3. From within the main PyRosetta directory, run `$ source SetPyRosettaEnvironment.sh` or append it to your .bashrc file and source that.
4. Test your PyRosetta installation by running the line `import rosetta; rosetta.init()` in Python. Output should be about the PyRosetta version and random seed.
    - Exiting the PyRosetta directory prior to running Python should help avoid path issues or confirm that your path is properly set.

## Quick Start Guide for Windows
Note: Windows is seldom supported in the Rosetta community. Requires Python 2.7.

1. Obtain a [[license|http://c4c.uwc4c.com/express_license_technologies/pyrosetta]] for PyRosetta.
2. Download and unzip a copy of PyRosetta from [[here|http://www.pyrosetta.org/dow]].
3. Test your PyRosetta installation by running the line `import rosetta; rosetta.init()` in Python. Output should be about the PyRosetta version and random seed.

**PyRosetta-3 Namespace vs. monolith:** According to Sergey, in the namespace build each C++ namespace has its own shared library which the kernel needs to load, resolve symbols, and so on. 
Hence, importing in the namespace build is IO heavy, but memory light.
The monolith build on the other hand, has all the C++ namespaces defined in a single C++ library.
For example, importing rosetta (via PyRosetta) in the namespace build on Stampede (NFS with high latency) could take up to 20 minutes.
Doing the same with the monolith build would require about 7 seconds. 
The current recommendation is namespace for machines with memory constraints (e.g. less than 4 GB per thread) or for local development. 
For production runs on clusters (typically using the NSF filesystem), use monolith. 

**PyRosetta-4 Namespace vs monolith:** Monolith version is the only PyRosetta-4 version.  This monolith takes up a very small memory footprint as compared to PyRosetta-3 monolith version, as well as numerous other improvements.

<!--- BEGIN_INTERNAL -->

## Building PyRosetta-4 from source

With the switch to C++11 in early September 2016, PyRosetta can now only be build with the PyRosetta-4 build scheme.

__Prerequisites__: You need to have Clang, CMake ( version > 2.8.12.2) and Ninja installed.

__To build PyRosetta__:

```
cd main/source/src/python/PyRosetta
./build.py -j8 --create-package path/to/package
python3 build.py -j8 --create-package path/to/package

cd `build.py --print-build-root`/build
python setup.py install
```
See [the Dev Wiki](https://wiki.rosettacommons.org/index.php/PyRosetta:build) for more.

##Locations for PyRosetta applications

### PyRosetta-4 ###
Unknown at this time.

### PyRosetta-3 ###
Rosetta developers creating new PyRosetta applications should place any public apps in `main/source/src/python/bindings/app/` so that they will be packaged and distributed with PyRosetta. These public apps should also have accompanying integration tests. Private scripts should be placed in `main/source/scripts/pyrosetta/pilot/<user_name>`. 

<!--- END_INTERNAL -->

##Additional Documentation
More extensive PyRosetta-specific documentation is available:
* <http://www.pyrosetta.org/documentation> - The main PyRosetta documentation page (thorough, but not too helpful for beginners)
* <http://www.pyrosetta.org/faq> - Frequently asked questions about PyRosetta
* <http://www.pyrosetta.org/tutorials> - Tutorials on how to use PyRosetta (**best to dive in here**)
* <http://www.pyrosetta.org/scripts> - Example scripts using PyRosetta (somewhat useful)
* <http://www.pyrosetta.org/home/what-is-pyrosetta> - Brief, general overview of PyRosetta
* <http://www.pyrosetta.org/dow> - Link to download PyRosetta, installation instructions at the bottom of page.

A general overview of the general Rosetta object structure and organization can be found here: http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4083816/

## The PyRosetta Toolkit

The [[PyRosetta Toolkit GUI]] is a graphical frontend to PyRosetta written in Python.  A Tutorial and overview of the code base and how to extend it for your own uses can be found [[here | PyRosetta Toolkit]].

Note that currently, the PyRosetta Toolkit and other published apps only distributed with __PyRosetta-3__

##See Also

* [[PyRosetta Toolkit]]: Tutorials for using/modifying the PyRosetta Toolkit GUI
* [[PyRosetta Toolkit GUI]]: Information on the PyRosetta Toolkit user interface
* [[PyMOL]]: More information on PyMOL
* [[Extending the PyMol Viewer]]: How to add new functionality to Rosetta's PyMOL Mover
* [[PyRosetta website (external)|http://www.pyrosetta.org]]