# PyRosetta

PyRosetta is an interactive Python-based interface to Rosetta, allowing users to create custom molecular modeling algorithms with Rosetta sampling and scoring functions using Python scripting. PyRosetta was written for Python 2.6.

PyRosetta is availible as a seperate download (independent of C++ Rosetta). See <http://www.pyrosetta.org/> for more details.

More extensive PyRosetta-specific documentation is availible:
* <http://www.pyrosetta.org/documentation> - The main PyRosetta documentation page (thorough, but not too helpful for beginners)
* <http://www.pyrosetta.org/faq> - Frequently asked questions about PyRosetta
* <http://www.pyrosetta.org/tutorials> - Tutorials on how to use PyRosetta (best to dive in here)
* <http://www.pyrosetta.org/scripts> - Example scripts using PyRosetta (somewhat useful)
* <http://www.pyrosetta.org/home/what-is-pyrosetta> - Brief, general overview of PyRosetta
* <http://www.pyrosetta.org/dow> - Link to download PyRosetta, installation instructions at the bottom of page.

A general overview of the general Rosetta object structure and organization can be found here: http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4083816/

## Quick Start Guide for Linux/OS X
Note: Python 2.6 or better is required. Works with Python 2.7, but not Python 3.

1. Obtain a [[license|http://c4c.uwc4c.com/express_license_technologies/pyrosetta]] for PyRosetta.
2a. Download a copy of PyRosetta from [[here|http://www.pyrosetta.org/dow]].
2b. Extract said copy with `$ tar -vjxf PyRosetta-<version>.tar.bz2`. Everything to run PyRosetta is contained within this directory.
2c. Alternatively, if you have a RosettaCommons GitHub account, you can checkout a PyRosetta repository (updated weekly) by running `$ git clone http://login@git-repository-address`. For example, to get the OS X namespace (see below) build one would run `$ git clone http://login@graylab.jhu.edu/download/PyRosetta/git/release/PyRosetta.namespace.mac.release.git`.
3. From within the main PyRosetta directory, run `$ source SetPyRosettaEnvironment.sh` or append it to your .bashrc file and source that.
4. Test your PyRosetta installation by running the line `import rosetta; rosetta.init()` in PyRosetta. Output should be about the PyRosetta version and random seed.
    - Exiting the PyRosetta prior to running Python should help avoid path issues or confirm that your path is properly set.

## The PyRosetta Toolkit

The [[PyRosetta Toolkit GUI]] is a graphical frontend to PyRosetta written in Python.  A Tutorial and overview of the code base and how to extend it for your own uses can be found [[here | PyRosetta Toolkit]]
