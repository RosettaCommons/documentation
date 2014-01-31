<!-- --- title: Classnumeric 1 1Xyz Vector -->numeric::xyzVector Class Reference

Detailed Description
--------------------

[u'xyzVector'] is a fast 3 coordinate ( x, y, z ) vector template class. Functions are inlined and loop-free for optimal speed. The destructor is declared non-virtual for speed so [u'xyzVector'] is not set up for use as a base class. As a template class, [u'xyzVector'] can hold various value types.

Forward declarations and typedefs for common value types are provided in the file xyzVector.fwd.hh. This header should be included in files that only use the names of the [u'xyzVector'] types (e.g., function declarations and functions that just pass the types through to other functions by pointer or reference).

Common operations that are normally coded in loops are provided and include:

normalize()

normalize\_or\_zero() - Zero [u'xyzVector'] if length is zero

normalize\_any() - Arbitrary normalized [u'xyzVector'] if length is zero

project\_normal() - Project normally onto input [u'xyzVector']

project\_parallel() - Project in direction of input [u'xyzVector']

distance() - Distance between two xyzVectors

distance\_squared() - Distance squared between two xyzVectors

dot(), dot\_product(), inner\_product() - dot or inner product of two xyzVectors

cross(), cross\_product() - cross product of two xyzVectors

midpoint() - midpoint between two xyzVectors.

Many operations also have 'ed' versions; e.g., normalize() and normalized() which do not modify the [u'xyzVector'] , but generates an [u'xyzVector'] .

Additionally, the header xyz\_functions.hh contains common functions that interact with [u'xyzVector'] such as:

product() - <xyzMatrix> [u'xyzVector'] product

inplace\_product() - <xyzMatrix> [u'xyzVector'] product, input [u'xyzVector'] is modified

outer\_product() - [u'xyzVector'] [u'xyzVector'] outer product

projection\_matrix() - projection matrix onto the line through an [u'xyzVector']

dihedral() - dihedral (torsion) angle with respect to four positions in a chain

rotation\_matrix() - rotation matrix about a helical axis through the origin through an angle

rotation\_axis() - transformation from rotation matrix to helical axis of rotation

eigenvalue\_jacobi() - classic Jacobi algorithm for the eigenvalues of a real symmetric matrix

eigenvector\_jacobi() - classic Jacobi algorithm for the eigenvalues and eigenvectors of a real symmetric matrix

* * * * *

The documentation for this class was generated from the following file:

-   doc/numeric/ [[xyzVector.dox|xyz-vector-8dox]]

