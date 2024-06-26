<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Calculates the shape similarity similar to concepts introduced by Lawrence and Coleman.The two surfaces have to be specified by explicitly providing lists of the residues making up each surface or using residue selectors. Selector1 specifies residueson the target protein (usually provided with -s) and selector2 the residues on the reference protein (provided either via SavePoseMover or -in:file:native flag).NO alignment of the protein is perfomed during the comparison.

```xml
<ShapeSimilarityMetric name="(&string;)" custom_type="(&string;)"
        verbose="(false &bool;)" quick="(false &bool;)"
        write_int_area="(false &bool;)" residue_selector1="(&string;)"
        residue_selector2="(&string;)" dist_weight="(0.5 &real;)"
        median="(false &bool;)" use_native="(true &bool;)" />
```

-   **custom_type**: Allows multiple configured SimpleMetrics of a single type to be called in a single RunSimpleMetrics and SimpleMetricFeatures. 
 The custom_type name will be added to the data tag in the scorefile or features database.
-   **verbose**: If true, print extra calculation details to the tracer.
-   **quick**: If true, do a quicker, less accurate calculation by reducing the density.
-   **write_int_area**: If true, write interface area to scorefile.
-   **residue_selector1**: Set which residues are to be considered on the target side using residue_selectors.
-   **residue_selector2**: Set which residues are to be considered on the reference side using residue_selectors.
-   **dist_weight**: Set the weight for the distance of dots. The higher value, the stronger far dots are penalized.
-   **median**: Set the scoring function to use the median rather than the mean.
-   **use_native**: Use the native if present on the cmd-line.

---
