
##Developing for Rosetta

- [[Rosetta overview|mini-overview]]
- [[Doxygen tips]] - How to work with Rosetta's in-code documentation.
- [[Writing an app]] - How to write your own Rosetta-based application.

##Organization overview.
- [[Rosetta library structure]] - Overview of how the Rosetta library is structured.
- [[src index page]] - Overview of the src directory.

- [[Namespace core]]
    * [[Namespace core-chemical]]
    * [[Namespace core-conformation]]
        * [[Namespace core-conformation-idealization]]
    * [[Namespace core-io-pdb]]
    * [[Namespace core-scoring]]
- [[Namespace utility]]
    * [[Namespace utility-factory]]
    * [[Namespace utility-io]]
    * [[Namespace utility-keys]]
    * [[Namespace utility-options]]
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
- [[U Tracer]] - How to use the UTracer tool in writing unit tests
- [[Mover test]] - How to write a unit test for a mover.  
- [[Scientific test]] - How to create and run scientific tests

##Internal development guides

- [[A guide to developing in Rosetta]] - Overview for developing in RosettaCommons.  
- [[Before commit check]] - Things to check before committing.  
- [[app-name]] - Application documentation page template.
    * [[template-app-documenation-page]] - Another application documentation template
- [[reviewertemplate]] -- How to review documentation.  



