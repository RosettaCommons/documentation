#xyzMatrix Example

1.  To use the xyzMatrix types in a function you would normally put a using declaration at the top of the function and then use the short typedef name to declare the objects:

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

    You can use [[numeric::xyzMatrix|xyzMatrix]] in loops by accessing the elements by index:

    ```
         m( i, j ); // For rows i = 1, 2, 3 and columns j = 1, 2, 3
                    // (1-based indexing for xyzMatrix )
    ```

2.  You can construct a [[numeric::xyzMatrix|xyzMatrix]] from nine values representing the entries of the matrix.

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

3.  You can construct a [[numeric::xyzMatrix|xyzMatrix]] from the address of the first value in a contiguous data structure like an FArray or std::vector.

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

4.  You can construct a [[numeric::xyzMatrix|xyzMatrix]] from three addresses, each pointing to the first value in a contiguous data structure like an FArray or std::vector.

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