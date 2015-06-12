#numeric::xyzMatrix Class Reference

Detailed Description
--------------------

xyzMatrix is a fast 3x3 matrix template class. Functions are inlined and loop-free for optimal speed. The destructor is declared non-virtual for speed so xyzMatrix is not set up for use as a base class. As a template class, xyzMatrix can hold various value types.

Forward declarations and typedefs for common value types are provided in the file xyzMatrix.fwd.hh. This header should be included in files that only use the names of the xyzMatrix types (e.g., function declarations and functions that just pass the types through to other functions by pointer or reference).

Common operations that are normally coded in loops are provided and include:

right\_multiply\_by() - Multiply on the right by an xyzMatrix

right\_multiply\_by\_transpose() - Multiply on the right by the transpose of an xyzMatrix

left\_multiply\_by() - Multiply on the left by an xyzMatrix

left\_multiply\_by\_transpose() - Multiply on the left by the transpose of an xyzMatrix

det() - Determinant

trace() - Trace

transpose() - Transpose

transposed() - Transposed copy

Note that tranpose() and transposed() follow the library convention that the 'ed' version does not modify the xyzMatrix, but generates an xyzMatrix.

xyzMatrix offers a number of construction methods including several column or row oriented methods: from nine elements, from pointer(s) to contiguous values, or from three xyzVectors.

Additionally, the header xyz\_functions.hh contains common functions that interact with xyzMatrix such as:

product() - xyzMatrix * [[xyzVector]] product

inplace\_product() - xyzMatrix * [[xyzVector]] product, input [[xyzVector]] is modified

outer\_product() - [[xyzVector]] * [[xyzVector]] outer product

projection\_matrix() - projection matrix onto the line through an [[xyzVector]]

rotation\_matrix() - rotation matrix about a helical axis through the origin through an angle

rotation\_axis() - transformation from rotation matrix to helical axis of rotation

eigenvalue\_jacobi() - classic Jacobi algorithm for the eigenvalues of a real symmetric matrix

eigenvector\_jacobi() - classic Jacobi algorithm for the eigenvalues and eigenvectors of a real symmetric matrix

##Usage

1.  To use the xyzMatrix types in a function, you would normally put a `using` declaration at the top of the function and then use the short typedef name to declare the objects:

    ```
        void
        f()
        {
          using numeric::xyzMatrix_double;

         xyzMatrix_double m;        // Default constructed (uninitialized)
         xyzMatrix_double n( 0.0 ); // Constructs n = ( 0.0, 0.0, 0.0
                                                        0.0, 0.0, 0.0
                                                        0.0, 0.0, 0.0 )

         ...
         n.xx() = 1.5; // Elements can be accessed as xx(), xy(), xz(),
                                                      yx(), yy(), yz()
                                                      zx(), zy(), and zz()
        }
    ```

    Additionally, the columns and rows of an xyzMatrix can be accessed or assigned by name or by 1-based index:

    ```
        col_x(), col_y(), col_z(), col( i ) i = 1, 2, 3;
        row_x(), row_y(), row_z(), row( i ) i = 1, 2, 3;
    ```

    You can use numeric::xyzMatrix in loops by accessing the elements by index:

    ```
         m( i, j ); // For rows i = 1, 2, 3 and columns j = 1, 2, 3
                    // (1-based indexing for xyzMatrix )
    ```

2.  You can construct a numeric::xyzMatrix from nine values representing the entries of the matrix.

    Note that orientation of the elements is specified by a named constructor:

    ```
         // Construction from column-ordered values:
         xyzMatrix_double m( xyzMatrix_double::cols( xx_a, yx_a, zx_a,
                                                     xy_a, yy_a, zy_a,
                                                     xz_a, yz_a, zz_a ) )

         // Assignment from column-ordered values:
         xyzMatrix_double m;
         ...
         m = xyzMatrix_double::cols( xx_a, yx_a, zx_a,
                                     xy_a, yy_a, zy_a,
                                     xz_a, yz_a, zz_a );

         // Construction from row-ordered values:
         xyzMatrix_double m( xyzMatrix_double::rows( xx_a, yx_a, zx_a,
                                                     xy_a, yy_a, zy_a,
                                                     xz_a, yz_a, zz_a ) )

         // Assignment from row-ordered values:
         xyzMatrix_double m;
         ...
         m = xyzMatrix_double::rows( xx_a, yx_a, zx_a,
                                     xy_a, yy_a, zy_a,
                                     xz_a, yz_a, zz_a );
    ```

3.  You can construct a numeric::xyzMatrix from the address of the first value in a contiguous data structure like an FArray or std::vector.

    Note that orientation of the elements is specified by a named constructor:

    ```
        // Construction from a pointer to contiguous column-ordered values:
        xyzMatrix_double m( xyzMatrix_double::cols( pointer ) );

        // Assignment from a pointer to contiguous column-ordered values:
        xyzMatrix_double m;
         ...
        m = xyzMatrix_double::cols( pointer );

        // Construction from a pointer to contiguous row-ordered values:
        xyzMatrix_double m( xyzMatrix_double::rows( pointer ) );

        // Assignment from a pointer to contiguous row-ordered values:
        xyzMatrix_double m;
        ...
        m = xyzMatrix_double::rows( pointer );

    ```

4.  You can construct a numeric::xyzMatrix from three addresses, each pointing to the first value in a contiguous data structure like an FArray or std::vector.

    Note that orientation of the elements is specified by a named constructor:

    ```
         // Construction from three pointers to contiguous columns:
         xyzMatrix_double m( xyzMatrix_double::cols( pointer, pointer, pointer ) );

         // Assignment from three pointers to contiguous columns:
         xyzMatrix_double m;
         ...
         m = xyzMatrix_double::rows( pointer, pointer, pointer );

         // Construction from three pointers to contiguous rows:
         xyzMatrix_double m( xyzMatrix_double::cols( pointer, pointer, pointer ) );

         // Assignment from three pointers to contiguous rows:
         xyzMatrix_double m;
         ...
         m = xyzMatrix_double::rows( pointer, pointer, pointer );
    ```


##See Also

* [[Utility namespace documentation|namespace-utility]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page