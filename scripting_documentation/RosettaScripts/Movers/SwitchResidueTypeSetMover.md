# SwitchResidueTypeSetMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SwitchResidueTypeSetMover

Switches the residue sets (e.g., allatom-\>centroid, or vice versa).

```
<SwitchResidueTypeSetMover name="&string" set=(&string)/>
```

-   set: which set to use (options: centroid, fa\_standard...)

Typically, RosettaScripts assumes that poses are all-atom. In some cases, a centroid pose is needed, e.g., for centroid scoring, and this mover is used in those cases.


