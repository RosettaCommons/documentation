#utility::pointer::access\_ptr Class Reference

*For guidelines on using owning and access pointers, please see the [[how to use pointers correctly]] page.*

Detailed Description
--------------------

access\_ptr is a simple pointer wrapper that you can't (directly) delete that is meant for pointing to access objects that are not owned. access\_ptr objects can be stored in STL containers and are as small and as fast as raw pointers. Deletion of the wrapped pointer is still possible so this is not bulletproof against determined misuse.

###Remarks   

The object pointed to by access\_ptr need not be allocated on the heap since access\_ptr never deletes the object it points to.

Pointers to const objects: access\_ptr\< Type const \>

-   Can create pointers to const objects
-   This allows construction from a temporary giving undefined behavior but this is true of all C++ smart pointers

Virtual functions shouldn't return access\_ptr because, like all template-based smart pointers, it doesn't support covariant return types but raw pointer return values can be assigned to access\_ptr.

Casts: The cast functions are merely a convenience for access\_ptr (unlike for non-intrusive shared ownership pointers) so for:

access\_ptr\< Base \> pB( new Derived() );

the cast:

dynamic\_pointer\_cast\< Derived \>( pB );

is equivalent to:

access\_ptr\< Derived \>( dynamic\_cast\< Derived \* \>( pB() ) );


##See Also

* [[Access pointer|access-pointers]]
* [[How to use pointers correctly]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page