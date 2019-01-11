# Stepwise documentation: Overview
# A little history
------------------
In prediction & design, the models we get back aren't always the lowest in Rosetta energy, especially if backbone movements need to be sampled. The stepwise assembly (SWA) approach was introduced into Rosetta by the Das lab to address conformational sampling bottlenecks for 10-20 residue problems. It finds very low energy structures through an enumeration over residue-by-residue steps & dynamic programming, and has outperformed fragment-based sampling where implemented – mostly RNA & RNA/protein problems. 

Despite interest from RosettaCommons labs, two barriers have precluded testing on problems like antibody modeling or protein interface design: SWA required queuing scripts specially customized to each cluster, and it was computationally expensive. The Das lab recently implemented a stepwise monte carlo (SWM) method that eliminates these barriers. SWM is embarassingly parallel and reduces computational expense from 10,000 CPU-hours to hours or minutes. The new `stepwise` framework also allows for sequence-optimization & constraints – necessary for design. A few straightforward steps would allow testing of the stepwise approach within any Rosetta protocol that invokes modeling/design over small sub-systems, including loops, enzyme active sites, and cyclic-peptides. 

This documentation is being written to help developers in different RosettaCommons labs to bring together separately evolving advances in protein and RNA sampling via the stepwise modeling framework and to allow wide testing of a powerful method that is complementary to most labs’ current sampling arsenals. 

An appeal: If you update the code or find something missing in this documentation, *please take a minute to EDIT this documentation for future developers.* Or if you can't do it, send a note to rhiju@stanford.edu, who will coordinate updates. Thanks!

# The 'stepwise' ansatz
-----------------------
Given one or more chains of residues in a crystallographic motif to be built de novo from 5’ to 3’ for each chain, stepwise Monte Carlo proceeds through recursion over a series of *cycles*, each cycle consisting of instantiation, de novo sampling, and minimization of a single residue. The ultimate aim is to extend the 5'-end fragment forward from 5' to 3' and to extend the 5'-end fragmnet backward from 3' to 5', resulting in a closed loop.

The assumption that experimentally occurring structures arise (or at least, can be arrived at) such step-by-step building of individual residues is what we previously termed a 'stepwise ansatz' {Sripakdeevong, PNAS, 2011}. Unlike other modes of Rosetta, stepwise employs single-residue moves, including the deletion and addition of individual residues. These moves are concentrated at termini and are accepted frequently; this allows for deep optimization of an all-atom energy function. For some problems, poses can also be split and merged, and separate chains can be docked or undocked, as described below.

The SWM calculation requires two input files: (1) a fasta file containing the sequences of chains in the user's full modeling problem; and (2) a PDB file or set of files providing any input starting structures for the problem. Optionally, users may also provide: (3) a native PDB file, if RMSD computation is desired; or (4) an alignment PDB file, if the user desires to keep the modeling constrained to be close to an existing structure.


# Workflow, from the outermost to innermost layer of the onion
--------------------------------------------------------------
(1) The `stepwise` app creates a `StepWiseMonteCarlo` object, which is a standard Rosetta `Mover`, and applies it to a `pose`. 

(2) In `StepWiseMonteCarlo`, several cycles of Monte Carlo minimization are run on the pose, again using a standard Rosetta `MonteCarlo` object. 

(3) Each cycle involves random selection of a `StepWiseMove`. [There is also a mode where you can apply a single move for testing or for enumeration.]

(4) Application of a `StepWiseMove` means adding, deleting, splitting, or merging some residues in the pose; and then asking a `StepWiseModeler` to resample the affected DOFs. The resampled DOFs define a `move_element` which can be the backbone DOFS of a terminal residue, the internal covalent connection between contiguous residues, or a jump (re-docking). It is also possible to make no covalent adds/deletes to the `pose` and instead just resample a specific connection. These 'resample' moves can either operate on a terminal residue (in which case they operate similar to the 'add' move sampling) or an internal residue (in which case they sample a subset of residue torsions and use kinematic closure to solve for the rest).

(5) The `StepWiseModeler` does some aligning and packing of the pose and then runs a `StepWiseConnectionSampler` using a bunch of variables setup in `StepWiseWorkingParameters`. That's the key step. After that, the `StepWiseModeler` then minimizes one (or sometimes more) resulting poses.

(6) Based on the `StepWiseWorkingParameters`, the `StepWiseConnectionSampler` initializes and runs the core stepwise functionality, called a `StepWiseSampleAndScreen`.

(7) `StepWiseSampleAndScreen` object is the core 'main loop' in stepwise modeling. It involves plug-and-play of several possible `StepWiseSamplers` (defining the nested loops of DOF sampling) and `StepWiseScreeners` (the gauntlet of filters, closers, packers, and clusterers).

# Classes, by directory
-----------------------
## The application is `stepwise.cc`
-----------------------------------
• The `stepwise` application is available in `src/apps/public/stepwise/stepwise.cc`. It is documented for the general user, with illustrative demos (and movies!) [[here|stepwise]]. It is currently pretty concise, with most setup delegated to constructors and classes described below. 

• If you add several lines to `stepwise.cc` to add functionality, great! Please also consider packaging those lines together and moving into the appropriate `util.cc` in a `protocols/stepwise/` subdirectory, to keep this main application file concise -- send a note to rhiju for advice. If you see a way to make this application more concise, even better!

• At the time of writing, there is also a `src/apps/public/stepwise/legacy/` subdirectory with `swa_protein_main`, `swa_rna_main`, and `swa_rna_util`. Almost all of the functionality of these older apps has now been reconstituted with much more modular classes. After some head-to-head comparisons in 2014-2015, publication of a methods paper on stepwise monte carlo, and updates to ERRASER, the plan is to remove this legacy code from the repository.
 
## protocols
------------
Almost all code relevant to stepwise monte carlo and assembly is in `src/protocols/stepwise`.
The contents of this directory are as follows, in order of importance.

### modeler/
Essentially every move in stepwise monte carlo (or stepwise enumeration) calls `StepWiseModeler`, which is in this directory. It takes a `pose` and a single position `moving residue`, and figures everything out from there. This is where choices should be encoded for, e.g., non-natural polymers or future moves that build residues through disulfides. More info is at the [[StepWiseModeler|stepwise-modeler]] page. Description of available options available at the [[StepWiseOptions|stepwise-options]] page.

### monte_carlo/
Moves and schedule of stochastic sampling for stepwise monte carlo (abbreviated SWM throughout the code). More information on classes are summarized under [[Monte Carlo Moves|stepwise-classes-moves]].

### StepWiseSampleAndScreen, sampler/, and screener/
These hold the various classes for enumerating or stochastically sampling residues (or rigid bodies). Detailed description on the [[StepWiseSampleAndScreen|stepwise-sample-and-screen]] page.

### options/
The options framework for stepwise modeler derives from `basic::resource_manager::ResourceOptions`, with convenient inheritance from StepWiseBasicOptions to StepWiseMonteCarloOptions and to StepWiseBasicModelerOptions (which itself parents StepWiseModelerOptions). Reasonably full list of options summarized at the [[StepWiseOptions|stepwise-options]] page.

### legacy/
This subdirectory has a lot of code written by P. Sripakdeevong & R. Das in 2009-2011 during tests of stepwise enumeration for RNA and proteins. It was not very modular, and the protein and RNA stuff was not unified; the modern `stepwise` framework fixes these issues. As mentioned above for `apps/public/stepwise/legacy`, these files will be removed after verification in 2015 that they can be fully deprecated.

## core
--------------------------------------------
### full_model_info
[[FullModelInfo|stepwise-fullmodelinfo]], in `src/core/pose/full_model_info/` is an important book-keeping object held by the pose used throughout the stepwise code. 

### scoring
Several [[score terms|stepwise-score]] in `src/core/scoring/` calculate energies for a full model even if only subpieces are instantiated (`other_pose`, `loop_close`, `free_side_chain`).

### additional notes 
Several helper functions developed for stepwise modeling have been lifted into various util.cc functions or classes. Of note are:

• `correctly_add_cutpoint_variants` in `core/pose/variant_util.hh`. Not only adds CUTPOINT variants & virtual atoms for sealing chainbreaks but also sets up chemical bond structure for both RNA and protein. And removes other variants that are incompatible with cutpoints.  
• `pdbslice` in `core/pose/util.hh` cuts subsets of residues out of poses, with smart resetting of jump atoms & variant handling.

## import_pose

Several functions in `import_pose/import_pose.cc` help to set up `Pose`s for `stepwise`-specific use. Furthermore, the `FullModelPoseBuilder` class controls one important aspect of how `stepwise` interprets the `-s` command line option. Unlike in standard `jd2` or `jd3` applications, `stepwise` does not assume that every argument to `-s` is a separate input PDB to which a particular `Mover` or more complex protocol ought to be independently applied. Rather, every input to `-s` reflects a different input 'chunk' of RNA to be stitched together by instantiated loops.

What does this mean practically? Well, we need to take the fasta file (obtained from `-fasta`) as a sort of guide to the "full modeling problem" we intend to solve. Then, we collect all the `Pose`s provided at `-s` and we interpret them as a 'focused pose' and a set of 'other' poses, and store the 'other' poses by owning pointer in the 'main pose'. These functions hide this slightly baroque but gratifyingly rarely-changing behavior.

##See Also

* [[Stepwise options]]: Options classes for Stepwise code
* [[Writing an application]]
* [[Development Documentation]]: The home page for development documentation
* [[I want to do x]]: Guide to selecting movers for structural perturbations
* [[Stepwise]]: The StepWise MonteCarlo application
* Applications for deterministic stepwise assembly:
  * [[Stepwise assembly for protein loops|swa-protein-main]]
    * [[Additional documentation|swa-protein-long-loop]]
  * [[RNA loop modeling with Stepwise Assembly|swa-rna-loop]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
