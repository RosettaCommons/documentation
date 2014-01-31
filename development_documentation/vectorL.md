<!-- --- title: Classutility 1 1Vector L -->utility::vectorL Class Reference

Detailed Description
--------------------

[u'vectorL'] is a class template that behaves identically to std::vector except that its elements are indexed from the value of the first template argument up instead of from 0. [u'vectorL'] is intended for use in place of std::vector in domains where 0-based indexing isn't natural.

[u'vectorL'] is meant to be a container like std::vector but with different element names (indexes). Taking the container point of view as dominant over the indexing distinction [u'vectorL'] was written to interoperate with std::vector in a number of ways:

-   You can (explicitly) construct a [u'vectorL'] from a std::vector
-   You can assign a [u'vectorL'] from a std::vector
-   You can explicitly convert a [u'vectorL'] to a reference to a std::vector
-   You can swap the contents of a [u'vectorL'] with a std::vector in constant time
-   You can compare a [u'vectorL'] with a std::vector
-   Elements are assigned and compared from the beginning of each container to the end, not by corresponding index number.

[u'vectorL'] automatically uses a signed index type when the lower index is negative and an unsigned index type otherwise. This means that when the lower index is negative that maximum possible index is reduced by approximately half due to the range of signed size types.

 Remarks   

The vectorL-based vectors may show a small performance penalty compared with std::vector due to the need to subtract the lower index from the specified index when indexing into the std::vector base object. In testing this has been found to be minimal when detectable.

Unlike std::vector the indexing operator[] will check for out of bounds errors in debug builds.

vector0.fwd.hh and vector1.fwd.hh provide typedefs for common value types.

vectorL.hh includes vectorL\_bool.hh which has the bool specialization (with all the same oddities as std::vector\< bool \>), and the analogous specializations are provided for <vector1> and <vector0> .

Use a.swap( b ) or swap( a, b ) or utility::swap( a, b ) to swap two vector1s or a <vector1> with a std::vector. std::swap( a, b ) will work but may be very slow if the std::swap overloads aren't supported on your compiler.

[u'vectorL'] inherits from std::vector. Although std::vector is not designed to serve as a base class this usage is safe because [u'vectorL'] has no additional data members.

 Note   
-   std::vector with L-based indexing and a few extras
-   Lower index must be in the range of ssize\_t
-   Index type is std::size\_t or ssize\_t depending on sign of L
-   When L is negative indexing operators can only reach the first max( ssize\_t ) element and attempting to index beyond that will trigger an assertion failure
-   Can construct and assign from std::vector and swap with std::vector
-   Can compare with std::vector: compares contents ignoring indexes
-   Can explicitly convert to std::vector
-   Private inheritance from std::vector is safe here

* * * * *

The documentation for this class was generated from the following file:

-   doc/utility/ [[vectorL.dox|vector-l-8dox]]

