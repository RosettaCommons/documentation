#AnchoredDesign application

#####Metadata

Author: Steven Lewis (smlewi - at - gmail.com)

Code and documentation by Steven Lewis (smlewi - at - gmail.com).
The PI was Brian Kuhlman, (bkuhlman - at - email.unc.edu) .

Example runs and code location
===============================
<!-- this is not in backticks for code boxes because it shatters the wrapping-->
The executable's source is at Rosetta/main/source/src/apps/public/interface_design/anchored_design/AnchoredDesign.cc. 
Most of the code is in the libraries at Rosetta/main/src/protocols/anchored_design/. 
There is an [[integration test|integration tests]] at Rosetta/main/main/tests/integration/tests/AnchoredDesign/ which functions as a small demo. 
There are more extensive demos with more documentation at `Rosetta/demo/protocol_capture/anchored_design`, `Rosetta/demo/public/anchored_design`, and `Rosetta/demo/public/domain_insertion`, which are online at TODO these three links to the online demos.

References
==========

-   [Lewis SM, Kuhlman BA. Anchored design of protein-protein interfaces. PLoS One. 2011;6(6):e20872. Epub 2011 Jun 17.](http://www.ncbi.nlm.nih.gov/pubmed/21698112) (pubmed link)

This paper describes how the code functions and computational benchmarking of the non-design aspects of the protocol.

-   [Gulyani A, Vitriol E, Allen R, Wu J, Gremyachinskiy D, Lewis S, Dewar B, Graves LM, Kay BK, Kuhlman B, Elston T, Hahn KM. A biosensor generated via high-throughput screening quantifies cell edge Src dynamics. Nat Chem Biol. 2011 Jun 12;7(7):437-44. doi: 10.1038/nchembio.585.](http://www.ncbi.nlm.nih.gov/pubmed/21666688) (pubmed link)

This paper describes the generation of a biosensor whose mode of activity is rationalized through the help of AnchoredDesign-derived models.

Purpose and Algorithm
=====================

AnchoredDesign is the main protocol discussed here. This protocol is meant to design interfaces between known target structures and new binding partners, using an "anchor" consisting of residues grafted from a known binding partner of the target onto the new scaffold. The idea is that this will reduce the conformational space we need to search and preclude the docking problem, while still leaving freedom to design the interface as necessary. The anchor should be grafted into a surface loop of the scaffold (see the [[AnchoredPDBCreator application|anchored-pdb-creator]]). Loop remodeling of the anchor loop will move the scaffold with respect to the target, exposing different parts of their surfaces to one another. Loop remodeling of other (unanchored) surface loops is also implemented. This lets us design a new, flexible-backbone interface between new binding partners.

Input Files
===========

See example runs above for more specific usage.  TODO page anchor

AnchoredDesign requires as inputs a starting structure, an anchor specification, and a loops specification ( See [[Loop modeling application|loopmodel]] and the [[loops file]]). The starting structure needs to have the anchor grafted into the scaffold (see [[AnchoredPDBCreator application|anchored-pdb-creator]] and its documentation), and the anchor needs to be docked properly relative to the target. The anchor/target interaction WILL NOT CHANGE, since it was drawn from a crystal structure. The relationship between the scaffold and rest of the system is treated flexibly; the scaffold does need to be connected to the anchor but it's fine if the scaffold crashes horribly into the target (that will be worked out by the protocol).

Note that the AnchoredDesign protocol respects the start, end, cut, and extended fields of the [[loops file]]. It ignores the skip_rate field.

The anchor file specification is a one-line file with three whitespace-delimited values: the chain letter, start, and end residue of the anchor. Like so:

`       B 442 445      `

It's going to assume PDBInfo exists, so if you have silent files try numbering from 1.

Options
=======

AnchoredDesign has its own namespace of options, and also supports general Rosetta options (packing, etc.)

AnchoredDesign options

-   anchor - string - anchor file
-   refine_only - boolean - do not run the perturbation step
-   show_extended - boolean - show the "extended loops" pdb - used as a check when doing structure prediction benchmarks
-   perturb_temp - real - Monte Carlo temperature for perturb phase
-   perturb_cycles - unsigned integer - number of perturb phase cycles
-   perturb_show - boolean - if true, outputs centroid poses after perturbation
-   debug - debug - debug mode (extra checks and pdb dumps)
-   refine_temp - real - Monte Carlo temperature for refine phase
-   refine_cycles - unsigned integer - number of refine phase cycles
-   refine_repack_cycles - unsigned integer - Perform a repack/minimize every N cycles of refine mode
-   allow_anchor_repack - boolean - off by default; allows the anchor to be repacked
-   vary_cutpoints - boolean - off by default; automatically pick new cutpoints each job. Great for large/MPI runs.
-   no_frags - boolean - disable all fragment moves (default is to take frags from an old-style frags file or autogenerate with the fragment picker)
-   VDW_weight - real - VDW score term weight in centroid mode; default is 1, but I am testing if 2 brings better results

These four boolean options allow deactivation of KIC or CCD loop closure for perturb and refine stages:

-   perturb_KIC_off
-   perturb_CCD_off
-   refine_KIC_off
-   refine_CCD_off

AnchoredDesign has a sub-namespace for filtering:

-   filters::score - real - do not print trajectories above this score
-   filters::sasa - real - do not print trajectories with interface delta sasas less than this
-   filters::omega - boolean - do not print trajectories with any loop omega torsions more than 30 degrees from trans

These options activate vicinity sampling in kinematic loop closure. (The default is to use random samples from the Ramachandran distribution for the non-pivot torsions in the loop; these options instead perturb the existing loop slightly). 
This is almost certainly out-of-date due to the development of [[Next Generation KIC]] loop closure.

-   loops::vicinity_sampling - bool - activate vicinity sampling
-   loops::vicinity_degree - real - degree range of perturbation; default is 1 degree

General options: All packing namespace options loaded by the PackerTask are respected. jd2 namespace options are respected. Anything very low-level, like the database paths, is respected.

-   packing::resfile - string - a [[resfile|resfiles]] if you want one
-   in::file::frag3 - string - fragments if you've got them
-   run::min_type - string - minimizer type. dfpmin_armijo_nonmonotone used for production.
-   loops::loop_file - string - [[loops file]]

PoseMetricCalculator flags include:

-   pose_metrics::interface_cutoff - real - interface depth for determining where to repack
-   pose_metrics::neighbor_by_distance_cutoff - real - loop neighbor depth for determining where to repack

Tips
====

-   You have three choices for fragments. If you say nothing, you get automatically generated fragments (this is good when designing the loops). The fragment picker is used to pick the top 4000 loop fragments and uses them in all loop frames. If you pass a frags file, it is used (good for known sequences). If you pass no\_frags, no fragments are used.
-   AnchoredDesign supports filtering. These are all post-protocol filters. No filters are active by default, passing an argument activates them independently. A failed filter results in returning FAIL_RETRY to the job distributor, which triggers re-running that nstruct from a new RNG point. Filtering DOES NOT speed up your trajectories.
-   AnchoredDesign uses LoopAnalyzerMover and InterfaceAnalyzerMover to report on the interface/loop quality. This information is appended to output PDBs.
-   I suggest -unmute protocols.loops.CcdLoopClosureMover, to get extra information about which loop CCD is trying. Kinematic reports by default.

Fluorophore modeling
====================

This section describes changes for fluorophore modeling experiments ([Gulyani A, Vitriol E, Allen R, Wu J, Gremyachinskiy D, Lewis S, Dewar B, Graves LM, Kay BK, Kuhlman B, Elston T, Hahn KM. A biosensor generated via high-throughput screening quantifies cell edge Src dynamics. Nat Chem Biol. 2011 Jun 12;7(7):437-44. doi: 10.1038/nchembio.585.](http://www.ncbi.nlm.nih.gov/pubmed/21666688) (pubmed link)).

In these experiments, a dye was chemically attached to a loop cysteine. In Rosetta, this was modeled as a [[noncanonical amino acid|noncanonical-amino-acids]] (the dye-cysteine conjugate). A few changes need to be made to accomodate a noncanonical amino acid in a flexible loop. These changes mostly focus on replacing the dunbrack and rama terms for that residue:

-   You have to make the params file and [[rotamer library|make-rot-lib]] for the noncanonical fluorophore conjugate. That is beyond the scope of this documentation. I used the pdb-file-of-rotamers style, not the dunbrack-library style.
-   Use the AnchoredDesign::akash::dye_pos flag to indicate to the protocol the location of the dye. The movemap used during minimization will prevent this residue from being minimized (to reflect the fact that there is no ramachandran plot of that residue).
-   If you use KIC loop modeling, and do NOT use vicinity sampling, then modify the function src::core::scoring::Ramachandran::random_phipsi_from_rama(AA const res_aa, Real & phi, Real & psi). You need to have it catch the case where res_aa is aa_unk, and reset it to some other residue type appropriate for your noncanonical (or alanine, which is probably good enough). You will need to modify the function signature to remove the const from the AA parameter (or make an internal copy, whatever).

Anchoring via constraint
========================

The code is capable of holding the anchor in place via constraints, rather than rigid locking through the fold tree. It will maintain a rigid anchor in the centroid perturb phase no matter what (I don't trust the centroid scorefunction that much), but it will allow internal backbone movement of the anchor, as well as rigid body movement, in full atom mode. I suggest using tight strong constraints to keep your anchor in place. Use these flags:

-   allow_anchor_repack (as above, to allow repacking if bb free)
-   constraints:cst_file - filename - to specify constraints
-   constraints:cst_weight - Real - weight for constraint score term
-   anchor_via_constraints - boolean - to activate constraints mode

Expected Outputs
================

AnchoredDesign should produce nstruct worth of result structures. If you used the default JobOutputter, you'll get PDBs with embedded score information and a scorefile summarizing most of the score information.

Post Processing
===============

There are three classes of output tagged to the end of the PDBs and/or in the scorefile:

-   scorefunction terms
-   LoopAnalyzerMover output,
-   InterfaceAnalyzerMover output.

The scorefunction tells you what Rosetta's standard scorefunctions think is best, and is useful for the first sorting of structures. Generally, only structures in the top few percent by total_score should be further analyzed. Even then, the other scorefunction terms (listed at the end of the PDB and in the score file) should be examined to throw out models that have particularly bad scores in any area - a model that is overall pretty good, but has a bad clash (fa_rep) for one particular residue, may be worth throwing out.

Next, you use the LoopAnalyzerMover output to filter for bad loop closures (which Rosetta's scorefunction detects insufficiently).  Read about it [[here|LoopAnalyzerMover]].

Finally, InterfaceAnalyzer puts results at the end of the PDB file as well; read about it here: [[Documentation for the InterfaceAnalyzer application|interface-analyzer]] . Again, throw out models with poor interfaces as determined by InterfaceAnalyzer.

Options for testing/debugging/experimental modes
================================================

These modes are not suggested for public use.

-   -delete_interface_native_sidechains (boolean, default false): This option removes the native sidechains near the interface of the input by repacking without -use_input_sc. -use_input_sc is generally recommended for AnchoredDesign to retain minimized rotamers; this forgetting step is useful when benchmarking to prevent unwanted information leaking in from the starting complex.
-   -RMSD_only_this (file): This option takes a path to a second input structure. AnchoredDesign skips its modification steps and just does its terminal RMSD comparisons (against this structure).
-   -super_secret_fixed_interface_mode (boolean, default false): This option activates a mode with an altered FoldTree that does not anchor the interface. Functionally it allows for "normal" redesign of interface loops (something the loop design executable does not do; although RosettaScripts does).
-   -randomize_input_sequence (boolean, default false): This option randomizes the input sequence of the designable positions to something within their resfile-defined mutational range. It forces HIS_D over HIS to prevent double-occurrence of HIS; all allowed canonical and noncanonical residues are weighted equally (unless you have noncanonicals that pretend to be histidine.) Useful because even with the loop extension mode, the centroid scorefunction's rama term will "know" what a loop of the input sequence should look like even without sidechains. AnchoredDesign normally only touches sequence after centroid mode, which may be too late to prevent unwanted recovery of a native loop/structure.

Changes since last release
==========================

Rosetta 3.3 is the first release. Benchmarking modes were added for 3.4 (I think?). Various testing options were created by the time of 3.5.

##See Also

* [[AnchorFinder | anchor-finder ]]: Locates plausible anchors at protein-protein interfaces.
* [[AnchoredPDBCreator | anchored-pdb-creator ]]: Creates input for this application.

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
