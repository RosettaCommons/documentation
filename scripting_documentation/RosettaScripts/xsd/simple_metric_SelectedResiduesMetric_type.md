<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
A utility metric that outputs the residue selection in Pose or PDB numbering.  Comma-Separated.

References and author information for the SelectedResiduesMetric simple metric:

SelectedResiduesMetric SimpleMetric's author(s):
Jared Adolf-Bryfogle, Scripps Research Institute [jadolfbr@gmail.com]

```xml
<SelectedResiduesMetric name="(&string;)" custom_type="(&string;)"
        rosetta_numbering="(false &bool;)" residue_selector="(&string;)" />
```

-   **custom_type**: Allows multiple configured SimpleMetrics of a single type to be called in a single RunSimpleMetrics and SimpleMetricFeatures. 
 The custom_type name will be added to the data tag in the scorefile or features database.
-   **rosetta_numbering**: Set to output in Rosetta numbering instead of PDB numbering
-   **residue_selector**: Required.  Output those residues selected. . The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.

---
