The Environment framework, also known as the ToplogyBroker, is a tool for generating larger, more complex simulation systems out of small interchangeable parts. The intent is to make rapid protocol development in RosettaScript easier by allowing sampling strategies to be carried out simultaneously rather than in sequence by constructing a consensus FoldTree that satisfies all movers. Such Movers inherit from the ClaimingMover (CM) class.

# For the User
There are a few currently available ClaimingMovers (abbreviated CM) that are ready to go:
* UniformRigidBodyCM: perform unbiased, rigid-body docking between two selected regions.
* FragmentCM: perform backbone torsion-angle fragment insertion on a target region.
* FragmentJumpCM: beta-strand/beta-strand pairing fragment insertion
* LoopCM: access to loop closure algorithms KIC and CCD modes refine and perturb
* RigidChunkCM: fix a region to values given in a pdb file and prevent other movers from sampling there
* CoMTrackerCM: generate a virtual residue that tracks the center of mass of a particular region
* AbscriptLoopCloserCM: close loops using the WidthFirstSlidingWindowLoopCloser (used in _ab initio_ to close unphysical chainbreaks)
* ScriptCM: interface with the Broker system for an arbitrary movemap-accepting mover (_i.e._ inherits from MoveMapMover).

## UniformRigidBodyCM
## FragmentCM
## FragmentJumpCM
## LoopCM
## RigidChunkCM
## CoMTrackerCM
## AbscriptLoopCloserCM
## ScriptCM