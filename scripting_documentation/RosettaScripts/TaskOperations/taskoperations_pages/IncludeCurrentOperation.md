# IncludeCurrent
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## IncludeCurrent

Includes current rotamers in the rotamer set.

**Notes:**
* The first packing call will include the rotamers from the input PDB. These input PDB rotamers will be lost after the first packing run, so they are only effective upon initial loading of a pdb.
* Successive packer calls will include the current rotamer of the pose at initialization (as the name implies).

```xml
<IncludeCurrent name="(&string)" />
```

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