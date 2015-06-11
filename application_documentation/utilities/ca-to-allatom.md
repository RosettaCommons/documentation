#ca\_to\_allatom application

Metadata
========

Last edited Oct 31 2010 by Frank DiMaio. Code by Frank DiMaio (dimaio@u.washington.edu). P.I.: David Baker.

Code and Demo
=============

The Mover for this application is in src/protocols/RBSegmentMoves/RBSegmentRelax.cc. Sub-movers that may be useful are also found in this folder. This code is also used as part of a tutorial on using Rosetta to refine structures into density. The complete demo is in demo/electron\_density/cryoEM\_tutoral. The portion of the tutorial using this application is in 'scenario6\_model\_from\_ca\_trace'.

References
==========

-   DiMaio F, Tyka MD, Baker ML, Chiu W, Baker D (2009). Refinement of protein structures into low-resolution density maps using rosetta. J. Mol. Biol. 392, 181-90.

Purpose
===========================================

This is an application intended to aid in building a full-atom mdoel from a low-resolution C-alpha-only trace (such as hand-traced models from cryo-electron microscopy). The input to the protocol includes the initial C-alpha trace and a rigid-body segmentation file, which identifies secondary-structure elements in the initial trace.

Algorithm
=========

The protocol is divded into 4 phases:

-   Fragment insertion – variable-length fragments are inserted at each secondary structure element. The fragments are dynamically selected based on RMS to the trace, and the insertion ensures that the fragment is in the same relative orientation as the original trace.
-   Rigid-body perterbation – The secondary structure elements are perturbed in a Monte-Carlo trajectory. Optionally, sequence-shifting moves explore alternate threadings of the model.
-   (optional) Loop remodelling
-   (optional) All-torsion minimization

The first two phases may be done in *either* all-atom or centroid mode. Loop modelling is always done in centroid mode, while all-torsion minimization is always fullatom.

Limitations
===========

This code assumes the starting C-alpha model contains some errors. If you want a reasonable backbone model with *exactly* the C-alpha coordinates specified a geometric tool like MaxSprout may be more appropriate.

Input Files
===========

The input PDB – even though it only needs coordinates for C-alpha atoms – must have lines for all backbone atoms. These may have coordinates of all 0's, with an occupancy set to -1, or a tool like MaxSprout can be used to find some geometrically reasonable conformation. These coordinates are not used at all by rosetta, but the PDB-reading machinery requires their presence.

The **RB segment file** (specified with -RBSegmentRelax:rb\_file) is as follows:

```
SEGMENT   1   4   8  E
SEGMENT   2  13  16  E
SEGMENT   3  26  34  E
...
```

The first column is the word 'SEGMENT', the second is a *unique* identifier for each segment, the third and fourth a residue range, and the fifth is 'E', 'H', or 'X' depending on secondary structure type (X means compound, for example, if modeling a strand-turn-strand motif as a single element).

A **vall file** (specified with -loops:vall) is used to generate backbone fragments dynamically. A version of it is included in the Rosetta database.

Options
=======

The options listed below include those specific to the ca\_to\_allatom application and a selection of common flags that may be useful. If a post-run looprelax is enabled, then the app takes all [[looprelax|loopmodel]] and [[relax]] specific options. If modelling into density, the app takes all [[density-fitting|density-map-scoring]] options.

**Common options:**

-   -in:file:fullatom
-   -in:file:centroid_input

These flags control whether fullatom or centroid models are used during the first two phases of the protocol (defaults to fullatom). The scorefunction given must agree with this.

-   -RBSegmentRelax:rb\_file

The rigid-body segmentation file. See notes above for more info.

-   -RBSegmentRelax:cst\_wt
-   -RBSegmentRelax:cst\_width

The weight and width of the constraints during the first two phases of the protocol. Wider and weaker constraints will produce structures further from the initial CA trace.

-   -RBSegmentRelax:nrbmoves

The number of moves in phase 1 and phase 2 of the protocol.

-   -RBSegmentRelax:rb\_scorefxn

The scorefunction used during the first 2 phases of the protocol. If the input pose is fullatom, make sure this is a fullatom function (like score13\_env\_hb); if centroid make sure it is a centroid function (like score5).

-   -RBSegmentRelax:skip\_fragment\_moves
-   -RBSegmentRelax:skip\_seqshift\_moves
-   -RBSegmentRelax:skip\_rb\_moves

This tell the protocol to skip one of the three move types. Note that if fragment moves are skipped, only 1 fragment insertion is done for each secondary structure element (to build the initial full-atom pose from a C-alpha trace).

-   -RBSegmentRelax:helical\_movement\_params
-   -RBSegmentRelax:strand\_movement\_params
-   -RBSegmentRelax:default\_movement\_params

The movement parameters, specified as angle-distance pairs. The helical and strand moves have two pairs of these parameters, corresponding to on-axis and off axis movements, while the default case has only one pair. As an example, '-strand\_movement\_params 40.0 1.0 1.0 0.2' will perturb strands 40 degrees/1A along the strand axis, and 1 degree/0.2A outside the strand axis. These parameters default to 0, so must be specified by the user.

-   -no\_lr

Should we skip looprelax?

**Rarely-used options:**

-   -fix\_ligands

If specified, all ligands in the inital trace will not move at all from the starting position

-   -frag\_randomness

When dynamically choosing fragments in phase 1, this parameter determines how much randomization goes into the search. In general, higher values for this will result in structures further from the starting model.

Tips
====

-   The parameter that has the biggest impact on final models is 'cst\_width'. If models seem to be moving too far (or alternately not far enough) from the starting model, this is the parameter to vary. Notice that as this parameter increases, more sampling is required to adequately cover conformational space.

-   If the starting model has a lot of beta sheet it may be useful to perform centroid modeling with the fullatom backbone hydrogen bonding terms. Try a centroid weight file (using -RBSegmentRelax:rb\_scorefxn) like:

    ```
    env         1.0
    pair        1.0
    cbeta       1.0
    vdw         1.0
    hbond_lr_bb 4.0
    hbond_sr_bb 1.0
    rama        0.2
    rg          2.0
    ```

Post Processing
===============

Post-processing is highly dependent on the accuracy of the initial C-alpha trace. If the lowest-energy models show good convergence (either by visual inspection or [[clustering|cluster]] ) then minimal postprcessing is needed. Alternately, these models may serve as starting points for additional modelling with [[loopmodeling|loopmodel]].

## See also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Old fragment picker | fragment-picking-old]]: the old fragment picker.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
