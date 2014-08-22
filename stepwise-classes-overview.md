# Stepwise docuemntation -- Overview
#A little history
In prediction & design, the models we get back aren't always the lowest in Rosetta energy, especially if backbone movements need to be sampled. The stepwise assembly (SWA) approach was introduced into Rosetta by my lab to address conformational sampling bottlenecks for 10-20 residue problems. It finds very low energy structures through an enumeration over residue-by-residue steps & dynamic programming, and has outperformed fragment-based sampling where we have implemented it – mostly RNA & RNA/protein problems. Despite interest from RosettaCommons labs, two barriers have precluded testing on problems like antibody modeling or protein interface design: SWA requires queuing scripts specially customized to each cluster, and it is computationally expensive. My lab has recently implemented a stepwise monte carlo (SWM) method that eliminates these barriers. SWM is embarassingly parallel and reduces computational expense from 10,000 CPU-hours to hours or minutes. The new framework also allows for sequence-optimization & constraints – necessary for design. A few straightforward steps would allow testing of SWM within any Rosetta protocol that invokes modeling/design over small sub-systems, including loops, enzyme active sites, and cyclic-peptides. This documentation is being written to help developers in different RosettaCommons labs to bring together separately evolving advances in protein and RNA sampling in the stepwise modeling framework and allow wide testing of a powerful method that is complementary to most labs’ current sampling arsenals.
  
# Overview of important classes
- [[Monte Carlo Moves|stepwise-classes-moves]] and the move schedule 
- [[SampleAndScreen|stepwise-sample-and-screen]] is a general class for enumerating or stochastically sampling residues (or rigid bodies) 
- [[Samplers|stepwise-samplers]] are concatenated together to define the sampling loop, and can go through millions of poses.
- [[Screeners|stepwise-screeners]] are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. 
- [[FullModelInfo|stepwise-fullmodelinfo]] is an important book-keeping object held by the pose used throughout the stepwise code. 
- [[Score terms|stepwise-score]] calculate energies for a full model even if only subpieces are instantiated (other_pose, loop_close, free_side_chain).


