# Generalized Kinematic Closure
By Vikram K. Mulligan, Baker laboratory.  Documentation written 4 April 2014.
The algorithm described here currently exists in the **collab/cycpep** and **vmullig/sidechainKIC** development branches, but will be checked into master shortly.  At that time, this documentation will be added to the primary documentation.

## Short summary
GeneralizedKIC (short for _G_eneralized _Ki_nematic _C_losure) is a generalization of the existing kinematic closure machinery.  The generalized version works with arbitrary backbones, and with loops that go through side-chains, ligands, etc.

## Usage cases
Generalized KIC is useful for the following situations:
* Given an arbitrary unbranched, covalently-contiguous part of a structure, with well-defined starting and ending points, one wishes to sample alternative conformations that preserve ideal geometry.  For example, if the N- and C-termini of a protein were linked by a disulfide bond, and one wished to sample alternative conformations for a short stretch of the N-terminal backbone, the disulfide bond, and a short stretch of the C-terminal backbone, subject to the condition that the disulfide remains closed, the GeneralizedKIC algorithm would be useful for this.
* Given a part of a structure that is open but which _ought_ to be covalently connected, with well-defined starting and ending points, one wishes to sample conformations that close the segment.  For example, given unjoined antiparallel beta strands forming a two-strand sheet, one might wish to sample hairpin conformations.  This closure can be through side-chains or ligands, too: given two segments containing metal-binding residues, one might want to sample conformations that allow a metal to be bound with ideal geometry.  GenralizedKIC can be useful for any of these cases.

The above scenarios tend to be sub-problems of more complicated problems, particularly involving heavily cross-linked molecules for which one might wish to sample many conformations.

_**This page is under construction.**_