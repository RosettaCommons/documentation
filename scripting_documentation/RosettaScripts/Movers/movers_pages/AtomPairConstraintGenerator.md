# AtomPairConstraintGenerator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AtomPairConstraintGenerator

Generates atom pair distance constraints to restrain pairs of atoms in the pose based on their distance. Constraints can be generated according to the state of the pose at apply time, or optionally, based on a separate native pose.

By default, the distance between the CA atoms and the first sidechain atom in each residue pair are constrained via a harmonic function, where score = w * ( x - x0 ) / sd, where w is the "weight" option, "x0" is the distance in the native/reference pose, "x" is the current distance, and "sd" is the "sd" option.

Remember that to have effect, the atom_pair_constraint scoreterm must be on in the scorefunction.


```
<AtomPairConstraintGenerator name=(&string)
    residue_selector=(&string TrueSelector)
    sd=(&Real 0.5)
    weight=(&Real 1.0)
    max_distance=(&Real 12.0)
    min_seq_sep=(&int 8)
    ca_only=(&bool true)
    native=(&bool false) />
```

* **residue_selector** - if given, only apply constraints to the selected residues. If not given, constraints will be applied to all residues in the pose.
* **sd** - the strength/deviation of the harmonic constraints to use (see above)
* **weight** - the weight of coordinate constraints (see above)
* **ca_only** - if true, only CA atoms will be constrained. If false, CA and the first sidechain atom will be constrained.
* **native** - if true, use the pose from  -in:file:native as the reference instead of the pose at apply time. A heuristic based on the size and PDB designations is used to match up residues in the two poses. Poses of differing sequences can be used, even for sidechain constraints. Only matching atoms will be constrained.
* **max_distance** - Residues with CB atoms further apart than this value will not be constrained.
* **min_seq_sep** - Residues closer in primary sequence space than this value will not be constrained.

### Example

This example adds and removes distance constraints to sheet residues only, and uses the pose specified by -in:file:native to obtain the coordinates.

```
<RESIDUE_SELECTORS>
    <SecondaryStructureSelector name="sheet" ss="E" use_dssp="1" />
</RESIDUE_SELECTORS>
<MOVERS>
    <AddConstraints name="add_csts" >
        <AtomPairConstraintGenerator name="gen_my_csts"
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

* [[AddConstraints]]
* [[RemoveConstraints]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]

