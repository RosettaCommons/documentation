#numeric::xyzVector Class Reference

Detailed Description
--------------------

xyzVector is a fast 3 coordinate ( x, y, z ) vector template class. Functions are inlined and loop-free for optimal speed. The destructor is declared non-virtual for speed so xyzVector is not set up for use as a base class. As a template class, xyzVector can hold various value types.

Forward declarations and typedefs for common value types are provided in the file xyzVector.fwd.hh. This header should be included in files that only use the names of the xyzVector types (e.g., function declarations and functions that just pass the types through to other functions by pointer or reference).

Common operations that are normally coded in loops are provided and include:
```
normalize()

normalize_or_zero() - Zero xyzVector if length is zero

normalize_any() - Arbitrary normalized xyzVector if length is zero

project_normal() - Project normally onto input xyzVector

project_parallel() - Project in direction of input xyzVector

distance() - Distance between two xyzVectors

distance_squared() - Distance squared between two xyzVectors

dot(), dot_product(), inner_product() - dot or inner product of two xyzVectors

cross(), cross_product() - cross product of two xyzVectors

midpoint() - midpoint between two xyzVectors.
```

Many operations also have 'ed' versions; e.g., `normalize()` and `normalized()` which do not modify the xyzVector, but generate an xyzVector.

Additionally, the header xyz\_functions.hh contains common functions that interact with xyzVector such as:

```
product() - xyzMatrix * xyzVector product

inplace_product() - xyzMatrix * xyzVector product, input xyzVector is modified

outer_product() - xyzVector * xyzVector outer product

projection_matrix() - projection matrix onto the line through an xyzVector

dihedral() - dihedral (torsion) angle with respect to four positions in a chain

rotation_matrix() - rotation matrix about a helical axis through the origin through an angle

rotation_axis() - transformation from rotation matrix to helical axis of rotation

eigenvalue_jacobi() - classic Jacobi algorithm for the eigenvalues of a real symmetric matrix

eigenvector_jacobi() - classic Jacobi algorithm for the eigenvalues and eigenvectors of a real symmetric matrix
```

##Usage

1.  To use the xyzVector types in a function, you would normally put a `using` declaration at the top of the function and then use the short typedef name to declare the objects:

   ```
   void
   f()
   {
          using numeric::xyzVector_double;

          xyzVector_double r; // Default constructed (uninitialized)
          xyzVector_double s( 0.0 ); // Constructs s = ( 0.0, 0.0, 0.0 )
          xyzVector_double t( 1.0, 2.0, 3.0 ); // Constructs t = ( 1.0, 2.0, 3.0 )

          ...
          t.x() = 1.5; // Elements can be accessed as x(), y(), and z()
   }
   ```

2.  You can also construct a xyzVector from the address of the first value in a contiguous data structure like an FArray or std::vector:


   ```
          xyzVector_double const pos_ij( &position(1,i,j) ); // position(1-3,i,j)
   ```

   You can use xyzVector in loops by accessing the elements by index:

   ```
          v( i ); // For i = 1, 2, 3   (1-based indexing for xyzVector )
          v[ i ]; // For i = 0, 1, 2   (0-based indexing for xyzVector )
   ```

##See Also

* [[Utility namespace documentation|namespace-utility]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page