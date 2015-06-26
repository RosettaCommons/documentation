#List of things you should check in your code before merging to master

Overview
========

This is Guideline reflect our current policy for core/protocols/devel libraries and unit test code. Make sure you check thing below before merging code to master.

Source code

**NOTE**: It is now recommended that all significant changes be submitted as [[pull requests]]. All of the recommendations below still apply.

-   It is expected that submitted code will be at least briefly documented. Use 'brief' doxygen comment tag for .hh files and 'details' tag for .cc file code documentation. Application documentation should be placed in this wiki (See the [[How to write documentation]] page for details).
-   In general you should not use C++ standard 'float' type, - use core::Real instead.
-   Do not commit code containing direct output to std::cout/cerr streams in to core/protocols/devel libraries or unit test. Use core::util::Tracer instead.
    -   *Unless* you are planning to terminate program abnormally (i.e utility\_exit(...)) because of the hard error. In that case you can can use cerr output to provide additional information for your error messages.

-   Use tabs rather than spaces for indentation and remove trailing whitespace. Also make sure you follow the other [[Coding Conventions]] such as removing "using" statements from header files.

Building

-   Test your build before committing it. (Replace '-j8' with number appropriate for your system, i.e. number of processors).
    -   Test library build. Execute 'scons -j8'.
    -   Test Unit test build is compiling. Execute 'scons -j8 cat=test' and make sure everything is compiling.
    -   Test bin and pilot\_apps\_all build. Execute 'scons -j8 bin pilot\_apps\_all'.

-   Make sure that everything is compiling and your modification did not produce any compilation warnings.

Unit test

-   [[Run unit test]] *before* committing any code, and make sure that your modifications did not break any tests.

-   If your changes break tests, fix them after insuring that the results are correct. If you can't fix some of the test or aren't sure if results correct, contact the developer responsible for this test and ask for help.

Integration Test

-   Run the [[integration tests]] *before* committing any code.
Note that your code should be compared to the results of running the integration tests on the same revision of the code without your changes. As with unit tests, consults other developers if the results of the tests don't match.

After commit

* Compile an independent version of Rosetta (e.g. on a different machine or in a different directory) to ensure that it compiles and runs properly. This is especially important if you have added a file because if you do not remember to add it using git, it may be available only in your copy of Rosetta.

Additional information about our current coding guideline can be found [[here|Coding-Conventions]]

Information on Commenting Guidelines (TODO: How do you even get access to this page?): [[https://www.rosettacommons.org/internal/doc/Rosetta++CommentingGuidelines.html]]

##See Also

* [[Pull requests]]
* [[GithubWorkflow]]
* [[RosettaAcademy]]
* [[Development documentation]]

