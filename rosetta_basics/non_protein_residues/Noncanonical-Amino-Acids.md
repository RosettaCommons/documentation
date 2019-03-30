# Working with noncanonical amino acids in Rosetta
References included by Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu) + Jared Adolf-Bryfogle, Dunbrack Lab (jpa37@drexel.edu). Created 13 March 2014.
Documentation added by Andrew Watkins (XRW3), adapted in part from a protocol capture from Renfrew et al. (2012).

Summary
==================
Rosetta can use noncanonical amino acids in packing, minimization, and design.
Because the statistical potentials used by talaris2014 are not trained on the NCAAs, generally the mm_std scoring function and its derivatives are employed instead.
As a user, you can use quantum mechanics software, OpenBabel, the molfile_to_params_polymer.py script, and the MakeRotLib application to make a novel NCAA ready for Rosetta use.
The ROTAMER_AA params file line allows you to skip the MakeRotLib step if you want to let your tyrosine related NCAA use tyrosine rotamers
If you use the BACKBONE_AA line to analogously assign a related canonical for backbone scoring terms, you can more-or-less use talaris without a reference energy for the noncanonical but this behavior is not supported.

What are noncanonical amino acids?
==================

Noncanonical amino acids are, simply, amino acids that are not among the twenty canonical amino acids nor their 19 D- counterparts.
Many of them are still found in proteins with moderate frequency and they can be very effective at improving folding and binding properties of proteins and peptidomimetics.


Incorporating noncanonical amino acids 
==================

First, draw your acetylated, N-methylamidated amino acid in whatever structure creation program you prefer.
Attempt to obtain a physically reasonable structure as a starting point so that QM does not crash.
Second, use a quantum mechanics program (the referenced publication used Gaussian) to optimize the aforementioned structure at a desired level of theory (Renfrew used HF/6-31G(d), with the Gaussian-specific options of Opt=ModRedundant SCF=Tight Test; OpenBabel can turn the amino acid structure into a Gaussian input file).
Third, take the output and turn it into a molfile (using OpenBabel and Gaussian: babel -ig09 -omol <output.out > molfile.mol).
Fourth, add these lines to the end of the molfile:  

```
M  ROOT \[the number of the N-terminal atom\]  
M  POLY_N_BB \[ditto, unless for some reason the most N terminal atom in your residue type is not N\]  
M  POLY_CA_BB \[the CA atom number\]  
M  POLY_C_BB \[the C atom number\]  
M  POLY_O_BB \[the O atom number\]  
M  POLY_IGNORE \[all the atoms of the capping groups except UPPER and LOWER\]  
M  POLY_UPPER \[the nitrogen atom number of the C-terminal methyl amide\]  
M  POLY_LOWER \[the carbonyl atom number of the N-terminal acetyl\]  
M  POLY_CHG \[the charge\]  
M  POLY_PROPERTIES \[any properties, like PROTEIN and CHARGED, etc.\]  
M  END  
```

These atom numbers can be easily obtained by visualizing the QM-optimized structure in pymol and labeling by atom numbers. 
Fifth, use the Rosetta script molfile_to_params_polymer.py to create a params file and put it in the database.

Making rotamer libraries
==================

```
AA_NAME LEU
EPS_RANGE 180 180 1
BB_RANGE -60 -60 1 2
BB_RANGE -40 -40 1 3
OMG_RANGE 180  180 1
NUM_CHI 2
NUM_BB  2
CHI_RANGE 1 0  345  15
CHI_RANGE 2 0  345  15
CENTROID 300 1 300 1
CENTROID 300 1 180 2
CENTROID 300 1  60 3
CENTROID 180 2 300 1
CENTROID 180 2 180 2
CENTROID 180 2  60 3
CENTROID  60 3 300 1
CENTROID  60 3 180 2
CENTROID  60 3  60 3
TEMPERATURE 1
```

The above is an options file specified by:

{Rosetta path}/bin/MakeRotLib.{extension} -options_file LEU.opt

Epsilon and omega are the preceding and following omega angles, respectively.
For N-alkylated amino acids and peptoid residues, it may be advantageous to sample both cis and trans conformations (and possibly plus or minus ten degrees); for particularly special cases you may want to sample all omega values and create a three-dimensional rotamer library.
The third number in each backbone line (1) is the step size.
If the numbers were different, the step should be set to 10 and each run would operate on multiple values of that dihedral angle and produce multiple output files.
The fourth number present in the BB_RANGE lines represents the dihedral in question.
Dihedral 2 corresponds to phi and 3 corresponds to psi (because the prepended acetyl adds a torsion); other numbers of backbone angles are supported.
Both the number of chi angles and (non-omega-like) backbone torsions are specified.
Centroids are listed to correspond to the chemistry of the residue.

In general, the following centroid schemes are necessary:
-	For an chi angle centered on a sp<sup>3</sup>-sp<sup>3</sup> bond (for example, chi2 of leucine centers on the CB-CG bond), there are three centroids at 300, 180, and 60 (corresponding to g-, a, g+ rotamers)
-	For an chi angle centered on a _symmetrical_ sp<sup>3</sup>-sp<sup>2</sup> bond (for example, chi2 of phenylalanine centers on the CB-CG bond), there are six centroids at 330, 300, 270, 240, 210, and 180 degrees.
-	For an chi angle centered on an _asymmetrical_ sp<sup>3</sup>-sp<sup>2</sup> bond (for example, chi2 of phenylalanine centers on the CB-CG bond), there are six centroids at 330, 300, 270, 240, 210, and 180 degrees.

ROTWELLS lines may be used instead of CENTROID designation, where you just have to give the rotwells legal for each chi. The above file would instead use:

```
ROTWELLS 1 3  60 180 300
ROTWELLS 2 3  60 180 300
```

If you want to generate an approximate "density-style" rotamer library for semirotameric amino acids, add a SEMIROTAMERIC line to the above file and run it separately to create a file with a continuous representation of the terminal, nonrotameric chi.

## References

Drew K, Renfrew PD, Craven TW, Butterfoss GL, Chou F-C, et al. (2013) Adding Diverse Noncanonical Backbones to Rosetta: Enabling Peptidomimetic Design. PLoS ONE 8(7): e67051. doi:10.1371/journal.pone.0067051

Renfrew PD, Choi EJ, Bonneau R, Kuhlman B (2012) Incorporation of Noncanonical Amino Acids into Rosetta and Use in Computational Protein-Peptide Interface Design. PLoS ONE 7(3): e32637. doi:10.1371/journal.pone.0032637

