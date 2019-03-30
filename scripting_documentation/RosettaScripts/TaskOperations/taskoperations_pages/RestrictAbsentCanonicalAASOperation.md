# RestrictAbsentCanonicalAAS
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictAbsentCanonicalAAS

Restrict design to user-specified residues. If resnum is left as 0, the restriction will apply throughout the pose.

     <RestrictAbsentCanonicalAAS name="(&string)" resnum="(0 &integer)" keep_aas="(&string)" />

<br/>
*For a more flexible system for specifying positions, see the [[Index|ResidueSelectors#residueselectors_conformation-independent-residue-selectors_residueindexselector]] [[ResidueSelector|ResidueSelectors]], as well as [[OperateOnResidueSubset|OperateOnResidueSubsetOperation]] and [[RestrictAbsentCanonicalAASRLT|Residue Level TaskOperations]].*

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