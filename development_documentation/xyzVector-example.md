<!-- --- title:  2 Users 2Tjacobs2 2Workspace 2Documentation Conversion 2Doc 2Numeric 2Xyz Vector 8Dox-Example -->/Users/tjacobs2/workspace/documentation\_conversion/doc/numeric/xyzVector.dox

1.  To use the xyzVector types in a function you would normally put a using declaration at the top of the function and then use the short typedef name to declare the objects:

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

2.  You can also construct a [[numeric::xyzVector|xyzVector]] from the address of the first value in a contiguous data structure like an FArray or std::vector:

          xyzVector_double const pos_ij( &position(1,i,j) ); // position(1-3,i,j)

    You can use [[numeric::xyzVector|xyzVector]] in loops by accessing the elements by index:

          v( i ); // For i = 1, 2, 3   (1-based indexing for xyzVector )
          v[ i ]; // For i = 0, 1, 2   (0-based indexing for xyzVector )


