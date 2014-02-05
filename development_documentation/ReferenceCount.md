#utility::pointer::ReferenceCount Class Reference

Detailed Description
--------------------

ReferenceCount is a base class for intrusive reference-counted classes that is designed to work with [[owning_ptr|owning-pointers]] . A class that inherits from ReferenceCount gets the machinery for shared-ownership management by [[owning_ptr|owning-pointers]] . Having the root class of a single inheritance hierarchy inherit from ReferenceCount makes all of the classes in its hierarchy compatible with [[owning_ptr|owning-pointers]] .

ReferenceCount can also be used in a multiple inheritance hierarchy if the root class using virtual inheritance for ReferenceCount (to avoid multiple instances of the counter if the inheritance hierarchy has diamond-shaped inheritance relationships). Because ReferenceCount is not a pure interface class it is not suitable for use in a Decorator pattern hierarchy because multiple copies of the counter would be present: [[ReferenceCountMI]] should be used in those situations.
