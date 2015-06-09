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
