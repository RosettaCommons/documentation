#Loops File


Application purpose
===========================================

Loop definitions are used to identify the residues in a loop for [[loop modeling|loopmodel]].

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

Residue numbers in loop definition files use _Rosetta numbering_, not PDB numbering.

Example
=======

For Example: A legal line in a loops file (the line by itself is a legal file):

```
LOOP 23 30 26
```
Loop from residues 23-30 with the cutpoint at 26.

Name
====

Rosetta's `-loop_file` flag (and others) are just taking a file name or file path, so any name is fine as long as you specify it.  For example:

```
my_protein.loops 
loopsfile
loop_file
top7.loops
loops.txt
```


##See Also

* [[File types list]]: List of file types used in Rosetta
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Structure prediction applications]]: List of applications for structure prediction, including loop modeling applications
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Structure prediction applications]]: Contains links to several applications for loop modeling
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications

<!--
The purpose of this remaining text is to improve the searchability of this page: 
loops file 
loops file 
loops file 
loop file 
loop file 
loop file
loop file 
loop file 
loop file
loop file 
loop file 
loop file
//-->
