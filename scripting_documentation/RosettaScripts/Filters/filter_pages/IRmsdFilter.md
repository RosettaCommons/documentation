# IRmsd
*Back to [[Filters|Filters-RosettaScripts]] page.*
## IRmsd

Calculates an interface rmsd. Rmsd is calculated over all backbone atoms for those residues found in the interface of the reference structure. Interface residues are those residues which are within 8 Angstroms of any residue on the other side of the interface.

```xml
<IRmsd name="(&string)" jump="(&int 1)" threshold="(&Real 5)" reference_pose="(&string)" scorefxn="(&string talaris2013)" />
```

- jump: Which jump defines the interface
- threshold: In truth value contexts, evaluate to true if the calculated interface rmsd is less than this value
- reference_pose: The name of the pose to calculate the rmsd with respect to. (From SavePoseMover). If not given, use the structure specified with -in:file:native instead. If no native pose or reference is given, use the input structure.
- scorefxn: The scorefunction used in calculating the interface. (As the interface is defined by distance, rather than score, the choice of scorefunction is not critical.)

## See also

* [[RmsdFilter]]
* [[SidechainRmsdFilter]]
