#Movers (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

Each mover definition has the following structure

```
<"mover_name" name="&string" .../>
```

where "mover\_name" belongs to a predefined set of possible movers that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the mover needs to be defined.

[[_TOC_]]

Mover Documentation Guide
-------------------------

Since RosettaScripts allows you to put Movers together in ways that have not been tried before there are a few things you **NEED** to answer when documenting your mover:

-   General description of what the mover does
    -   Example: This is meant as an example of how to construct a Mover in RosettaScripts and how to describe all of the options that it takes. This outline was decided upon at Post-RosettaCon11-Minicon.
-   XML code example:

```
<MyMover name="&string" bool_option=(1 &bool) int_option=(50 &int) string_option=(&string) real_option=(2.2 &Real) scorefxn=(default_scorefxn &string) task_operations=(&string,&string,&string)/>)
```

-   What the tags do:
    -   **bool\_option** describes how a boolean tag is made. Default is true.
    -   **int\_option** describes how an integer tag is made. Let's say this represents \# of cycles of a loop to run, so the range would have to be \> 0.
    -   **real\_option** describes how to a Real option tag is made.
    -   **string\_option** is an example of how a string tag is made.
-   What options must be provided?
    -   For example let's say that we need to pass a value to string\_option or the protocol will not not run, you would include something like this:
    -   string\_option="/path/to/some/file" needs to be defined to avoid mover exit.
-   Expected input type:
    -   Does this mover expect a certain kind of pose (protein/DNA, 2 chains, monomer)
-   Internal TaskOperations:
    -   Are there default TaskOperations (RestrictToInterface for example) that this mover uses, is there a way to override them?
-   FoldTree / Constraint changes:
    -   Describe if/how the mover modifies the input (or default) FoldTree or Constraints
-   If the mover can change the length of the pose say so.

Predefined Movers
-----------------

The following are defined internally in the parser, and the protocol can use them without defining them explicitly.

**NullMover**

Has an empty apply. Will be used as the default mover in \<PROTOCOLS\> if no mover\_name is specified. Can be explicitly specified, with the name "null".


General Movers
--------------
[[General Movers | general-movers]]


Special Movers
--------------
[[Special Movers | special-movers]]

Loop Modeling Movers
--------------------
[[Loop Modeling Movers | loop-modeling-movers]]

Protein Interface Modeling/Design/Analysis Movers
-------------------------------------------------
These movers are at least somewhat specific to the design of protein-protein interfaces. Attempting to use them with, for example, protein-DNA complexes may result in unexpected behavior.

[[Protein Interface Modeling, Design, and Analysis Movers | protein-interface-design-movers]]

Ligand-centric Movers
---------------------
[[Ligand Centric Movers | ligand-centric-movers]]

DNA interface Design Movers
---------------------------
[[DNA Interface Design Movers | dna-interface-design-movers]] 

Currently Undocumented
----------------------
The following Movers are available through RosettaScripts, but are not currently documented. See the code (particularly the respective parse\_my\_tag() and apply() functions) for details. (Some may be undocumented as they are experimental/not fully functional.)

AddEncounterConstraintMover, BackboneSampler, BackrubSidechain, BluePrintBDR, CAcstGenerator, CCDLoopCloser, CartesianSampler, CircularPermutation, CloseFold, CompoundTranslate, ConformerSwitchMover, ConstraintFileCstGenerator, CoordinateCst, DefineMovableLoops, DesignProteinBackboneAroundDNA, DnaInterfaceMinMover, DnaInterfaceMultiStateDesign, DockSetupMover, DockingInitialPerturbation, EnzdesRemodelMover, ExtendedPoseMover, FavorNonNativeResidue, FlxbbDesign, FragmentLoopInserter, GenericSymmetricSampler, GridInitMover, GrowPeptides, HamiltonianExchange, HotspotHasher, Hybridize, InsertZincCoordinationRemarkLines, InterlockAroma, InverseRotamersCstGenerator, InvrotTreeCstGenerator, IterativeLoophashLoopInserter, JumpRotamerSidechain, LigandDesign, LoadVarSolDistSasaCalculatorMover, LoadZnCoordNumHbondCalculatorMover, LoopHash, LoopHashDiversifier, LoopMover\_Perturb\_CCD, LoopMover\_Perturb\_KIC, LoopMover\_Perturb\_QuickCCD, LoopMover\_Perturb\_QuickCCD\_Moves, LoopMover\_Refine\_Backrub, LoopMover\_Refine\_CCD, LoopMover\_Refine\_KIC, LoopMover\_SlidingWindow, LoopRefineInnerCycleContainer, LoopRelaxMover, LoophashLoopInserter, MatchResiduesMover, MatcherMover, MinimizeBackbone, ModifyVariantType, ModulatedMover, MotifDnaPacker, NtoCCstGenerator, PDBReload, ParallelTempering, PerturbChiSidechain, PerturbRotamerSidechain, PlaceSurfaceProbe, RandomConformers, RemodelLoop, RemoveCsts, RepackTrial, ResidueVicinityCstCreator, RigidBodyPerturbNoCenter, RotamerRecoveryMover, Rotates, SaneMinMover, ScoreMover, SeedFoldTree, SeedSetupMover, SeparateDnaFromNonDna, SetAACompositionPotential, SetChiMover, SetSecStructEnergies, SetupForDensityScoring, SetupHotspotConstraints, SetupHotspotConstraintsLoops, ShearMinCCDTrial, SheetCstGenerator, ShoveResidueMover, SimulatedTempering, SmallMinCCDTrial, StapleMover, StoreCombinedStoredTasksMover, SwapSegment, Symmetrizer, TempWeightedMetropolisHastings, ThermodynamicRigidBodyPerturbNoCenter, TrialCounterObserver, load\_unbound\_rot, profile
