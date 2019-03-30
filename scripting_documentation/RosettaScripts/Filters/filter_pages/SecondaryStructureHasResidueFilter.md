# SecondaryStructureHasResidue
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SecondaryStructureHasResidue

Counts fraction of DSSP-defined secondary structure elements that contain N or more of a given residue type(s). Useful for checking whether each helix/sheet secondary structure element in a de novo design structure has at least one hydrophobic residue. Uses 2 task operations to select residues (if designable it includes them in calculation); res_check_task_operations is used to select which residues to (not) check for correct aa identity, ss_select_task_operations is used to select which residues are included in the base count of total secondary structure elements. default task is all residues.

```xml
<SecondaryStructureHasResidue name="(&string)" secstruct_fraction_threshold="(1.0 &Real)" res_check_task_operations="(&string)" ss_select_task_operations="(&string)" required_restypes="(VILMFYW &string)" nres_required_per_secstruct="(1 &int)" filter_helix="(1 &bool)" filter_sheet="(1 &bool)" filter_loop="(0 &bool)" min_helix_length="(4 &int)" min_sheet_length="(3 &int)" min_loop_length="(1 &int)" />
```

- secstruct_fraction_threshold: fraction of considered SS elements with N or more required restype(s)
- res_check_task_operations: which residues checking for correct restype(s)? (designable=check)
- ss_select_task_operations: which residues checking for existing SS structure elements? (designable=check)
- required_restypes: defaults to non-Ala h'phobics. Use aa1letter string
- nres_required_per_secstruct: default to only one per element to count as a "yes" for that SS element
- filter_helix/sheet/loop: yes/no. do we care about this type, or skip it entirely?
min_helix/sheet/loop_length: what defines SS element?

## See also:

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[AngleToVectorFilter]]
* [[DsspMover]]
* [[GeometryFilter]]
* [[HelixKinkFilter]]
* [[SecondaryStructureFilter]]
* [[TorsionFilter]]
