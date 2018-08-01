# Covalent Labeling MS Score Terms

Creator Names:
* Melanie Aprahamian (aprahamian.4@osu.edu)
* PI: Steffen Lindert (lindert.1@osu.edu)

Date created: July 27, 2018

## Covalent Labeling Mass Spectrometry
Covalent labeling (sometimes referred to as “protein footprinting”) involves exposing a protein in solution to a small labeling reagent that will covalently bond to select amino acid sidechains that are exposed to solvent, whereas sidechains buried within the core of the protein or occluded by interacting protein subunits will not get labeled. This provides information about the relative location of certain amino acids with respect to the solvent (either on the surface and solvent exposed or buried within the protein or protein complex structure). A variety of different labeling reagents exist and some are highly specific as to which amino acid(s) can react with the reagent and others have a much broader range of potential target residues.

On its own, covalent labeling MS experiments do not provide enough information to determine a proteins tertiary structure, but using the information in conjunction with Rosetta, the quality of generated models improves.

Experimental results are typically represented in the form of protection factors (PF). We define the protection factor as the ratio of the relative intrinsic reactivity for residue i divided by the experimentally determined labeling rate constant k. The natural logarithm of the PFs provide a quantitative measure that correlates to a residue's relative solvent exposure (which can easily be determined within Rosetta).

Publication: [Aprahamian et. al., Anal. Chem. 2018](https://pubs.acs.org/doi/abs/10.1021/acs.analchem.8b01624)

## Per Residue Solvent Exposure
One way to quantify solvent exposure on a per residue basis is to look at its relative neighbor count. The pilot application `per_residue_solvent_exposure.cc` utilizes several different methods to calculate and output the neighbor counts on a per residue basis. The app contains two main ways to calculate the neighbor counts: centroid or fullatom (FA). Within each, there are multiple different methods to calculate the neighbor count. 

### Centroid
Calculating the neighbor count in centroid mode will represent each sidechain as a single point, a centroid ([Centroid](https://www.rosettacommons.org/docs/wiki/rosetta_basics/Glossary/Glossary#c). The neighbor count can then be calculated using either the "sphere" or "cone" method.

The "sphere" method counts the number of residues around the target residue and weights the count with a logistic function defined as
**neighbor count = 1/(1+exp(distance_steepness * (d - distance_cutoff)) **
where **d** is the calculated distance between the target residue's CEN and the neighbor residue's CEN, **distance_steepness** defines the steepness of the curve, and **distance_midpoint** defines the midpoint of the curve.

The "cone" method was adapted from the [LayerSelector](https://www.rosettacommons.org/docs/wiki/scripting_documentation/RosettaScripts/ResidueSelectors/ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector) ResidueSelector. It calculates the neighbor count by weighting not just by the distance from the target residue but also the angle made between the target and the neighbor. 


### Usage
To use the application, the following command line options need to be specified:
'''


## Hydroxyl Radical Footprinting (HRF)
We have developed a centroid based score term, `hrf_ms_labeling`, that utilizes the experimental output of HRF MS experiments.

The energy method lives in `Rosetta/main/source/src/core/scoring/methods/HRF_MSLabelingEnergy.cc`.

### Per Residue Solvent Exposure for HRF
In order to calculate a residue's relative solvent exposure in a given model, we identified that a centroid based neighbor count gave the most correlation to the experimental input data. This neighbor count calculation uses a logistic function with a midpoint of `9.0` and a steepness of `0.1`. To determine the neighbor count, a simple pilot application was written to read in a pdb and output a per residue neighbor count: `/bin/burial_measure_centroid.cc`.

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

##See Also

* [[Scoring explained]]
* [[Score types]]
* [[Centroid vs fullatom]]
* [[Scorefunction history]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
