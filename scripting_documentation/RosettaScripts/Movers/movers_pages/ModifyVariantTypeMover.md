# ModifyVariantType
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ModifyVariantType

Add or remove variant types on specified residues.

```
<ModifyVariantType name=[name] add_type=[type[,type]...] remove_type=[type[,type...]] task_operations=(&string,&string,&string)/>
```

Adds (if missing) or removes (if currently added) variant types to the residues specified in the given task operations. Use [[OperateOnCertainResidues|TaskOperations-RosettaScripts#Per-Residue-Specification]] operations to select specific residues.


