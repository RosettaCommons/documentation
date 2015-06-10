#utility::pointer::owning\_ptr Class Reference

*For guidelines on using owning and access pointers, please see the [[how to use pointers correctly]] page.*

Detailed Description
--------------------

owning\_ptr is designed to be a shared-ownership intrusive reference counted smart pointer much like boost::intrusive\_ptr but with a few modifications.

Differences from intrusive\_ptr:

-   Construction and assignment from objects, not just pointers to them, is supported for syntactic flexibility.
-   Assignment operators use direct assignment and reference updating rather than the swap idiom that intrusive\_ptr uses for speed (about 2x faster) since we are not designing for recovery from exceptions in pointer assignment.
-   operator\< for owning\_ptr to pointer comparisons so you can use the address of a pointee as a lookup key.

 Remarks   

Ownership of the pointee object can be shared with intrusive\_ptr or other smart pointers that use the same reference counting mechanism in the object.

Pointers to const objects: owning\_ptr\< Type const \>

-   Can create pointers to const objects
-   This allows construction from a temporary giving undefined behavior but this is true of all C++ smart pointers

Virtual functions shouldn't return owning\_ptr because, like all template-based smart pointers, it doesn't support covariant return types but raw pointer return values can be assigned to owning\_ptr.

Casts: The cast functions are merely a convenience for owning\_ptr (unlike for non-intrusive shared ownership pointers) so for:

owning\_ptr\< Base \> pB( new Derived() );

the cast:

dynamic\_pointer\_cast\< Derived \>( pB );

is equivalent to:

owning\_ptr\< Derived \>( dynamic\_cast\< Derived \* \>( pB() ) );
