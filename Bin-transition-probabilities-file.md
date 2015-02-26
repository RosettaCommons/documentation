#Bin transition probabilities file

Author: Vikram K. Mulligan, Baker laboratory (vmullig@uw.edu)

This page describes the .bin_params format, syntax, and conventions.

Bin transition probabilities (.bin_params) files are used to define the probabilities of transitioning from one mainchain torsion bin at residue i to another bin at residue i+1.  For our purposes, a mainchain torsion bin is defined as a region in mainchain torsion space lying within well-defined, rectangular boundaries.  For example, bin "B" from the ABEGO definitions is defined as any mainchain conformation for which phi is between -180 and 0 degrees, psi is greater than 50 or less than -125 degrees, and omega is greater than 90 or less than -90 degrees.

The defined transition probabilities are used by certain sampling schemes, and could be used for scoring as well.

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

Each bin transition probability file must define at least one bin transition probability matrix.  Each probability matrix defines a set of bins for position i, a set of bins for position i+1, a set of rules for what types of residues could be at positions i and i+1, and the actual (un-normalized) transition probabilities or counts.  Multiple matrices may be defined to allow different transition probabilities given different types of residues at positions i and i+1.  For example, the probability of transitioning to the normally prohibited regions of Ramachandran space is very low unless residue i+1 is a glyceine.  Each defined transition matrix must be flanked with <b>BEGIN</b> and <b>END</b> lines.