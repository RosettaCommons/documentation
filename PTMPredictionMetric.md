# PTMPredictionMetric
*Back to [[SimpleMetrics]] page.*
## PTMPredictionMetric

### Reference
This is currently unpublished.

### General description
Metric for predicting 18 different post-translational modifications (PTMs) using neural networks.
The metric requires Rosetta to be build using `extras=tensorflow` (for compilation details see [[trRosettaProtocol]]).
You can use this metric together with the [[GenericMonteCarloMover]] and [[RandomMutationMover]] to maximize/minimize the probability of a modification in your protein of interest.

### Details and caveat
We use local sequence and structure features around the potentially modified site to predict its modification probability. We do not use global or homology features (e.g. whole sequence, ESM embeddings, MSAs, cellular localization), as the Metric is not only meant for prediction of PTMs but also for _engineering_ PTMs of any protein, be it _de novo_ or natural. This does mean that, for example, optimizing the probability of an N-linked glycosylation site will still not result in a glycosylated protein if the protein lacks a secretion tag or is expressed in an unsuitable system like _E. coli_.

### Examples 
Predicting N-linked glycosylation:
```
<ROSETTASCRIPTS>
    <FILTERS>
    </FILTERS>
    <RESIDUE_SELECTORS>
        <Index name="res" resnums="22A,38A,81A,165A,285A,63A,133A,144A,246A"/>
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <PTMPredictionMetric name="glycosylation_prediction" residue_selector="res" modification="NlinkedGlycosylation" />
    </SIMPLE_METRICS>
    <MOVERS>
        <RunSimpleMetrics name="run" metrics="glycosylation_prediction" override="true"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="run"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```


[[include:simple_metric_PTMPredictionMetric_type]]

##See Also

* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover