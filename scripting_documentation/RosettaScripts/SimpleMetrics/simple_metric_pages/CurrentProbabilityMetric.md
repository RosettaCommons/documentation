# CurrentProbabilityMetric
*Back to [[SimpleMetrics]] page.*
## CurrentProbabilityMetric

[[include:simple_metric_CurrentProbabilityMetric_type]]

### General description
A PerResidueRealMetric that returns just the probability for the sequence currently present in the pose from a PerResidueProbabilitiesMetric (going from length\*20 to length\*1 probabilities). Useful for filtering or visualization of probabilities. This metric alone does not require compilation with `extras=tensorflow,pytorch` but the model predictions that are typically input do. See [[Building Rosetta with TensorFlow and PyTorch]] for the compilation setup.


### Example
This example predicts the amino acid probabilities for chain A of our protein using ProteinMPNN and then returns just the probabilities for the current sequence from them. Additionally it uses the metric_to_bfactor option of [[RunSimpleMetrics]] mover which enables easy visualization of the values in ChimeraX/PyMol. 
```
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <ProteinMPNNProbabilitiesMetric name="prediction"/>
        <CurrentProbabilityMetric name="current" metric="prediction" custom_type="probs"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="analysis" metrics="current" metric_to_bfactor="probs"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="analysis"/>
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