# HSSTriplet
*Back to [[Filters|Filters-RosettaScripts]] page.*
## HSSTriplet

Evaluate the given helix-strand-strand triplets. Calculates distance between strand pair and helix, and the angle between the plane of the sheet and the helix. Returns true if the distance is between min_dist and max_dist, and if the angle is between min_angle and max_angle. Also can report a value based on output_id and output_type.
```xml
<HSSTriplet name="(&string)" hsstriplets="('' &string)" blueprint="('' &string)" min_dist="(7.5 &Real)" max_dist="(13.0 &Real)" min_angle="(-12.5 &Real)" max_angle="(90.0 &Real)" output_id="(1 &bool)" output_type="('dist' &string)" />
```

-   hsstriplets: a string describing the HSS Triplets. Either hsstriplets or blueprint must be specified, and both cannot be used at the same time. The format of the string is: i,j-k  
     Where i is an integer denoting the number of the helix, and j an integer denoting the strand number of strand1 (from N to C), and k is an integer denoting the strand number of strand2.
-   blueprint: a blueprint file which contains an HSS triplets information in the above format. Cannot be used at the same time as the "hsstriplets" option
-   min_dist: minimum distance for acceptance from the helix to the plane of the sheet
-   max_dist: maximum distance for acceptance from the helix to the plane of the sheet
-   min_angle: minimum angle between the strands and helix
-   max_angle: maximum angle between the strands and helix
-   output_id: Specifies which HSS triplet in the list of input HSS triplets will be reported
-   output_type: Valid values are "dist" and "angle" -- dist returns the distance of the HSS triplet specified by output_id, and angle returns the angle

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[HelixKinkFilter]]
* [[HelixPairingFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureCountFilter]]
* [[SecondaryStructureHasResidueFilter]]

