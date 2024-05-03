# PyRosetta

PyRosetta is an interactive Python-based interface to Rosetta, allowing users to create custom molecular modeling algorithms with Rosetta sampling and scoring functions using Python scripting. PyRosetta was written for Python 2.6, while the newer PyRosetta-4 require Python-3

PyRosetta is available as a separate download (independent of C++ Rosetta). See <http://www.pyrosetta.org/> for more details.  If you are a developer, it can also be compiled from source.

[[_TOC_]]


## Installing and using PyRosetta-4
For details on how get and install PyRosetta-4 please consult our main web site at [http://www.pyrosetta.org](http://www.pyrosetta.org)

## [DEPRECATED] PyRosetta-3 ##
3. From within the main PyRosetta directory, run `$ source SetPyRosettaEnvironment.sh` or append it to your .bashrc file and source that.
4. Test your PyRosetta installation by running the line `import rosetta; rosetta.init()` in Python. Output should be about the PyRosetta version and random seed.
    - Exiting the PyRosetta directory prior to running Python should help avoid path issues or confirm that your path is properly set.


**PyRosetta-3 Namespace vs. monolith:** According to Sergey, in the namespace build each C++ namespace has its own shared library which the kernel needs to load, resolve symbols, and so on. 
Hence, importing in the namespace build is IO heavy, but memory light.
The monolith build on the other hand, has all the C++ namespaces defined in a single C++ library.
For example, importing rosetta (via PyRosetta) in the namespace build on Stampede (NFS with high latency) could take up to 20 minutes.
Doing the same with the monolith build would require about 7 seconds. 
The current recommendation is namespace for machines with memory constraints (e.g. less than 4 GB per thread) or for local development. 
For production runs on clusters (typically using the NSF filesystem), use monolith. 

**PyRosetta-4 Namespace vs monolith:** Monolith version is the only PyRosetta-4 version.  This monolith takes up a very small memory footprint as compared to PyRosetta-3 monolith version, as well as numerous other improvements.

<!--- BEGIN_INTERNAL -->

IMPORTANT: DEVELOPERS, PLEASE DO NOT ADD GENERAL PyRosetta documentation to sections above, all such documentation should be instead placed at PyRosetta.org to avoid syncing issues when code evolved.

## Building PyRosetta-4 from source

With the switch to C++11 in early September 2016, PyRosetta can now only be build with the PyRosetta-4 build scheme.

__Prerequisites__: You need to have Clang, CMake ( version > 2.8.12.2) and Ninja installed.

__To build PyRosetta__:

```
cd main/source/src/python/PyRosetta
python build.py -j8 --create-package path/to/package

cd `build.py --print-build-root`/setup
sudo python setup.py install
```
See [the Dev Wiki](https://wiki.rosettacommons.org/index.php/PyRosetta:build) for more.

__To build under Conda__:

To build under Conda, first create the environment you want to install the PyRosetta to, including the version of Python you wish to use. Then follow the instructions above. 

It may be that the build script needs help finding the Python include files and libraries ("Could not find requested Python version"). When that happens, you can specify the path to the build.py script

```
python build.py -j8 --python-include-dir ${CONDA_PREFIX}/include/python* --python-lib ${CONDA_PREFIX}/lib/python* --create-package path/to/package
```

Note that you don't need to run setup.py with sudo if your conda environment is a user-level install.

__Binding complex data-types to PyRosetta__

If you are running a PyRosetta script and encounter this error or similar, "TypeError: Unable to convert value to a Python type!" - it means that the PyRosetta build did not bind the specific type of variable you're trying to access.  This happens with complex data-structures that can hold other data-structures (such as a std::map, std::vector, std::list, utility::vector1, etc...).  The solution is to declare a `struct` that inherits from this complex data type within the namespace and header file they're used.  

For example, in `class FragmentStore` we have member variables of type `std::map<std::string, std::vector<numeric::Size>> int64_groups`, `std::map<std::string, std::vector<numeric::Real>> real_groups`, and `std::map<std::string, std::vector< std::vector<numeric::Real>>> realVector_groups`.  When accessing these variables using `fragment_store.int64_groups["Key"]` in PyRosetta we receive the above error. The fix is declaring the following outside the class, but within the `protocols::indexed_structure_store` namespace:

```
struct map_std_string_std_vector_unsigned_long_std_allocator_unsigned_long_t : public std::map<std::string, std::vector<numeric::Size> > {};
struct map_std_string_std_vector_double_std_allocator_double_t : public std::map<std::string, std::vector<numeric::Real> > {};
struct map_std_string_std_vector_std_vector_double_std_allocator_double_std_allocator_std_vector_double_std_allocator_double_t : public std::map<std::string, std::vector<std::vector<numeric::Real>> > {};
```

The PyRosetta script can now access and change those member variables in `FragmentStore`

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

Note that currently, the PyRosetta Toolkit and other published apps are only distributed with __PyRosetta-3__

##See Also

* [[PyRosetta Toolkit GUI]]: Information on the PyRosetta Toolkit user interface
* [[PyRosetta Toolkit Tutorial | PyRosetta Toolkit]]: Tutorials for using/modifying the PyRosetta Toolkit GUI
* [[PyMOL]]: More information on PyMOL
* [[Extending the PyMol Viewer]]: How to add new functionality to Rosetta's PyMOL Mover
* [[PyRosetta website (external)|http://www.pyrosetta.org]]