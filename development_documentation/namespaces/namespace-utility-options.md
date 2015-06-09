#utility::options Namespace Reference

Program options system.

Detailed Description
--------------------

The utility::options package provides a system for representing and accessing the value of program options. This system is designed to have syntactic and type convenience and to be "pluggable", allowing optional modules to add their own options. Options are accessed by named keys (see the options::keys package) which provides a high level of type safety and fast lookup.

```
Introduction

Options are specified to applications in the usual ways with options entered
directly on the command line or in files specified on the command line:

  application -option1 -option2=value2
```
