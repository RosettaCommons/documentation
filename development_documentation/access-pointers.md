<!-- --- title: Classutility 1 1Pointer 1 1Access  Ptr -->utility::pointer::access\_ptr Class Reference

Detailed Description
--------------------

[u'access\_ptr'] is a simple pointer wrapper that you can't (directly) delete that is meant for pointing to access objects that are not owned. [u'access\_ptr'] objects can be stored in STL containers and are as small and as fast as raw pointers. Deletion of the wrapped pointer is still possible so this is not bulletproof against determined misuse.

 Remarks   

The object pointed to by [u'access\_ptr'] need not be allocated on the heap since [u'access\_ptr'] never deletes the object it points to.

Pointers to const objects: access\_ptr\< Type const \>

-   Can create pointers to const objects
-   This allows construction from a temporary giving undefined behavior but this is true of all C++ smart pointers

Virtual functions shouldn't return [u'access\_ptr'] because, like all template-based smart pointers, it doesn't support covariant return types but raw pointer return values can be assigned to [u'access\_ptr'] .

Casts: The cast functions are merely a convenience for [u'access\_ptr'] (unlike for non-intrusive shared ownership pointers) so for:

access\_ptr\< Base \> pB( new Derived() );

the cast:

dynamic\_pointer\_cast\< Derived \>( pB );

is equivalent to:

access\_ptr\< Derived \>( dynamic\_cast\< Derived \* \>( pB() ) );

* * * * *

The documentation for this class was generated from the following file:

-   doc/utility/pointer/ [[access_ptr.dox|access--ptr-8dox]]

