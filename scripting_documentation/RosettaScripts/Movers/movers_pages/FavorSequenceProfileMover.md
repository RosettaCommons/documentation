# FavorSequenceProfile
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FavorSequenceProfile

```xml
<FavorSequenceProfile scaling="('prob' &string)" weight="(1 &Real)"  pssm="(&string)" use_native="(0 &bool)" use_fasta="(0 &bool)" use_starting="(0 &bool)" chain="(0, &int)" use_current="(0 &bool)" pdbname="(&string)" matrix="(BLOSUM62 &string)" scorefxns="(comma seperated list of &string)" exclude_resnums="&string" />
```

Sets residue type constraints on the pose according to the given profile and weight. Set one (and only one) of the following:

-   pssm - a filename of a blast formatted pssm file containing the sequence profile to use
-   use\_native - use the structure specified by -in:file:native as reference
-   use\_fasta - use a native FASTA sequence specified by the -in:file:fasta as reference
-   use\_starting - use the starting input structure (e.g. one passed to -s) as reference
-   use\_current - use the current structure (the one passed to apply) as the reference
-   pdbname - use the structure specified by the filename as the reference

specify if needed:

-   chain - 0 is all chains, otherwise if a sequence is added, align it to the specified chain
-   exclude_resnums - exclude residues from being constrained

You can set how to scale the given values with the "scaling" settings. The default value of "prob" does a per-residue Boltzmann-weighted probability based on the profile score (the unweighted scores for all 20 amino acid identities at any given position sum to -1.0). A setting of "global" does a global linear fixed-zero rescaling such that all (pre-weighted) values fall in the range of -1.0 to 1.0. A setting of "none" does no adjustment of values.

The parameter "weight" can be used to adjust the post-scaling strength of the constraints. (e.g. at a weight=0.2, global-scaled constraint energies fall in the range of -0.2 to 0.2 and prob-weighted IDENTITY-based constraint energies are in the range of -0.2 to 0, both assuming a res\_type\_constraint=1)

Note that the weight parameter does not affect the value of res\_type\_constraint in the scorefunction. As the constraints will only be visible with non-zero res\_type\_constraint values, the parameter scorefxns is a convenience feature to automatically set res\_type\_constraint to 1 in the listed functions where it is currently turned off.

If a structure is used for input instead of a PSSM, the profile weights used are based off of the given substitution matrix in the database. Current options include:

-   MATCH: unscaled/unweighted scores of -1 for an amino acid match and 1 for a mismatch
-   IDENTITY: unscaled/unweighted scores of -1 for a match and +10000 for a mismatch. Most useful with prob-scaling, giving a prob-scaled/unweighted score of -1.0 for an amino acid match, and 0 for a mismatch.
-   BLOSUM62: Values vary based on aa and substitution. Unnscaled/unweighted scores are mostly in the range of -2 to +4, but range up to -11 and +4.

NOTE: The default behavior of FavorSequenceProfile has changed from previous versions. If you're using a structure as a reference, you'll want to check your weight, scaling and substitution matrix to make sure your energy values are falling in the appropriate range.

The following settings will replicate the default behavior of the [[FavorNativeResidueMover]] with the default weight of 1.5:
```xml
<FavorSequenceProfile name="favournative" weight="1.5" use_current="true" matrix="IDENTITY"/>
```
Note that in contrast to FavorNativeResidue, FavorSequenceProfile does not update the weights of your scorefxn (unless it is listed in `scorefxns`).

##See Also

* [[ConsensusDesignMover]]
* [[FavorNativeResidueMover]]
* [[ResidueTypeConstraintMover]]
* [[PSSM2BfactorMover]]
* [[FavorSymmetricSequenceMover]]
* [[I want to do x]]: Guide to choosing a mover
