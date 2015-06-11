#An overview of the src directory

From a conceptual standpoint, the src directory contains all the C++ code specfic to Rosetta. The directory structure within Rosetta delineates conceptual dependencies. A Rosetta developer should keep in mind the layered architecture depicted in the figure below. The arrows represent allowed dependency flows. Any code dependency on directories not accessible by following the arrows is not allowed. A strict vertical code dependency has been observed thus far in writing Rosetta code. Historically lateral independence within sub directories has not been required, however recent design decisions have identified this as a goal. Consequently, the figure below should be updated to display those dependencies as they are achieved.


[[/images/RosettaLib.png]]


ObjexxFCL Library
================

The `ObjexxFCL` library provides the infrastructure needed to emulate Fortran by code that has been translated from Fortran 77 to C++. It is heavily used in Rosetta at present, but will gradually disappear as Rosetta becomes more object-oriented.

Utility Library
==============

[[Utility Library|namespace-utility]] 


The utility directory contains utility classes that are (at least in theory) not Rosetta-specific such as [[utility::vector1|vector1]] (a base 1 indexed of child class of std::vector with a few extra additions) and izstream (an infilestream which allows reading of zipped files).  Broadly speaking, these classes are implemented in a project-agnostic manner (i.e. they need not be Rosetta-specific).  Classes in this directory sometimes have mathematical class methods, but algorithms for complicated calculations are typically relegated to the numeric directory.

###Namespaces within utility
* [[utility|namespace-utility]]
* [[utility::io|namespace-utility-io]]
* [[utility::factory|namespace-utility-factory]] **NO LONGER EXISTS**
* [[utility::keys|namespace-utility-keys]]
* [[utility::options|namespace-utility-options]]

###Useful classes within utility
* [[Owning pointer|owning-pointers]]
* [[Access pointer|access-pointers]]
* Classes derived from std::vector
  * [[vector0]]
  * [[vector1]]
  * [[vectorL]]
* [[xyzVector]]
* [[xyzMatrix]]

Numeric Library
===============

[[Numeric Library|namespace-numeric]]

The numeric directory contains low-level functions that carry out mathematical operations.  While some of these might be general mathematics (calculating a fast Fourier transform, for example, or performing principal component analysis on a dataset), others might be Rosetta-specific calculations or might be implemented in a Rosetta-specific manner.


Basic Library
=================

The basic directory contains organizational and housekeeping classes specific to the Rosetta project.  Functions for accessing the Rosetta database typically reside here, for example, as does code for the Rosetta options system.  Certain Rosetta-specific tools, such as the [[tracer]], can also be found in the basic library.

Core Library <a name="core" />
============

[[/images/core_structure.png]]

The core directory contains classes that manage most of the internal machinery of Rosetta. This includes topics such as chemical representations of models, conformational representations of models, low-level operations on conformations, and energetic evaluation ([[scoring|scoring-explained]]) of models.

TODO: Steven, could you provide a description of roughly what falls into each of these levels?

###Namespace documentation (incomplete)

* [[core::chemical|namespace-core-chemical]]
* [[core::conformation|namespace-core-conformation]]
  * [[core::conformation::idealization|namespace-core-conformation-idealization]] **NO LONGER EXISTS**
* [[core::io::pdb|namespace-core-io-pdb]]
* [[core::scoring|namespace-core-scoring]]

###Readmes, Tutorials and Reference Documents for the Core Library

For a general overview of Rosetta concepts (including many concepts from core), please see the [[Rosetta overview]] page.

- chemical
    - [[Description of chemical|Rosetta-overview#chemical]]
- conformation
    - [[Description of conformation|Rosetta-overview#conformation]]
    - [[Symmetry]]
- pose
    - [[Brief description of pose|Rosetta-overview#pose]]
- kinematics
    - [[AtomTree overview and concepts|atomtree-overview]]
    - [[FoldTree overview and concepts|foldtree-overview]]
- optimization
    - [[Minimization overview and concepts|minimization-overview]]
- pack
    - [[How to use the PackerTask|packer-task]]
    - [[Resfile syntax and conventions|resfiles]]
    - [[How to write new resfile commands|resfile-reader]]
- scoring
    - [[Explanation of scoring in Rosetta|scoring-explained]]
    - [[Score types]]
      * [[Additional score types|score-types-additional]]
    - [[How to add a new scoring term|new-energy-method]]
    - [[Constraints file formats|constraint-file]]
 




Protocols Library
=================

[[/images/protocols_structure.png]]

The protocols directory contains higher level code which makes use of the core directory components to accomplish modeling tasks. The code in this directory should be in a state such that it is useable by a general audience (Please provide adequate documentation for all code placed in this directory). One of the main base classes to be aware of is the Mover class. This class is the interface class from which most Rosetta developers inherit when creating new modeling protocols. Most developers will interface with the Rosetta code at this level unless they need to extend the model representation capabilities of Rosetta.

Like the core directory, the protocols directory has been split into several library levels, with code in each level only allowed to depend on the levels below it. 

Development Library
===================

devel\_index\_page The devel directory is a staging area for protocols. Essential code in this area is not considered mature. Standards of documentation are lax (Note though that documenting code after the fact is much more difficult, so it is HIGHLY recommended that a developer provide good documentation even for code that is fluctuating rapidly. It will make your life easier and more productive, and your colleagues will appreciate your thoroughness). Code in this library is not included in Rosetta releases.

Adding New Directories in "top level" of src **(Don't do it!)**
============================================

New directories in the "top level" of src should only be added after consulting with the general community. New directories indicate that the design of the suite of libraries is insufficient. Design decisions affect the entire community. Hence, input from the community should be solicited. Once a decision has been reached, add a new section to this page explaining the place of the new directory in relation to the rest of the code. 

Adding New Subdirectories
=========================

New subdirectories in one of the above existing directories can be added much more readily without damaging the overall structure of the library. First determine which level of the library the new concepts fit into. If one is unsure of where new code should be placed, consult experienced Rosetta developers. This can either be in one's lab or (even better) send a message out to the developer mailing list (One might find out that someone else has a complimentary idea with a starting point already available).

##See Also

* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page