## StoreCompoundTaskMover
*Back to [[Mover|Movers-RosettaScripts]] page.*

This mover uses previously defined task operations applied to the current pose to construct a new compound logical task with NOT, AND, OR, XOR, NAND, NOR, ANDNOT, and ORNOT operations. It then creates a packer task by applying the task operations to the current pose and saves the packer task in the pose's cacheable data, allowing the task to be accessed, unchanged, at a later point in the RosettaScripts protocol. Must be used in conjunction with the RetrieveStoredTask task operation. By making compound tasks of compound tasks, esssentially all logical tasks can be defined. Note: this mover has not yet been thoroughly tested. The source code is currently located in: src/protocols/toolbox/task_operations

```xml
<StoreCompoundTaskMover name="(&string)" task_name="(&std::string)" mode="('packable' &std::string)" true_behavior="(&string)" false_behavior="('prevent_repacking' &string)" invert="(false &bool)" verbose="(false &bool)" overwrite="(false &bool)">
<OPERATION task_operations="(comma-delimited list of operations &string)"/> 
<.... 
</StoreCompoundTaskMover> 
```

Example:

```xml
<StoreCompoundTaskMover name="store_packable_any" task_name="packable_any" mode="packable" true_behavior="" false_behavior="prevent_repacking" invert="0" verbose="1" overwrite="0">
    <OR task_operations="resfile1" />
    <OR task_operations="resfile2" />
    <OR task_operations="design_bbi" />
</StoreCompoundTaskMover>
```

-   task\_name: The index where the task will be stored in the pose's cacheable data. Must be identical to the task\_name used to retrieve the task using the RetrieveStoredTask task operation.
-   mode: What property of the residues should be assessed? Options: packable or designable
-   true\_behavior: What behavior should be assigned to residues for which the compound task is true? Options: prevent\_repacking or restrict\_to\_repacking. If not set to one of these options, then by default these residues will remain designable.
-   false\_behavior: What behavior should be assigned to residues for which the compound task is false? Default: prevent\_repacking Options: prevent\_repacking or restrict\_to\_repacking. If false\_behavior="", then these residues will remain designable.
-   invert: setting to true will cause the final outcome to be inverted. If, for instance multiple AND statements are evaluated and each evaluates to true for a given residue, then the false\_behavior will be assigned to that residue.
-   verbose: setting to true will produce a pymol selection string for the positions assigned the true behavior
-   overwrite: above which threshold (e.g. delta score/delta ddg) a negative state will be counted in the Boltzmann fitness calculation. This prevents the dilution of negative states.
-   OPERATION: any of the operations the following logical operations: NOT, AND, OR, XOR, NAND, NOR, ANDNOT, and ORNOT. Note that the operations are performed in the order that they are defined. No precedence rules are enforced, so that any precedence has to be explicitly written by making compound statements of compound statements. Note that the first OPERATION specified in the compound statement treated as a negation if NOT, ANDNOT, or ORNOT is specified.
-   task\_operations: A comma-delimited list of task operations

##See Also

* [[StoreTaskMover]]
* [[Task operations in RosettaScripts|TaskOperations-RosettaScripts]]
* [[TaskAwareCstsMover]]
* [[TaskAwareMinMOver]]
* [[TaskAwareSymMinMover]]
