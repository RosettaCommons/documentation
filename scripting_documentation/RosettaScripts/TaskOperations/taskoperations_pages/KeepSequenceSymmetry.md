# KeepSequenceSymmetry
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page. Page last updated 25 January 2021.*
## KeepSequenceSymmetry

This feature was created to perform the same purpose of link residues, but hopefully in a more user-friendly way. 
It must be paired with a corresponding [[SetupForSequenceSymmetryMover]] to have any affect.

When used, the packer will enforce identical sequences for all linked regions defined in a corresponding **SetupForSequenceSymmetryMover**.

### Linking Residue Logic



### Syntax
```xml
<KeepSequenceSymmetry name="(&string)" setting="true(&bool)"/>
```
* **setting**: If true, Rosetta will activate the SequenceSymmetricAnnealer. Use this when you want to design identical regions but do not want/cannot enforce physical symmetry.

Please report bugs to jack@med.unc.edu

### Developer Info

Enabling this task operation will construct the SequenceSymmetricAnnealer.
Introduced in PR 4260, updated in PR 5168. 

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