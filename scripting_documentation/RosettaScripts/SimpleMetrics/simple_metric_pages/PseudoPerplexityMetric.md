# PseudoPerplexityMetric
*Back to [[SimpleMetrics]] page.*
## PseudoPerplexityMetric


### General description
Calculate the pseudo-perplexity from a _PerResidueProbabilitiesMetric_, which is a value defining the likelihood of a sequence given the prediction of a model (smaller is better). It is defined as the exponentiation of the average negative logarithm of the predicted probabilities.

[[include:simple_metric_PseudoPerplexityMetric_type]]

### Example


```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
        <Index name="mask" resnums="25"/>
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <PerResidueEsmProbabilitiesMetric name="prediction" residue_selector="res" attention_mask_selection="mask"  write_pssm="test.pssm" model="esm2_t6_8M_UR50D" multirun="true"/>
        <PseudoPerplexityMetric name="perplex" metric="prediction"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="run" metrics="perplex"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="run"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Reference
This is currently unpublished.

##See Also

* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover