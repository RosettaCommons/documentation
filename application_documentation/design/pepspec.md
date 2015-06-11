#Pepspec application

Metadata
========

Author: Chris King (dr.chris.king@gmail.com)

Last updated 4/13/2010; P.I. Phil Bradley (pbradley@fhcrc.org)

Code and Demo
=============

This applications live in src/apps/public/pepspec/pepspec.cc and src/apps/public/pepspec/pepspec\_anchor\_dock.cc . The demo lives in demo/pepspec . The integration tests lives in test/integration/tests/pepspec\_anchor\_dock and test/integration/tests/pepspec .

References
==========

C.A. King and P. Bradley, Structure-based prediction of protein–peptide specificity in rosetta, Proteins 78 (2010), pp. 3437–3449.

Application purpose
===========================================

Many cell signalling events and protein-protein interactions are mediated by peptide binding domains and short, linear peptide motifs. The pepspec application can be used for structure-based prediction of protein-peptide specificity of peptide-binding proteins. For the primary pepspec application, the user must supply a model of the peptide-binding protein of interest bound to either a peptide or a single peptide residue. If such a model is not available, a single residue-docked conformation can be generated using the pepspec\_anchor\_dock application first. The pepspec\_anchor\_dock application must be supplied with a model of the unbound target protein and one or more homologous protein-peptide complex structures to estimate an initial conformation for a single peptide "anchor" residue on the surface of the target protein. Pepspec uses this input protein-peptide configuration a starting place to perform flexible-backbone peptide design on the surface of the protein, generating a large number of putative peptide ligands. These peptides may then be ranked by predicted binding affinity to produce a position-specific scoring matrix for the target protein.

Algorithm
=========

The pepspec application implements an anchored, flexible-backbone peptide docking and design algorithm in which the sequence and structure of the peptide are simultaneously optimized. Rather than performing global peptide docking searches, pepspec requires as input an approximate location for a key "anchor" residue of the peptide; the remainder of the peptide is assembled from fragments as in de novo structure prediction and refined with simultaneous sequence optimization. Backbone flexibility of the protein is optionally incorporated implicitly by docking into a structural ensemble for the protein partner.

Limitations
===========

This application is *NOT* for structure prediction of an entire protein. You need to have a model of the peptide-binding protein, although this model may be derived from experiment, homology modeling, or de novo protein folding. This applcation does *NOT* move the backbone of the input protein structure. Backbone ensembles can be generated with the [[backrub]] or [[relax]] applications. This application does *NOT* support de novo docking of the peptide anchor residue; you need to have at bare minimum a model of a protein-peptide complex homologous to your target protein. To dock a single residue with no knowledge of where the binding pocket might be, you may consider using the [[docking|ligand-dock]] application.

Modes
=====

This application has two major modes: Anchor Docking and Peptide Design. Anchor Docking: If you already have a structure of the target protein bound to an N-mer peptide, you may not need to do this step. If you need to dock an anchor residue onto your protein, then the anchor docking mode allows you to use structures of homologous protein-peptide complexes to predict the position of the anchor residue on your target protein. You provide a single structure of your target protein or an ensemble of structures, along with a set of homologous complexes. The homologues must be aligned to the target protein! The algorithm uses the relative positions of the homologues’ anchor residues to dock a new anchor residue to your target protein, and outputs the structures and associated score data for use in the next step. Peptide Design: In the peptide design phase, putative binding peptides are designed at the surface of the target protein. The algorithm takes as input one or more protein-peptide complexes. The "peptide" may be a single residue docked in the previous phase. The existing peptide is optionally extended from each termini by a user-defined number of residues, and low-resolution backbone sampling takes place before high-resolution peptide sequence design. The low resolution step uses a full-atom (not centroid) poly-A or poly-G peptide with a minimal score function that only penalizes atomic clashes and insures the peptide remains near the surface of the protein. The design phase attempts full combinatorial sequence design with both soft repulsive atoms and then with full repulsive atoms, followed by minimization. Then, the sequence is diversified using a Monte-Carlo+minimization design phase. In this diversification stage, random point mutations are made to the peptide, surrounding sidechains conformations are optimized, and the point mutation is accepted or rejected stochastically with probability based on the change in the prptide's estimated binding score. The binding score is calculated by subtracting the rosetta energy of the unbound peptide with fixed backbone and repacked sidechains from the total protein-peptide complex rosetta energy. (Note: total rosetta energy may be used instead by supplying the flag "-pepspec:binding\_score false".) In this way, each peptide backbone generates many different peptide sequences. Sequence-score data is output for post-processing, and protein structures may also be optionally saved.

Input Files
===========

Anchor Docking Input Files
-------------------

-   Input structure (list): pepspec\_anchor\_dock requires an input structure of the target peptide-binding protein. pepspec\_anchor\_dock also accepts a list of input structures if sampling of a pre-generated protein conformational ensemble is desired.
-   Homolog input structure list + peptide data: This file contains a list of homologue protein-peptide structures, along with data about which residue in the structure is the peptide anchor residue. Each line of the file should contain three tab-separated entries: the pdb file, the peptide chain, and the peptide anchor residue number. The format looks like:

\<homolog\_pdb\_filename\> \<peptide\_chain\> \<peptide\_anchor\_res\>

for each homolog. It is highly recommended you perform the structural alignment of the homologues to your target structure ahead of time. This is necessary to insure that the homologue complex peptides' coordinates are properly superimposed in your target protein's reference frame. As long as peptide backbone coordinates can be gleaned from the homologues, all other aspects of the homologues' PDB model quality are irrelevant. You can optionally choose for Rosetta to attempt a sequence alignment and subsequent structural alignment of the homologue proteins to your target protein (-pepspec:seq\_align), but the alignment may not be ideal. I recommend using [Cealign](http://www.pymolwiki.org/index.php/Cealign) .

Pepspec Input Files
-------------------------------------

-   Input structure(s): pepspec requires an input structure of a protein docked to an N-mer polypeptide. pepspec also accepts a list of input structures if sampling of a conformational ensemble is desired. Single-residue docked structures can be generated with the pep\_anchor\_dock application (see above).
-   Constraint file (optional): pepspec can optionally use coordinate constraints on the peptide backbone. These constraints can be generated with the pep\_anchor\_dock application.
-   Native structure (optional): When the native structure is known, pepspec can print peptide backbone RMSD information along with score and sequence data.
-   Peptide Constraints (optional): A peptide constraint file (auto-generated in the anchor docking phase) may be used to bias the peptide backbone toward conformations similar to the peptides in homologous complexes by utilizing a flat-bottom harmonic constraint. Each line of the constraint file corresponds to one peptide position; lines can be deleted form the constraint file to free the corresponding peptide position from bias during backbone sampling. Each line contains eight tab-separated values: the atom name, the peptide sequence position *relative to the anchor residue (0)* , the xyz coordinates, the minimum distance from the xyz coord (0.0), the standard deviation (inverse of "spring constant"), and the zero-constraint tolerance distance from the center of the harmonic well. The format for peptide constraint files looks like:

\<atom\_name\> \<peptide\_position\> \<x\_coord\> \<y\_coord\> \<z\_coord\> \<0.0\> \<std\_dev\> \<tolerance\>

Options
=======

You will probably only need to use General and Typical Options. These options will make more sense after you read the Tips section below.

-option:name [data\_type] - this is a description (default\_value)

General Options
-------------------

-   -database [file path] - the Rosetta 3 database location
-   -in:file:s [file path] - single input structure
-   -pepspec:pdb\_list [String] - instead of a single input structure, use a list of input structures ()
-   -o [String] - this is a string to define the tag used to name the output scorefiles, pdbs, and pdb directories
-   -ex1 - increase the chi1 resolution of the rotamer library
-   -ex2 - increase the chi2 resolution of the rotamer library
-   -extrachi\_cutoff 0 - increase rotamer sampling at exposed positions

Anchor Docking Options (Typical)
--------------------------------

-   -pepspec:ref\_pdb\_list [String] - list file of homologue structures and peptide anchor data ()
-   -pepspec:n\_peptides [Integer] - number of output structures to generate (8)
-   -pepspec:anchor\_type [String] - three-letter amino acid code, residue type of anchor residue to be docked (ALA)
-   -pepspec:no\_prepack\_prot [Boolean] - suppress repacking all rotamers in the input protein structure (see Tips section below) (false)

Anchor Docking Options (Extra)
------------------------------

-   -pepspec:clash\_cutoff [Real] - VdW repulsive score cutoff for defining residue clashes (5.0)
-   -pepspec:prep\_align\_prot\_to [String] - align input target structures (when using an input ensemble) to one structure ()
-   -pepspec:prep\_use\_ref\_rotamers [Boolean] - copy anchor residue chi angles from homologue peptides and surpress rotamer optimization (false)
-   -pepspec:n\_dock\_loop [Integer] - number of iterations of inner docking loop (4)
-   -pepspec:n\_anchor\_dock\_std\_devs [Real] - number of standard deviations by which to permit translational and rotational deviation from homologue average anchor residue rigid-body orientation (1.0)
-   -pepspec:prep\_trans\_std\_dev [Real] - manually set magnitude of anchor residue translational (Angstroms) perturbation from homologue average in docking (ignore homologue standard deviation) (0.5)
-   -pepspec:prep\_rot\_std\_dev [Real] - manually set magnitude of anchor residue rotational (degrees) perturbation from homologue average in docking (ignore homologue standard deviation) (10.0)
-   -pepspec:seq\_align [Boolean] - attempt sequence/structure alignment of homologues to target structure (NOT RECOMMENDED) (false)

Pepspec Options (Typical)
-------------------------

-   -pepspec:pep\_anchor [Integer] - peptide anchor residue ()
-   -pepspec:pep\_chain [String] - peptide chain ()
-   -pepspec:n\_prepend [Integer] - number of residues to add to the n-terminus of the peptide or anchor residue (0)
-   -pepspec:n\_append [Integer] - number of residues to add to the c-terminus of the peptide or anchor residue (0)
-   -pepspec:n\_peptides [Integer] - number of protein-peptide output structures to generate (8)
-   -pepspec:homol\_csts [String] - name of peptide constraint file, generated by pepspec\_anchor\_dock (optional) ()

Pepspec Options (Extra)
-----------------------

-   -score:weights [String] - score function weights used for rotamer sampling, minimization, and final scoring (standard.wts)
-   -pepspec:soft\_wts [String] - score function weights used for soft-repulsive rotamer sampling (soft\_rep.wts)
-   -pepspec:cen\_wts [String] - score function weights used for low-resolution peptide backbone sampling (cen\_ghost.wts)
-   -pepspec:binding\_score [Boolean] - calculate binding score, used for sequence diversity MC-min sampling (true)
-   -pepspec:upweight\_interface [Boolean] - increase protein-peptide score interactions by a factor of 2 (false)
-   -pepspec:run\_sequential [Boolean] - use all input structures from input pdb list sequentially, do not choose randomly (false)
-   -pepspec:n\_build\_loop [Integer] - number of iterarions of global low-resolution peptide backbone sampling (1000)
-   -pepspec:n\_cgrelax\_loop [Integer] - number of iterations of local low-resolution peptide backbone sampling (1)
-   -pepspec:interface\_cutoff [Real] - Distance cutoff for definition of protein-peptide interface (5.0)
-   -pepspec:use\_input\_bb [Boolean] - preserve input peptide backbone structure (false)
-   -pepspec:remove\_input\_bb [Boolean] - delete all peptide residues except for anchor (false)
-   -pepspec:frag\_file [String] - fragment library file used in global peptide backbone sampling (filtered.vall.dat.2006-05-05.gz)
-   -pepspec:gen\_pep\_bb\_sequential [Boolean] - add peptide residues one at a time during global peptide backbone sampling (false)
-   -pepspec:input\_seq [String] - build peptides of a given sequence, do not do any design ()
-   -pepspec:ss\_type [String] - only use fragments of a given secondary structure in global peptide backbone sampling ()
-   -pepspec:clash\_cutoff [Real] - VdW repulsive score cutoff for defining residue clashes (5.0)
-   -pepspec:calc\_sasa [Boolean] - calculate delta SASA for each output seuence in score file (slower execution) (false)
-   -pepspec:diversify\_pep\_seqs [Boolean] - perform MC-min sequence diversification on each peptide backbone (true)
-   -pepspec:diversify\_lvl [Integer] - controls amount of sampling in sequence diversification. Number of sequences attempted is number of peptide residues times this value (10)
-   -pepspec:save\_low\_pdbs [Boolean] - save one protein-peptide complex pdb for each designed peptide (true)
-   -pepspec:save\_all\_pdbs [Boolean] - additionally save one pdb for each peptide sequence generated in the peptide sequence diversification stage (false)
-   -pepspec:no\_design [Boolean] - do not change sequence of input peptide (false)

Benchmarking Options
--------------------

-   -in:file:native [String] - native structure, for benchmarking ()
-   -pepspec:native\_pep\_anchor [Integer] - native peptide anchor residue ()
-   -pepspec:native\_pep\_chain [String] - native peptide anchor residue ()
-   -pepspec:native\_align [Boolean] - align target structure to native for RMSD analysis (false)
-   -pepspec:rmsd\_analysis [Boolean] - output peptide C-alpha RMSD data (false)
-   -pepspec:phipsi\_analysis [Boolean] - output peptide phi/psi data (false)

Tips
====

-   use "-ex1" and "-ex2" flags for extra rotamer sampling. Definitely use "ex1". You may experiment with "-ex2" if you expect to need sampling of many long sidechains.
-   use "-extrachi\_cutoff 0" to insure that your -ex flags are actually effective

Anchor Docking Tips
-------------------

-   The target protein will be automatically pre-packed by this application. If the input structure sidechain rotamers have already been optimized by Rosetta, use -pepspec:no\_prepack\_prot to speed up execution time.
-   If docking keeps failing due to clashing residues, check your structural alignment! If everything looks aligned, try increasing the clash tolerance (default 5.0) using -pepspec:clash\_cutoff. This can happen especially when trying to dock into a catalytic active site. Don’t worry, these clashes will be ignored in the next phase.
-   After running, you may want to use the scorefile to filter out high-energy docked conformations before feeding the ensemble of docked structures into the peptide design phase.

Pepspec Tips
-------------------------------------

-   A note on using peptide constraints: If you used the pepspec\_anchor\_dock app to get starting structures, it is possible that the peptide backbone constraint file was generated using only one or two homologue complexes as a reference. If this is the case, or you have reason to believe that peptides may in fact bind with backbone conformations not represented in the homologue set, then use of the constraints may prevent your simulation from ever generating the necessary diversity of peptide backbone structures. To avoid use of constraints, simply do not include a reference to the constraint file in you command line arguments. (e.g. delete the line "-pepspec::homol\_csts \*.cst" from you input arguments.) If you're not using constraints, you need to do much, MUCH more sampling (i.e. an order of magnitude more).
-   The target protein *must* be pre-packed before attempting peptide design! Failure to do this can result in crazy answers! If you are NOT using an input structure generated from the pepspec anchor docking phase, then use the [[fixbb]] application to repack all the sidechains.
-   By default, only one structure per peptide backbone conformation is saved. This is because the sequence diversification phase would generate a huge number of similar structures. To save a structure for every line in the scorefile, use -pepspec:save\_all\_pdbs .
-   The diversification stage can substantially slow down execution time. If you aren't worried about over-converging to one solution (e.g. if you are just trying to design one peptide ligand), you can suppress the behavior with to command line argument "-pepspec:diversify\_pep\_seqs false"

Expected Outputs
================

This application produces protein-peptide structures and scorefiles. The scorefiles may be used to generate sequence-specitificity position-weight matrices by using the scripts described below. Note: pepspec will automatically generate folders for the output structures named "\<output\_tag\>.pdbs"

Post Processing
===============

A position-weight matrix (PWM) can be generated from pepspec output using the script gen\_pepspec\_pwm.py found in (ROSETTA\_LOCATION)/analysis/apps. This script will sort all peptide sequences by Rosetta binding score and generate a matrix of peptide positions by residue frequencies. A background PWM can optionally be supplied to normalize the raw pepspec output PWM (see References at the top of this document). Run 'gen\_pepspec\_pwm.py help' for more information.

-   PWMs may also be generated and visualized using 3rd-party software such as [WebLogo](http://weblogo.berkeley.edu) .

-   Note: The supplied background PWM is valid for normalizing PWMs generated with the standard.wts Rosetta score weights! Use of different score weights will necessarily perturb residue frequencies in the background PWM.

New things since last release
=============================

This is the first release of these applications.

##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
