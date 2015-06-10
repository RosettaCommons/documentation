#How to write new resfile commands

Author: Steven Lewis

This page describes how to add new commands to the resfile in Rosetta. A command is an object with a method that will make changes to the PackerTask for ONE single residue at a time.

The resfile reader parses each record into whitespace-delimited chunks of information, and attempts to match them against a group of available commands (which must be known at compile time). It then passes the necessary information to an instantiation of a command object, which applies whatever the command is supposed to do.

In coding details, the interfaces are as follows:

-   Command objects should be declared in ResfileReader.hh and inherit from the ResfileCommand class at the top of that file. Implementation probably ought to reside in ResfileReader.cc.
-   The command MUST be added to create\_command\_map in ResfileReader.cc. This map connects the input strings to actual commands.
-   Any command can be interpreted as a default command, for almost-all residues, or a command specific to a residue. The commands will not be able to discriminate whether they are working on a default line or not and should only work on one residue at a time.
-   The object should have (at least) two methods:
    -   name() returns a string, which must EXACTLY MATCH the string you want to use for the command in the resfile (like "NATAA"). This is the map key for the command\_map.
    -   residue\_action, which takes four arguments:
        -   a vector1 of strings (the tokenized line of input from the resfile)
        -   a Size (integer...) which is a position in the input line
        -   a reference to the PackerTask it operates on
        -   another Size, which is the residue position it operates on.

-   Command objects should treat the input line as constant. They should increment the input line position as appropriate (++ once to account for the name itself, ++ again for each argument read and "used up").

Of course, the resfile only exists to modify the PackerTask. You will also have to modify the PackerTask\_, or some child class, to include the set functions and data members you wish to modify.

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Resfiles]]: Resfile syntax and conventions
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.

