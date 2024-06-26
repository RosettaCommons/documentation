<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Filters poses based upon their geometry (omega angle, for example(

```xml
<Geometry name="(&string;)" omega="(165.0 &real;)" cart_bonded="(20.0 &real;)"
        cstfile="(filename &string;)" cst_cutoff="(10000.0 &real;)"
        start="(1 &non_negative_integer;)" end="(100000 &non_negative_integer;)"
        count_bad_residues="(false &bool;)" residue_selector="(&string;)"
        confidence="(1.0 &real;)" />
```

-   **omega**: cutoff for omega angle of peptide plane, Cis-proline is also considered. Works for multiple chains
-   **cart_bonded**: bond angle and length penalty score
-   **cstfile**: if specified, the given constraint file will be used to introduce constraints into the pose. Only atom pair constraints will be used. The constraint scores will be checked to see if they are lower than cst_cutoff. If the constraint score is greater than cst_cutoff, the pose will fail.
-   **cst_cutoff**: cutoff for use with cstfile option
-   **start**: starting residue number to scan
-   **end**: ending residue number
-   **count_bad_residues**: If true, the number of residues failing the filter will be computed and returned as the filter score by report_sm(). If false, the filter score will be either 1.0 (i.e. all residues pass) or 0.0 (i.e. a residue failed the filter). Default: false
-   **residue_selector**: If specified, only residues selected by the user-specified residue selector will be scanned. By default, all residues are selected. If start and/or end are also set, only residues selected by the residue_selector AND within the range [start, end] will be scanned. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
