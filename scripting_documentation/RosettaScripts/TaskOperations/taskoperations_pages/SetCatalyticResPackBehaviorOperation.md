# SetCatalyticResPackBehavior
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SetCatalyticResPackBehavior

Ensures that catalytic residues as specified in a match/constraint file do not get designed. If no option is specified the constrained residues will be set to repack only (not design).

If the option fix\_catalytic\_aa=1 is set in the tag (or on the commandline), catalytic residues will be set to non-repacking.

If the option -enzdes::ex\_catalytic\_rot \<number\> is active, the extra\_sd sampling for every chi angle of the catalytic residues will be according to \<number\>, i.e. one can selectively oversample the catalytic residues

