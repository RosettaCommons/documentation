# KeepSequenceSymmetry
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## KeepSequenceSymmetry

This feature was created to perform the same purpose of link residues,
but hopefully in a more user-friendly way.

When used, the packer will enforce that all chains end up with the same sequence.
It uses pdb info to link residues together,
so all residues with the same pdb number will be the same amino acid in the end.

A residue will not be allowed to mutate unless it has a partner on every chain in the pose.

Like traditional symmetry, this assumes that all chains are part of the same symmetric system.
It is impossible to have, say, chains A+B+C where A+B are symmetric and C is separate.

```xml
<KeepSequenceSymmetry name="(&string)" setting="true(&bool)"/>
```

*setting:* If true, Rosetta will activate the SequenceSymmetricAnnealer. Use this when you give Rosetta a multimer to design and you want the sequences of the chains to be the same but you don't need strict physical symmetry.

Please report bugs to jack@med.unc.edu

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta