<!-- --- title: Featurereporters -->Implemented Feature Reporters
=================

[[_TOC_]]

##[[SimpleMetricFeatures]]
* Calcualte and output arbitrary [[SimpleMetrics]]

##[[Meta|MetaFeaturesReporters]]   
* Information about the batch of structures and the protocol that was used to generate it

 * [[Protocol|MetaFeaturesReporters#ProtocolFeatures]] , [[Batch|MetaFeaturesReporters#BatchFeatures]] , [[JobData|MetaFeaturesReporters#JobDataFeatures]] , [[PoseComments|MetaFeaturesReporters#PoseCommentsFeatures]] , [[Runtime|MetaFeaturesReporters#RuntimeFeatures]]


##[[Chemical|ChemicalFeaturesReporters]]   
* Chemical type information that is used to define molecular conformations

* [[AtomType|ChemicalFeaturesReporters#AtomTypeFeatures]] , [[ResidueType|ChemicalFeaturesReporters#ResidueTypesFeatures]]

##[[One-Body|OneBodyFeaturesReporters]]   
* Features identified by a single residue

* [[Residue|OneBodyFeaturesReporters#ResidueFeatures]] , [[ResidueConformation|OneBodyFeaturesReporters#ResidueConformationFeatures]] , [[ProteinResidueConformation|OneBodyFeaturesReporters#ProteinResidueConformationFeatures]] , [[RotamerFeatures|OneBodyFeaturesReporters#RotamerFeatures]] , [[ProteinBackboneTorsionAngle|OneBodyFeaturesReporters#ProteinBackboneTorsionAngleFeatures]] , [[ProteinBondGeometry|OneBodyFeaturesReporters#ProteinBondGeometryFeatures]] [[ResidueBurial|OneBodyFeaturesReporters#ResidueBurialFeatures]] , [[ResidueSecondaryStructure|OneBodyFeaturesReporters#ResidueSecondaryStructureFeatures]] , [[BetaTurnDetection|OneBodyFeaturesReporters#BetaTurnDetectionFeatures]] , [[RotamerBoltzmannWeight|OneBodyFeaturesReporters#RotamerBoltzmannWeightFeatures]]

##[[Two-Body|TwoBodyFeaturesReporters]]   
* Features that are identified by a pair of residues

* [[Pair|TwoBodyFeaturesReporters#PairFeatures]] , [[AtomAtomPair|TwoBodyFeaturesReporters#AtomAtomPairFeatures]] , [[AtomInResidueAtomInResiduePair|TwoBodyFeaturesReporters#AtomInResidueAtomInResiduePairFeatures]] , [[ProteinBackboneAtomAtomPair|TwoBodyFeaturesReporters#ProteinBackboneAtomAtomPairFeatures]] , [[HBond|TwoBodyFeaturesReporters#HBondFeatures]] , [[Orbital|TwoBodyFeaturesReporters#OrbitalFeatures]] , [[SaltBridge|TwoBodyFeaturesReporters#SaltBridgeFeatures]] , [[ChargeCharge|TwoBodyFeaturesReporters#ChargeChargeFeatures]] , [[LoopAnchor|TwoBodyFeaturesReporters#LoopAnchorFeatures]]

##[[Multi-Body|MultiBodyFeaturesReporters]]   
* Features that are identified by more than two residues

* [[Structure|MultiBodyFeaturesReporters#StructureFeatures]] , [[PoseConformation|MultiBodyFeaturesReporters#PoseConformationFeatures]] , [[GeometricSolvation|MultiBodyFeaturesReporters#GeometricSolvationFeatures]] , [[RadiusOfGyration|MultiBodyFeaturesReporters#RadiusOfGyrationFeatures]] , [[Sandwich|MultiBodyFeaturesReporters#SandwichFeatures]] , [[Smotif|MultiBodyFeaturesReporters#SmotifFeatures]] , [[SecondaryStructureSegment|MultiBodyFeaturesReporters#SecondaryStructureSegmentFeatures]] , [[StrandBundle|MultiBodyFeaturesReporters#StrandBundleFeatures]], [[Interface | MultiBodyFeaturesReporters#InterfaceFeatures]], [[Antibody | MultibodyFeaturesReporters#AntibodyFeatures]], [[CDR Cluster | MultibodyFeaturesReporters#CDRClusterFeatures]]

##[[Multi-Structure|MultiStructureFeaturesReporters]]   
* Features that are identified by more than one structure

* [[ProteinRMSD|MultiStructureFeaturesReporters#ProteinRMSDFeatures]] , [[ProteinRMSDNoSuperposition|MultiStructureFeaturesReporters#ProteinRMSDNoSuperpositionFeatures]] , [[RotamerRecovery|MultiStructureFeaturesReporters#RotamerRecoveryFeatures]]

##[[Energy Function|EnergyFunctionFeaturesReporters]]   
* Feature models and their parameters used to create energy terms

* [[TotalScore|EnergyFunctionFeaturesReporters#TotalScoreFeatures]] , [[ScoreType|EnergyFunctionFeaturesReporters#ScoreTypeFeatures]] , [[ScoreFunction|EnergyFunctionFeaturesReporters#ScoreFunctionFeatures]] , [[StructureScores|EnergyFunctionFeaturesReporters#StructureScoresFeatures]] , [[ResidueScores|EnergyFunctionFeaturesReporters#ResidueScoresFeatures]] , [[ResidueTotalScores|EnergyFunctionFeaturesReporters#ResidueTotalScoresFeatures]] , [[HBondParameter|EnergyFunctionFeaturesReporters#HBondParameterFeatures]] , [[ScreeningFeatures|EnergyFunctionFeaturesReporters#ScreeningFeatures]]

##[[Antibody | MultiBodyFeaturesReporters#antibody-features]]
* FeatureReporters specifically for the analysis of antibodies
* [[Antibody | MultiBodyFeaturesReporters#antibody-features_antibodyfeatures]], [[CDR Cluster | MultiBodyFeaturesReporters#antibody-features_cdrclusterfeatures]]

##[[Experimental|ExperimentalFeaturesReporters]]   
* Experimental data not defined by the atomic coordinates
* [[PdbData|ExperimentalFeaturesReporters#PdbDataFeatures]]


##See Also

* [[Features reporter overview]]: The FeaturesReporter home page
* [[FeaturesTutorials]]: Tutorials for using FeaturesReporters
* [[RosettaScripts home page|RosettaScripts]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: Input/output to databases using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options