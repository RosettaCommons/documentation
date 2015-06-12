# Loop Modeling
## Loop Modeling

The goal of loop modeling is to predict the conformation of a relatively short 
stretch of protein backbone and sidechain.  As one example, it's not uncommon 
for crystal structures to be missing density in some regions.  Loop modeling 
can be used to predict structures for these regions.  As another, homology 
models often need to account for short insertions or deletions.  Loop modeling 
can be used to predict how these sequence changes affect structure.

Loop modeling in Rosetta is very configurable, but the basic algorithm goes 
like this:

* Inputs:
 
  The inputs are a protein structure and a set of indices specifying where one 
  or more regions to model (i.e. the loop or loops) start and stop.

* Step 1: Initial build
 
  The algorithm starts by building an initial backbone for each loop being 
  sampled.  This backbone is just a starting point for the rest of the 
  algorithm, so it's only realistic in the sense of having reasonable bond 
  lengths and not completely clashing with anything.  Note that by skipping 
  this step, you can use the loop modeling algorithm for ensemble generation.

* Step 2: Centroid refinement

  The algorithm continues by refining the loop conformation in the context of 
  the centroid score function.  The centroid score function represents the 
  backbone atoms in full detail, but abstracts the sidechains into spherical 
  blobs.  This creates a smoother energy landscape that is easier to explore 
  broadly.  The landscape is sampled using Monte Carlo "local backbone moves", 
  i.e. moves that perturb the backbone within the region being sampled but not 
  outside of it.
  
* Step 3: Fullatom refinement

  The algorithm finishes by refining the loop conformation in the context of 
  the fullatom score function.  This is conceptually very similar to the 
  centroid refinement discussed above, except now all the atoms are 
  represented in full detail and both sidechain and local backbone Monte Carlo 
  moves are employed.

* Outputs:

  Each loop modeling simulation takes about 30 minutes and produces one model 
  structure as output.  Typically, to predict a structure for a single loop, 
  you would generate at least 500 such models and take whichever has the lowest 
  energy.  You might also calculate an RMSD for each model relative to the 
  lowest scoring one and look for funnels in score vs. RMSD space.

## Relevant movers

* [[LoopModeler|LoopModelerMover]]
* [[LoopBuilder|LoopBuilderMover]]
* [[LoopProtocol|LoopProtocolMover]]
* [[KicMover]]
* [[RepackingRefiner|RepackingRefinerMover]]
* [[RotamerTrialsRefiner|RotamerTrialsRefinerMover]]
* [[MinimizationRefiner|MinimizationRefinerMover]]
* [[PrepareForCentroid|PrepareForCentroidMover]]
* [[PrepareForFullatom|PrepareForFullatomMover]]

##See Also

* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Loopmodel application|loopmodel]]
* [[Structure prediction applications]]: A list of command line applications to be used for structure prediction, including loop modeling
* [[Loop file format|loops-file]]
* [[Fragments file format|fragment-file]]