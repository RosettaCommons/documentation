#numeric::xyzVector Class Reference

Detailed Description
--------------------

xyzVector is a fast 3 coordinate ( x, y, z ) vector template class. Functions are inlined and loop-free for optimal speed. The destructor is declared non-virtual for speed so xyzVector is not set up for use as a base class. As a template class, xyzVector can hold various value types.

Forward declarations and typedefs for common value types are provided in the file xyzVector.fwd.hh. This header should be included in files that only use the names of the xyzVector types (e.g., function declarations and functions that just pass the types through to other functions by pointer or reference).

Common operations that are normally coded in loops are provided and include:

normalize()

normalize\_or\_zero() - Zero xyzVector if length is zero

normalize\_any() - Arbitrary normalized xyzVector if length is zero

project\_normal() - Project normally onto input xyzVector

project\_parallel() - Project in direction of input xyzVector

distance() - Distance between two xyzVectors

distance\_squared() - Distance squared between two xyzVectors

dot(), dot\_product(), inner\_product() - dot or inner product of two xyzVectors

cross(), cross\_product() - cross product of two xyzVectors

midpoint() - midpoint between two xyzVectors.

Many operations also have 'ed' versions; e.g., normalize() and normalized() which do not modify the xyzVector , but generates an xyzVector .

Additionally, the header xyz\_functions.hh contains common functions that interact with xyzVector such as:

product() - [[xyzMatrix]] * xyzVector product

inplace\_product() - [[xyzMatrix]] * xyzVector product, input xyzVector is modified

outer\_product() - xyzVector * xyzVector outer product

projection\_matrix() - projection matrix onto the line through an xyzVector

dihedral() - dihedral (torsion) angle with respect to four positions in a chain

rotation\_matrix() - rotation matrix about a helical axis through the origin through an angle

rotation\_axis() - transformation from rotation matrix to helical axis of rotation

eigenvalue\_jacobi() - classic Jacobi algorithm for the eigenvalues of a real symmetric matrix

eigenvector\_jacobi() - classic Jacobi algorithm for the eigenvalues and eigenvectors of a real symmetric matrix
