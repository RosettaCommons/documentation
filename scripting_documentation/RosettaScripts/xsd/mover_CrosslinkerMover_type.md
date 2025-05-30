<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Adds a crosslinker linking two or more user-specified side-chains.

References and author information for the CrosslinkerMover mover:

CrosslinkerMover Mover's citation(s):
\*Dang B, \*Wu H, \*Mulligan VK, Mravic M, Wu Y, Lemmin T, Ford A, Silva D-A, Baker D, and DeGrado WF.  (2017).  De novo design of covalently constrained mesosize protein scaffolds with unique tertiary structures.  Proc Natl Acad Sci USA 114(41):10852–10857.  doi: 10.1073/pnas.1710695114.  (\*Co-primary authors.)

```xml
<CrosslinkerMover name="(&string;)" linker_name="(&string;)"
        symmetry="(&string;)" metal_type="(&string;)" add_linker="(&bool;)"
        constrain_linker="(&bool;)"
        pack_and_minimize_linker_and_sidechains="(&bool;)"
        sidechain_fastrelax_rounds="(&integer;)" do_final_fastrelax="(&bool;)"
        final_fastrelax_rounds="(&integer;)"
        filter_by_sidechain_distance="(&bool;)"
        sidechain_distance_filter_multiplier="(&real;)"
        filter_by_constraints_energy="(&bool;)"
        constraints_energy_filter_multiplier="(&real;)"
        filter_by_final_energy="(&bool;)" final_energy_cutoff="(&real;)"
        residue_selector="(&string;)" scorefxn="(&string;)" />
```

-   **linker_name**: (REQUIRED) The name of the type of linker to use.  For example, use TBMB for 1,3,5-tris(bromomethyl)benzene. (Allowed options are TBMB|1_4_BBMB|TMA|lanthionine|thioether|tetrahedral_metal|octahedral_metal|trigonal_planar_metal|trigonal_pyramidal_metal|square_planar_metal|square_pyramidal_metal.)
-   **symmetry**: The symmetry of the input pose.  For example, "C3" for cyclic, threefold symmetry.  The symmetry must be a character followed by an integer.  Allowed characters are 'A' (asymmetric), 'C' (cyclic), 'D' (dihedral), and 'S' (mirror cyclic).
-   **metal_type**: For crosslinks mediated by metals, which metal is mediating the crosslink?  Defaults to "Zn".  (Should be written as an element name -- e.g. "Cu", "Ca", "Fe", etc.)
-   **add_linker**: Should the linker geometry be added to the pose?  Default true.
-   **constrain_linker**: Should constraints for the linker be added to the pose?  Default true.
-   **pack_and_minimize_linker_and_sidechains**: Should the linker and the connecting sidechains be repacked, and should the jump to the linker, and the linker and connnecting side-chain degrees of torsional freedom, be energy-minimized?  Default true.
-   **sidechain_fastrelax_rounds**: The number of rounds of FastRelax to apply when packing and minimizing side-chains and the liker.  Default 3.
-   **do_final_fastrelax**: Should the whole pose be subjected to a FastRelax?  Default false.
-   **final_fastrelax_rounds**: The number of rounds of FastRelax to apply when relaxing the whole pose.  Default 3.
-   **filter_by_sidechain_distance**: Prior to adding the linker geometry, should this mover abort with failure status if the selected side-chains are too far apart to connect to the linker?  Default true.
-   **sidechain_distance_filter_multiplier**: This is a multiplier for the sidechain distance cutoff filter.  Higher values make the filter less stringent.  Default 1.0.
-   **filter_by_constraints_energy**: After adding the linker geometry, adding constraints, and repacking and minimizing the linker and the connecting side-chains, should ths mover abort with failure status if the constraints energy is too high (i.e. the energy-minimized linker geometry is bad)?  Default true.
-   **constraints_energy_filter_multiplier**: This is a multiplier for the constraints energy cutoff filter.  Higher values make the filter less stringent.  Default 1.0.
-   **filter_by_final_energy**: At the end of this protocol, should this mover exit with error status if the final energy is above a user-defined cutoff?  Default false.
-   **final_energy_cutoff**: If we are exiting with error status if the final energy is too high, this is the energy cutoff.  Default 0.0.
-   **residue_selector**: (REQUIRED) A previously-defined residue selector that has been set up to select the residues that will be cross-linked. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **scorefxn**: (REQUIRED) A scorefunction to use for packing, energy-minimization, and filtering.  If constraints are turned off in this score function, they will be turned on automatically at apply time.

---
