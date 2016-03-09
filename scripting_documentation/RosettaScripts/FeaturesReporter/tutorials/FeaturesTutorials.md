#Features Tutorials

These tutorials are meant for researchers interested in evaluating structure prediction protocols with respect to local structural features or researchers interested in improving an structural biology energy function. Each tutorial goes through an example of a concrete task as a way to orient new users. At the end of each tutorial there are references for more detailed information is provided.

[[_TOC_]]

Running Features Analysis
=========

- [[Generating a features database|FeaturesTutorialRunSciBench]]
    -   The features scientific benchmark is on the RosettaTests cluster. Running it locally is often a good starting point to in depth analysis. This tutorial starts from checking out the source to looking plots.

- [[Running the features R scripts to compare sample sources|FeaturesTutorialRunFeaturesAnalysis]]
    -   The features analysis scripts are R scripts to extract features, estimate distributions and compare the distributions through plots and statistics

- [[SQL basics|FeaturesTutorialSQLBasics]]
    -   To do work with features, having some exposure to the basics of the Structured Query Language is extremely useful. This tutorial introduces some of SQL and how it can be used to look at and compare features




##See Also

* [[Features reporter overview]]: The home page for FeaturesReporters
* [[FeatureReporters]]: List of implemented FeatureReporters
* [[RosettaScripts home page|RosettaScripts]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: Input/output to databases using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options