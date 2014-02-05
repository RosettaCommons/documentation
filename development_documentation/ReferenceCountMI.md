#utility::pointer::ReferenceCountMI Class Reference

Detailed Description
--------------------

ReferenceCountMI is a pure interface base class for multiple inheritance Decorator pattern hierarchies needing reference counting.

To use ReferenceCountMI the root class in the hierarchy should inherit from it virtually and the concrete classes should inherit from the ReferenceCountMI\_ implementation.