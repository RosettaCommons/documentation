#How to make Rosetta robust against malformed PDBs

Author: Steven Lewis (smlewi@gmail.com)

This document was orginally written 6 Apr 2010 by Steven Lewis. This document was last updated 23 Mar 2013 by Steven Lewis.

When this was tested in February 2016 during the rewrite-the-PDB-reader effort, most of these tricks were found to no longer be sufficient.

Purpose
===========================================

Rosetta's PDB reader is fragile. There are lots of PDBs that cannot be read in by Rosetta (several thousand fail to read in at all), and many more that cannot be scored for some reason. Unfortunately, these bad PDBs tend to cause Rosetta to crash rather than exit gracefully. This document describes how to "robustify" Rosetta so that it will not crash when encountering a bad PDB.

When would I use it?
====================

You might want to robustify Rosetta if you are going to do a small-nstruct, large -l experiment. In my case, I ran with -nstruct 1 against literally the entire PDB, once in 2010 (?) and once in 2012.

Why are these not set up by default?
====================================

The changes that have to be made cause a significant performance hit to Rosetta (particularly the vectorL change). These should not be left on by default. A better question is, why does no one improve the PDB reader to more gracefully catch these errors. The answer to that is: why don't you do it, and make this page obsolete?

Okay, I'm convinced, how do I do it?
====================================

You NEED to make a few changes:

-   run your code under jd2
-   replace all assert() statements in utility/vectorL with runtime\_assert statements. This causes out-of-bounds errors in the Rosetta workhorse vector1 class to be caught in the assert instead of segfaulting. You could also compile in debug mode, or leave the NDEBUG statements in release mode. The point is that bounds checking must be on. (This is what causes the performance hit)
-   (NOTE: this was not found to be necessary in November 2012!) replace all assert()s in the Conformation class with runtime\_assert, or equivalent.

This combination of changes will cause vector overruns to throw exceptions inside runtime\_assert, instead of crashing or causing segfaults. jd2 will catch the exceptions and treat the failed PDB as a failed job, print an error message, and cleanly move on to the next PDB in your list.

There are some other suggested changes:

-   pass the

    ```
    -in:file:obey_ENDMDL 
    ```

    flag. This causes the PDB reader to stop reading multimodel NMR-derived PDBs after the first model.


-   Ignoring unrecognized residues with

    ```
    -ignore_unrecognized_res 
    ```

    is a good choice to prevent ligand from crashing the PDB reader.

How many PDBs are bad?
======================

The PDB as of mid-November 2012 contained 86008 PDBs. Of these, 6460 crash in the PDB reader. Another 40 crashed from vector1 runtime\_asserts, and 6 from containing only single-residue chains, somewhere in the AnchorFinder executable. (These 46 may not be universally malformed, depending on what AnchorFinder does differently from your application).

##See Also

* [[Running Rosetta with options]]
* [[Guides for non-protein inputs|non-protein-residues]]: Notes on working with [[noncanonical amino acids|Noncanonical Amino Acids]], [[metals|Metals]], [[carbohydrates|Carbohydrates]], _etc_.
* [[Options in Rosetta|options-overview]]
* [[How to turn on residue types that are off by default]]
* [[Params files|Residue Params file]]: Notes for adding new residue types that are not already in the Rosetta database.
* [[Preparing structures for Rosetta|preparing-structures]]