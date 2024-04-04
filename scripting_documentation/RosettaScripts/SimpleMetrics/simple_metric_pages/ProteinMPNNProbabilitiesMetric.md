# ProteinMPNNProbabilitiesMetric
*Back to [[SimpleMetrics]] page.*
## ProteinMPNNProbabilitiesMetric

[[include:simple_metric_ProteinMPNNProbabilitiesMetric_type]]

### General description
A metric for estimating the probability of an amino acid at a given position, as predicted by the ProteinMPNN model. This metric requires to be build with `extras=torch`, see [[Building Rosetta with TensorFlow and Torch]] for the compilation setup.

### Example
The example predicts the amino acid identities for chain A using only the coordinates of chain A, while masking the sequence of position 25 and uses the predicted probabilities to score the sequence. 
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
        <Index name="mask" resnums="25"/>
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <ProteinMPNNProbabilitiesMetric name="prediction" residue_selector="res" coord_selector="res" sequence_mask_selector="mask" write_pssm="mpnn.pssm"/>
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
```bibtex
@article{dauparas2022robust,
  title={Robust deep learning--based protein sequence design using ProteinMPNN},
  author={Dauparas, Justas and Anishchenko, Ivan and Bennett, Nathaniel and Bai, Hua and Ragotte, Robert J and Milles, Lukas F and Wicky, Basile IM and Courbet, Alexis and de Haas, Rob J and Bethel, Neville and others},
  journal={Science},
  volume={378},
  number={6615},
  pages={49--56},
  year={2022},
  publisher={American Association for the Advancement of Science}
}
```

##See Also

* [[PseudoPerplexityMetric]]: Calculate the pseudo-perplexity score for any PerResidueProbabilitiesMetric
* [[AverageProbabilitiesMetric]]: Average multiple PerResidueProbabilitiesMetrics
* [[PerResidueEsmProbabilitiesMetric]]: Predict probabilities using the ESM language model family
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover