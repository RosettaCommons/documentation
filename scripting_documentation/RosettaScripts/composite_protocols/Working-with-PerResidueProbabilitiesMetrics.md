# Working with PerResidueProbabilitiesMetrics
[[Return to RosettaScripts|RosettaScripts]]

[[_TOC_]]

##Overview
This page describes workflows using PerResidueProbabilitiesMetrics, which provide predicted amino acid probabilities from e.g. ProteinMPNN or the ESM language family. For example, they can be used to score a given protein structure, to analyze conservation of residues, or to directly sample mutations from.

##Build setup
In order to run ML models you will have to compile with `extras=pytorch,tensorflow`, for details see [[Building Rosetta with TensorFlow and PyTorch]]. All other metrics/movers/taskops do no require extras per se.

##Prediction using ML models
Currently available models are [[ProteinMPNN|ProteinMPNNProbabilitiesMetric]] and the [[ESM language model family|PerResidueEsmProbabilitiesMetric]]. Both models predict amino acid probabilities for a given residue selection, with ESM only using the sequence and ProteinMPNN using both backbone and sequence to make predictions. For more details on available options and paper references see the individual documentation.

```xml
<ROSETTASCRIPTS> 
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define models to use -----------------------------
        <ProteinMPNNProbabilitiesMetric name="mpnn" residue_selector="res"/>
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t33_650M_UR50D"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="predictions" metrics="mpnn,esm"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="predictions"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```
##Average, Save and Load probabilities
###Average probabilities
Multiple PerResidueProbabilitiesMetrics can be [[averaged|AverageProbabilitiesMetric]] together, which is useful for later combined sampling or scoring. A weight can be provided for each metric to up-/down-weigh specific metrics. In the following example, we average the predictions of ProteinMPNN and ESM (with twice the weight on ESM) and then score our protein.
```xml
<ROSETTASCRIPTS> 
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define models to use -----------------------------
        <ProteinMPNNProbabilitiesMetric name="mpnn" residue_selector="res"/>
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t33_650M_UR50D"/>
        ----------------- Average predictions without re-calculation -------
        <AverageProbabilitiesMetric name="avg" metrics="mpnn,esm" weights="1,2" use_cached_data="true"/>
        ----------------- Analyze predictions without re-calculation -------
        <PseudoPerplexityMetric name="avg_perplex" metric="avg" use_cached_data="true" custom_type="avg"/>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <RunSimpleMetrics name="predictions" metrics="mpnn,esm"/>
        <RunSimpleMetrics name="analysis" metrics="avg,avg_perplex"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="predictions"/>
        <Add mover_name="analaysis"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

###Save probabilities
All PerResidueProbabilities can be [[saved|SaveProbabilitiesMetricMover]] to a weights file format or a psi-blast style PSSM (position-specific-scoring-matrix). This is either useful for separating model predictions and later sequence/mutation sampling (weights file), or to [[constrain during design|FavorSequenceProfileMover]] (PSSM file).
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define model to use for prediction -----------------------------
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t33_650M_UR50D" multirun="true"/>
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
###Load probabilities
Probabilities weight files saved with the [[SaveProbabilitiesMetricMover]] or manually created can be [[loaded|LoadedProbabilitiesMetric]] into a PerResidueProbabilitiesMetric. The first lines of the `probs.weights` file look like this:
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
##Analyze probabilities
###Score
To score a pose with predicted probabilities the [[PseudoPerplexityMetric]] can be used, where lower is better with 1 being the lowest possible value.
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <PerResidueEsmProbabilitiesMetric name="prediction" residue_selector="res" model="esm2_t33_650M_UR50D"/>
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
###Conservation
To get the conservation of positions relative to the predicted probabilities, the [[ProbabilityConservationMetric]] can be used. It provides the relative Shannon Entropy, where the returned value is between 0 (no conservation, all amino acids are equally likely) to 1 (fully conserved, only one amino acid is predicted). The example below also outputs the values to the b-factor column of the pdb, allowing easy visualization in PyMol/ChimeraX.
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
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
###Get best single-point mutations
A [[metric|BestMutationsFromProbabilitiesMetric]] for calculating mutations with the highest delta probability to the current residues from a PerResidueProbabilitiesMetric can be used to quickly identify single-point mutations that are likely to have a high impact. The examples uses the ESM language model to predict amino acid probabilities, and then gets the ten most likely mutations that are at least as likely as the currently present amino acid. 
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
        <Chain name="res" chains="A" />
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        ----------------- Define models to use -----------------------------
        <PerResidueEsmProbabilitiesMetric name="esm" residue_selector="res" model="esm2_t33_650M_UR50D"/>
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
##Sample a sequence/mutations from probabilities

##Restrict available amino acids during design based on probabilities

##Restrain design using probabilities