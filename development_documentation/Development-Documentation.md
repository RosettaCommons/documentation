#Development Documentation

##Developing for Rosetta

- [[Rosetta overview]] - Explanations of key concepts in Rosetta.
- [[Glossary]] - Brief definitions of Rosetta-related terms
- [[Doxygen tips]] - How to work with Rosetta's in-code documentation.
- [[Writing an app]] - How to write your own Rosetta-based application.
- [[Making rosetta robust for running on large number of inputs|robust]]

##Where is the documentation for the various Rosetta libraries?
The documentation for the various libraries is a bit scattered.  Here is a partially-complete list:

**Internal libraries:**

- Publicly available [Doxygen code documentation](https://www.rosettacommons.org/manuals/latest/main/) describing the interface to Rosetta objects and functions
- Historical version of the documentation, including both user manual and code documentation.
    - The [Rosetta 3.5 user manual](https://www.rosettacommons.org/manuals/archive/rosetta3.5_user_guide/), with documentation for the core and protocols libraries; curiously, this lacks RosettaScripts documentation
    - The [Rosetta 3.4 user manual](https://www.rosettacommons.org/manuals/archive/rosetta3.4_user_guide/), with documentation for the core and protocols libraries and on RosettaScripts (an older version, for historical reference only)

<!--- BEGIN_INTERNAL -->
For RosettaCommons developers, we have a version of the Doxygen documentation which also includes code. (Password protected access).

- Doxygen documentation of [core and protocols](http://graylab.jhu.edu/Rosetta.Developer.Documentation/core+protocols/) (built frequently to reflect the latest commits to master)
- Doxygen documentation for the [basic, numeric, utility, and ObjexxFCL (Fortran compatibility) libraries](http://graylab.jhu.edu/Rosetta.Developer.Documentation/all_else/), (built frequently to reflect the latest commits to master)

<!--- END_INTERNAL -->

**External libraries:**

- [Boost 1.55.0 documentation](http://www.boost.org/doc/libs/1_55_0/) (a very useful library intended to extend the standard C++ libraries with frequently-needed functionality)
- [The Eigen library](http://eigen.tuxfamily.org/dox/) (used for linear algebra, matrix manipulations, Eigenvector problems, etc.)
- [DAlphaBall](https://simtk.org/project/xml/downloads.xml?group_id=212) information and references (but no documentation), which is used in Rosetta's holes score term


##Code organization

| [[/images/rosetta_code_mindmap.png]]<br /> A general scheme of Rosetta source code organization<br /> Large size file (poster size) can be downloaded [from here](http://bioshell.pl/~bioshell/rosetta_code_mindmap.jpg)|  
|-----------|

- [[Rosetta library structure]] - Overview of how the Rosetta library is structured.
- [[src index page]] - Overview of the src directory.

- [[Namespace core|src-index-page#core]]
    * [[Namespace core::chemical|Namespace core-chemical]]
    * [[Namespace core::conformation|Namespace core-conformation]]
        * [[Namespace core::conformation::idealization|Namespace core-conformation-idealization]]
    * [[Namespace core::io::pdb|Namespace core-io-pdb]]
    * [[Namespace core::scoring|Namespace core-scoring]]
    * [[Namespace core::fragments|namespace-core-fragments]]
- [[Namespace utility]]
    * [[Namespace utility::factory|Namespace utility-factory]]
    * [[Namespace utility::io|Namespace utility-io]]
    * [[Namespace utility::keys|Namespace utility-keys]]
    * [[Namespace utility::options|Namespace utility-options]]
- [[Namespace numeric]]
- [[Namespace objexxFCL]]

##Rosetta style guidelines

- [[How to use pointers correctly]] - Working with Rosetta's smart pointer system.
- [[A note on parsing residue selections in movers and filters]] -- Using the residue selection parsing system to detect Rosetta numbering, PDB numbering, or ReferencePose numbering.

##Using particular classes

- [[Owning pointers]] - Rosetta's shared-ownership intrusive reference counted smart pointer.  Currently implemented using boost::shared_ptr.
    * [[Access pointers]] - An "owning pointer" which doesn't take ownership.
- [[Vector1]] - Rosetta's 1-based indexing vector class.
    * [[Vector0]] - A 0-based indexing version of vector1.
    * [[VectorL]] - The generalized L-based indexing vector, from which vector1 and vector0 are derived.
- [[Tracer]] - Using the tracer output class.

- [[Hbonds]] - Dealing with the Hbond energy terms.
- [[namespace-core-fragments]] - Using the classed located in src/core/fragments/

- [[xyzVector]] - A vector specialized for Cartesian coordinate use.

- [[xyzMatrix]] - A 3x3 matrix class specialized for Cartesian coordinate use.


##How to extend Rosetta

- [[New energy method]] - How to add a new energy term.
- [[Resfile reader]] - How to extend the resfile reader.
- [[Multithreading]] - How to add support for multithreading.

##Testing changes

###See the 

- [[Rosetta tests]] - A guide to running and writing tests for Rosetta
- [[Run unit test]] - How to run the unit tests.
- [[Write unit test|writing-unit-tests]] - Writing unit tests.
- [[UTracer]] - How to use the UTracer tool in writing unit tests
- [[Mover test]] - How to write a unit test for a mover.  
- [[Integration tests]]
- [[Scientific Benchmarks]] - How to create and run scientific tests

## Visualization Tools

- [[PyMOL]] Resources for visualizing Rosetta simulations in PyMol
- [[Extending the PyMol Viewer]] Extending the PyMol Mover to add additional visualization features during Rosetta simulations

##See Also

* [[Common Errors]]: Common errors seen when compiling Rosetta and how to fix them.
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[RosettaScripts]]: Wiki page for RosettaScripts, the Rosetta XML interface
* [[PyRosetta]]: Wiki page for PyRosetta, the independent Python interface to Rosetta
* [[Rosetta Timeline]]: History of Rosetta
* [[Getting Started]]: A page for people new to Rosetta
* [[Build Documentation]]: Information on building Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables
