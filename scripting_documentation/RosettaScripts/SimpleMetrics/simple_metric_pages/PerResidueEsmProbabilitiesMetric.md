# PerResidueEsmProbabilitiesMetric
*Back to [[SimpleMetrics]] page.*
## PerResidueEsmProbabilitiesMetric

[[include:simple_metric_PerResidueEsmProbabilitiesMetric_type]]

### General description
Uses the Evolutionary Scale Modeling (ESM) protein language model family to predict amino acid probabilities for a given selection. The prediction is based on the chain sequence of the selected residue. It will mask and predict each residue selected by the `residue_selector`. The `attention_mask_selection` can optionally be used to hide other parts of the sequence (but is NOT the way you specify residues for prediction!). 

### Details
The metric requires Rosetta to be build using `extras=tensorflow` (for compilation details see [[Building Rosetta with TensorFlow and PyTorch]]). The smallest base model is already present but larger models need to be downloaded once, you can do this either by setting the `-auto_download` flag or following the instructions printed by the metric. Non-canonical amino acids can be present in the sequence that is used for prediction, however, they will be set to the "unknown" token, you might additionally want to use the `attention_mask_selection` to prevent them from altering your prediction. 

### Available models
Currently available models are: `esm2_t6_8M_UR50D`, `esm2_t12_35M_UR50D`, `esm2_t30_150M_UR50D`, `esm2_t33_650M_UR50D`

### Example
This example predicts the probabilities for the complete chain A while masking the position 25 using the esm2_t6_8M_UR50D model. The `multirun` option controls whether all positions are getting predicted in one inference pass or one by one (you would instead set this to false if you run out of memory). Additionally it specifies to output a position-specific-scoring-matrix (PSSM) in psi-blast format containing the predicted probabilities as logit, which can be used with the [[FavorSequenceProfileMover]] to constrain a design run. Lastly, it uses the [[PseudoPerplexityMetric]] to calculate a single score from all predicted probabilities, describing the likelihood of the overall sequence.

```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <PerResidueEsmProbabilitiesMetric name="prediction" residue_selector="res" write_pssm="test.pssm" model="esm2_t6_8M_UR50D" multirun="true"/>
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
The implementation in Rosetta is currently unpublished.

You should also cite:

Initital ESM paper

```bibtex
@article{rives2019biological,
  author={Rives, Alexander and Meier, Joshua and Sercu, Tom and Goyal, Siddharth and Lin, Zeming and Liu, Jason and Guo, Demi and Ott, Myle and Zitnick, C. Lawrence and Ma, Jerry and Fergus, Rob},
  title={Biological Structure and Function Emerge from Scaling Unsupervised Learning to 250 Million Protein Sequences},
  year={2019},
  doi={10.1101/622803},
  url={https://www.biorxiv.org/content/10.1101/622803v4},
  journal={PNAS}
}
```

ESM-2 paper

```bibtex
@article{lin2022language,
  title={Language models of protein sequences at the scale of evolution enable accurate structure prediction},
  author={Lin, Zeming and Akin, Halil and Rao, Roshan and Hie, Brian and Zhu, Zhongkai and Lu, Wenting and Smetanin, Nikita and dos Santos Costa, Allan and Fazel-Zarandi, Maryam and Sercu, Tom and Candido, Sal and others},
  journal={bioRxiv},
  year={2022},
  publisher={Cold Spring Harbor Laboratory}
}
```

##See Also

* [[PseudoPerplexityMetric]]: Calculate the pseudo-perplexity score for any PerResidueProbabilitiesMetric
* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover