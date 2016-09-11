#ReferenceCount

ReferenceCount was the core class in the smart pointer system that Rosetta3 used up until 2015. 
Nearly every class in Rosetta ultimately inherits from this class - by that measure it is our most important class. 
Luki Goldschmidt transitioned us to a [[newer smart pointer system|development_documentation/tutorials/How-to-use-pointers-correctly]], which obviated the purpose of the old ReferenceCount as the holder class for the smart pointer system how-many-point-at-me variable.
The class remains as an empty class.
This is partly because, as the ultimate inheritance root of almost all classes, it was too hard to remove. 
It offers a remaining benefit to the Pose DataCache, as a common reference point for all classes that can be put into said DataCache.

#See Also
* [[Owning pointer|owning-pointers]]
* [[Access pointers]]
* [[How to use pointers correctly]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page

<!--- search optimization
ReferenceCount
ReferenceCount
ReferenceCount
--->