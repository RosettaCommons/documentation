#Rosetta-scripts XML file testing application, "parse_rosetta_script"

Metadata
========

This document was created September 2017 by Andrew Leaver-Fay. The `parse_rosetta_script` application is maintained by Brian Kuhlman's lab. Send questions to (bkuhlman@email.unc.edu)

Code and Demo
=============

The "entry-point" code for the `parse_rosetta_script` application lives in `src/protocols/rosetta_scripts/RosettaScriptsParser.cc`, however, it relies on the schemas defined by hundreds of Movers, Filters, ResidueSelectors, TaskOperations, etc that are distributed throughout the code base.

A demo for the use of this application lives in the Rosetta/rosetta_scripts_scripts/testing/parse_all_scripts.py -- this script will run the parse_rosetta_script
application against all of the scripts listed in Rosetta/rosetta_scripts_scripts/scripts_to_parse.py

References
==========

The original rosetta_scripts paper was published in the following paper:

Fleishman, Sarel J., et al. "RosettaScripts: a scripting language interface to the Rosetta macromolecular modeling suite." PloS one 6.6 (2011): e20161.


Application purpose
===========================================

The purpose of this application is to test an XML script written for the rosetta_scripts application to ensure that it
is valid according to Rosetta's internally-generated XML Schema and to then test if all of the objects that are defined
within this XML script can be constructed -- in particular, if all of their ```parse_my_tag``` methods succeed. If the
script passes these two tests, then the application will print a brief success message and exit with a 0 exit status --
if either steps fail, it will print any error message that had been generated, and exit with a non-zero exit status.

Algorithm
=========

The script loads in the XML file, expanding all xi:include tags that it encounters, and replacing all script-vars variables
that it finds. It constructs the schema for rosetta_scripts and validates the input XML file against the schema. If this step
succeeds, then it constructs all of the Mover/Filter/ResidueSelector/ScoreFunction/TaskOperation/etc. objects that are specified
in the XML file and calls all of their parse-my-tag / parse-tag methods.

Limitations
===========

This application does not execute a rosetta script, it merely verifies that it could be executed.

In the case of the MultiplePoseMover, where an entire protocol is embedded beneath the `<MultiplePoseMover...>` tag, the
construction of the embedded Movers/Filters/etc. does not take place until the MultiplePoseMover's `apply` method is invoked.
This script does not invoke the `apply` method of any Mover, and so it cannot guarantee that the embedded Movers/Filters/etc.
can be correctly instantiated. It will, at least, ensure that the embedded Movers/Filters/etc. are valid according to
Rosetta's internally-generated schema.

Input Files
===========

The principle input files for this application are XML files. One XML file may include another XML file using an `<xi:include href="filename">` tag.
This allows you to reuse elements in multiple scripts withut duplication.

In addition to the input XML files, the Movers/Filters/etc. which are created as a result of tags in those XML files, may also read from input files.
Some of these Movers/Filters/etc. will read from the input files during the parse-my-tag / parse-tag functions that are invoked, but many delay
the file read until their `apply` function is called. In this application, their `apply` functions are not called.


Options
=======

There are two principle command-line arguments to use with rosetta_scripts and rosetta-scripts-like applications (such as this one)

```
-parser:protocol <xml-filename>                         The script that will be read and whose tags will be turned into Rosetta objects 
-parser:script_vars <ws-sep-varname-equals-value-pairs> The input XML file(s) may contain variables that can then be replaced with other
                                                        values from the command line. These variables should be enclosed in double % symbols.
                                                        E.g. <SomeTag value="%%myvariable%%"/>. The variable in the previous XML element named
                                                        myvariable can be replaced with a particular value, e.g. 10.3 by having the script_vars
                                                        flag on the command line: --parser:script_vars myvariable=10.3
                                                        You may have as many variables as you would like; each variable should be separated by
                                                        whitespace (i.e. the ws-sep part; it is white-space-separated). The variable name an
                                                        the value you wish to assign should be separated by an equals sign. Valid variable names
                                                        include any alpha-numeric strings and may contain underscores; they should not contain
                                                        consecutive percent symbols. Alternatively, you may include the script_vars option multiple
                                                        times on the command line, giving a different variable=value pair for each instance.

```

There are many other flags that this application and that other rosetta-scripts-related applications will use as the objects that they
construct are initialized. (In general, we frown on objects that are initialized using rosetta_scripts from accessing the command line,
but not all developers have been careful in ensuring that their Movers/Filters/etc. avoid using the command line.)

Tips
====

You can use the `-parser:info <tag-name>` option with the rosetta_scripts application to print out XML-schema information
and associated documentation text for a particular Tag with the requested tag-name if you find that one Mover/Filter/etc.
is not parsing.

Expected Outputs
================

Exits with a brief success message if the input script can be parsed and with a zero exit status;
exits with a detailed error message and a non-zero exit status otherwise.

Post Processing
===============

No post-processing 