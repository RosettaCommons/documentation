#Features reporter overview

These applications are meant for researchers interested in evaluating structure prediction protocols with respect to local structural features or researchers interested in improving a structural biology energy function.

We provide tutorials that describe an example of a concrete task as a way to orient new users.
At the end of each tutorial there references where more detailed information is provided.
If there is a specific tutorial you think or would like to see here, please add it to the list at the bottom of requested tutorials!

We also document individual FeatureReporters and R scripts useful for post-processing data.

-	[[How to run FeatureReporters| FeaturesTutorials]]
-	[[List of Implemented FeatureReporters | FeatureReporters]]
- [[SimpleMetricFeatures]]: Run an arbitrary set of SimpleMetrics as Features.

<!--- BEGIN_INTERNAL -->
-       [[Writing new FeatureReporters | FeaturesExtracting]]
-	[[Writing new R Scripts for Analysis| FeaturesRScripts]]
<!--- END_INTERNAL -->

Overview
========

In order to aid in analysis and comparisons of native protein structures and Rosetta models and designs, the Rosetta Feature Reporter framework was developed comprising an analytical framework developed in Rosetta C++ and a comparison and plotting framework developed in R, a free, open-source comprehensive statistical package. The framework was initially used to improve the default Rosetta energy function and hydrogen bonding (resulting in the now-default talaris2013 energy function), but has since been expanded for use in a number of analytical and comparative tasks. In the framework, a Feature is a component or set of components of a structure to be analyzed. These ‘features’ encompass energies, hydrogen bond distances, sequences, etc.  


A **[[FeaturesReporter|FeaturesExtracting#FeaturesReporter]]** is responsible for reading and writing a *feature* or set of *features* to a relational database (mySQL, SQLITE3, etc.). RosettaScripts is used to specify which FeatureReporters to run on a set of structures.

Comparing a set of features from two different sets of structures is done in two steps. The first step is to analyze each set of structures using a chosen number of FeatureReporters through an XML script and the RosettaScripts application. Each FeatureReporter is its own Rosetta C++ class and analyzes a set of features from the input structure and outputs one or more tables into a relational database.

Once two or more databases are created for a set of features derived from each structure in each dataset, the second step is to compare the datasets using the FeatureReporter R Framework. This framework enables one to specify the input databases to compare as well as various output options and the set of Feature R Scripts to be run through either the command line or a JSON file specifying the components (a common data interchange format used by a variety of computational languages and programs). Each Features R script requires the use of different FeatureReporters to enable the comparison, with some R scripts requiring many FeatureReporters to be used. The plots and tables output by the FeatureReporter R Framework can then be used to deduce similarities and differences between the given datasets in addition to various statistical outputs.

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


- [[FeaturesTutorials]] - Tutorials for the Feature Reporter Analysis Framework

References
==========


O'Meara, M. J., Leaver-Fay, A., Tyka, M., Stein, A., Houlihan, K., DiMaio, F., Bradley, P., Kortemme, T., Baker, D., Snoeyink, J., [A Combined Covalent-Electrostatic Model of Hydrogen Bonding Improves Structure Prediction with Rosetta](https://dx.doi.org/10.1021/ct500864r)  . Journal of Chemical Theory and Computation, 2015.

Leaver-Fay, A., O'Meara, M. J., Tyka, M., Jacak, R., Song, Y., Kellogg, E. H., Thompson, J., Davis, I. W., Pache, R. A., Lyskov, S., Gray, J. J., Kortemme, T., Richardson, J. S., Havranek, J. J., Snoeyink, J., Baker, D., Kuhlman, B., [Scientific benchmarks for guiding macromolecular energy function improvement](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3724755/). Methods in enzymology, 2013. 523: p. 109.


##See Also

* [[RosettaScripts home page|RosettaScripts]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: Input/output to databases using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options