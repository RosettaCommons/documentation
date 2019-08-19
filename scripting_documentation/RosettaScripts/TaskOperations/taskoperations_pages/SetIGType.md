# SetIGType
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SetIGType

Task operation to set interaction graph type linmem, lazy, or double lazy

```xml
<SetIGType name=(string) lin_mem_ig=(bool,"false") lazy_ig=(bool,"false") double_lazy_ig=(bool,"false")/>
```

name (string):  The name given to this instance.
lin_mem_ig (bool,"false"):  Interaction graph type lin_mem_ig.
lazy_ig (bool,"false"):  Interaction graph type lazy_ig.
double_lazy_ig (bool,"false"):  Interaction graph type double_lazy_ig.

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