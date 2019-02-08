# Covalent Labeling MS Score Terms

Creator Names:
* Melanie Aprahamian (aprahamian.4@osu.edu)
* PI: Steffen Lindert (lindert.1@osu.edu)

Date created: July 27, 2018
Updated: February 8, 2019 

## Covalent Labeling Mass Spectrometry
Covalent labeling (sometimes referred to as “protein footprinting”) involves exposing a protein in solution to a small labeling reagent that will covalently bond to select amino acid sidechains that are exposed to solvent, whereas sidechains buried within the core of the protein or occluded by interacting protein subunits will not get labeled. This provides information about the relative location of certain amino acids with respect to the solvent (either on the surface and solvent exposed or buried within the protein or protein complex structure). A variety of different labeling reagents exist and some are highly specific as to which amino acid(s) can react with the reagent and others have a much broader range of potential target residues.

On its own, covalent labeling MS experiments do not provide enough information to determine a proteins tertiary structure, but using the information in conjunction with Rosetta, the quality of generated models improves.

Experimental results are typically represented in the form of protection factors (PF). We define the protection factor as the ratio of the relative intrinsic reactivity for residue i divided by the experimentally determined labeling rate constant k. The natural logarithm of the PFs provide a quantitative measure that correlates to a residue's relative solvent exposure (which can easily be determined within Rosetta).

Publication: [Aprahamian et. al., Anal. Chem. 2018](https://pubs.acs.org/doi/abs/10.1021/acs.analchem.8b01624)

## Hydroxyl Radical Footprinting (HRF)
We have developed a centroid based score term, `hrf_ms_labeling`, that utilizes the experimental output of HRF MS experiments.

The energy method lives in `Rosetta/main/source/src/core/scoring/methods/HRF_MSLabelingEnergy.cc`.

### Per Residue Solvent Exposure for HRF
In order to calculate a residue's relative solvent exposure in a given model, we identified that a centroid based neighbor count gave the most correlation to the experimental input data. This neighbor count calculation uses a logistic function with a midpoint of `9.0` and a steepness of `0.1`. To determine the neighbor count, a simple application was written to read in a pdb and output a per residue neighbor count: `/bin/burial_measure_centroid.cc`.

### Usage
To use `hrf_ms_labeling` for centroid mode scoring, an input text file containing the experimentally derived protection factors and their corresponding residue numbers is required. The general format for this input file is:

```
#RESIDUE NUMBER, lnPF
7	4.0943445622
11	4.0989003788
14	4.3705979389
18	2.2462321564
...
```

The associated weights file, `hrf_ms_labeling.wts`, gives this score a weight of `6.0`. This was optimized based solely on rescoring pre-generated _ab initio_ models. More work needs to be done to optimize for use with [Abinitio Relax](https://www.rosettacommons.org/docs/wiki/application_documentation/structure_prediction/abinitio-relax).

Command line usage for rescoring models:
```
.../bin/score.linuxgccrelease \
   -database /path/to/rosetta/main/database \
   -in:file:s S_000001.pdb \
   -score:weights hrf_ms_labeling.wts 
   -in:file:hrf_ms_labeling labeling_input_file.txt 
   -centroid_input
```

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
