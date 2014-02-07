#A Guide to Developing in Rosetta

Metadata
========

Author: Kristian Kaufmann

last modified: 11/08/2008

This guide is under construction. Some of the pages are pretty useful others still need a lot of work.

Overview
========

This guide is written to introduce a new developer to useful tools and expected practices while developing Rosetta. This guide does not provide instruction on programming in C++. See other sources for guidance in learning C++. This guide walks the reader through

-   Using subversion the version control system
-   Navigating the Rosetta library structure
-   Writing a simple application and documenting the code using Doxygen.
-   Documenting with Doxygen
-   Compiling the Rosetta library and application using SCons
-   Running and Writing Unit, Integration, Performance, and Scientific Tests
-   Procedures for successfully checkin in your code without breaking the build or Unit and Integration tests.

Using subversion the version control system
===========================================

**We no longer use Subversion**

A Guide to Using Subversion on the Command Line included in this manual contains a subset of these commands introduced in an order which might be needed for a new developer. Subversion is a widely used easy to leard version control system. For an in depth view into subversion see the subversion manual online at [http://svnbook.red-bean.com](http://svnbook.red-bean.com) . Several svn clients have been developed including some very easy to use graphical user interfaces see [http://subversion.tigris.org/links.html\#clients](http://subversion.tigris.org/links.html#clients) . The RosettaWiki https://wiki.rosettacommons.org/index.php/Tools:Subversion contains an extensive page on using subversion with several examples for many subversion commands.

Navigating the Rosetta library structure
========================================

The rosetta library contains five top level directories of which every developer should be aware. More detailed descriptions of each of these directories can be found on [[A Guide to the Structure of the Rosetta Library|rosetta-library-structure]] and subsequently links.

-   src/ The src directory contains all the source files for the rosetta library.
-   test/ The test directory contains source files and scripts for unit, integration, and scientific tests used to verify that the rosetta library is functioning correctly.
-   bin/ The bin directory contains soft links to all the rosetta applications.
-   tools/ The tools directory contains the files for the custom SCons Builder for the rosetta library.
-   demo/ The demo directory is intended to contains files for running test case or demo of particular applications.

Writing a simple application and documenting the code using Doxygen.
====================================================================

One of the main design goals of Rosetta is that writing new applications and extension of existing protocols be easy. This section is intended to show a developer how to write new application with a new protocol. The reader will be taken through the process

-   writing a new Mover
-   writing a new application using the Job Distributor and the new Mover.

After reading the page [[Writing a Rosetta Application|writing-an-app]] the reader should be able to write their own Rosetta application.

Documenting with Doxygen
========================

Rosetta uses Doxygen to produce documentation. [[Tips for writing doxygen documentation|doxygen-tips]] provides useful information for making the most of Doxygen

Compiling the Rosetta library and application using SCons
=========================================================

[[A Guide to Using SCons to Build Rosetta|Build-Documentation]] demonstrates some simple features of the build system followed by a more detailed discussion of the build system structure and how it can be extended. Rosetta uses a custom SCons builder. The builder allows multiple build configurations.

Running and Writing Unit, Integration, Performance, and Scientific Tests
========================================================================

[[A Guide to Running and Writing Tests for Rosetta|rosetta-tests]] takes the reader through the running each of these test sets and writing of a test in each of these categories. Rosetta has 4 sets of tests. Unit tests check particular functions of the Rosetta library. Integration tests track behavior of applications one individual cases. Performance tests monitor speed of Rosetta applications. Scientific tests monitor the behavior of Rosetta applications on a larger scale than Integration tests and with scientifically defined objectives.

Procedures for successfully checkin in your code without breaking the build or Unit and Integration tests.
==========================================================================================================

The linked page is very terse but basically accurate. It will be expanded overtime. [[List of things you should check in your code before committing it in to svn|before-commit-check]] is intended to show the reader steps that minimize the chance of a commit breaking the build or tests. Commiting your code to the trunk of Rosetta can be a perilous process almost every Rosetta developer that I know has commited code that broke Rosetta at one time or another.
