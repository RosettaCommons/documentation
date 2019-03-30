# ConservativeDesign
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ConservativeDesign

TaskOperation to allow only conservative mutations at designable residues.

###Published Description

The conservative mutations for each residue type are composed
of the substitutions for each residue which score >= 0 in one
of the BLOSUM matrices (which are used for the seminal
protein sequence similarity programs, PsiBlast and Clustal).
All BLOSUM matrices can be used for conservative design.
The numbers of the word BLOSUM indicate the sequence similarity
cutoffs used to derive the BLOSUM matrices, with higher numbers
being a more conservative set of mutations.
By default, the conservative mutations from the BLOSUM62 matrix
are used to strike a balance between variability and conservation.

Paper: [RosettaAntibodyDesign (RAbD): A general framework for computational antibody design](https://doi.org/10.1371/journal.pcbi.1006112)

###XML

```xml
<ConservativeDesignOperation name="(string)" residue_selector="(string)" data_source=(string,"blosum62") include_native_aa=(bool,"true")/>
```

**residue_selector** - By default, ConservativeDesign works on all residues. It will be confined to a selection of residues if a selector is provided

**data_source** - Set the source of the data used to define what is conservative. Options are: chothia_76 and the Blosum matrices from 30 to 100; designated as blosum30, 62, etc. Default is blosum62.  The higher the number, the more conservative the set of mutations (numbers are sequence identity cutoffs).

**include_native_aa** - Include native amino acid in the allowed_aas list

##See Also

* [[Loop modeling|loopmodel]]: An application for modeling loops
* [[LoopModelerMover]]: A loop modeling mover
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
