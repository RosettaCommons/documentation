The motivation and basic philosophy behind the stepwise approach to protein & RNA modeling is described in the [[general application documentation|stepwise]]. This page and the associated content is meant to be a resource for Rosetta developers who will be re-using or advancing the core classes in the `stepwise` code. At the time of writing, this code has been primarily developed for modeling RNA loops and motifs with some tests on small protein loops and mini proteins.
There are several potentially exciting frontiers that would require modest extensions to the current framework, including: refinement of protein, RNA, and protein/RNA crystal structures; building of termini and loops via integration with the new, unified LoopMover framework; and stepwise design of loops and mini-proteins. 
  
- [[Monte Carlo Moves|stepwise-classes-moves]] and the move schedule 
- [[SampleAndScreen|stepwise-sample-and-screen]] is a general class for enumerating or stochastically sampling residues (or rigid bodies) 
- [[Samplers|stepwise-samplers]] are concatenated together to define the sampling loop, and can go through millions of poses.
- [[Screeners|stepwise-screeners]] are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. 
- [[FullModelInfo|stepwise-fullmodelinfo]] is an important book-keeping object held by the pose used throughout the stepwise code. 
- [[Score terms|stepwise-score]] calculate energies for a full model even if only subpieces are instantiated (other_pose, loop_close, free_side_chain).
