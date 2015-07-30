<!-- --- title: Featurereporters -->FeaturesReporters
=================

Overview
========

In order to aid in analysis and comparisons of native protein structures and Rosetta models and designs, the Rosetta Feature Reporter framework was developed comprising an analytical framework developed in Rosetta C++ and a comparison and plotting framework developed in R, a free, open-source comprehensive statistical package. The framework was initially used to improve the default Rosetta energy function and hydrogen bonding (resulting in the now-default talaris2013 energy function), but has since been expanded for use in a number of analytical and comparative tasks. In the framework, a Feature is a component or set of components of a structure to be analyzed. These ‘features’ encompass energies, hydrogen bond distances, sequences, etc.  


A **[[FeaturesReporter|FeaturesExtracting#FeaturesReporter]]** is a type of class that is responsible for reading and writing a *feature* or set of *features* to a relational database (mySQL, SQLITE3, etc.). RosettaScripts is used to specify which FeatureReporters to run on a set of structures.

A features database contains all of the structural information associated with a set structures in a batch of structures. The hierarchy below outlines the general organization of this database.  

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

Comparing a set of features from two different sets of structures is done in two steps. The first step is to analyze each set of structures using a chosen number of FeatureReporters through an XML script and the RosettaScripts application. Each FeatureReporter is its own Rosetta C++ class and analyzes a set of features from the input structure and outputs one or more tables into a relational database.

Once two or more databases are created for a set of features derived from each structure in each dataset, the second step is to compare the datasets using the FeatureReporter R Framework. This framework enables one to specify the input databases to compare as well as various output options and the set of Feature R Scripts to be run through either the command line or a JSON file specifying the components (a common data interchange format used by a variety of computational languages and programs). Each Features R script requires the use of different FeatureReporters to enable the comparison, with some R scripts requiring many FeatureReporters to be used. The plots and tables output by the FeatureReporter R Framework can then be used to deduce similarities and differences between the given datasets in addition to various statistical outputs.

- [[FeaturesTutorials]] - Tutorials for the Feature Reporter Analysis Framework

References
==========


O'Meara, M. J., Leaver-Fay, A., Tyka, M., Stein, A., Houlihan, K., DiMaio, F., Bradley, P., Kortemme, T., Baker, D., Snoeyink, J., [A Combined Covalent-Electrostatic Model of Hydrogen Bonding Improves Structure Prediction with Rosetta](https://dx.doi.org/10.1021/ct500864r)  . Journal of Chemical Theory and Computation, 2015.

Leaver-Fay, A., O'Meara, M. J., Tyka, M., Jacak, R., Song, Y., Kellogg, E. H., Thompson, J., Davis, I. W., Pache, R. A., Lyskov, S., Gray, J. J., Kortemme, T., Richardson, J. S., Havranek, J. J., Snoeyink, J., Baker, D., Kuhlman, B., [Scientific benchmarks for guiding macromolecular energy function improvement](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3724755/). Methods in enzymology, 2013. 523: p. 109.


Implemented Feature Reporters
=============================

[[_TOC_]]

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