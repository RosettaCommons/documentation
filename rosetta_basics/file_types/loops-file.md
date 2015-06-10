#Loops File

Name
====

Any name is fine as long as you specify the correct file name in the command lines. For Example:

```
*.loops 
```

Application purpose
===========================================

Loop definitions are used to identify the residues in a loop. See: The -loops, the -loop\_file, and many others.

File Format
======

```
column1  "LOOP":     Literally the string LOOP, identifying this line as a loop
                     In the future loop specification files may take other data.
column2  "integer":  Loop start residue number
column3  "integer":  Loop end residue number
column4  "integer":  Cut point residue number, >=startRes, <=endRes. Default or 0: let LoopRebuild choose cutpoint randomly.
column5  "float":    Skip rate. default - never skip
column6  "boolean":  Extend loop. Default false
```

Example
=======

For Example: A legal line in a loops file (the line by itself is a legal file):

```
LOOP 23 30 26
```
Loop from residues 23-30 with the cutpoint at 26.


##See Also

* [[File types list]]: List of file types used in Rosetta
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Structure prediction applications]]: List of applications for structure prediction, including loop modeling applications
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications