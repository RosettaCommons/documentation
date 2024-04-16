# LoadedProbabilitiesMetric
*Back to [[SimpleMetrics]] page.*
## LoadedProbabilitiesMetric

### General description
A metric to load a probabilities weights file into a PerResidueProbabilitiesMetric, which then can be used downstream. The weights file can be created by saving a metric with the [[SaveProbabilitiesMetricMover]] or through manual creation. The format is `POSENUMBER RESIDUETYPE WEIGHT`, see below for an example.

[[include:simple_metric_LoadedProbabilitiesMetric_type]]

### Example
Load probabilities from a specified file and use them to score the current pdb with the [[PseudoPerplexityMetric]]. The first lines of the `probs.weights` file look like this:
```
#POSNUM RESIDUETYPE WEIGHT
1 ALA 0.000125
1 CYS 0.0
1 ASP 0.0
1 GLU 0.0
1 PHE 0.002197
1 MET 0.972065
1 ASN 0.0
....
```

```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <LoadedProbabilitiesMetric name="loaded_probs" filename="probs.weights"/>
        <PseudoPerplexityMetric name="perplex" metric="loaded_probs" use_cached_data="true"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="load" metrics="loaded_probs"/>
        <RunSimpleMetrics name="score" metrics="perplex"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="load"/>
        <Add mover_name="score"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```
### Reference
The implementation in Rosetta is currently unpublished.

##See Also
* [[SaveProbabilitiesMetricMover]]: A mover to save a PerResidueProbabilitiesMetric into a weights/pssm file
* [[PseudoPerplexityMetric]]: Calculate the pseudo-perplexity score for any PerResidueProbabilitiesMetric
* [[AverageProbabilitiesMetric]]: Average multiple PerResidueProbabilitiesMetrics
* [[PerResidueEsmProbabilitiesMetric]]: Predict probabilities using the ESM language model family
* [[ProteinMPNNProbabilitiesMetric]]: Predict probabilities using the ProteinMPNN model
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover