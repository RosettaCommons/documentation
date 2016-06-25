#Loop modeling application

Metadata
========

This document was last updated March 26th, 2015, by Shane Ó Conchúir. The original version of the application was created by Michael Tyka et al., and the first loop closure algorithm (CCD) was implemented by Chu Wang et al. in 2007.  The robotics-inspired kinematic closure (KIC) algorithm for loop closure was added by Daniel J. Mandell et al. in 2009, and the refined next generation KIC algorithm by Amelie Stein and Tanja Kortemme in 2013. The latest algorithmic development in loop modeling is KIC with fragments, added by Roland A. Pache and Tanja Kortemme in 2014. 

An introductory tutorial on loop modeling can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling).


References
==========

-   Stein A, Kortemme T. (2013). Increased sampling of near-native protein conformations. *PLoS One*. 2013 May 21;8(5):e63090. doi: 10.1371/journal.pone.0063090. Print 2013. PMID: 23704889

-   Mandell DJ, Coutsias EA, Kortemme T. (2009). Sub-angstrom accuracy in protein loop reconstruction by robotics-inspired conformational sampling. *Nat Methods*. 2009 Aug;6(8):551-2. doi: 10.1038/nmeth0809-551. PMID: 19644455

-   Qian, B., Raman, S., Das, R., Bradley, P., McCoy, A.J., Read, R.J. and Baker D. (2007). High resolution protein structure prediction and the crystallographic phase problem. *Nature*. 2007 Nov 8;450(7167):259-64. Epub 2007 Oct 14. PMID: 17934447

-   Wang, C., Bradley, P. and Baker, D. (2007) Protein-protein docking with backbone flexibility. *J Mol Biol*. 2007 Oct 19;373(2):503-19. Epub 2007 Aug 2. PMID: 17825317


Purpose and Algorithm
=====================

This protocol was originally developed to be combined with Rosetta full atom structure refinement (relax mode) to streamline the task of comparative modeling. It has since then evolved into a general protocol for modeling loops in protein structures. There are currently the following  algorithms available (can be selected using specific flags; see documentation pages for these different algorithms for details):

-  [[CCD|loopmodel-ccd]]: fragment insertion with cyclic coordinate descent to close chain breaks

-  [[KIC|loopmodel-kinematic]]: robotics-inspired kinematic closure combined with random sampling of non-pivot loop torsions from Ramachandran space

-  [[next generation KIC|next-generation-KIC]]: refined version of KIC; using omega sampling, neighbor-dependent Ramachandran distributions and ramping of rama and fa_rep score terms to achieve higher loop reconstruction performance and increase sampling of sub-Angstrom conformations (recommended algorithm if no fragment data is available)

-  [[KIC with fragments|KIC_with_fragments]]: fragment-based loop modeling using kinematic closure; combining the sampling powers of KIC and coupled phi/psi/omega degrees of freedom from protein fragment data to achieve higher loop reconstruction performance and the best sampling yet of sub-Angstrom conformations (recommended algorithm if fragment data is available) 


Input Files
===========

Common input files include:
-   Start pdb: Template pdb file with real coordinates for all residues plus the first and last residue of each loop region.

-   Loop file:
    ```
    column1  "LOOP":     The loop file identify tag
    column2  "integer":  Loop start residue number
    column3  "integer":  Loop end residue number
    column4  "integer":  Cut point residue number, >=startRes, <=endRes. Default: 0 (let the loop modeling code 
                         choose the cut point)
                         Note: Setting the cut point outside the loop can lead to a segmentation fault. 
    column5  "float":    Skip rate. Default: 0 (never skip modeling this loop)
    column6  "boolean":  Extend loop (i.e. discard the native loop conformation and rebuild the loop from scratch,
                         idealizing all bond lengths and angles). Default: 0 (false)
    ```
    **NOTE:** Residue indices in loop definition files refer to *Rosetta numbering* (numbered continuously from '1', including across multi-chain proteins). It may be useful to renumber starting structures with Rosetta numbering so loop defintions and PDB residue indices agree.

-   Fragment files (for CCD and KIC with fragments)


Command Line Options
====================

Depending on the specific loop algorithm you choose ([[CCD|loopmodel-ccd]]/[[KIC|loopmodel-kinematic]]/[[next generation KIC|next-generation-KIC]]/[[KIC with fragments|KIC_with_fragments]]), different sets of flags apply. 
Please check the documentation for the respective algorithm for details. 

For a full list of all available loop modeling flags, please check the [[full options list|full-options-list]]


Protocol capture
================

A protocol capture for some of the loop modeling algorithms above (KIC, next generation KIC, KIC with fragments) can 
be downloaded from the [[Macromolecular modeling and design benchmarks|https://kortemmelab.ucsf.edu/benchmarks/captures/loop_modeling]] website. 
The [[loop modeling page|https://kortemmelab.ucsf.edu/benchmarks/benchmarks/loop_modeling]] also lists suggested parameters to use for the different protocols.


loopmodel MPI
=============

The loopmodel executable has a separate MPI implementation from the JD2 implementation that serves most of Rosetta. As normal, just compile Rosetta in mpi (add extras=mpi to the scons command line when compiling) to activate MPI. When you run loopmodel.mpi.\*\*\*, it will expect that you have precreated output directories for it, named ./output\_\#, where \# is the zero-indexed processor rank (and you need one for each processor). So, for a 8-processor MPI job, created output\_0, output\_1, ..., output\_7.

## See Also

* [Loop Modeling Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling)
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction, including loop modeling
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* [[Loops file]]: File format for specifying loops for loop modeling
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files

