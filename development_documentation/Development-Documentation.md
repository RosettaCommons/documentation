#Development Documentation

##Developing for Rosetta

- [[Rosetta overview]]
- [[Using Git]] - Basic steps to working with git and committing code 
- [[Doxygen tips]] - How to work with Rosetta's in-code documentation.
- [[Writing an app]] - How to write your own Rosetta-based application.
- [[Packer Task]] - Controlling which side chains can vary during rotamer optimization 
- [[Making rosetta robust for running on large number of inputs|robust]]

##Where is the documentation for the various Rosetta libraries?
The documentation for the various libraries is a bit scattered.  Here is a partially-complete list:

**Internal libraries:**
- [Doxygen documentation of core and protocols, for developers (built frequently to reflect the latest commits to master)](http://graylab.jhu.edu/Rosetta.Developer.Documentation/core+protocols/)
- [Doxygen documentation for the basic, numeric, utility, and ObjexxFCL (Fortran compatibility) libraries, for developers (built frequently to reflect the latest commits to master)](http://graylab.jhu.edu/Rosetta.Developer.Documentation/all_else/)
- [The Rosetta 3.5 user manual, with documentation for the core and protocols libraries (not the latest version available to developers); curiously, this lacks RosettaScripts documentation](https://www.rosettacommons.org/manuals/archive/rosetta3.5_user_guide/)
- [The Rosetta 3.4 user manual, with documentation for the core and protocols libraries and on RosettaScripts (an older version, for historical reference only)](https://www.rosettacommons.org/manuals/archive/rosetta3.4_user_guide/)

**External libraries:**

- [Boost 1.55.0 documentation (a very useful library intended to extend the standard C++ libraries with frequently-needed functionality)](http://www.boost.org/doc/libs/1_55_0/)
- [The Eigen library (used for linear algebra, matrix manipulations, Eigenvector problems, etc.)](http://eigen.tuxfamily.org/dox/)
- [Information and references (but no documentation) about DAlphaBall (used in Rosetta's holes score term)](https://simtk.org/project/xml/downloads.xml?group_id=212)


##Code organization
- [[Rosetta library structure]] - Overview of how the Rosetta library is structured.
- [[src index page]] - Overview of the src directory.

- [[Namespace core]]
    * [[Namespace core::chemical|Namespace core-chemical]]
    * [[Namespace core::conformation|Namespace core-conformation]]
        * [[Namespace core::conformation::idealization|Namespace core-conformation-idealization]]
    * [[Namespace core::io::pdb|Namespace core-io-pdb]]
    * [[Namespace core::scoring|Namespace core-scoring]]
- [[Namespace utility]]
    * [[Namespace utility::factory|Namespace utility-factory]]
    * [[Namespace utility::io|Namespace utility-io]]
    * [[Namespace utility::keys|Namespace utility-keys]]
    * [[Namespace utility::options|Namespace utility-options]]
- [[Namespace numeric]]
- [[Namespace objexxFCL]]

##Rosetta style guidelines

- [[Owning pointer usage guidlines]] - Working with Rosetta's smart pointer system.

##Using particular classes - Some of this documention may be out of date.

- [[Owning pointers]] - Rosetta's shared-ownership intrusive reference counted smart pointer.
    * [[Access pointers]] - An "owning pointer" which doesn't take ownership.
    * [[ReferenceCount]] - How owning pointers are implemented.
    * [[ReferenceCountMI]] - ReferenceCount for multiple inheritance.
- [[Vector1]] - Rosetta's 1-based indexing vector class.
    * [[Vector0]] - A 0-based indexing version of vector1.
    * [[VectorL]] - The generalized L-based indexing vector, from which vector1 and vector0 are derived.
- [[Tracer]] - Using the tracer output class.

- [[Hbonds]] - Dealing with the Hbond energy terms.
- [[Directory-core-fragments]] - Using the classed located in src/core/fragments/

- [[xyzVector]] - A vector specialized for Cartesian coordinate use.
    * [[xyzVector example]]
- [[xyzMatrix]] - A 3x3 matrix class specialized for Cartesian coordinate use.
    * [[xyzMatrix example]]

##How to extend Rosetta

- [[New energy method]] - How to add a new energy term.
- [[Resfile reader]] - How to extend the resfile reader.

##Testing changes

- [[Rosetta tests]] - A guide to running and writing tests for Rosetta
- [[Run unit test]] - How to run the unit tests.
- [[Write unit test|test]] - Writing unit tests.
- [[UTracer]] - How to use the UTracer tool in writing unit tests
- [[Mover test]] - How to write a unit test for a mover.  
- [[Scientific test]] - How to create and run scientific tests