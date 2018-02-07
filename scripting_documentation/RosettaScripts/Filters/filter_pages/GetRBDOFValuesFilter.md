# GetRBDOFValues
*Back to [[Filters|Filters-RosettaScripts]] page.*
## GetRBDOFValues

Calculates either the current translation or rotation across a user specified jump (referenced by jump\_id or sym\_dof\_name).

```xml
<GetRBDOFValues name="(&string)"  jump="(1 &int)" sym_dof_name="('' &string)" verbose="(0 &bool)" axis="('x' &char)" get_disp="(0 &bool)" get_angle="(0 &bool)" init_disp="(0 &Real)" init_angle="(0 &Real)" get_init_value(0 &bool)/>
```

-   jump: Jump number of movable jump for which to calculate the translation or rotation
-   sym\_dof\_name: Sym\_dof\_name for movable jump for which to calculate the translation or rotation
-   verbose: Output jump and corresponding displacement or angle to tracer
-   axis: Axis in local coordinate frame about which to calculate the translation or rotation (not currently set up to handle off axis values)
-   get\_disp: If set to true (and get\_disp is false), then will calculate the displacement across the specified jump
-   get\_angle: If set to true (and get\_angle is false), then will calculate the angle of rotation about the specified jump
-   init\_disp: Initial displacement value to add to each calculated value
-   init\_angle: Initial angle value to add to each calculated value
-   get\_init\_value: Get the initial displacement or angle for the specified jump from the SymDofMoverSampler

## See also

* [[ClashCheckFilter]]
* [[InterfacePackingFilter]]
* [[MutationsFilter]]
* [[OligomericAverageDegreeFilter]]
* [[SymUnsatHbondsFilter]]
