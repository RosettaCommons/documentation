# SeqprofConsensus
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SeqprofConsensus

Read PSSM sequence profiles and at each position allow only identities that pass a certain threshold in the PSSM. The code mentions symmetry-support, but I haven't tested this.

    <SeqprofConsensus name="(&string)" filename="(''&string)" min_aa_probability="(0.0 &Real)" probability_larger_than_current="(1 &bool)" ignore_pose_profile_length_mismatch="(0 &bool)" convert_scores_to_probabilities="(1&bool)"  keep_native="(0&bool)"/>

SeqprofConsensus can also be operated with ProteinInterfaceDesign and RestrictToAlignedSegments task operations contained within it. In that case, three different threshold can be set, one for the protein interface (where residues are marked for design), one for RestrictToAlignedSegments (again, where residues are marked for design), and one for the remainder of the protein. The reasoning is that you may want to be less 'consensus-like' at the active site than away from it. The three cutoffs would then be set by: conservation\_cutoff\_protein\_interface\_design, conservation\_cutoff\_aligned\_segments, and min\_aa\_probability (for the remainder of the protein). The subtags, ProteinInterfaceDesign and RestrictToAlignedSegments are expected to be subtags of SeqprofConsensus and all of the options open to these task operations can be set the same way (the option name is not expected and if you specify it you would generate failure).

-   filename: of the PSSM. If none is specified, the task operation will attempt to read SequenceProfile constraints directly from the pose, and set up a profile based on those constraints. If those aren't available, expect an exit.
-   min\_aa\_probability: the PSSM style log2 transformed probabilities. For instance set to 0 to allow favorable positions, set to 2 to allow very favorable only, and set to -2 to also allow slightly unfavorable identities. The highest-probability identities are always allowed to design, so set to very high values (\>10) if you want the highest probability identities to be allowed in design.
-   probability\_larger\_than\_current: always allow identities with probabilities at least larger than that of the current residue seen in the PDB.
-   ignore\_pose\_profile\_length\_mismatch: if set to 0 this will cause a utility exit if the pose and profile do not match.
-   convert\_scores\_to\_probabilities: convert the PSSM scores (e.g., -4, +10) to probabilities in the 0-1 range.
-   keep\_native: If set to true adds the native aa identity to allowed identities regardless of min\_aa\_probability cut-off.

[[include:to_SeqprofConsensus_type]]

##See Also

* [[FavorSequenceProfileMover]]: A mover that favors the 
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta