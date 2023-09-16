# BestMutationsFromProbabilitiesMetric
*Back to [[SimpleMetrics]] page.*
## BestMutationsFromProbabilitiesMetric

[[include:simple_metric_BestMutationsFromProbabilitiesMetric_type]]

### General description
A metric for calculating mutations with the highest delta probability to the current residues from a `PerResidueProbabilitiesMetric`. Returns the most likely positions and their delta probability as CurrentAA-Position-MutationAA (e.g. A89T) in **pose numbering**. This metric alone does not require compilation with `extras=tensorflow,pytorch` but the model predictions that are typically input do. See [[Building Rosetta with TensorFlow and PyTorch]] for the compilation setup.

### Example
The examples uses the ESM language model to predict amino acid probabilities, and then gets the ten most likely mutations that are at least as likely as the currently present amino acid.
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define models to use -----------------------------
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t33_650M_UR50D" write_pssm="esm.pssm"/>
        ----------------- Analyze predictions without re-calculation -------
        <BestMutationsFromProbabilitiesMetric name="esm_mutations" metric="esm" use_cached_data="true" max_mutations=10 delta_cutoff=0.0 />
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="inference" metrics="esm"/>
        <RunSimpleMetrics name="analysis" metrics="esm_mutations"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="inference"/>
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