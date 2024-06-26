#AnchorFinder

#####Metadata

Author: Steven Lewis (smlewi -- at -- gmail.com)

Code and documentation by Steven Lewis (smlewi -- at -- gmail.com). The PI was Brian Kuhlman, (bkuhlman -- at -- email.unc.edu).

Code and Demo
=============

The code for this application lives in Rosetta/main/source/src/apps/public/interface_design/anchored_design/AnchorFinder.cc. Its [[mover|Glossary]] is embedded in the application file. There is a demo in the integration tests (Rosetta/main/tests/integration/tests/AnchorFinder). There is a more extensive demo with more documentation at `Rosetta/demo/public/anchored_design` or in the demo section of the release.

References
==========

-   [Lewis SM, Kuhlman BA. Anchored design of protein-protein interfaces. PLoS One. 2011;6(6):e20872. Epub 2011 Jun 17.](http://www.ncbi.nlm.nih.gov/pubmed/21698112) (pubmed link)

Purpose
===========================================

The purpose of AnchorFinder is to search for anchors in protein dimers. It is part of the overall AnchoredDesign suite. Briefly, anchors are regions in an interface that serve as handles and could be grafted from a natural interacting partner into a new scaffold (the purpose of the AnchoredPDBCreator application) and then flexibly designed around to create a new protein-protein interface between the original target and scaffold (the AnchoredDesign application).

It was written to help look for proteins useable for fixed-sequence benchmarking of the AnchoredDesign protocol. It can also be used to examine individual interfaces for things that look like anchors (although the human eye is superior if you only want to look at a few structures).

Compiling the Rosetta library and application using SCons
=========================================================

AnchorFinder is intended to be run "robustly". See also the "[[Robust Rosetta|robust]]" documentation.  AnchorFinder was run against the entire PDB at one point; robustification allows it to not crash on malformed PDBs.

Algorithm
=========

The idea is pretty simple. In the first phase, it throws out inputs that are not protein multimers. Nonprotein atoms are stripped, and monomers and too-short structures (20 residues) are thrown out.

If a candidate structure passes that filter, then AnchorFinder basically prints out the neighbor graph, sorted by chain, to a file called \<pdbname\>.out.

It then looks for anchor regions in that structure (regions of high loopness and many cross-interface neighbors) and collects those windows in another file, default name goodfile.out.

Limitations
===========

This code looks for anchors only in a vague sense, you still need to look at the suggested anchors before use. Also, it cannot tell if your input structures are biological heterodimers, homodimers, crystal dimers, octamers, 3 identical heterodimers in one asymmetric unit, etc. If you already know what protein you want to look for anchors in, your eyes are better than this code anyway: load it up in PyMOL and just look. If you have 20 possibilities it's useful.

Modes
=====

Nominally, "looking for benchmark proteins" is a mode (that only the original author will ever use), and "looking for anchors in protein dimer X" is a mode that you might use. The code is used identically, although you'd use a large number of inputs for the first and few for the second.

Input Files
===========

This code has no special inputs, just the flags and pdbs.

Options
=======

AnchorFinder options consist of flags to control what it looks for in an anchor and where it puts the data:

-   window_size (integer) length of windows for consideration - 4 or 5 or 6, etc, contiguous residues at a time? I suggest 5 residue windows.
-   loopness (real between 0 and 1) What fraction of this window should have loop secondary structure as assigned by DSSP? It takes it as a decimal between 0-1, I suggest 0.6 (which translates to 3/5 residues for a 5 residue window) to 1 (all residues loop).
-   nbrs_per_residue (integer) How many cross-interface interactions per residue should the window have? I suggest a minimum of 4. This translates to 20 (redundancy included) cross-interface interactions for a 5 residue window. By redundancy, I mean residues 43 and 44 on chain A can both interact with residue 234 on chain B and it will count as two interactions
-   bestoutfile (filename) What file name should the good interactions be printed to? I leave it as an exercise to the reader to pick their own file name. Defaults to goodfile.out.

Suggested general rosetta options include:

-   database (file path) You'll need the database, as usual
-   s or l (file paths) input pdbs, either as a list to s or in a file to l.
-   obey_ENDMDL (boolean) This flag causes the PDB reader to stop reading NMR models after the first model in the file; otherwise you get multimodel messes with 20 chains atop one another (and tremendous false neighbor counts).
-   packing:pack_missing_sidechains false (boolean) Pass false to this flag to skip packing inputs - it's a waste of time for these purposes.
-   packing:prevent_repacking (boolean) Probably has no effect, but it won't hurt. Packing is a waste of your time here.
-   jd2:no_output (boolean) You don't need the PDB inputs echoed as outputs, it'll just waste your disk space. This prevents that output.

Tips
====

The code is much more efficient if you use all the "general rosetta" options above.

It is slower in execution, but far faster because it doesn't crash, if you do the robustness tricks linked to above.

If the code accumulates large amounts of memory, you don't have a memory leak. What is happening is that the Job Distributor is needlessly caching the huge number of input PDBs, not knowing they are unneeded after first use. When this code was written, that was a fixed problem; it may have since become unfixed. In that case, run in smaller batches and concatenate the outputs.

Expected Outputs
================

Pdbname.data looks like this:

Rows are residues, columns are chains, data are neighbors in that chain for each residue
```
residue chain   PDBdata DSSP    1       2
1       1       2 D     L       7       0
2       1       3 D     L       10      0
3       1       4 D     L       14      0
...
```

You can mine this later without rerunning AnchorFinder to look for anchors. The number of columns will grow if you have more than two chains in the PDB (which can still be valid input, if you have an asymmetric unit of 3 heterodimers).

Goodfile.out looks like this:

```
PDB pdb2vk1 window 45 loopness 5 nbrs 0 28 0 0 start 46 A pymol select pdb2vk1 and chain A and resi 46-50
PDB pdb2vk1 window 108 loopness 5 nbrs 0 25 0 0 start 109 A pymol select pdb2vk1 and chain A and resi 109-113
PDB pdb2vk1 window 109 loopness 5 nbrs 0 36 0 0 start 110 A pymol select pdb2vk1 and chain A and resi 110-114
PDB pdb2vk1 window 110 loopness 5 nbrs 0 46 0 0 start 111 A pymol select pdb2vk1 and chain A and resi 111-115
PDB pdb2vk1 window 111 loopness 5 nbrs 0 46 0 0 start 112 A pymol select pdb2vk1 and chain A and resi 112-116
PDB pdb2vk1 window 112 loopness 5 nbrs 0 47 0 0 start 113 A pymol select pdb2vk1 and chain A and resi 113-117
```

Each line identifies the PDB, the window number, its loopness, its number of neighbors on each chain in the PDB (variable \# of columns), the starting residue PDB numbering for the window, and a Pymol selection for the window.

Post Processing
===============

At this point, the data is yours to play with. I searched for windows with large numbers of neighbors on only one chain using sifter.py (included in the protocol capture attached to publication), then sorted for those with the largest number of neighbors (sort -n -k1 \<input\>). After that it was all manual filtering to choose structures for the benchmarks. I've never used it to look for anchors in small numbers of structures.

New things since last release
=============================

Rosetta 3.3 is the first release.

##See Also


* [[AnchoredDesign | anchored-design ]]: Actually designing anchored interfaces located by this application
* [[AnchoredPDBCreator | anchored-pdb-creator ]]: Creates input for the next step of this workflow.

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Preparing structures]]: How to prepare structures for use in Rosetta
