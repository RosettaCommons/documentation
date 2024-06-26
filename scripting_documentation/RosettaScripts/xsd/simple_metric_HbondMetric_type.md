<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
A metric to report the total h-bonds residues from a selection to all [OTHER] residues, or from a set of residues to another set of residues.  If No selection is given, will report ALL vs ALL.

 TIPS:
  Use the SummaryMetric to get total hbonds of a selection or total number of residues having some number of hbonds. . See the WaterMediatedBridgedHBondMetric for water-mediated h-bonds.

  It is recommended to use -beta (-beta_nov16 and -genpot) as your scorefunction for better detection of hbonds.

  By default does not report self-self hbonds (but this is an option).

 AUTHORS:
  Jared Adolf-Bryfogle (jadolfbr@gmail.com)
   Citation: De-Novo Glycan Modeling in Rosetta (drafting)

```xml
<HbondMetric name="(&string;)" custom_type="(&string;)"
        output_as_pdb_nums="(false &bool;)" residue_selector="(&string;)"
        residue_selector2="(&string;)" include_self="(false &bool;)" />
```

-   **custom_type**: Allows multiple configured SimpleMetrics of a single type to be called in a single RunSimpleMetrics and SimpleMetricFeatures. 
 The custom_type name will be added to the data tag in the scorefile or features database.
-   **output_as_pdb_nums**: If outputting to scorefile use PDB numbering+chain instead of Rosetta (1 - N numbering)
-   **residue_selector**: If a residue selector is present, we only calculate and output metrics for the subset of residues selected. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **residue_selector2**: Optional Selector to measure hbonds between residues in each selection, instead of ANY between selector1 and the pose.  If NO selector is given, will calculate hbonds to all [OTHER] residues. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **include_self**: Set to include self-self hydrogen bonds: Ex: resJ - resJ

---
