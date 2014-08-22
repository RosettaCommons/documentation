# Stepwise documentation: Overview
#A little history
In prediction & design, the models we get back aren't always the lowest in Rosetta energy, especially if backbone movements need to be sampled. The stepwise assembly (SWA) approach was introduced into Rosetta by the Das lab to address conformational sampling bottlenecks for 10-20 residue problems. It finds very low energy structures through an enumeration over residue-by-residue steps & dynamic programming, and has outperformed fragment-based sampling where implemented – mostly RNA & RNA/protein problems. Despite interest from RosettaCommons labs, two barriers have precluded testing on problems like antibody modeling or protein interface design: SWA required queuing scripts specially customized to each cluster, and it was computationally expensive. The Das lab recently implemented a stepwise monte carlo (SWM) method that eliminates these barriers. SWM is embarassingly parallel and reduces computational expense from 10,000 CPU-hours to hours or minutes. The new `stepwise` framework also allows for sequence-optimization & constraints – necessary for design. A few straightforward steps would allow testing of the stepwise approach within any Rosetta protocol that invokes modeling/design over small sub-systems, including loops, enzyme active sites, and cyclic-peptides. This documentation is being written to help developers in different RosettaCommons labs to bring together separately evolving advances in protein and RNA sampling via the stepwise modeling framework and to allow wide testing of a powerful method that is complementary to most labs’ current sampling arsenals. 

#An appeal
If you update the code or find something missing in this documentation, *please take a minute to EDIT this documentation for future users.* Thanks!

# Overview, by directory
## The application
- The `stepwise` application is available in `src/apps/public/stepwise/stepwise.cc`. It is documented for the general user, with illustrative demos (and movies!) [[here|stepwise]]. It is currently pretty concise, with most setup delegated to constructors and classes described below. 

- If you add several lines to it to add functionality, great! Please also consider packaging those lines together and moving into the appropriate `util.cc` or other `protocols/` file, to keep this file concise -- send a note to rhiju for advice. If you see a way to make this application more concise, even better!

- At the time of writing, there is also a `src/apps/public/stepwise/legacy/` subdirectory with `swa_protein_main`, `swa_rna_main`, and `swa_rna_util`. Almost all of the functionality of these older apps has now been reconstituted with much more modular classes. After some head-to-head comparisons in 2014-2015, publication of a methods paper on stepwise monte carlo, and updates to ERRASER, the plan is to remove this legacy code from the repository.
 
## Protocols
Almost all code relevant to stepwise monte carlo and assembly is in `src/protocols/stepwise`.
The contents of this directory are as follows, in order of importance.

# monte_carlo/
Moves and schedule of stochastic sampling for stepwise monte carlo (abbreviated SWM throughout the code). More information on classes are summarized under [[Monte Carlo Moves|stepwise-classes-moves]].

# modeler/
Essentially every move in stepwise monte carlo (or stepwise enumeration) calls `StepWiseModeler`, which is in this directory. It takes a `pose` and a single position `moving residue`, and figures everything out from there, including  whether to sample of one terminal nucleotide (default for RNA), or two amino acids (default for protein); what the two partitions are that will move relative to each other (there are essentially always two!); and whether to do rigid body docking (if the moving residue's parent is a jump). This is where choices should be encoded for, e.g., non-natural polymers.

Here is the  `apply` function for `StepWiseModeler`:
```
		initialize( pose );

		do_prepacking( pose );
		do_modeler( pose );
		if ( modeler_successful() ) do_minimizing( pose );

		reinitialize( pose );
```
• `initialize` figures out a bunch of working parameters -- which residues to move, any `bridge_res` residues to CCD close, etc. -- into one object. All of this information can actually be derived from the pose & `moving_res`, but it was historical to have all of it readily available in one object. The function also re-roots the pose so that the biggest partition is fixed, and aligns it to an alignment pose; this accelerates computation. Last, native constraints can be applied here if the `rmsd_screen` option is specified from command line.
• `do_prepacking` packs protein side-chains and RNA 2' hydroxyls, as well as any 5' or 3' phosphates that are hanging off RNA strands. By default, the packing allows virtualization of side-chains and RNA hydroxyls -- if there aren't enough contacts with those groups to define them, they are kept virtual (through bonuses in the `free_side_chain` and `free_2HOprime` terms).
• `do_modeler` actually carries out the enumerative or stochastic sampling using the StepWiseConnectionSampler, which sets up a [SampleAndScreen|stepwise-sample-and-screen] (see below).  No minimizing occurs here,  just a grid search over backbone torsions or rigid-body DOFs.
• `do_minimizing` takes the lowest energy pose(s) found in sampling, and carries out minimization. How many poses to minimize is encoded in option `num_pose_minimize` (see [options/] below).
• `reinitialize` zeros out several objects in `StepWiseModeler` in case it is reused (which it will be in `StepWiseMonteCarlo` applications). It also removes any native constraints added to the pose.

# StepWiseSampleAndScreen.cc

# sampler/

# screener/

# options/

# full_model_info/

# legacy/
- [[SampleAndScreen|stepwise-sample-and-screen]] is a general class for enumerating or stochastically sampling residues (or rigid bodies) 
- [[Samplers|stepwise-samplers]] are concatenated together to define the sampling loop, and can go through millions of poses.
- [[Screeners|stepwise-screeners]] are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. 

## Core
- [[FullModelInfo|stepwise-fullmodelinfo]] is an important book-keeping object held by the pose used throughout the stepwise code. 
- [[Score terms|stepwise-score]] calculate energies for a full model even if only subpieces are instantiated (other_pose, loop_close, free_side_chain).


