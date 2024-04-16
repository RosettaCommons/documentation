# SaveProbabilitiesMetricMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SaveProbabilitiesMetricMover


### General description
Save a PerResidueProbabilitiesMetric to a weights and/or position-specific-scoring-matrix (PSSM) file. The weights file can be loaded as [[LoadedProbabilitiesMetric]] and the PSSM can be used with the [[FavorSequenceProfileMover]] to add ResidueType constraints for a design run.

[[include:mover_SaveProbabilitiesMetricMover_type]]

### Example
Here we use the ESM language model to predict amino acid probabilities and save them both as PSSM and weights file.

```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define model to use for prediction -----------------------------
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t30_150M_UR50D" multirun="true"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="inference" metrics="esm"/>
        -------------------------- Setup saving ---------------------------------------------
        <SaveProbabilitiesMetricMover name="save" metric="esm" filename="probs" filetype="both" use_cached_data="true"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="inference"/>
        <Add mover_name="save"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Reference
This is currently unpublished.

##See Also

##See Also
* [[LoadedProbabilitiesMetric]]: Load a saved probability weights file as PerResdidueProbabilitiesMetric
* [[PseudoPerplexityMetric]]: Calculate the pseudo-perplexity score for any PerResidueProbabilitiesMetric
* [[AverageProbabilitiesMetric]]: Average multiple PerResidueProbabilitiesMetrics
* [[PerResidueEsmProbabilitiesMetric]]: Predict probabilities using the ESM language model family
* [[ProteinMPNNProbabilitiesMetric]]: Predict probabilities using the ProteinMPNN model
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover