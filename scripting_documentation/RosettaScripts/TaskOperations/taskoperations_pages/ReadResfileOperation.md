# ReadResfile
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ReadResfile

Read a [[resfile|resfiles]]. If a filename is given, read from that file. Otherwise, read the file specified on the commandline with -packing:resfile.

```xml
<ReadResfile name="(&string)" filename="(&string)" selector="(&string)" />
```

Optionally, a previously-defined [[ResidueSelector|ResidueSelectors]] may be specified using the ```selector=(&string)``` option.  If this is used, then the ResidueSelector is used as a mask, and the ReadResfile TaskOperation is applied _only_ to those residues selected by the ResidueSelector, even if the resfile lists other residues as well.  This can be useful when used in conjunction with conformation-dependent ResidueSelectors -- a user can, for example, select the protein core with the [[LayerSelector|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector]] ResidueSelector and then apply a resfile to define different sets of amino acids for different positions in the linear sequence, to be applied only _if_ they lie in the core.  If the ```selector=(&string)``` option is not used, the ReadResfile taskoperation is applied to all residues defined in the resfile.

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
