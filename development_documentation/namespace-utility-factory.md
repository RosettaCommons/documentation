<!-- --- title: Namespaceutility 1 1Factory -->utility::factory Namespace Reference

A pluggable class factory system. [More...](#details)

Detailed Description
--------------------

A pluggable class factory system.

For each abstract product type the factory can create objects of its concrete subtypes that have registered with the factory. The type to be created is selected by passing a key of a registered type to the factory's create function.

The abstract product class controls the types of the key, the returned pointer (so a smart pointer with ownership semantics like [[utility::pointer::owning_ptr|owning-pointers]] can be used if desired), and the signature of the creation function that the factory calls.

Registration is easily performed by defining objects of the Registrant class template, either as static members or namespace objects that are defined at program startup. The Registrant has constructors accepting key and creation function pointer pairs with types defined by abstract product typedefs. The creation functions must be static member functions or global functions.

The factory supports registration of pointers to the keys so that global keys that might not yet be constructed can be registered. The keys are automatically moved to the non-pointer registry before any use of the registry.

Due to the limitations of the C++ linker mechanism the registrant objects defined in sources in a static library are not linked to an application unless something else in the object file is needed. For this reason the registrant definitions should be included into a file that is known to be needed by all applications that would need to use the factory: if this is not possible then they should be directly linked to the application and not placed in a library. A different mechanism would be needed for dynamic libraries that would be platform specific and is not supported here.
