<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
reports attributes of secondary structure. Currently SSElement is defined as helix OR sheet

```xml
<SSElementLengthFilter name="(&string;)" scorefxn="(&string;)"
        threshold="(-999999 &real;)" report_avg="(true &bool;)"
        report_longest="(false &bool;)" report_shortest="(false &bool;)"
        residue_selector="(&string;)" confidence="(1.0 &real;)" />
```

-   **scorefxn**: Name of score function to use
-   **threshold**: cutoff length
-   **report_avg**: reports avg
-   **report_longest**: reports longest
-   **report_shortest**: reports shortest
-   **residue_selector**: parses residue selector. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
