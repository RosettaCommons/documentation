<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<TaskAwareMinMover name="(&string;)" chi="(&bool;)" bb="(&bool;)"
        jump="(&bool;)" max_iter="(200 &positive_integer;)"
        type="(lbfgs_armijo_nonmonotone &minimizer_type;)"
        tolerance="(0.01 &real;)" cartesian="(false &bool;)"
        bondangle="(0 &bool;)" bondlength="(0 &bool;)"
        task_operations="(&task_operation_comma_separated_list;)"
        packer_palette="(&named_packer_palette;)" scorefxn="(&string;)" />
```

-   **chi**: Allow chi degrees of freedom to minimize
-   **bb**: Allow bb degrees of freedom to minimize
-   **jump**: Allow jump degrees of freedom to minimize
-   **max_iter**: Number of iterations
-   **type**: Minimizer type, chosen from a long list of algorithms
-   **tolerance**: Minimization tolerance (absolute)
-   **cartesian**: Use cartesian minimization (not internal coordinate)
-   **bondangle**: Minimize bond angle degrees of freedom
-   **bondlength**: Minimize bond length degrees of freedom
-   **task_operations**: A comma-separated list of TaskOperations to use.
-   **packer_palette**: A previously-defined PackerPalette to use, which specifies the set of residue types with which to design (to be pruned with TaskOperations).
-   **scorefxn**: Name of score function to use

---
