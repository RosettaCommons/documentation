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

##See Also

* [[Utility namespace documentation|namespace-utility]]
* [[C++ std::vector documentation|http://www.cplusplus.com/reference/vector/vector/]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page