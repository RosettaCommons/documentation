#Features Tutorial: GGplots2 basics

The [ggplot2](http://had.co.nz/ggplot2/) R package is recommended for making plots. It follows the [Grammar of Graphics](http://www.springer.com/statistics/computanional+statistics/book/978-0-387-24544-7) by encouraging thinking of plots as being separate from the data they portray. Fundamentally, a plot consists of [*layers*](http://had.co.nz/ggplot2/layer.html) each of which consists of visual [aesthetic elements](http://had.co.nz/ggplot2/geom_.html) and a *mapping* of the data to the aesthetic elements. By defining the semantics of the plot independent of the data, the same plot can be generated for different data.

##See Also

* [[Features reporter overview]]: The FeaturesReporter home page
* R tutorials for FeaturesReporters
  * [[FeaturesTutorialRBasics]]
  * [[FeaturesTutorialPlotScript]]
  * [[FeaturesTutorialPlotTuning]]
* [[FeaturesTutorials]]: Tutorials for using FeaturesReporters
* [[FeatureReporters]]: List of implemented FeatureReporters
* [[RosettaScripts home page|RosettaScripts]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: Input/output to databases using Rosetta