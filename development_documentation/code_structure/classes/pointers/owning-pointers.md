#Owning pointers

*For guidelines on using owning and access pointers or smart pointers, please see the [[how to use pointers correctly]] page.*

Owning pointers, or smart pointers, are pointers that retain knowledge of how many live pointers there are to their contained object.
This has two purposes.
First, the pointed-to object won't be deleted unless all owning pointers are deleted (preventing segfaults).
Second, the pointed-to object will be deleted automatically if all owning pointers to it are deleted (preventing memory leaks).

This page once hosted documentation on Rosetta's deprecated [[ReferenceCount]] based smart pointer system.

##See Also

* [[Access pointer|access-pointers]]
* [[How to use pointers correctly]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[ReferenceCount]]: Formerly used for owning and access pointers (now deprecated)
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page