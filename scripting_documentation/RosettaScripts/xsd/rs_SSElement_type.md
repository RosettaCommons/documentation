<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
a selector for choosing parts of secondary structure

```xml
<SSElement name="(&string;)" selection="(&string;)" to_selection="(&string;)"
        chain="(&string;)"
        reassign_short_terminal_loop="(2 &non_negative_integer;)" />
```

-   **selection**: H=helix,L=Loop,S=Sheet,N=n_terminal,C=terminal can define only start
-   **to_selection**: H=helix,L=Loop,S=Sheet,N=n_terminal,C=terminal
-   **chain**: chain letter
-   **reassign_short_terminal_loop**: if terminal less than X residues loop is reassigned to neighboring SS element (default=2; 0=no reassignment).

---
