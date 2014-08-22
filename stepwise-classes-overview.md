# Stepwise documentation: Overview
#A little history
In prediction & design, the models we get back aren't always the lowest in Rosetta energy, especially if backbone movements need to be sampled. The stepwise assembly (SWA) approach was introduced into Rosetta by the Das lab to address conformational sampling bottlenecks for 10-20 residue problems. It finds very low energy structures through an enumeration over residue-by-residue steps & dynamic programming, and has outperformed fragment-based sampling where implemented – mostly RNA & RNA/protein problems. Despite interest from RosettaCommons labs, two barriers have precluded testing on problems like antibody modeling or protein interface design: SWA required queuing scripts specially customized to each cluster, and it was computationally expensive. The Das lab recently implemented a stepwise monte carlo (SWM) method that eliminates these barriers. SWM is embarassingly parallel and reduces computational expense from 10,000 CPU-hours to hours or minutes. The new `stepwise` framework also allows for sequence-optimization & constraints – necessary for design. A few straightforward steps would allow testing of the stepwise approach within any Rosetta protocol that invokes modeling/design over small sub-systems, including loops, enzyme active sites, and cyclic-peptides. This documentation is being written to help developers in different RosettaCommons labs to bring together separately evolving advances in protein and RNA sampling via the stepwise modeling framework and to allow wide testing of a powerful method that is complementary to most labs’ current sampling arsenals. 

#An appeal
If you update the code or find something missing in this documentation, *please take a minute to EDIT this documentation for future users.* Thanks!

# Overview, by directory
## The application
- The `stepwise` application is available in `src/apps/public/stepwise/stepwise.cc`. It is documented for the general user, with illustrative demos (and movies!) [[here|stepwise]]. It is currently pretty concise, with most setup delegated to constructors and classes described below. 

- If you add several lines to it to add functionality, great! Please also consider packaging those lines together and moving into the appropriate `util.cc` or other `protocols/` file, to keep this file concise. If you see a way to make this application more concise, even better!

- At the time of writing, there is also a `src/apps/public/stepwise/legacy/` subdirectory with `swa_protein_main`, `swa_rna_main`, and `swa_rna_util`. Almost all of the functionality of these older apps has now been reconstituted with much more modular classes. After some head-to-head comparisons in 2014-2015, publication of a methods paper on stepwise monte carlo, and updates to ERRASER, the plan is to remove this legacy code from the repository.
 
## Protocols
- [[Monte Carlo Moves|stepwise-classes-moves]] and the move schedule 
- [[SampleAndScreen|stepwise-sample-and-screen]] is a general class for enumerating or stochastically sampling residues (or rigid bodies) 
- [[Samplers|stepwise-samplers]] are concatenated together to define the sampling loop, and can go through millions of poses.
- [[Screeners|stepwise-screeners]] are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. 

## Core
- [[FullModelInfo|stepwise-fullmodelinfo]] is an important book-keeping object held by the pose used throughout the stepwise code. 
- [[Score terms|stepwise-score]] calculate energies for a full model even if only subpieces are instantiated (other_pose, loop_close, free_side_chain).


