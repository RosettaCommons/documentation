<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Run the ERRASER2 protocol

```xml
<ERRASER2Protocol name="(&string;)" selector="(&string;)" scorefxn="(&string;)"
        n_rounds="(&non_negative_integer;)" />
```

-   **selector**: . The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **scorefxn**: Name of score function to use
-   **n_rounds**: Number of ERRASER2 minimize-rebuild rounds.

---
