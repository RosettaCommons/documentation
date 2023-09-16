# ProbabilityConservationMetric
*Back to [[SimpleMetrics]] page.*
## ProbabilityConservationMetric

[[include:simple_metric_ProbabilityConservationMetric_type]]

### General description
A metric for calculating the conservation of a position given some predicted probabilities (using the relative Shannon Entropy). The returned value is between 0 (no conservation, all amino acids are equally likely) to 1 (fully conserved, only one amino acid is predicted). This metric alone does not require compilation with `extras=tensorflow,pytorch` but the model predictions that are typically input do. See [[Building Rosetta with TensorFlow and PyTorch]] for the compilation setup.


### Example
This example predicts the amino acid probabilities for chain A of our protein using ProteinMPNN and then calculates the conservation from them. Additionally it uses the `metric_to_bfactor` option of the [[RunSimpleMetrics]] mover which enables easy visualization of the values in ChimeraX/PyMol.
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <ProteinMPNNProbabilitiesMetric name="prediction"/>
        <ProbabilityConservationMetric name="conservation" metric="prediction" custom_type="score"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="run" metrics="conservation" metric_to_bfactor="score"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="run"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Reference
The implementation in Rosetta is currently unpublished.

##See Also

* [[PseudoPerplexityMetric]]: Calculate the pseudo-perplexity score for any PerResidueProbabilitiesMetric
* [[AverageProbabilitiesMetric]]: Average multiple PerResidueProbabilitiesMetrics
* [[PerResidueEsmProbabilitiesMetric]]: Predict probabilities using the ESM language model family
* [[ProteinMPNNProbabilitiesMetric]]: Predict probabilities using the ProteinMPNN model
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover