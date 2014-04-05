# Generalized Kinematic Closure
By Vikram K. Mulligan, Baker laboratory.  Documentation written 4 April 2014.
The algorithm described here currently exists in the **collab/cycpep** and **vmullig/sidechainKIC** development branches, but will be checked into master shortly.  At that time, this documentation will be added to the primary documentation.

## Short summary
GeneralizedKIC (short for _G_eneralized _Ki_nematic _C_losure) is a generalization of the existing kinematic closure machinery.  The generalized version works with arbitrary backbones, and with loops that go through side-chains, ligands, etc.  It has also been implemented with full RosettaScripts support, making it easy to incorporate into more complicated protocols.

## Usage cases
Generalized KIC is useful for the following situations:
* Given an arbitrary unbranched, covalently-contiguous part of a structure, with well-defined, fixed starting and ending points, one wishes to sample alternative conformations that preserve ideal geometry.  An example would be a case in which the N- and C-termini of a protein were linked by a disulfide bond, and one wished to sample alternative conformations for a short stretch of the N-terminal backbone, the disulfide bond, and a short stretch of the C-terminal backbone, subject to the condition that the disulfide remains closed.
* Given a part of a structure that is open but which _ought_ to be covalently connected, with well-defined, fixed starting and ending points, one wishes to sample conformations that close the segment.  For example, given unjoined antiparallel beta strands forming a two-strand sheet, one might wish to sample hairpin conformations.  This closure can be through side-chains or ligands, too: given two segments containing metal-binding residues, one might want to sample conformations that allow a metal to be bound with ideal geometry.
* Given a covalent linkage between distant parts of a FoldTree and a structural perturbation that pulls the atoms involved in the covalent linkage apart, one wishes to find compensatory structural perturbations that maintain the closed covalent geometry while minimally altering the structure.

The above scenarios tend to be sub-problems of more complicated problems, particularly involving heavily cross-linked molecules for which one might wish to sample many conformations.

## Example RosettaScripts

**_TO DO_**

## General workflow
In general, one must:

1. Build or import a structure.  GeneralizedKIC cannot add residues or geometry.  If one wants to build a new loop, for example, one must add the new loop residues before calling GeneralizedKIC.  (In RosettaScripts, the **PeptideStubMover** is useful for building geometry from scratch or for adding residues to existing geometry.)

2. Ensure that covalent linkages have been declared.  GeneralizedKIC will move atoms about to ensure ideal geometry, but cannot declare new chemical bonds.  (In RosettaScripts, the **DeclareBond** mover lets Rosetta know that certain residues are covalently attached to one another.)

3. Set the GeneralizedKIC options (number of closure attempts, whether the algorithm should accept the first successful closure or choose from all successful closure attempts, _etc._).  In RosettaScripts, the format is as follows:

**_TO DO_**

4. Define a series of residues for the GeneralizedKIC closure problem.  This must be an unbranched chain of residues with continuous covalent linkages.  When the GeneralizedKIC::apply() function is called, a continuous chain of atoms running through the selected residues is automatically chosen.

5. Define one or more GeneralizedKICperturbers.  Each perturber samples conformation space for each closure attempt.

6. Define one or more GeneralizedKICfilters.  Filters are applied after each closure attempt, and eliminate solutions that don't meet some criterion.

7. Set the GeneralizedKICselector.  The selector chooses a single solution from the set of solutions found that pass all of the filters.

8. That's it!  You should be happily closing loops, now.

## Algorithm details

The kinematic closure algorithm is described in detail in [Coutsias _et al_. (2004). _J. Comput. Chem._ 25(4):510-28.](http://www.ncbi.nlm.nih.gov/pubmed/14735570) and in [Mandell _et al_. (2009). _Nat. Methods._ 6(8)551-2.](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2847683/)

**_This section is still being written.  A brief overview will be given here._**

## Failure cases
GeneralizedKIC cannot handle the following cases:
* Multiple covalent connections between residues in the chain of residues to be closed.  (This is something that, in general, Rosetta handles poorly).
* Loops involving salt bridges, cation-pi interactions, hydrogen bonds, or other noncovalent interactions.  (The GeneralizedKIC framework has been written with this in mind as a possible future extension, however.)  Note that coordinate covalent bonds between metal-binding residues and metal ions are considered "covalent" in Rosetta, and _are_ handled properly by GeneralizedKIC.

_**This page is under construction.**_