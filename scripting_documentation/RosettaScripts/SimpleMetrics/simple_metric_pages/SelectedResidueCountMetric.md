#SelectedResidueCountMetric

*Back to [[SimpleMetrics]] page.*

## SelectedResidueCountMetric

Author: Vikram K. Mulligan (vmullig@uw.edu)

Documentation created 24 April 2018.

[[_TOC_]]

## Purpose and Description

The SelectedResidueCountMetric [[SimpleMetric|SimpleMetrics]] counts the number of residues in a pose (in the absence of a [[residue selector|ResidueSelectors]] or in a selection (if a [[residue_selector|ResidueSelectors]] is provided).

## Usage

```xml
<SelectedResidueCountMetric name="(&string)" residue_selector="(&string)" />
```

* **residue_selector:** The name of a previously-defined [[residue selector|ResidueSelectors]].  If provided, the number of selected residues is counted.  If not provided, all residues in the pose are counted.

##See Also

* [[SelectedResiduesMetric]]: Return a string containing the selected residue indices.
* [[SelectedResiduesPyMolMetric]]: Return a string containing a PyMol selection for the selected residue indices.
* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover