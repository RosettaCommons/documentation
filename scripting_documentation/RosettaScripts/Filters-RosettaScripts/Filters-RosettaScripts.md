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

Simple filter which are availible without explicitly defining them.

**[[TrueFilter]]** -

**[[FalseFilter]]** -

## Special Filters

Filters which are useful for combining, modifying or working with other filters and movers.

**[[CompoundStatement|CompoundStatementFilter]]** -

**[[CombinedValue|CombinedValueFilter]]** -

**[[CalculatorFilter]]** -

**[[ReplicateFilter]]** -

**[[Boltzmann|BoltzmannFilter]]** -

**[[MoveBeforeFilter]]** -

**[[Operator|OperatorFilter]]** -

**[[Sigmoid|SigmoidFilter]]** -

**[[IfThenFilter]]** -

**[[ContingentFilter]]** -

**[[PoseComment|PoseCommentFilter]]** -

**[[Range|RangeFilter]]** -

## General Filters

### Basic Filters

**[[ResidueCount|ResidueCountFilter]]** -

**[[NetCharge|NetChargeFilter]]** -

### Energy/Score

**[[BindingStrain|BindingStrainFilter]]** -

**[[Delta|DeltaFilter]]** -

**[[EnergyPerResidue|EnergyPerResidueFilter]]** -

**[[Residue Interaction Energy|Residue Interaction EnergyFilter]]** -

**[[ScoreType|ScoreTypeFilter]]** -

**[[TaskAwareScoreType|TaskAwareScoreTypeFilter]]** (Formerly AverageInterfaceEnergy) -

**[[ResidueSetChainEnergy|ResidueSetChainEnergyFilter]]** -

### Distance

**[[ResidueDistance|ResidueDistanceFilter]]** -

**[[AtomicContact|AtomicContactFilter]]** -

**[[AtomicContactCount|AtomicContactCountFilter]]** -

**[[AtomicDistance|AtomicDistanceFilter]]** -

**[[TerminusDistance|TerminusDistanceFilter]]** -

### Geometry

**[[AngleToVector|AngleToVectorFilter]]** -

**[[Torsion|TorsionFilter]]** -

**[[HelixPairing|HelixPairingFilter]]** -

**[[SecondaryStructure|SecondaryStructureFilter]]** -

**[[SecondaryStructureCount|SecondaryStructureCountFilter]]** -

**[[SecondaryStructureHasResidue|SecondaryStructureHasResidueFilter]]** -

**[[HelixKink|HelixKinkFilter]]** -

**[[Bond geometry and omga angle|Bond geometry and omga angleFilter]]** -

**[[HSSTriplet|HSSTripletFilter]]** -

### Packing/Connectivity

**[[CavityVolume|CavityVolumeFilter]]** -

**[[AverageDegree|AverageDegreeFilter]]** -

**[[PackStat|PackStatFilter]]** -

**[[InterfaceHoles|InterfaceHolesFilter]]** -

**[[NeighborType|NeighborTypeFilter]]** -

**[[ResInInterface|ResInInterfaceFilter]]** -

**[[ShapeComplementarity|ShapeComplementarityFilter]]** -

**[[SSShapeComplementarity|SSShapeComplementarityFilter]]** (SecondaryStructureShapeComplementarity) -

**[[SpecificResiduesNearInterface|SpecificResiduesNearInterfaceFilter]]** -

### Burial

**[[TotalSasa|TotalSasaFilter]]** -

**[[Sasa|SasaFilter]]** -

**[[ResidueBurial|ResidueBurialFilter]]** -

**[[ExposedHydrophobics|ExposedHydrophobicsFilter]]** -

### Comparison

**[[RelativePose|RelativePoseFilter]]** -

**[[Rmsd|RmsdFilter]]** -

**[[SidechainRmsd|SidechainRmsdFilter]]** -

**[[IRmsd|IRmsdFilter]]** -

**[[SequenceRecovery|SequenceRecoveryFilter]]** -

### Bonding

**[[HbondsToResidue|HbondsToResidueFilter]]** -

**[[HbondsToAtom|HbondsToAtomFilter]]** -

**[[BuriedUnsatHbonds|BuriedUnsatHbondsFilter]]** -

**[[BuriedUnsatHbonds2 |BuriedUnsatHbonds2 Filter]]** -

**[[DisulfideFilter]]** -

**[[AveragePathLength|AveragePathLengthFilter]]** -

**[[DisulfideEntropy|DisulfideEntropyFilter]]** -

## Report Filters

These filters are used primarily for the reports they generate in the log and/or score and silent files, more so than their ability to end a run.

**[[DesignableResidues|DesignableResiduesFilter]]** -

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

**[[Time|TimeFilter]]** -

**[[PeptideDeriver|PeptideDeriverFilter]]** -

**[[PoseInfo|PoseInfoFilter]]** -

**[[SaveResfileToDisk|SaveResfileToDiskFilter]]** -

**[[SSPrediction|SSPredictionFilter]]** -

## Special Application Filters

### Binding

**[[Ddg|DdgFilter]]** -

**[[InterfaceBindingEnergyDensityFilter]]** -

### Ligand docking and enzyme design

**[[DSasa|DSasaFilter]]** -

**[[DiffAtomBurial|DiffAtomBurialFilter]]** -

**[[LigInterfaceEnergy|LigInterfaceEnergyFilter]]** -

**[[EnzScore|EnzScoreFilter]]** -

**[[RepackWithoutLigand|RepackWithoutLigandFilter]]** -

### Ligand design

**[[HeavyAtom|HeavyAtomFilter]]** -

**[[CompleteConnections|CompleteConnectionsFilter]]** -

### Hotspot Design

**[[StubScore|StubScoreFilter]]** -

### MatDes

**[[OligomericAverageDegree|OligomericAverageDegreeFilter]]** -

**[[SymUnsatHbonds|SymUnsatHbondsFilter]]** -

**[[ClashCheck|ClashCheckFilter]]** -

**[[InterfacePacking|InterfacePackingFilter]]** -

**[[MutationsFiler|MutationsFilerFilter]]** -

**[[GetRBDOFValues|GetRBDOFValuesFilter]]** -

### Backbone Design

**[[Foldability|FoldabilityFilter]]** -


