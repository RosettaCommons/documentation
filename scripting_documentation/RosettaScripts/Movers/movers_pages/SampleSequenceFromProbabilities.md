# SampleSequenceFromProbabilities
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SampleSequenceFromProbabilities


### General description
Sample whole sequences or a specified number of mutations from a PerResidueProbabilitiesMetric and thread them onto the pose.

[[include:mover_SampleSequenceFromProbabilities_type]]

### Example
In this example, we sample ten mutations from ESM predicted probabilities, where each mutation needs have at least a probability of 0.0001 and a delta probability to current of 0.0 (meaning at least as likely as the current amino acid at a particular position). There is a temperature option for both the choice of position and amino acids, where T<1 leads to more deterministic behavior and T>1 to more diversity. We also restrict the choice of mutations with a resfile specifying packing behavior of residues and/or amino acids. 

```xml
<ROSETTASCRIPTS>
    <TASKOPERATIONS>
        <ReadResfile name="rrf" filename="./resfile.resfile"/>
    </TASKOPERATIONS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define model to use for prediction -----------------------------
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t30_150M_UR50D" write_pssm="" multirun="true"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        ----------------------- Sample mutations ------------------------------------------
        <SampleSequenceFromProbabilities name="sample" metric="esm" pos_temp="1.0" aa_temp="1.0" prob_cutoff="0.0001" delta_prob_cutoff="0.0" max_mutations="10" task_operations="rrf" use_cached_data="true"/>
        <RunSimpleMetrics name="run" metrics="esm"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="run"/>
        <Add mover_name="sample"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Reference
This is currently unpublished.

##See Also

##See Also

* [[PseudoPerplexityMetric]]: Calculate the pseudo-perplexity score for any PerResidueProbabilitiesMetric
* [[AverageProbabilitiesMetric]]: Average multiple PerResidueProbabilitiesMetrics
* [[PerResidueEsmProbabilitiesMetric]]: Predict probabilities using the ESM language model family
* [[ProteinMPNNProbabilitiesMetric]]: Predict probabilities using the ProteinMPNN model
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover