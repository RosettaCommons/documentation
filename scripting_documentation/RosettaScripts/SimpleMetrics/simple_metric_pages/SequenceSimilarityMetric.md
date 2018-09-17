# SequenceSimilarityMetric
*Back to [[SimpleMetrics]] page.*
## SequenceSimilarityMetric

Author: Jack Maguire, jackmaguire1444@gmail.com

## Purpose and Description

Compares the sequences of the native structure (using native flag) to the sequence of a given pose.
The BLOSUM62 scores are averaged for every selected position.

## Usage

```xml
<SequenceSimilarityMetric name="(&string)" residue_selector="(&string)" apply_selector_to_native="false" normalize="true"/>
```

* **residue_selector:** The name of a previously-defined [[residue selector|ResidueSelectors]].  If provided, only the BLOSUM62 scores for the selected residues will be averaged. If not provided, all residues in the pose are counted.
* **apply_selector_to_native:** If true, apply the residue selector to the native pose instead of the given pose. For example, a layer selector will use the native structure to determine what is core/boundary/surface instead of the current structure.
* **normalize:** If true, divide the final score by the number of positions. Otherwise this is just the sum of the BLOSUM62 scores for the selected positions.

##See Also

* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover