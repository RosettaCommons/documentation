<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
selects hbond acceptors or donors that are not satisfied

```xml
<Unsat name="(&string;)" check_acceptors="(&bool;)" legacy="(&bool;)"
        hbond_energy_cutoff="(&real;)" consider_mainchain_only="(&bool;)"
        scorefxn="(&string;)" />
```

-   **check_acceptors**: whether you want to count acceptors or donors
-   **legacy**: do you want the hbnet style hbond detection or legacy style
-   **hbond_energy_cutoff**: what is the hbond energy cutoff
-   **consider_mainchain_only**: should we consider just mainchains?
-   **scorefxn**: Name of score function to use

---
