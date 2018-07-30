# Covalent Labeling MS Score Terms

Creator Names:
* Melanie Aprahamian (aprahamian.4@osu.edu)
* PI: Steffen Lindert (lindert.1@osu.edu)

## Covalent Labeling Mass Spectrometry
Covalent labeling (sometimes referred to as “protein footprinting”) involves exposing a protein in solution to a small labeling reagent that will covalently bond to select amino acid sidechains that are exposed to solvent, whereas sidechains buried within the core of the protein or occluded by interacting protein subunits will not get labeled. This provides information about the relative location of certain amino acids with respect to the solvent (either on the surface and solvent exposed or buried within the protein or protein complex structure). A variety of different labeling reagents exist and some are highly specific as to which amino acid(s) can react with the reagent and others have a much broader range of potential target residues.

On its own, covalent labeling MS experiments do not provide enough information to determine a proteins tertiary structure, but using the information in conjunction with Rosetta, the quality of generated models improves.

Experimental results are typically represented in the form of protection factors (PF). We define the protection factor as the ratio of the relative intrinsic reactivity for residue i divided by the experimentally determined labeling rate constant k. This provides a quantitative measure that correlates to a residue's relative solvent exposure (which can easily be determined within Rosetta)

Publication: [Aprahamian et. al., Anal. Chem. 2018](https://pubs.acs.org/doi/abs/10.1021/acs.analchem.8b01624)

## Hydroxyl Radical Footprinting (HRF)
We have developed a centroid based score term that utilizes the experimental output of HRF MS experiments.

 