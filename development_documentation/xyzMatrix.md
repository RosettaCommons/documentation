<!-- --- title: Classnumeric 1 1Xyz Matrix -->numeric::xyzMatrix Class Reference

Detailed Description
--------------------

[u'xyzMatrix'] is a fast 3x3 matrix template class. Functions are inlined and loop-free for optimal speed. The destructor is declared non-virtual for speed so [u'xyzMatrix'] is not set up for use as a base class. As a template class, [u'xyzMatrix'] can hold various value types.

Forward declarations and typedefs for common value types are provided in the file xyzMatrix.fwd.hh. This header should be included in files that only use the names of the [u'xyzMatrix'] types (e.g., function declarations and functions that just pass the types through to other functions by pointer or reference).

Common operations that are normally coded in loops are provided and include:

right\_multiply\_by() - Multiply on the right by an [u'xyzMatrix']

right\_multiply\_by\_transpose() - Multiply on the right by the transpose of an [u'xyzMatrix']

left\_multiply\_by() - Multiply on the left by an [u'xyzMatrix']

left\_multiply\_by\_transpose() - Multiply on the left by the transpose of an [u'xyzMatrix']

det() - Determinant

trace() - Trace

transpose() - Transpose

transposed() - Transposed copy

NOte that tranpose() and transposed() follow the library convention that the 'ed' version does not modify the [u'xyzMatrix'] , but generates an [u'xyzMatrix'] .

[u'xyzMatrix'] offers a number of construction methods including several column or row oriented methods: from nine elements, from pointer(s) to contiguous values, or from three xyzVectors.

Additionally, the header xyz\_functions.hh contains common functions that interact with [u'xyzMatrix'] such as:

product() - [u'xyzMatrix'] <xyzVector> product

inplace\_product() - [u'xyzMatrix'] <xyzVector> product, input <xyzVector> is modified

outer\_product() - <xyzVector> <xyzVector> outer product

projection\_matrix() - projection matrix onto the line through an <xyzVector>

rotation\_matrix() - rotation matrix about a helical axis through the origin through an angle

rotation\_axis() - transformation from rotation matrix to helical axis of rotation

eigenvalue\_jacobi() - classic Jacobi algorithm for the eigenvalues of a real symmetric matrix

eigenvector\_jacobi() - classic Jacobi algorithm for the eigenvalues and eigenvectors of a real symmetric matrix

* * * * *

The documentation for this class was generated from the following file:

-   doc/numeric/ [[xyzMatrix.dox|xyz-matrix-8dox]]

