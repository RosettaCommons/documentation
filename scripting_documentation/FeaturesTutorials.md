<!-- --- title: Featurestutorials -->Tutorials
=========

These tutorials are meant for researchers interested in evaluating structure prediction protocols with respect to local structural features or researchers interested in improving an structural biology energy function. Each tutorial goes through an example of a concrete task as a way to orient new users. At the end of each tutorial there references for more detailed information is provided.

If there is a specific tutorial you think or would like to see here--please add it to the list at the bottom of requested tutorials!

Tutorials to Run Existing Feature Analysis
------------------------------------------

-   [[Generating a features database for sample source|FeaturesTutorialRunSciBench]]
    -   The features scientific benchmark is on the RosettaTests cluster. Running it locally is often a good starting point to in depth analysis. This tutorial starts from checking out the source to looking plots.

-   [[Run feature analyses to compare sample sources|FeaturesTutotiralRunFeaturesAnalysis]]
    -   The features analysis scripts are R scripts to extract features, estimate distributions and compare the distributions through plots and statistics

-   [[Look at interesting feature instances in PyMOL|FeaturesTutorialInspectInstances]]
    -   Some time the quickest way to explore specific type of structural feature is to inspect a handful of examples. This tutorial shows how specific feature instances from an sqlite3 features database and then viewing them in pymol.

Tutorials to Create New Feature Analysis
----------------------------------------

Using the features diagnostics tool to analyze feature distributions can be really powerful: new relationships between different structural features can be quickly examined and the analysis can be applied to new conformation datasets as the research progresses. Use the tool, however, requires investing a little effort to become familiar with underlying tools. It should be possible to with minimal effort take an existing analysis and extend it either look at new structural features.

These tutorials begin with simple examples of how to interact with the underlying tools, give resources for further study and highlight concepts that may be stumbling blocks. The examples come from working with structural features of protein structures.

If you there is a specific topic that you find confusing or frustrating, feel free to include in the requested topics section below!

General Resources for Features Analysis
---------------------------------------

-   [[SQL basics|FeaturesTutorialSQLBasics]]
    -   To do work with features, having some exposure to the basics of the Structured Query Language is necessary. This tutorial introduces some of SQL and how it can be used to look at features

-   [[R Basics|FeaturesTutorialRBasics]]
    -   R is a scriting language widely in the statistical and data visualization community. In spite of it's idiosyncrasies, it has significant momentum behind it and worth learning a little. This tutorial presents how to find language support (because 'R' is not google-able).

-   [[ggplot2 basics|FeaturesTutorialGGplots2Basics]]
    -   ggplot2 is an R package that implements the "Grammar of Graphics" as an approach to efficiently visualize data. Using ggplot2 has a conceptual learning curve, so this tutorial goes through some of the different types of plots and show how they are made.

-   [[Write a simple plot script|FeaturesTutorialPlotScript]]
    -   This tutorial shows the structure of a basic features analysis script and the components fit together.

-   [[Run analysis script interactively in an R terminal|FeaturesTutorialRunningInteractively]]
    -   Running an analysis script interactively can be useful for creating and tuning an analysis script.

-   [[Tune Plots to Publication Quality|FeaturesTutorialPlotTuning]]
    -   This tutorial is a mix of technical and artistic advice for the features analysis plots can fine tuned.

-   [[Implementing a FeaturesReporter|FeaturesExtracting]]
    -   Shows how to create a new FeaturesReporter using the base class and extracting features in parallel

### Requested Tutorials

    <put requested tutorial topics here>
