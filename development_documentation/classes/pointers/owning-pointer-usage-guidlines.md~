#Owning Pointer Usage Guidelines

Overview
========

This is Guideline how to chose between Owning Pointer (OP) and 'const &' coding styles. Use this document to decide on type of class data member / function arguments.

Current official style/usage of 'OP' and 'const &' styles:

-   Use OPs where objects passed into a different object which will retain partial ownership
-   Use references (&) where objects are passed and going to be modified
-   Use const references where objects are passed and not going to be modified

To decide which data type is appropriate for you function/class consider following questions:

-   Class:
    1.  Will instance of you class own this data? i.e: is data life spawn exactly as a life spawn of class instance itself? In later case you probably do not need OP for you data member.
    2.  Does you class holding 'someone else data', i.e. 'referencing' it? If this so, then it is likely that appropriate type for you data is OP.


