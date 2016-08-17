This ConstraintGenerator currently only works with canonical amino acids.


```
<SheetConstraintGenerator name=(&string)
    secstruct=(&string, "")
    use_dssp=(&bool, true)
    spairs=(&string, "")
    blueprint=(&string, "")
    flat_bottom_constraints=(&bool, true)
    constrain_ca_ca_dist=(&bool, true)
    constrain_bb_angle=(&bool, true)
    constrain_cacb_dihedral=(&bool, true)
    constrain_bb_dihedral=(&bool, true)
    dist=(&real, 5.5)
    dist_tolerance(&real, 1.0)
    angle_tolerance=(&real, 0.35)
    cacb_dihedral_tolerance=(&real, 0.9)
    bb_dihedral_tolerance=(&real, 0.52)
    weight=(&real, 1.0) />
```

* **secstruct**: If set, the given secondary structure will be used to find strands.  Must match the length of the pose.  If unset, the secondary structure will be obtained based on the value of 'use_dssp'.

* **use_dssp**: If secstruct is not set, and use_dssp is True, DSSP will be called on the input pose to determine its secondary structure, and in turn, the location of its strands. If false, the pose secondary structure will be used.  If use_dssp=False and don't specify a secstruct, you must ensure this pose secondary structure is properly set. One way this can be done is via DsspMover.

* **spairs**: If specified, strand pairings will be determined using the given topology.  This is a string of the format S1-S2.O.R, where S1 is the strand number in primary sequence space for the first strand, S2 is the strand number in primary sequence space for the second strand, O is 'A' for antiparallel or 'P' for parallel, and R is the register shift. S1 must be < S2. Multiple pairings can be specified using ';' as a delimeter. For example, the following describes a pairing between strands 2 and 3, and a parallel pairing between strands 1 and 2.
    2-3.A.0;1-2.P.0
If unspecified, the SheetConstraintGenerator will attempt to find strand pairings via data cached in the pose.  This data is placed into the pose by the Tom's backbone building mover.

* **blueprint**: Allows specification of a blueprint file to be used to set the secondary structure. The 'secstruct' option will be set using the information in the blueprint. The length of the blueprint must exactly match the length of the pose. If the blueprint contains a SSPAIR line, the 'spairs' option will also be set using that line.

* **flat_bottom_constraints**: If true, flat bottom constraints will be used for all constraints.  If false, harmonic constraints to an ideal value will be used for all constraints.

* **constrain_ca_ca_dist**: If true, CA-CA distance of paired strand residues will be constrained.
* **constrain_bb_angle**: If true, 

    constrain_bb_angle=(&bool, true)
    constrain_cacb_dihedral=(&bool, true)
    constrain_bb_dihedral=(&bool, true)
    dist=(&real, 5.5)
    dist_tolerance(&real, 1.0)
    angle_tolerance=(&real, 0.35)
    cacb_dihedral_tolerance=(&real, 0.9)
    bb_dihedral_tolerance=(&real, 0.52)
    weight=(&real, 1.0) />

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