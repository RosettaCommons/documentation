# RenderGridsToKinemage
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RenderGridsToKinemage

```xml
<RenderGridsToKinemage name="(&string)" file_name="(&string)" grid_name="(&string)" low_color="(&string)" high_color="(&string)" stride="(&int)"/>
```

RenderGridsToKinemage will output a Kinemage file representing 1 or more scoring grids. If you want to output multiple scoring grids, run the mover multiple times, specifying a different grid name each time. This mover is intended for debugging purposes, and should only be run with a single pose. It is also very slow. Kinemage files can be viewed with King

-   file\_name: The filename to output the kinemage file to
-   grid\_name: the name of the grid in the scoring manager to output
-   low\_color: 3 comma sepeated floats describing the color of the minimum value of the grid. The floats should be 0.0-1.0 and represent red, green blue. For example, a value of "1.0,0.0,0.0" will be red.
-   high\_color: 3 comma sepeated floats describing the color of the minimum value of the grid. colors of grid points will be in a smooth gradient between low\_color and high\_color.
-   stride: The "stride" of the grid. If stride is 1, every grid point will be output. if stride is 5, every 5th grid point will be output.


##See Also

* [[TransformMover]]: Uses scoring grids
* [[I want to do x]]: Guide to choosing a mover
