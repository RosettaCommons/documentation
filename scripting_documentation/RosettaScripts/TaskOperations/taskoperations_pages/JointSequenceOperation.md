# JointSequence
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## JointSequence

    <JointSequence use_current=(true &bool)  use_native=(false &bool) filename=(&string) native=(&string) use_natro=(false &bool) 
    use_fasta=(false &bool) chain=( &integer) use_chain=(&integer) />

Prohibit designing to residue identities that aren't found at that position in any of the listed structures:

-   use\_current - Use residue identities from the current structure (input pose to apply() of the taskoperation)
-   use\_native - Use residue identities from the structure listed with -in:file:native
-   filename - Use residue identities from the listed file
-   native - Use residue identities from the listed file
-   use\_fasta - Use residue identities from a native sequence given by a FASTA file (specify the path to the FASTA file with the -in:file:fasta flag at the command line)
-   chain - to which chain to apply, 0 is all chains
-   use\_chain - given an additional input pdb, such as through in:file:native, which chain should the sequence be derived from. 0 is all chains.

If use\_natro is true, the task operation also adds the rotamers from the native structures (use\_native/native) in the rotamer library.

