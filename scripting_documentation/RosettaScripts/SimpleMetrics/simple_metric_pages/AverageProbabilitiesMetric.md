# AverageProbabilitiesMetric
*Back to [[SimpleMetrics]] page.*
## AverageProbabilitiesMetric

[[include:simple_metric_AverageProbabilitiesMetric_type]]

### General description
A metric for averaging multiple `PerResidueProbabilitiesMetrics`.

### Details
Like other `PerResidueProbabilitiesMetrics` the probabilities can be output as logits in a psi-blast style PSSM using the [[SaveProbabilitiesMetricMover]], and used as input for the [[FavorSequenceProfileMover]]. This metric alone does not require compilation with `extras=tensorflow,pytorch` but the model predictions that are typically input do. See [[Building Rosetta with TensorFlow and PyTorch]] for the compilation setup.

### Example
In this example we predict the amino acid probabilities for chain A of our protein using ProteinMPNN and ESM, average both predictions and use the average probabilities to calculate a single score for our protein.
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define models to use -----------------------------
        <ProteinMPNNProbabilitiesMetric name="mpnn" residue_selector="res"/>
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t33_650M_UR50D"/>
        ----------------- Average the probabilities ------------------------
        <AverageProbabilitiesMetric name="avg" metrics="mpnn,esm"/>
        ----------------- Analyze predictions without re-calculation -------
        <PseudoPerplexityMetric name="perplex" metric="avg" use_cached_data="true"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="predictions" metrics="avg"/>
        <RunSimpleMetrics name="analysis" metrics="perplex"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="predictions"/>
        <Add mover_name="analysis"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Reference
The implementation in Rosetta is currently unpublished.

##See Also

* [[PseudoPerplexityMetric]]: Calculate the pseudo-perplexity score for any PerResidueProbabilitiesMetric
* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[PerResidueEsmProbabilitiesMetric]]: Predict probabilities using the ESM language model family
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover