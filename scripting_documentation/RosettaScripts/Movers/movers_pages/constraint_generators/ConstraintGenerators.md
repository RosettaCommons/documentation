# Constraint Generators
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Constraint Generators

Constraint Generators are a method for automatically making and removing constraints, based on the current structure of the pose.

The [[AddConstraintsMover]] can take a Constraint Generator and add constraints to the pose, and the [[RemoveConstraintsMover]] will remove constraints added by the AddConstraintsMover.

See the [[RosettaScripts Mover page|Movers-RosettaScripts#general-movers_constraints_constraint-generators]] for a current listing of valid Constraint Generators.

### Example

This example adds and removes distance constraints to sheet residues only, and uses the pose specified by `-in:file:native` to obtain the coordinates.

```xml
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

* [[AddConstraintsMover]]
* [[RemoveConstraintsMover]]
* [[ConstraintScoreFilter]]
* [[Constraints file format|constraint-file]]
* [[ConstraintSetMover]]
* [[ClearConstraintsMover]]
