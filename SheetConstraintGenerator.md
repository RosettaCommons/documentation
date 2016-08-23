This ConstraintGenerator currently only works residue types containing C, O, N, CA, and CB atoms.


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

* **constrain_bb_angle**: If true, two angle constraints will be generated for each paired residues.  For parallel pairings, these constraints will enforce a 90 degree angle between N-C-C2 and N2-C2-C, where C2 and N2 are the C and N atoms of the second paired residue. In antiparallel pairing, the angles are N-C-N2 and N2-C2-N. This constraint can be used to enforce register shift.

* **constrain_cacb_dihedral**: If true, the CB-CA-CA2-CB2 dihedral will be constrained to an ideal value of 0, where CA and CB are from the first residue in the pair, and CA2 and CB2 refer to CA and CB of the second residue in the pair. This constraint ensures that the CB atoms of paired residues are pointed in roughly the same direction

* **constrain_bb_dihedral**: If true, the O-N-C-C2 dihedral is constrained to an ideal value of 0, where O, N, and C are atom names from the first residue of the pair and C2 is the C atom of the second paired residue. This constraint ensures the carbonyl oxygen is in plane with the paired strand.

* **dist**: Distance to use for CA-CA distance constraints

* **dist_tolerance**: The standard deviation that determines the constraint penalty.  For harmonic constraints, the penalty is (x-x0)/(sd^2), where SD is this value.

* **angle_tolerance**: The standard deviation of the angle constraints
* **cacb_dihedral_tolerance**: The standard deviation of the cacb constraints
* **bb_dihedral_tolerance**: The standard deviation of the O-N-C-C2 dihedral constraints
* **weight**: Scalar weighting factor. This number is multiplied to the constraint penalty

### Example

This example creates constraints to enforce a sheet with two antiparallel strands and a register shift of 1.

```
<MOVERS>
    <AddConstraints name="add_csts" >
        <SheetConstraintGenerator name="gen_my_csts" spairs="1-2.A.1;2-3.A.0" />
    </AddConstraints>
    <RemoveConstraints name="rm_csts" constraint_generators="gen_my_csts" />
</MOVERS>
<PROTOCOLS>
    <Add mover="add_csts" />
    <!-- do things with constraints -->
    <Add mover="rm_csts" />
</PROTOCOLS>
```