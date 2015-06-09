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
M  ROOT \[the number of the N-terminal atom\]
M  POLY_N_BB \[ditto, unless for some reason the most N terminal atom in your residue type is not N\]
M  POLY_CA_BB \[the CA number\]
M  POLY_C_BB \[the C number\]
M  POLY_O_BB 16
M  POLY_IGNORE 2 3 4 5 6 8 9 10 11 12
M  POLY_UPPER 7
M  POLY_LOWER 1
M  POLY_CHG 1
M  POLY_PROPERTIES PROTEIN POLAR CHARGED
M  END
Fifth, use the Rosetta script molfile_to_params_polymer.py.

## References

Drew K, Renfrew PD, Craven TW, Butterfoss GL, Chou F-C, et al. (2013) Adding Diverse Noncanonical Backbones to Rosetta: Enabling Peptidomimetic Design. PLoS ONE 8(7): e67051. doi:10.1371/journal.pone.0067051

Renfrew PD, Choi EJ, Bonneau R, Kuhlman B (2012) Incorporation of Noncanonical Amino Acids into Rosetta and Use in Computational Protein-Peptide Interface Design. PLoS ONE 7(3): e32637. doi:10.1371/journal.pone.0032637

