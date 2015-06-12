#StepWiseScreener
`StepWiseScreener` objects are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. The base class is in `src/protocols/screener/StepWiseScreener.cc`. The primary example of how to set up these objects is the `initialize_screeners()` function of `StepWiseConnectionSampler`.

# Most important functions 
###`bool check_screen()`
Return true/false if a filter.

Return true if the job of this screener is to always pass, but to carry out an action -- and run the action (e.g., packing or loop closure) in this function.

###`bool name()`
Required for output of final 'cut table' in [[`StepWiseSampleAndScreen`|stepwise-sample-and-screen]], the number of samples that pass each StepWiseScreener

###`StepWiseScreenerType type()`
Register your `StepWiseScreener` in the enum in `StepWiseScreenerType.hh`.


###`void add_mover( CompositionMoverOP update_mover, CompositionMoverOP restore_mover )`
How this screener can communicate to later screeners any things to apply to their poses.
A `CompositionMover` is basically a `vector1` of movers (actually, mover pointers). If the mover pointer is null, that means do nothing. 


###`void apply_mover( CompositionMoverOP, Size const, Size const )`
How this `StepWiseScreener` receives communication from prior screeners.


###`void fast_forward( StepWiseSamplerBaseOP )`
If this `StepWiseScreener` fails `check_screen`, this function can tell the sampler to skip ahead. For example, in docking, if the rigid body arrangement of two partitions does not allow for chain closure, it may make sense to skip any fine-grained sampling of residue alternatives.


# Useful sub-classes
### `SampleApplier`
Holds a `pose_` as a private variable. Automatically knows what to do when handed movers through `apply_mover()`. This sub-class is a better choice than the base `StepWiseScreener` class for actions that require working on a 'scratch' pose, e.g., `ProteinCCD_ClosureScreener`, or `SugarInstantiator`. 

### `StepWiseResiduePairScreener`
Holds two residue positions as private variables. This ends up being useful for fast_forwarding past alternatives for either or both residues if, say, a distance screen fails.

# Currently available `StepWiseScreener` classes
### Basic Actions
`PoseSelectionScreener.cc` should be at the end of all screeners. It holds a StepWiseClusterer which collects poses and can cluster 'on-the-fly'.

###Common Filters
`PartitionContactScreener.cc` looks at the two partitions whose intermediate connection (a jump or several backbone DOFS) is being sampled. Asks for no clashes, but some contact, essentially by computing `fa_atr` and `fa_rep` score terms for pairs of cross-partition residues.

`VDW_BinScreener.cc` enables fast clash checks -- equivalent to a `BumpGrid` (and perhaps should use that object).

`NativeRMSD_Screener.cc` for staying close to a reference pose. Takes advantage of alignment over largest partition that occurs in the [[`StepWiseModeler`|stepwise-modeler]] wrapper before running StepWiseSampleAndScreen.

`BaseCentroidScreener.cc` is specific to RNA, and asks for at least one base pair or base stack between partitions of the pose.

### Chain Closure
`ProteinCCD_ClosureScreener.cc` and`RNA_ChainClosureScreener.cc`

### Packing
`PackScreener.cc` for calls to protein side chain Packer; `O2PrimeScreener.cc` for RNA 2'-OH  packing, and `PhosphateScreener.cc` for specialized sampling of phosphates at 5' or 3' ends of RNA strands. In all cases, packing allows the possibility of virtualizing these 'secondary' side-chain(-like) moieties of the biopolymer.

###Geometric Filters
Largely developed for sampling 'floating bases' for RNA -- docking of nucleotides that are not covalently connected to the rest of the pose, but instead separated by a single nucleotide:  `RNA_ChainClosableGeometryResidueBasedScreener.cc`, `RNA_ChainClosableGeometryScreener.cc`, `RNA_ChainClosableGeometryStubBasedScreener.cc`, `AnchorSugarScreener.cc`, `CentroidDistanceScreener.cc`, `ResidueContactScreener.cc`. Developed and tested mainly for RNA, but could be generalized easily to protein, protein/RNA problems, etc.

### Rigid Body
`StubApplier.cc` and `StubDistanceScreener.cc` allow screening of rigid-body arrangements during docking based purely on geometry, without requiring pose updates (which can take a very long time). Currently tested only for RNA, but should be easy to generalize.

### Sampler fast-forwarding (advanced)
`IntegrationTestBreaker.cc` is a special early 'shut-down' of sampling to make enumerative integration tests fast.

`FastForwardToNextRigidBody.cc` and `FastForwardToNextResidueAlternative.cc`  are specialized to docking -- once a solution is found for the internal DOFs of two docked partitions, skip ahead to the next rigid body arrangment.

### Rarely used
`TagDefinition.cc` can figure out and store a special tag in the pose. May be deprecated soon.

`Scorer.cc` scores the pose with a specified scorefunction. Usually this happens anyway in other screeners, so this is not needed.

`BulgeApplier.cc` was used for virtualizing RNA residues not making contact.  May be deprecated soon.

`SugarInstantiator.cc` was used to instantiate riboses of 'floating' RNA bases that could make a possible hydrogen bond to something. May be deprecated soon.

`BaseBinMapUpdater.cc` was used for rigid body sampling of RNA bases, but not supported anymore.

Go back to [[StepWiseSampleAndScreen|stepwise-sample-and-screen]].

Go all the way back to [[StepWise Overview|stepwise-classes-overview]].

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
