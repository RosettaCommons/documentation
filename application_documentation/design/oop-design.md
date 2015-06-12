#oop\_design application

Metadata
========

Author: Kevin Drew, (kdrew@nyu.edu)

Last updated November 30, 2012;

Code and Demo
=============

-   Application source code: `        rosetta/main/source/src/apps/public/noncanonical_backbones/oop_design.cc       `
-   Mover source code: `        rosetta/main/source/src/protocols/simple_moves/oop/OopRandomSmallMover.cc       `
-   Mover source code: `        rosetta/main/source/src/protocols/simple_moves/oop/OopRandomPuckMover.cc       `
-   For a demonstration of a basic run see integration folder ( `        rosetta/main/tests/integration/tests/oop_design/       ` ) and demo folder ( `        rosetta/demos/public/oop_design       ` ).

Documentation for the oop\_design application
=============================================

The main references for the oop\_design app are to be published in the PlosOne 2013 Rosetta Special Collection

Application purpose
===========================================

Oligooxopiperazines (oop) are a scaffold peptidomimetic (4-6 residues in length with cyclized backbones every two residues) that mimics the i, i+4, i+7 residues of an alpha helix. Many protein interaction interfaces involve helices and there is interest in using oops for protein interaction inhibitors. The rational design of oops using the oop\_design app attempts to find high affinity binders to target proteins.

Algorithm
=========

1.  Pertubation phase: rigid body movement of oop wrt target, oop small moves to oop ring conformation, oop puck move to change oop ring pucker, small moves to ring linkers
2.  Design phase: design user specified residues on oop scaffold and minimize
3.  Repeat 10x

Input Files
===========

oop\_design requires the following inputs:

-   **Starting structure:**
     The starting structure should have two chains, where the first should be the target protein and the second the oop scaffold (see demo inputs for example). The starting conformation should be close to a plausible binding mode because the oop\_design app does not do large perturbations. The starting structure should also be refined prior to input where the recommended procedure is to do relax with constraints (reference).

Options
=======

I. Common oop\_design flags:
----------------------------
| Flag | Description | Type | Default |
|:-----|:------------|:-----|:--------|
|-oop_design_positions|positions on oop chain to be designed|list of numbers [ex. 1 2 3 6]|None, only repack, no design|
| -pert_num| number of perturbations made during perturbation phase| integer|10|
|-design_loop_num|number of perturbation + design cycles|integer|10|


II. Relevant Common Rosetta flags
---------------------------------

More information on common Rosetta flags can be found in the [[relevant rosetta manual pages|Rosetta-Basics]]. In particular, flags related to the job-distributor (jd2), scoring function, constraint files and packing resfiles are identical to those in any other Rosetta protocol).

| Flag | Description | 
|:-----|:------------|
|-in::file::s Or -in:file:silent|Specify starting structure  (in::file::s for PDB format, in:file:silent for silent file format).|
|-in::file::silent_struct_type AND -out::file::silent_struct_type|Format of silent file to be read in/out. For silent output, use the binary file type since other types may not support ideal form|
|-nstruct|Number of models to create in the simulation|
|-use_input_sc|Include rotamer conformations from the input structure during side-chain repacking. Unlike the -unboundrot flag, not all rotamers from the input structure are added each time to the rotamer library, only those conformations accepted at the end of each round are kept and the remaining conformations are lost.|
|-ex1/-ex1aro -ex2/-ex2aro -ex3 -ex4|Adding extra side-chain rotamers|
|-database|The Rosetta database|
|-include_patches|Turn on patch files which are off by default.   Turning on patches/oop_pre.txt and patches/oop_post.txt is a requirement for oop applications.|

Tips
====

Example runs
------------

1.  generate 1000 (or more) models

    ```
     oop_design.{ext}
    -database ${rosetta_db} -include_patches patches/oop_pre.txt patches/oop_post.txt -s start.pdb -nstruct 1000 -oop_design_positions 1 2 3 4 -pert_num 100 -design_loop_num 10
    ```

2.  Sort models by total score, take top 5%, sort by REPACK\_ENERGY\_DIFF. Inspect top models.

Limitations:
------------

-   **Start with good binding mode:**
     This application does not do large perturbations and therefore only minimally explores the space around the input structure. Use experimental evidience, a full docking app or estimate the binding mode by hotspot residues of native complex.

-   **Target model:**
     This application assumes the backbone of the target structure is in a fixed conformation and does not do flexible backbone moves.

-   **Oop length:**
     This application has only been tested for oop dimers (4 residues). Although untested, there is no obvious reason why an oop trimer or an extended oop (ex. oop dimer with n-term or c-term additional residues would not work.

-   **Typical running time:**
     With default settings and a typical input structure (\~ 100 residues), a single model is estimated around 15 seconds. For a recommended 1000x models, the runtime should be around \< 25 mins.

-   **Multichain receptors:**
     This app currently supports only the use of single-chain targets. If you want to use a multichain target, you may be able to get away with hacking your input PDB to re-label all target chains as one big chain (removing termini atoms and TER cards). Renumbering is necessary only to resolve numbering conflicts.

Expected Outputs
================

The output of a oop\_design run is a score file (score.sc by default) and k model structures (as specified by the -nstruct flag and the other common Rosetta input and output flags). The score of each model is the second column of the score file.

Post Processing
===============

Model selection should be made based on sorting by total score, take top 5% and sort by REPACK\_ENERGY\_DIFF in the score file.

##See Also

* [[HBS design | hbs-design ]]: Designs hydrogen bond surrogate alpha helices (HBS), another helix mimetic.
* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
