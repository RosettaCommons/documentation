#beta\_strand\_homodimer\_design suite of apps

Metadata
========

Author: P. Ben Stranges (stranges@unc.edu), PI is Brian Kuhlman: (bkuhlman@unc.edu)

Code and Demo
=============

The code is at `       rosetta/main/source/src/apps/public/scenarios/beta_strand_homodimer/      ` ; there's an integration test at `       rosetta/main/tests/integration/tests/beta_strand_homodimer/      ` . However if you want to actually use the code you should look at the demo: `       rosetta/demos/public/beta_strand_homodimer_design/      `

References
==========

-   Stranges PB, Machius M, Miley MJ, Tripathy A, and Kuhlman B. (2011) "Computational design of a symmetric homodimer using beta-strand assembly" PNAS in press.

Purpose
===========================================

This code was written for a relatively singular application: finding proteins with surface exposed beta-strands, then trying to make and design a homodimer that will form via that beta-strand. It could be used for general homodimer design but has not been tested.

Algorithm
=========

The below is coppied verbatim from the paper given above: We defined a beta-strand as surface-exposed if it met three criteria. 1) Five sequential residues had beta-strand secondary structure as judged by DSSP. 2) There were no backbone-backbone hydrogen bonds formed by every other residue in the strand. 3) Every other residue had fewer than 16 neighboring residues, or had 16 to 30 neighbors and a solvent-accessible surface area (SASA) per atom greater than 2.0 Å2. Residues are defined as neighbors if their Cbeta to Cbeta distance is \< 10Å. An example command line used to find the exposed strands follows:

The output from the above is then used to put together the command line for the construction of the potential homodimers. The procedure is as follows: The axis of an exposed beta-strand was defined as a vector from the Calpha atom on the first residue of the strand to the Calpha atom on the final residue of the strand. Another vector is defined at the center residue of the strand from the carbonyl carbon to carbonyl oxygen. A final vector is drawn perpendicular to the two vectors described through the Calpha atom of the residue at center of the strand. The anti-parallel homodimer is constructed by copying the protein and rotating the copy 180° about this axis. The copied chain is then translated away from the original by 6.0 Å to create a starting point for evaluation. The copied chain was then translated along the axis of the exposed strand in steps of 7 Å to identify alternate conformations that have no clashing backbone atoms. As a final filter, we check to make sure there are no backbone-backbone clashes between the two chains. The identification of exposed beta-strands generated from the above protocol was used as input for the next step.

The homodimer model generated above was used to generate the symmetry definition and starting structure for interface design. First, the protein is symmetrically docked against itself to sample rigid body degrees of freedom. After the docking step, all residues within 8 Å of the other chain were symmetrically designed. Finally, the backbone and side chains of all interface residues were minimized.

Input Files
===========

See the demo at: `       rosetta/main/demos/public/beta_strand_homodimer_design      `

Options
=======

exposed\_strand\_finder options

General options:

-   -s or -l for input structure(s)
-   -ignore\_unrecognized\_res - bool - Good to have true for large numbers of input structures
-   -packing::pack\_missing\_sidechains
-   -out::nooutput -bool- this protocol manages its own output, prevent job distributor from helping
-   -struct\_file -file- path to the file for the structure restrictor if needed

App specific options

-   -beta\_length - integer - how long of an exposed strand do you look for
-   -sat\_allow - integer - how many satisfied bb atoms do you allow in this range

Allow alignment of a found strand to some target protein (optional):

-   -check\_rmsd false - bool - whether you should check the exposed strand against some tagret strand
-   -native - file - the target structure to check the rms of the exposed strand against
-   -strand\_span - string vector - chain start end of the native to check the exposed strand against (example: B 10 15)

homodimer\_maker options

-   -s input stucture to make into a homodimer
-   -run::chain - char - PDB chain letter for the chain you want to use to make the homodimer
-   -sheet\_start - integer - PBD residue \# of the first residue in the strand
-   -sheet\_stop - integer - PBD residue \# of the last residue in the strand
-   -window\_size - integer - number of residues to consider within the exposed strand when calculating vectors. Cannot be larger than sheet\_stop - sheet\_start + 1.

homodimer\_design options General options:

-   -s - \*\_INPUT.pdb from symmetery script
-   -symmetry:symmetry\_definition -file- symmetry deffinition file from script
-   -nstruct -integer- try 5000 or so for production runs

Application specific:

-   -pack\_min\_runs - integer - number of cycles through design/minimization
-   -make\_ala\_interface - bool - make the interface all Ala before docking
-   -find\_bb\_hbond\_E - bool - calculate the bb-bb H bonding energy for the output
-   -disallow\_res CGP \# prevents design up Gly, Cys, Pro

Other useful options

-   -favor\_native\_res 0.5
-   -run:min\_type dfpmin
-   -pose\_metrics:interface\_cutoff 8.0
-   -use\_input\_sc
-   -ex1
-   -ex2
-   -overwrite
-   -docking::docking\_local\_refine true/false
-   -docking::sc\_min true
-   -docking::dock\_ppk false
-   symmetry:perturb\_rigid\_body\_dofs 3 5
-   -out::file::fullatom

Tips
====

These protocols are specific for one method of finding exposed beta-strands and designing that protein to be a homodimer. We are not sure how easily it could be used for other purposes.

Expected Outputs
================

See the full description in `       rosetta/main/demos/public/beta_strand_homodimer_design/README      `

Post Processing
===============

The demo located in `       rosetta/main/demos/public/beta_strand_homodimer_design/      ` has a full description of how to handle outputs.

Changes since last release
==========================

3.4 is the first release of this code. - stranges

##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
