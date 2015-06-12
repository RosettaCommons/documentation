#utility::options Namespace Reference

Program options system.

Detailed Description
--------------------

The utility::options package provides a system for representing and accessing the value of program options. This system is designed to have syntactic and type convenience and to be "pluggable", allowing optional modules to add their own options. Options are accessed by named keys (see the options::keys package) which provides a high level of type safety and fast lookup.

**NOTE**: The actual options and option keys are found in the `basic::options` namespace. The `utility::options` namespace constitutes only the system itself.

Options are specified to applications in the usual way with options entered
directly on the command line or in files specified on the command line:
```
  application @flags_file -option1 -option2=value2
```

###Flags files <a name="flagsfile" />

The flags file (named flags_file in the above example) can contain any number of options specified in their typical syntax (e.g. `in::file::s example.pdb` ) with each option on a separate line. Alternatively, option namespaces can be nestedwithin namespaces as shown below with options in the same namespace having the same indentation level. For example, the following two sets of options would be equivalent:

```
-in::file::s example.pdb
-in::file::native native.pdb
-in::path::database path/to/Rosetta/database
-score::weights talaris2014
```

```
-in
   -file
      -s example.pdb
      -native native.pdb
   -path
      -database path/to/Rosetta/database
-score
   -weights talaris2014
```

It is also perfectly acceptable to mix the two styles in the same file. For example, the following file would also be equivalent:

```
-in
   -file
      -s example.pdb
      -native native.pdb
-score::weights talaris2014
-database path/to/Rosetta/database
```

##See Also

* [[Utility namespace|namespace-utility]]
  * [[utility::io|namespace-utility-io]]
  * [[utility::factory|namespace-utility-factory]] **NO LONGER EXISTS**
  * [[utility::keys|namespace-utility-keys]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page