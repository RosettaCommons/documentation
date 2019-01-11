# SwitchResidueTypeSetMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SwitchResidueTypeSetMover

Switches the residue sets (e.g., allatom-\>centroid, or vice versa).

```xml
<SwitchResidueTypeSetMover name="&string" set="(&string)"/>
```

-   set: which set to use (options: centroid, centroid_rot, fa\_standard...)

Typically, RosettaScripts assumes that poses are all-atom. In some cases, a centroid pose is needed, e.g., for centroid scoring, and this mover is used in those cases.


##See Also

* [[PrepareForFullatomMover]]
* [[PrepareForCentroidMover]]
* [[Centroid vs fullatom]]
* [[I want to do x]]: Guide to choosing a mover
