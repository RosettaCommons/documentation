#Movemap file format

Metadata
========

This document was edited by Frank DiMaio on 5/11/2010.

Overview
========

Certain protocols (e.g. [[backrub]]) accept a user-specified movemap, that tells the algorithm what torsion angles and rigid-body degrees of freedom are allowed to move. For example, one may not want to move highly-conserved sidechains in modeling applications or preserve certain interactions in design applications. This document briefly describes the format used to specify these degrees of freedom.

File Formats
============

Each line in the movemap file identifies a jump, residue, or residue range, followed by the allowed degrees of freedom. These entities may be specified as follows:

```
RESIDUE r      # a single residue, 'r'
RESIDUE s t    # all residues s through t
JUMP k         # jump #k
```

For example:

```
RESIDUE 36 48 BBCHI  # set res 36-48 bb & chi movable
RESIDUE 89 NO        # set res 89 unmovable
JUMP 1 YES           # set jump 1 movable
```

Specifying a '\*' for the residue or jump number sets the default value:

```
RESIDUE * CHI        # set all residues chi movable
JUMP * NO            # set all jumps unmovable
```

Priority:

-   The allowed movement of specific residues always take priority over the defaults.
-   If a residue appears more than once, the last appearance in the file determines the allowed movement.

Setting 'CHI' implies BB not movable, thus don't do:

```
RESIDUE * CHI
RESIDUE * BB
```

Instead:

```
RESIDUE * BBCHI
```

Notes:

-   Residues are numbered with "Rosetta numbering": the first residue is \#1, resids are incremented across chains.
-   Using the default inputters, jump \#1 connects chains 1 and 2, jump \#2 connects chains 1 and 3, etc. However, protocols may (and often do) change these jumps or even introduce intrachain jumps. Generally one will simply want to specify only a default value for jump movement.
-   If a residue/default is not specified, the movemap default is used (this is protocol-specific)
-   If a value for a jump is not given (e.g. if one gives just "JUMP 4\\n"), it defaults to movable (YES)

Sample Files
============

This example is from a homology modeling exercise where a DNA-binding protein is remodeled with DNA present. Residues 1-117 are the protein residues, and 118-132 and 133-147 are the two DNA chains. Jump 1 connects the protein to the DNA, while Jump 2 connects the two DNA chains.

The example below allows all protein torsions to move, while the DNA remains fixed. The rigid-body orientation of the protein with respect to the DNA is allowed to move, while the relative orientation of the two DNA chains may not change.

```
RESIDUE * BBCHI
RESIDUE 118 147 NO
JUMP * YES
JUMP 2 NO
```

##See Also

* [[File types list]]: List of file types used in Rosetta
* [[Movemap|RosettaEncyclopedia#movemap]]: Definition of MoveMap in the glossary
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications