#Filters (RosettaScripts)

[[Return to RosettaScripts|RosettaScripts]]

Each filter definition has the following format:

```
<"filter_name" name="&string" ... confidence=(1 &Real)/>
```

where "filter\_name" belongs to a predefined set of possible filters that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the filter needs to be defined.

If confidence is 1.0, then the filter is evaluated as in predicate logic (T/F). If the value is less than 0.999, then the filter is evaluated as fuzzy, so that it will return True in (1.0 - confidence) fraction of times it is probed. This should be useful for cases in which experimental data are ambiguous or uncertain.

[[_TOC_]]

## Predefined Filters

Simple filter which are available without explicitly defining them.

**[[TrueFilter]]** - Always passes.

**[[FalseFilter]]** - Never passes.

## Special Filters

Filters which are useful for combining, modifying or working with other filters and movers.

**[[CompoundStatement|CompoundStatementFilter]]** -

**[[CombinedValue|CombinedValueFilter]]** -

**[[CalculatorFilter]]** - Combine multiple filters with a mathematical expression.

**[[ReplicateFilter]]** - Repeat a filter multiple times and average.

**[[Boltzmann|BoltzmannFilter]]** -

**[[MoveBeforeFilter]]** - Apply a mover before applying the filter.

**[[Operator|OperatorFilter]]** -

**[[Sigmoid|SigmoidFilter]]** -

**[[IfThenFilter]]** -

**[[ContingentFilter]]** -

**[[PoseComment|PoseCommentFilter]]** -

**[[Range|RangeFilter]]** -

## General Filters

### Basic Filters

**[[ResidueCount|ResidueCountFilter]]** - Filter based on the total number of residues.

**[[NetCharge|NetChargeFilter]]** -

### Energy/Score

**[[ScoreType|ScoreTypeFilter]]** - Filter based on a particular score term.

**[[TaskAwareScoreType|TaskAwareScoreTypeFilter]]** (Formerly AverageInterfaceEnergy) - 

**[[BindingStrain|BindingStrainFilter]]** -

**[[Delta|DeltaFilter]]** -

**[[EnergyPerResidue|EnergyPerResidueFilter]]** -

**[[Residue Interaction Energy|ResidueIEFilter]]** -

**[[ResidueSetChainEnergy|ResidueSetChainEnergyFilter]]** -

### Distance

**[[ResidueDistance|ResidueDistanceFilter]]** - Filter based on the distance between two residues.

**[[AtomicContact|AtomicContactFilter]]** -

**[[AtomicContactCount|AtomicContactCountFilter]]** -

**[[AtomicDistance|AtomicDistanceFilter]]** - Filter based on the distance between two atoms.

**[[TerminusDistance|TerminusDistanceFilter]]** -

### Geometry

**[[AngleToVector|AngleToVectorFilter]]** -

**[[Torsion|TorsionFilter]]** - Filter based on the value of a dihedral.

**[[HelixPairing|HelixPairingFilter]]** -

**[[SecondaryStructure|SecondaryStructureFilter]]** -

**[[SecondaryStructureCount|SecondaryStructureCountFilter]]** -

**[[SecondaryStructureHasResidue|SecondaryStructureHasResidueFilter]]** -

**[[HelixKink|HelixKinkFilter]]** -

**[[Bond geometry and omega angle|GeometryFilter]]** -

**[[HSSTriplet|HSSTripletFilter]]** -

### Packing/Connectivity

**[[CavityVolume|CavityVolumeFilter]]** -

**[[AverageDegree|AverageDegreeFilter]]** -

**[[PackStat|PackStatFilter]]** -

**[[InterfaceHoles|InterfaceHolesFilter]]** -

**[[NeighborType|NeighborTypeFilter]]** -

**[[ResInInterface|ResInInterfaceFilter]]** - Filter based on the total number of residues in the interface.

**[[ShapeComplementarity|ShapeComplementarityFilter]]** -

**[[SSShapeComplementarity|SSShapeComplementarityFilter]]** (SecondaryStructureShapeComplementarity) -

**[[SpecificResiduesNearInterface|SpecificResiduesNearInterfaceFilter]]** -

### Burial

**[[TotalSasa|TotalSasaFilter]]** - Filter based on the total solvent accessible surface area of the pose.

**[[Sasa|SasaFilter]]** - Filter based on the solvent accessible surface area of an *interface*.

**[[ResidueBurial|ResidueBurialFilter]]** -

**[[ExposedHydrophobics|ExposedHydrophobicsFilter]]** -

### Comparison

**[[RelativePose|RelativePoseFilter]]** -

**[[Rmsd|RmsdFilter]]** - Filter based on the C-alpha RMSD to a reference structure. 

**[[SidechainRmsd|SidechainRmsdFilter]]** -

**[[IRmsd|IRmsdFilter]]** - Filter based on backbone RMSD over residues in the interface.

**[[SequenceRecovery|SequenceRecoveryFilter]]** -

### Bonding

**[[HbondsToResidue|HbondsToResidueFilter]]** -

**[[HbondsToAtom|HbondsToAtomFilter]]** -

**[[BuriedUnsatHbonds|BuriedUnsatHbondsFilter]]** -

**[[BuriedUnsatHbonds2|BuriedUnsatHbonds2Filter]]** -

**[[DisulfideFilter]]** - Filter based on the presence of a disulfide across an interface.

**[[AveragePathLength|AveragePathLengthFilter]]** -

**[[DisulfideEntropy|DisulfideEntropyFilter]]** -

## Report Filters

These filters are used primarily for the reports they generate in the log and/or score and silent files, more so than their ability to end a run.

**[[DesignableResidues|DesignableResiduesFilter]]** - Report which residues are designable.

**[[Expiry|ExpiryFilter]]** -

**[[FileExist|FileExistFilter]]** -

**[[FileRemove|FileRemoveFilter]]** -

**[[RelativeSegmentFilter]]** -

**[[Report|ReportFilter]]** -

**[[RotamerBoltzmannWeight|RotamerBoltzmannWeightFilter]]** -

**[[StemFinder|StemFinderFilter]]** -

**[[AlaScan|AlaScanFilter]]** -

**[[DdGScan|DdGScanFilter]]** -

**[[FilterScan|FilterScanFilter]]** -

**[[Time|TimeFilter]]** - Report how long a sequence of movers/filters takes.

**[[PeptideDeriver|PeptideDeriverFilter]]** -

**[[PoseInfo|PoseInfoFilter]]** - Report basic information about the pose to the tracer.

**[[SaveResfileToDisk|SaveResfileToDiskFilter]]** -

**[[SSPrediction|SSPredictionFilter]]** -

## Special Application Filters

### Binding

**[[Ddg|DdgFilter]]** - Filter based on the binding energy.

**[[InterfaceBindingEnergyDensityFilter]]** -

### Ligand docking and enzyme design

**[[DSasa|DSasaFilter]]** -

**[[DiffAtomBurial|DiffAtomBurialFilter]]** -

**[[LigInterfaceEnergy|LigInterfaceEnergyFilter]]** - Filter based on binding energy of a ligand.

**[[EnzScore|EnzScoreFilter]]** -

**[[RepackWithoutLigand|RepackWithoutLigandFilter]]** -

### Ligand design

**[[HeavyAtom|HeavyAtomFilter]]** - Filter based on the number of heavy atoms in a residue.

**[[CompleteConnections|CompleteConnectionsFilter]]** - Filter based on unfulfilled connections.

### Hotspot Design

**[[StubScore|StubScoreFilter]]** - Filter based on if the scaffold is 'feeling' any of the hotspot stub constraints.

<!--- BEGIN_INTERNAL -->

### MatDes

**[[OligomericAverageDegree|OligomericAverageDegreeFilter]]** -

**[[SymUnsatHbonds|SymUnsatHbondsFilter]]** -

**[[ClashCheck|ClashCheckFilter]]** -

**[[InterfacePacking|InterfacePackingFilter]]** -

**[[MutationsFilter|MutationsFilter]]** -

**[[GetRBDOFValues|GetRBDOFValuesFilter]]** -

<!--- END_INTERNAL -->

### Backbone Design

**[[Foldability|FoldabilityFilter]]** -

##See Also

* [[RosettaScripts]]: The RosettaScripts home page
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[RosettaScripts Movers|Movers-RosettaScripts]]
* [[RosettaScripts TaskOperations|TaskOperations-RosettaScripts]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Getting Started]]: A page for people new to Rosetta
* [[Glossary]]
* [[RosettaEncyclopedia]]

