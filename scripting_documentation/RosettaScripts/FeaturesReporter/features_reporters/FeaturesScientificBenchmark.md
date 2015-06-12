#Features Scientific Benchmark

A feature is a measurement of a molecular structure that is represented geometrically. Examples include the properties measured by components of Rosetta's ScoreFunctions such as torsion angles, hydrogen bond distances and angles. More complicated examples include the volume of voids or radial density distributions.

Exploring features in experimental and predicted structures usually involves common steps:

1.  collect datasets
2.  extract features
3.  select, filter and compare using multiple types of features
4.  create plots and statistics

Going through these steps by hand is often not too hard. Usually, however, the context and purpose of the investigation evolves. So over time, the analysis needs to be re-done with new datasets, using different features and generating different plots and statistics. If the original analysis was not well organized, each time it will be as hard as the first.

The Features Scientific Benchmark is designed to help you investigate features to make re-analysis easy and straight forward. It provides,

-   Handy [[reference datasets|FeaturesDatasets]]
-   A Rosetta/C++ framework to facilitate [[extracting features|FeaturesExtracting]] from Poses to relational databases
-   [[Feature Reporters|FeatureReporters]] to organize and manage feature data
-   [[R scripts|FeaturesRScripts]] and [[tutorials|FeaturesTutorials]] to assist common types of feature analysis.

Additionally, [[contributed feature analyses|FeaturesTestingServer]] can be run automatically on the [[Testing Server]] so the scientific quality of Rosetta can be monitored.

 Here are the slides for a [tutorial](http://garin.med.unc.edu/~momeara/features_tutorial.pdf) (\~5Mb), which was presented at the January Rosetta developers workshop.


##See Also

* [[Scientific Benchmarks]]
* [[Rosetta tests]]: The testing home page