
This ConstraintGenerator currently only works with canonical amino acids.


```
<HydrogenBondConstraintGenerator name=(&string)
    residue_selector1=(&string TrueSelector)
    residue_selector2=(&string TrueSelector)
    atoms1=(&string "")
    atoms2=(&string "")
    atom_pair_func=(&string "HARMONIC 2.8 0.5")
    angle1_func=(&string "CIRCULARHARMONIC 2.0 0.5")
    angle2_func=(&string "CIRCULARHARMONIC 2.0 0.5") />
```

* **residue_selector1** - If given, the residues r1 (see above) will come from the subset of residues selected by residue_selector1. This should probably always be given to avoid huge numbers of constraints being generated.
* **residue_selector2** - If given, the residues r2 (see above) will come from the subset of residues selected by residue_selector2. This should probably always be given to avoid huge numbers of constraints being generated.
* **atoms1** - Comma-seperated list of atom names to consider constraining for each residue r1 selected by residue_selector1. Atom names that are not present in the pose will not be constrained -- therefore, if one specifies "OD1,OE1" as atoms1, it could be used for both Asp and Glu residues -- OD1 would be constrained in Asp residues, and OE1 would be constrained in Glu residues.
* **atoms2** - Comma-seperated list of atom names to consider constraining for each residue r2 selected by residue_selector2. Atom names not present in the pose will not be constrained (see "atoms1" above).
* **atom_pair_func** -- Function to be used for atom pair constraints. By default, "HARMONIC x 0.5" is used, where x is the ideal A1-A2 distance.
* **angle1_func** - Function used for angle constraints. By default, "CIRCULARHARMONIC x 0.5" is used, where x is the ideal P_A1-A1-A2 angle.
* **angle2_func** - Function used for angle2 constraints. By default, "CIRCULARHARMONIC x 0.5" is used, where x is the ideal A1-A2-P_A2 angle.


### Example

This example creates constraints to enforce a hydrogen bond between atom NE2 on residue 6 and atom OE1 on residue 50. The atom pair constraint between these atoms uses a custom function -- a flat-bottom function with width 0.4 and sd 0.5.

```
<RESIDUE_SELECTORS>
    <Index name="his6" resnums="6" />
    <Index name="glu50" resnums="50" />
</RESIDUE_SELECTORS>
<MOVERS>
    <AddConstraints name="add_csts" >
        <HydrogenBondConstraintGenerator name="gen_my_csts"
            residue_selector1="his6"
            residue_selector2="glu50"
            atoms1="NE2"
            atoms2="OE1" 
            atom_pair_func="FLAT_HARMONIC 2.8 0.5 0.4" />
    </AddConstraints>
    <RemoveConstraints name="rm_csts" constraint_generators="gen_my_csts" />
</MOVERS>
<PROTOCOLS>
    <Add mover="add_csts" />
    <!-- do things with constraints -->
    <Add mover="rm_csts" />
</PROTOCOLS>
```