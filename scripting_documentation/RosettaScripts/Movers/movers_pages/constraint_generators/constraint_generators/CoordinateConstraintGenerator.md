# CoordinateConstraintGenerator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## CoordinateConstraintGenerator

Generates coordinate constraints to restrain atoms of the pose to specific coordinates. Coordinate constraints can be generated according to the state of the pose at apply time, or optionally, based on a separate native pose.


Remember that to have effect, the coordinate_constraint scoreterm must be on in the scorefunction. It is highly recommended that you apply a virtual root to your pose prior to applying these constraints, especially if you're constraining against a native. (See the [[VirtualRootMover]] mover.)


```xml
<CoordinateConstraintGenerator name="(&string)"
    residue_selector="(&string TrueSelector)"
    sd="(&Real 0.5)"
    bounded="(&bool false)"
    bounded_width="(&Real 0.0)"
    sidechain="(&bool false)"
    ca_only="(&bool false)"
    ambiguous_hnq="(&bool false)"
    native="(&bool false)"
    align_reference="(&bool false)" />
```

* **residue_selector** - if given, only apply constraints to the selected residues. If not given, constraints will be applied to all residues in the pose.
* **sd** - the strength/deviation of the constraints to use (e.g. -relax:coord_cst_stdev)
* **bounded** - whether to use harmonic (false) or bounded (true) constraints
* **bounded_width** - the width of the bounded constraint (e.g. -relax::coord_cst_width)
* **sidechain** - whether to constrain backbone heavy atoms (false) or all heavy atoms (true) (e.g. -relax:coord_constrain_sidechains)
* **ca_only** - if true, only CA atoms will be constrained. If false, all atoms (if sidechain=true) or all backbone heavy atoms (if sidechain=false) will be constrained.
* **ambiguous_hnq** - If true, ambiguous constraints will be generated for His, Asn, and Gln sidechains which will constrain each sidechain atom to either possible atom (e.g. for Asn, OD1 would be constrained to the coordinates of OD1 or ND2, whichever is currently closer as the pose is moved).
* **native** - if true, use the pose from  -in:file:native as the reference instead of the pose at apply time. A heuristic based on the size and PDB designations is used to match up residues in the two poses. Poses of differing sequences can be used, even for sidechain constraints. Only matching atoms will be constrained.
* **align_reference** - If true, the reference/native pose will be always be superimposed onto the current pose before being used to generate constraints. If false, the reference/native pose is only superimposed onto the current pose if a virtual root is not present (see above).

### Example

This example adds and removes coordinate constraints to sheet residues only, and uses the pose specified by -in:file:native to obtain the coordinates.

```xml
<RESIDUE_SELECTORS>
    <SecondaryStructureSelector name="sheet" ss="E" use_dssp="1" />
</RESIDUE_SELECTORS>
<MOVERS>
    <AddConstraints name="add_csts" >
        <CoordinateConstraintGenerator name="gen_my_csts"
            residue_selector="sheet" native="1" />
    </AddConstraints>
    <RemoveConstraints name="rm_csts" constraint_generators="gen_my_csts" />
</MOVERS>
<PROTOCOLS>
    <Add mover="add_csts" />
    <!-- do things with constraints -->
    <Add mover="rm_csts" />
</PROTOCOLS>
```


##See Also

* [[AddConstraintsMover]]
* [[RemoveConstraintsMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]

