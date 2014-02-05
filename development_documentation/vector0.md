#utility::vector0 Class Reference

Detailed Description
--------------------

vector0 is [[vectorL]] with the lower index set to 0. Since this is the same lower index as std::vector the main purpose for vector0 is to obtain the bounds checking in operator[] in debug builds.

 Note   
-   std::vector with assert-checked bounds in operator[] and a few extras
-   Can construct and assign from std::vector and swap with std::vector
-   Can compare with std::vector
-   Can explicitly convert to std::vector
-   Public inheritance from concrete [[vectorL]] template is safe here