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


<!--- BEGIN_INTERNAL -->
Creating New Features Analyses code
========================================

Using the features diagnostics tool to analyze feature distributions can be really powerful: new relationships between different structural features can be quickly examined and the analysis can be applied to new conformation datasets as the research progresses. Use the tool, however, requires investing a little effort to become familiar with underlying tools. It should be possible to with minimal effort take an existing analysis and extend it either look at new structural features.

These tutorials begin with simple examples of how to interact with the underlying tools, give resources for further study and highlight concepts that may be stumbling blocks. The examples come from working with structural features of protein structures.

-   [[Implementing a FeaturesReporter|FeaturesExtracting]]
    -   Shows how to create a new FeaturesReporter using the base class and extracting features in parallel

-   [[Write a simple plot script|FeaturesTutorialPlotScript]]
    -   This tutorial shows the structure of a basic features analysis script and the components fit together.



General Developer Resources
=================================================

-   [[R Basics|FeaturesTutorialRBasics]]
    -   R is a scriting language widely in the statistical and data visualization community. In spite of it's idiosyncrasies, it has significant momentum behind it and worth learning a little. This tutorial presents how to find language support (because 'R' is not google-able).

-   [[ggplot2 basics|FeaturesTutorialGGplots2Basics]]
    -   ggplot2 is an R package that implements the "Grammar of Graphics" as an approach to efficiently visualize data. Using ggplot2 has a conceptual learning curve, so this tutorial goes through some of the different types of plots and show how they are made.

-   [[Tune Plots to Publication Quality|FeaturesTutorialPlotTuning]]
    -   This tutorial is a mix of technical and artistic advice for the features analysis plots can fine tuned.

<!--- END_INTERNAL -->

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