#Bin transition probabilities file

Author: Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu)

This page describes the .bin_params format, syntax, and conventions.

Bin transition probabilities (.bin_params) files are used to define the probabilities of transitioning from one mainchain torsion bin at residue i to another bin at residue i+1.  For our purposes, a mainchain torsion bin is defined as a region in mainchain torsion space lying within well-defined, rectangular boundaries.  For example, bin "B" from the ABEGO definitions is defined as any mainchain conformation for which phi is between -180 and 0 degrees, psi is greater than 50 or less than -125 degrees, and omega is greater than 90 or less than -90 degrees.

The defined transition probabilities are used by certain sampling schemes, and could be used for scoring as well.  Note that the format is intended to be completely general, so that it could be applied to alpha-amino acids, beta-amino acids, nucleic acids, other noncanonical building blocks, or mixed heteropolymers.

## Bin transition probabilities file format

Pre-defined bin transition probabilities files are located in the database/protocol_data/generalizedKIC/bin_params directory.  A sample bin transition probability file is shown below:

```
#ABBA.binparams
#Created by Vikram K. Mulligan (vmullig@uw.edu), 2 February 2015
#This file defines transition probabilities for the A, B, B', A', O, and O' bins.
#Bins A and B are defined as they are for ABEGO bins (phi < 0, psi -125 to 50, and
#omega 90 to 180 or -180 to -90 for A; phi < 0, psi -180 to -125 or 50 to 180, and
#omega 90 to 180 or -180 to -90 for B).  Bins A' and B' are the mirror image,
#rotated about phi=0, psi=0 (so phi > 0, psi -50 to 125, omega 90 to 180 or -180
#to 90 for A'; phi > 0, psi 125 to 180 or -180 to 50, omega 90 to 180 or -180 to -90
#for B').  Bins O and O' have cis omega angles (omega -90 to 90), and are in the
#negative or positive phi space, respectively.
#Note the defined bins must cover the full mainchain torsion space!
BEGIN
MAINCHAIN_TORSIONS_I 3
MAINCHAIN_TORSIONS_IPLUS1 3
BIN_COUNT_I 6
BIN_COUNT_IPLUS1 6
I_BIN A -180.0 0.0 -125.0 50.0 90.0 -90.0
I_BIN B -180.0 0.0 50.0 -125.0 90.0 -90.0
I_BIN Aprime 0.0 180.0 -50.0 125.0 90.0 -90.0
I_BIN Bprime 0.0 180.0 125 -50.0 90.0 -90.0
I_BIN O -180.0 0.0 -180.0 180.0 -90.0 90.0
I_BIN Oprime 0.0 180.0 -180.0 180.0 -90.0 90.0
SUB_BINS_I L_AA
IPLUS1_BINS_COPY_I
PROPERTIES_I L_AA ALPHA_AA
PROPERTIES_IPLUS1 L_AA ALPHA_AA
NOT_PROPERTIES_I D_AA
NOT_PROPERTIES_IPLUS1 D_AA
NOT_RES_I GLY
NOT_RES_IPLUS1 GLY
MATRIX	1670055	313251	87373	26201	3915	682
MATRIX	363556	1205782	71936	34623	9406	1044
MATRIX	39384	118400	17691	2634	705	63
MATRIX	25528	35553	1949	2328	493	64
MATRIX	3121	5916	176	183	171	70
MATRIX	215	742	75	42	51	20
END
```

Bin transition probabilities files may be commented with the pound sign (#).  Anything past a pound sign character is ignored.

Each bin transition probability file must define at least one bin transition probability matrix.  Each probability matrix defines a set of bins for position i, a set of bins for position i+1, a set of rules for what types of residues could be at positions i and i+1, and the actual (un-normalized) transition probabilities or counts.  Multiple matrices may be defined to allow different transition probabilities given different types of residues at positions i and i+1.  For example, the probability of transitioning to the normally prohibited regions of Ramachandran space is very low unless residue i+1 is a glycine.  Each defined transition matrix must be flanked with <b>BEGIN</b> and <b>END</b> lines.

After the <b>BEGIN line</b>, the next two lines define the number of mainchain torsions (rotatable bonds) in residues i and i+1.  This is necessary since there is no assumption that this is being applied solely to alpha-amino acids.  In our example, though, we are defining transitions for alpha-amino acids, so the number of mainchain torsions at both positions is 3.

```
MAINCHAIN_TORSIONS_I 3
MAINCHAIN_TORSIONS_IPLUS1 3
```

The next two lines specify the number of bins that will be defined at positions i and i+1.  In this example, both positions will have six bins defined.

```
BIN_COUNT_I 6
BIN_COUNT_IPLUS1 6
```

Having specified that there will be six bins, we now need to define the bin names and boundaries.  We do so with <b>I_BIN</b> and <b>IPLUS1_BIN</b> lines, each with the following syntax:

```
I_BIN <bin_name> <torsion_1_start_of_range> <torsion_1_end_of_range> <torsion_2_start_of_range> <torsion_2_end_of_range> ... <torsion_n_start_of_range> <torsion_n_end_of_range>
```

Torsion values must lie between -180 degrees and 180 degrees.  If the end of range value is less than the start of range value for any torsion range, it is assumed that the bin runs from the start of the range to 180, then wraps back to -180 and up to the end of range value.  Note that bins must not overlap, and must cover the entire torsion space.

Within each bin, the relative probability of a particular set of mainchain torsion values might not be equal.  In the case of alpha-amino acids, sub-bins may be defined automatically based on the Ramachandran map (and these permit Ramachandran-biased sampling within each bin).  The <b>SUB_BINS_I</b> and <b>SUB_BINS_IPLUS1</b> lines define how sub-bins will be set up.  Current options are:
- "NONE" (<i>i.e.</i> uniform probability across the bin)
- "L_AA" (uses the Ramachandran map for L-alanine to set up the sub-bin probability distribution)
- "D_AA" (uses the Ramachandran map for D-alanine)
- "L_PRO" (uses the Ramachandran map for L-proline)
- "D_PRO" (uses the Ramachandran map for D-proline)
- "GLY" (uses the Ramachandran map for glycine).

The number of <b>I_BIN</b> lines must match the <b>BIN_COUNT_I</b> line, and the number of <b>IPLUS1_BIN</b> lines must match the <b>BIN_COUNT_IPLUS1</b> line.  The exception is if the bins for the i+1 position are identical to the bins for the i position, in which case a shorthand is to include a <b>IPLUS1_BINS_COPY_I</b> line.  If an <b>IPLUS1_BINS_COPY_I</b> line is included, then <b>IPLUS1_BIN</b> and <b>SUB_BINS_IPLUS1</b> lines will not be required.

So for the six bins in our example, we have the following lines:

```
I_BIN A -180.0 0.0 -125.0 50.0 90.0 -90.0
I_BIN B -180.0 0.0 50.0 -125.0 90.0 -90.0
I_BIN Aprime 0.0 180.0 -50.0 125.0 90.0 -90.0
I_BIN Bprime 0.0 180.0 125 -50.0 90.0 -90.0
I_BIN O -180.0 0.0 -180.0 180.0 -90.0 90.0
I_BIN Oprime 0.0 180.0 -180.0 180.0 -90.0 90.0
SUB_BINS_I L_AA
IPLUS1_BINS_COPY_I
```

The next few lines define properties that residues at positions i or i+1 MUST have (<b>PROPERTIES_I</b> and <b>PROPERTIES_IPLUS1</b> lines), and properties that they must NOT have (<b>NOT_PROPERTIES_I</b> and <b>NOT_PROPERTIES_IPLUS1</b> lines), for the rules defined by the current bin transition probabilities to apply to them.  In the present example, we require that the i and i+1 positions are alpha-amino acids and L-amino acids, and that they cannot be D-amino acids (which is redundant, but that's fine).

```
PROPERTIES_I L_AA ALPHA_AA
PROPERTIES_IPLUS1 L_AA ALPHA_AA
NOT_PROPERTIES_I D_AA
NOT_PROPERTIES_IPLUS1 D_AA
```

The next few lines define residue identities for positions i or i+1.  If <b>RES_I</b> or <b>RES_IPLUS1</b> lines are present, each with a list of three-letter codes, then the residue at position i or i+1 MUST be one of the ones in the list in order for the bin transition rules to apply.  In this case, we have no list of required residues.  If <b>NOT_RES_I</b> or <b>NOT_RES_IPLUS1</b> lines are included, then the residue at position i or i+1 must NOT be one of the ones in the list in order for the bin transition rules to apply.  Here, we exclude glycine (even though this is redundant, since we have already required that the i and i+1 positions be L-amino acids).

```
NOT_RES_I GLY
NOT_RES_IPLUS1 GLY
```

Finally, we actually define the transition matrix, with one line corresponding to each bin for position i (with the order the same as the <b>I_BIN</b> definition lines), and one column corresponding to each bin for position i+1 (with the order the same as the <b>IPLUS1_BIN</b> definition lines).  The matrix values are counts or un-normalized transition probabilities.  The algorithm will automatically normalize these and generate cumulative distribution functions for random sampling.

```
MATRIX	1670055	313251	87373	26201	3915	682
MATRIX	363556	1205782	71936	34623	9406	1044
MATRIX	39384	118400	17691	2634	705	63
MATRIX	25528	35553	1949	2328	493	64
MATRIX	3121	5916	176	183	171	70
MATRIX	215	742	75	42	51	20
```

Additional <b>BEGIN</b> ... <b>END</b> blocks may be defined for as many bin transitions probability matrices as one wishes to define.  If a particular i/i+1 pair of residues matches the properties and residue identity criteria for more than one bin transition probability matrix, the first one encountered that matches is used (so it is best for the bin transition probability matrices to define non-overlapping criteria).

##See Also

* [[File types list]]: List of file types used in Rosetta
* [[General RosettaScripts movers|Movers-RosettaScripts#general-movers]]: Includes movers that take a bin transition probabilities file
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications