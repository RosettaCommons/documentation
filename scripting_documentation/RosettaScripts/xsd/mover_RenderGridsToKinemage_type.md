<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Visualization tool for grids

```xml
<RenderGridsToKinemage name="(&string;)" grid_name="(&string;)"
        file_name="(&string;)" low_color="(&three_dim_real_vector;)"
        zero_color="(&three_dim_real_vector;)"
        high_color="(&three_dim_real_vector;)" color="(&three_dim_real_vector;)"
        gradient_bins="(10 &non_negative_integer;)"
        stride="(2 &non_negative_integer;)" grid_set="(default &string;)" />
```

-   **grid_name**: (REQUIRED) The name of the grid to dump to the file
-   **file_name**: (REQUIRED) The name of the file to which to dump the given grid
-   **low_color**: RGB values for color to use for low value
-   **zero_color**: RGB values for color to use for zero
-   **high_color**: RGB values for color to use for high value
-   **color**: RGB values for color to use
-   **gradient_bins**: Size of bins to use
-   **stride**: Separation between possible colors
-   **grid_set**: The Grid Set from which to take the grid.

---
