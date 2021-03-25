# Covalent Labeling MS Score Terms

Creator Names:
* Sarah Biehn (biehn.4@osu.edu)
* Melanie Aprahamian (aprahamian.4@osu.edu)
* PI: Steffen Lindert (lindert.1@osu.edu)

Date created: July 27, 2018
Updated: February 24, 2021 

## Covalent Labeling Mass Spectrometry
Covalent labeling (sometimes referred to as “protein footprinting”) involves exposing a protein in solution to a small labeling reagent that will covalently bond to select amino acid side chains that are exposed to solvent, whereas side chains buried within the core of the protein or occluded by interacting protein subunits will not get labeled. This provides information about the relative location of certain amino acids with respect to the solvent (either on the surface and solvent exposed or buried within the protein or protein complex structure). A variety of different labeling reagents exist and some are highly specific as to which amino acid(s) can react with the reagent and others have a much broader range of potential target residues.

On its own, covalent labeling MS experiments do not provide enough information to determine a proteins tertiary structure, but using the information in conjunction with Rosetta, the quality of generated models improves.

Experimental results are typically represented in the form of protection factors (PF). We define the protection factor as the ratio of the relative intrinsic reactivity for residue i divided by the experimentally determined labeling rate constant k. The natural logarithm of the PFs provide a quantitative measure that correlates to a residue's relative solvent exposure (which can easily be determined within Rosetta).

HRF Publication: [Biehn and Lindert, _Nat. Comm._ 2021] (https://www.nature.com/articles/s41467-020-20549-7).
Please see Supplementary Note 1 in the publication for an in-depth tutorial with corresponding command lines.

## Hydroxyl Radical Footprinting (HRF)
We have developed the `hrf_dynamics` score term that uses lnPF data from HRF MS experiments to reward models that agree with experimental data.

The energy method is located in `Rosetta/main/source/src/core/energy_methods/HRFDynamicsEnergy.cc`.

### Per Residue Solvent Exposure for HRF
In order to calculate a residue's relative solvent exposure in a given model, we identified a prediction equation that relates conical neighbor count calculated from 30 mover models and experimental input data in the form of lnPF. This neighbor count calculation uses a logistic function with a distance midpoint of `9.0`, distance steepness of `1.0`, angle midpoint of `pi/2`, and angle steepness of `2pi`. To determine the neighbor count, a simple application was written to read in a pdb and output a per residue neighbor count: `Rosetta/main/source/src/apps/public/analysis/per_residue_solvent_exposure.cc`.

### Usage
To use `hrf_dynamics`, an input text file containing the experimentally derived lnPFs for residue types W, Y, F, H, and L along with the corresponding residue numbers is required. The general format for this input file is:

```
#RESIDUE NUMBER, lnPF
7	4.0943445622
14      4.370597939
33      5.634789603
...
```

The associated weights file, `hrf_dynamics.wts`, gives this score a weight of `12.0`. This was optimized based solely on rescoring pre-generated _ab initio_ models. More work needs to be done to optimize for use with [Abinitio Relax](https://www.rosettacommons.org/docs/wiki/application_documentation/structure_prediction/abinitio-relax).

Command line usage for rescoring models:
```
~/Rosetta/main/source/bin/score.linuxgccrelease \
   -database /path/to/rosetta/main/database \
   -in:file:s S_000001.pdb \
   -score:hrf_dynamics_input labeling_input_file.txt
   -score:weights hrf_dynamics.wts 
```

### Building mover models from top-scoring _ab initio_ models
Mover models are generated using a Rosetta XML script: `Rosetta/main/source/scripts/rosetta_scripts/public/flexibility/nma_relax.xml`.
Command line usage for mover model generation:
```
~/Rosetta/main/source/bin/rosetta_scripts.linuxgccrelease -s S_000001.pdb -nstruct 30 -parser:protocol ~/Rosetta/main/source/scripts/rosetta_scripts/public/flexibility/nma_relax.xml
```
Mover models can then be scored with `hrf_dynamics`.

###Previous work
Information regarding the previous score term,  `hrf_ms_labeling`, can be found in the following publication: [Aprahamian et. al., Anal. Chem. 2018](https://pubs.acs.org/doi/abs/10.1021/acs.analchem.8b01624)

## General Covalent Labeling

In order to further generalize the use of covalent labeling data for protein structure prediction, two new score terms were developed to be used in conjunction with AbinitioRelax: `covalent_labeling` and `covalent_labeling_fa`. These score terms live in `CovalentLabelingEnergy.cc` and `CovalentLabelingFAEnergy.cc`, respectively.

Both versions of the score term take as inputs the labeled residue resID and the corresponding neighbor counts (it is up to the user to identify how to correlate the experimental data to a neighbor count measure). The centroid version of the score term (`covalent_labeling`) is used during the low-resolution Abinitio phase and the weights are controlled by the weight patch files found in the `database` (`score*_covalentlabeling.patch_wts`). The full-atom version is used in the Relax phase and the weight is controlled by the weights file `covalent_labeling_fa.wts`.

###Usage

The general form of the covalent labeling score term was designed to be used in either a rescoring fashion (like the HRF score term above) or in `AbinitioRelax` to guide model generation.

An input file (which we'll refer to simply as `covalent_labeling_input_file.txt` is needed defined with 2 columns as follows:

```
#RESIDUE NUMBER, NEIGHBOR COUNT
2 9.741145
3 6.41184
6 11.2967
15 13.1428
16 12.6952
...
```

A `flags` file can be used to define all of the needed inputs:

```
-abinitio
 -stage1_patch score0_covalentlabeling.wts_patch
 -stage2_patch score1_covalentlabeling.wts_patch
 -stage3a_patch score2_covalentlabeling.wts_patch
 -stage3b_patch score5_covalentlabeling.wts_patch
 -stage4_patch score3_covalentlabeling.wts_patch
 -relax
-relax
 -fast
-in
 -file
  -fasta /path/to/protein.fasta
  -frag3 /path/to/frags_3
  -frag9 /path/to/frags_9
  -native /path/to/protein.pdb
-score
 -covalent_labeling_input /path/to/covalent_labeling_input_file.txt
 -covalent_labeling_fa_input /path/to/covalent_labeling_input_file.txt
 -weights covalent_labeling_fa.wts
-out
 -nstruct #
```

To execute the command, please follow the standard methods for running [Abinitio Relax](https://www.rosettacommons.org/docs/wiki/application_documentation/structure_prediction/abinitio-relax).

##See Also

* [[Scoring explained]]
* [[Score types]]
* [[Centroid vs fullatom]]
* [[Scorefunction history]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
