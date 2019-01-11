# Idealize
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Idealize

Some protocols (LoopHashing) require the pose to have ideal bond lengths and angles. Idealize forces these values and then [[minimizes|Minimization-overview]] the pose in a stripped-down energy function (rama, disulf, and proline closure) and in the presence of coordinate constraints. Typically causes movements of 0.1A from original pose, but the scores deteriorate. It is therefore recommended to follow idealization with some refinement.

```xml
<Idealize name="(&string)" atom_pair_constraint_weight="(0.0&Real)" coordinate_constraint_weight="(0.01&Real)" fast="(0 &bool)" report_CA_rmsd="(1 &bool)" ignore_residues_in_csts="(&comma delimited residue list)" impose_constraints="(1&bool)" constraints_only="(0&bool)"/>
```

-   ignore\_residues\_in\_csts: set certain residues to not have coordinate constraints applied to them during idealization, meaning that they're free to move in order to form completely ideal bonds. Useful when, e.g., changing loop length and quickly making a chemically sensible chain.
-   impose\_constraints: impose the coordinate and pair constraints on the current pose?
-   constraints\_only: jump out of idealize after imposing the constraints without doing the actual idealization run?

impose\_constraints & constraints\_only can be used intermittently to break the idealize process into two stages: first impose the constraints on a 'realistic' pose without idealizing (constraints\_only=1), then mangle the pose and apply idealize again (impose\_constraints=0).


##See Also

* [[MinMover]]
* [[FastRelaxMover]]
* [[Minimization overview]]
* [[AtomCoordinateCstMover]]
* [[Constraints file format|constraint-file]]
