#Access pointers

*For guidelines on using owning and access pointers or smart pointers, please see the [[how to use pointers correctly]] page.*

Access pointers (access_ptr) are part of a smart pointer system.  access_ptr is a simple pointer wrapper that you can't (directly) delete that is meant for pointing to access objects that are not owned. access_ptr objects can be stored in STL containers and are as small and as fast as raw pointers. Deletion of the wrapped pointer is still possible so this is not bulletproof against determined misuse.

This page once hosted documentation on Rosetta's deprecated [[ReferenceCount]] based smart pointer system.

##See Also

* [[Owning pointer|owning-pointers]]
* [[How to use pointers correctly]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[ReferenceCount]]: Formerly used for owning and access pointers (now deprecated)
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page