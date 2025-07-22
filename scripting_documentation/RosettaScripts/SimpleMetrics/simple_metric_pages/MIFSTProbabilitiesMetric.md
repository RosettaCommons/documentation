# MIFSTProbabilitiesMetric
*Back to [[SimpleMetrics]] page.*
## MIFSTProbabilitiesMetric

[[include:simple_metric_MIFSTProbabilitiesMetric_type]]

### General description
A metric for estimating the probability of an amino acid at a given position, as predicted by the Masked Inverse Folding with Sequence Transfer (MIF-ST) model from [Yang et al.](https://doi.org/10.1101/2022.05.25.493516). This metric requires to be build with `extras=torch`, see [[Building Rosetta with TensorFlow and Torch]] for the compilation setup.

### Note on processor usage.

By default, the MIFSTProbabilitiesMetric will use multiple processors during prediction. (The number of processors to use is autodetermined by Torch, based on the number of processors on the machine.)

To limit the number of processors being used, set the following environment variables prior to running Rosetta (commands assuming Bash, and assuming one CPU used):
```
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export TORCH_NUM_THREADS=1
export TORCH_INTRAOP_NUM_THREADS=1
export TORCH_INTEROP_NUM_THREADS=1
```

This, of course, will increase the runtime, but may be necessary when running on systems where you explicitly need to control CPU usage.

### Example
The example predicts the amino acid probabilities for chain A using only the coordinates and sequence of chain A.It does so by running one prediction for each position while masking its residue type. With `multirun=true` & `use_gpu=true` all predictions are batched together and run on the GPU (if available). Lastly it uses these predictions to score the current sequence using the pseudo-perplexity metric.
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <MIFSTProbabilitiesMetric name="prediction" residue_selector="res" feature_selector="res" multirun="true" use_gpu="true"/>
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
@article {Yang2022.05.25.493516,
	author = {Kevin K. Yang and Hugh Yeh and Niccol{\`o} Zanichelli},
	title = {Masked Inverse Folding with Sequence Transfer for Protein Representation Learning},
	elocation-id = {2022.05.25.493516},
	year = {2023},
	doi = {10.1101/2022.05.25.493516},
	publisher = {Cold Spring Harbor Laboratory},
	URL = {https://www.biorxiv.org/content/early/2023/03/19/2022.05.25.493516},
	eprint = {https://www.biorxiv.org/content/early/2023/03/19/2022.05.25.493516.full.pdf},
	journal = {bioRxiv}
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