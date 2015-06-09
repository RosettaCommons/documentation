#rosetta::scoring Namespace Reference

Energy functions and scoring methods for computing acceptability of decoys.

Detailed Description
--------------------

Energy functions and scoring methods for computing acceptability of decoys.

The scoring layer contains the energy function objects (functors) and the scoring method functors that compute weighted sums of energies (scores). The energy and scoring functors live in Strategy pattern hierarchies with abstract interfaces to provide decoupling between their calling clients and the concrete methods, providing a "pluggable" design that makes the addition of new functions and the modification of existing functions simple and with a low recompilation burden.

The scoring layer is designed to depend on the conformation and chemical layers but not on optimization or any protocol-specific layers.
