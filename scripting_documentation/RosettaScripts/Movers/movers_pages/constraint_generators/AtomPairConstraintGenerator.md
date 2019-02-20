# AtomPairConstraintGenerator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AtomPairConstraintGenerator

[[include:constraint_generator_AtomPairConstraintGenerator_complex_type]]

Generates atom pair distance constraints to restrain pairs of atoms in the pose based on their distance. Constraints can be generated according to the state of the pose at apply time, or optionally, based on a separate native pose.

By default, the distance between the CA atoms and the first sidechain atom in each residue pair are constrained via a harmonic function, where score = w * ( x - x0 ) / sd, where w is the "weight" option, "x0" is the distance in the native/reference pose, "x" is the current distance, and "sd" is the "sd" option. Optionally, this can be changed by the harmonic function.

If ca_only=False, the neighbor atoms are constrained instead.

Remember that to have effect, the atom_pair_constraint scoreterm must be on in the scorefunction.


### Example 1

This example adds and removes distance constraints to sheet residues only, and uses the pose specified by -in:file:native to obtain the coordinates.

```xml
<RESIDUE_SELECTORS>
    <SecondaryStructure name="sheet" ss="E" use_dssp="1" />
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

### Example 2

```xml
<RESIDUE_SELECTORS>
    <SecondaryStructure name="sheet" ss="E" use_dssp="1" />
    <SecondaryStructure name="alpha" ss="H" use_dssp="1" />
</RESIDUE_SELECTORS>
<MOVERS>
    <AddConstraints name="add_csts" >
        <AtomPairConstraintGenerator name="gen_my_csts"
            residue_selector="sheet" secondary_selector="alpha" native="1" />
    </AddConstraints>
    <RemoveConstraints name="rm_csts" constraint_generators="gen_my_csts" />
</MOVERS>
<PROTOCOLS>
    <Add mover="add_csts" />
    <!-- do things with constraints -->
    <Add mover="rm_csts" />
</PROTOCOLS>
```

In this case, constraints will be generated between the alpha helix and the beta strand residues, but no constraint will be generated between different alpha residues or between two beta strand residues.

##See Also

* [[AddConstraintsMover]]
* [[RemoveConstraintsMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]

