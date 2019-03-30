# AddConstraintsToCurrentConformationMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddConstraintsToCurrentConformationMover

Add constraints to the pose based on the current conformation. It can either apply coordinate constraints to protein Calpha and DNA heavy atoms (the default) or atom pair distance constraints between protein Calpha pairs. The functional form for the coordinate constraints can either be harmonic or bounded (flat-bottom), whereas atom pair distance constraints are currently only gaussian in form.

    <AddConstraintsToCurrentConformationMover name="(&string)" 
    use_distance_cst="(&bool 0)" coord_dev="($Real 1.0)" bound_width="(&Real 0)" 
    min_seq_sep="(&Real 8)" max_distance="(&Real 12.0)" cst_weight="(&Real 1.0)" 
    task_operations="(&comma-delimited list of taskoperations)" CA_only="(&bool 1)" bb_only="(&bool 0)"
     />

-   use\_distance\_cst - if true, use atom-atom pair distance constraints, otherwise use coordinate constraints.
-   coord\_dev - Controls how quickly constraints increase with increasing deviation for all three constraint types. A value in Angstroms, with smaller numbers being tighter constraints.
-   bound\_width - for coordinate constraints, if non-zero (actually, greater than 1e-3) use bounded constraints with the given flat-bottom width. If zero, use harmonic constraints.
-   min\_seq\_sep - for atom pair distance constraints, the minimum sequence separation between pairs of constrained residues.  This does NOT pay attention to chainbreaks.
-   max\_distance - for atom pair distance constraints, the maximum Cartesian distance between pairs of constrained Calpha atoms. - Note: Because of implementation details, the value of the constraint will be forced to zero at distances greater than 10 Ang, regardless of the max\_distance setting.
-   cst\_weight - for atom pair distance constraints, the scaling factor
-   task\_operations - apply constraints to residues which are non-packing and non-design ones. Leave it empty if want to apply constraints to all residues.  Cannot be used with "residue\_selector"
-  residue\_selector - Residue selector that specifies which residues to which constraints should be applied.  Default is all residues. Cannot be used with "task\_operations"
-   CA\_only -Apply constraints only on CA atom. Otherwise, apply to all non-hydrogen atoms (in coordinate constraints).
-   bb\_only - Only apply to backbone heavy atoms (only support in coordinate constraints)

(Remember that to have effect, the appropriate scoreterm - "coordinate\_constraint" or "atom\_pair\_constraint" - must be nonzero in the scorefunction.)


##See Also

* [[ConstraintSetMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[ClearConstraintsMover]]
* [[AddSidechainConstraintsToHotspotsMover]]
* [[TaskAwareCstsMover]]
