<!-- --- title: Featurereporters -->FeaturesReporters
=================

A **[[FeaturesReporter|FeaturesExtracting#FeaturesReporter]]** is a class that is responsible for reading writing to a database instances of a certain type of structural property called a *feature* .

To create a *FeaturesReporter* , it must implement that base class interface.

A features database contains all the structural information associated with a set structures in a batch structures.

                  protocols      <------------ One row per execution of Rosetta
                     /\
                     ||
             /---> batches <---\    <--------- One row per set of structures
            / |      /\       | \                
           /  |      ||       |  \
          /   |      ||       |   \
         /-----> Structures <------\   <------ One row per structure, uuid 
        /     |    /     \    |     \
     Feature  Feature   Feature   Feature  <-- Each FeatureReporter manages a type of    
     Reporter Reporter  Reporter  Reporter     of structural data. Static data is indexed 
                                               per batch.

[[Meta|MetaFeaturesReporters]]   
* Information about the batch of structures and the protocol that was used to generate it

* [[Protocol|MetaFeaturesReporters#ProtocolFeatures]] , [[Batch|MetaFeaturesReporters#BatchFeatures]] , [[JobData|MetaFeaturesReporters#JobDataFeatures]] , [[PoseComments|MetaFeaturesReporters#PoseCommentsFeatures]] , [[Runtime|MetaFeaturesReporters#RuntimeFeatures]]


[[Chemical|ChemicalFeaturesReporters]]   
* Chemical type information that is used to define molecular conformations

* [[AtomType|ChemicalFeaturesReporters#AtomTypeFeatures]] , [[ResidueType|ChemicalFeaturesReporters#ResidueTypesFeatures]]

[[One-Body|OneBodyFeaturesReporters]]   
* Features identified by a single residue

* [[Residue|OneBodyFeaturesReporters#ResidueFeatures]] , [[ResidueConformation|OneBodyFeaturesReporters#ResidueConformationFeatures]] , [[ProteinResidueConformation|OneBodyFeaturesReporters#ProteinResidueConformationFeatures]] , [[RotamerFeatures|OneBodyFeaturesReporters#RotamerFeatures]] , [[ProteinBackboneTorsionAngle|OneBodyFeaturesReporters#ProteinBackboneTorsionAngleFeatures]] , [[ProteinBondGeometry|OneBodyFeaturesReporters#ProteinBondGeometryFeatures]] [[ResidueBurial|OneBodyFeaturesReporters#ResidueBurialFeatures]] , [[ResidueSecondaryStructure|OneBodyFeaturesReporters#ResidueSecondaryStructureFeatures]] , [[BetaTurnDetection|OneBodyFeaturesReporters#BetaTurnDetectionFeatures]] , [[RotamerBoltzmannWeight|OneBodyFeaturesReporters#RotamerBoltzmannWeightFeatures]]

[[Two-Body|TwoBodyFeaturesReporters]]   
* Features that are identified by a pair of residues

* [[Pair|TwoBodyFeaturesReporters#PairFeatures]] , [[AtomAtomPair|TwoBodyFeaturesReporters#AtomAtomPairFeatures]] , [[AtomInResidueAtomInResiduePair|TwoBodyFeaturesReporters#AtomInResidueAtomInResiduePairFeatures]] , [[ProteinBackboneAtomAtomPair|TwoBodyFeaturesReporters#ProteinBackboneAtomAtomPairFeatures]] , [[HBond|TwoBodyFeaturesReporters#HBondFeatures]] , [[Orbital|TwoBodyFeaturesReporters#OrbitalFeatures]] , [[SaltBridge|TwoBodyFeaturesReporters#SaltBridgeFeatures]] , [[ChargeCharge|TwoBodyFeaturesReporters#ChargeChargeFeatures]] , [[LoopAnchor|TwoBodyFeaturesReporters#LoopAnchorFeatures]]

[[Multi-Body|MultiBodyFeaturesReporters]]   
* Features that are identified by more than two residues

* [[Structure|MultiBodyFeaturesReporters#StructureFeatures]] , [[PoseConformation|MultiBodyFeaturesReporters#PoseConformationFeatures]] , [[GeometricSolvation|MultiBodyFeaturesReporters#GeometricSolvationFeatures]] , [[RadiusOfGyration|MultiBodyFeaturesReporters#RadiusOfGyrationFeatures]] , [[Sandwich|MultiBodyFeaturesReporters#SandwichFeatures]] , [[Smotif|MultiBodyFeaturesReporters#SmotifFeatures]] , [[SecondaryStructureSegment|MultiBodyFeaturesReporters#SecondaryStructureSegmentFeatures]] , [[StrandBundle|MultiBodyFeaturesReporters#StrandBundleFeatures]]

[[Multi-Structure|MultiStructureFeaturesReporters]]   
* Features that are identified by more than one structure

* [[ProteinRMSD|MultiStructureFeaturesReporters#ProteinRMSDFeatures]] , [[ProteinRMSDNoSuperposition|MultiStructureFeaturesReporters#ProteinRMSDNoSuperpositionFeatures]] , [[RotamerRecovery|MultiStructureFeaturesReporters#RotamerRecoveryFeatures]]

[[Energy Function|EnergyFunctionFeaturesReporters]]   
* Feature models and their parameters used to create energy terms

* [[TotalScore|EnergyFunctionFeaturesReporters#TotalScoreFeatures]] , [[ScoreType|EnergyFunctionFeaturesReporters#ScoreTypeFeatures]] , [[ScoreFunction|EnergyFunctionFeaturesReporters#ScoreFunctionFeatures]] , [[StructureScores|EnergyFunctionFeaturesReporters#StructureScoresFeatures]] , [[ResidueScores|EnergyFunctionFeaturesReporters#ResidueScoresFeatures]] , [[ResidueTotalScores|EnergyFunctionFeaturesReporters#ResidueTotalScoresFeatures]] , [[HBondParameter|EnergyFunctionFeaturesReporters#HBondParameterFeatures]] , [[ScreeningFeatures|EnergyFunctionFeaturesReporters#ScreeningFeatures]]

[[Experimental|ExperimentalFeaturesReporters]]   
* Experimental data not defined by the atomic coordinates

* [[PdbData|ExperimentalFeaturesReporters#PdbDataFeatures]]


