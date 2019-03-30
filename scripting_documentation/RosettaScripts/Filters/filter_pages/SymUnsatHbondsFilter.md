# SymUnsatHbonds
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SymUnsatHbonds

Maximum number of buried unsatisfied H-bonds allowed across an interface. Works with both symmetric and asymmetric poses, as well as with poses with symmetric “building blocks”. Takes the current pose, uses the jump number or sym\_dof\_names and core::pose::symmetry::get\_sym\_aware\_jump\_num(pose,jump) to get the correct vector for translation into the unbound state, uses the RigidBodyTransMover to translate the pose into its unbound state, goes through every heavy atom in the asymmetric unit and finds cases where a polar is considered buried in the bound state, but not in the unbound state. If passes, will output the number of unsatisfied hydrogen bonds to the scorefile and tracer. Also outputs to the tracer the specific residues and atoms that are unsatisfied and a formatted string for easy selection in pymol.

```xml
<SymUnsatHbonds name="(&string)" jump="(1 &size)" sym_dof_names="('' &string)" cutoff="(20 &size)"/>
```

-   jump: What jump to look at.
-   sym\_dof\_names: What jump(s) to look at. For multicomponent systems, one can simply pass the names of the sym\_dofs that control the master jumps. For one component systems, jump can still be used.
-   cutoff: Maximum number of buried unsatisfied H-bonds allowed.

## See also

* [[ClashCheckFilter]]
* [[GetRBDOFValuesFilter]]
* [[InterfacePackingFilter]]
* [[MutationsFilter]]
* [[OligomericAverageDegreeFilter]]
