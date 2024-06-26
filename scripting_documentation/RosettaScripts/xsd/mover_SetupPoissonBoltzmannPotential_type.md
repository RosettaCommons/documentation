<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Initialize the runtime environment for Poisson-Boltzmann solver. It allows keeping track of protein mutations to minimize the number of PB evaluations.

```xml
<SetupPoissonBoltzmannPotential name="(&string;)" scorefxn="(&string;)"
        jump="(1 &non_negative_integer;)" per_residue_ddg="(false &bool;)"
        repack_unbound="(false &bool;)"
        task_operations="(&task_operation_comma_separated_list;)"
        packer_palette="(&named_packer_palette;)" repack_bound="(true &bool;)"
        relax_bound="(false &bool;)" relax_unbound="(true &bool;)"
        translate_by="(1000.0 &real;)" relax_mover="(&string;)"
        filter="(&string;)" chain_num="(&string;)" chain_name="(&string;)"
        solvate="(false &bool;)" solvate_unbound="(false &bool;)"
        solvate_rbmin="(false &bool;)" min_water_jump="(true &bool;)"
        compute_rmsd="(false &bool;)" dump_pdbs="(false &bool;)"
        apbs_path="(&string;)" charged_chains="(&string;)"
        revamp_near_chain="(&string;)" potential_cap="(&real;)"
        sidechain_only="(&bool;)" epsilon="(&real;)" calcenergy="(&bool;)"
        apbs_debug="(2 &integer;)" />
```

-   **scorefxn**: Name of score function to use
-   **jump**: XSD XRW TO DO
-   **per_residue_ddg**: XSD XRW TO DO
-   **repack_unbound**: XSD XRW TO DO
-   **task_operations**: A comma-separated list of TaskOperations to use.
-   **packer_palette**: A previously-defined PackerPalette to use, which specifies the set of residue types with which to design (to be pruned with TaskOperations).
-   **repack_bound**: XSD XRW TO DO
-   **relax_bound**: Should we relax the bound state, if a relax mover is specified?  Default false.
-   **relax_unbound**: Should we relax the unbound state, if a relax mover is specified?  Default true.
-   **translate_by**: Distance in Angstroms by which to separate the components of the bound state
-   **relax_mover**: XSD XRW TO DO
-   **filter**: XSD XRW TO DO
-   **chain_num**: XSD XRW TO DO
-   **chain_name**: XSD XRW TO DO
-   **solvate**: Solvate bound pose (using ExplicitWater mover)
-   **solvate_unbound**: Solvate unbound pose (using ExplicitWater mover)
-   **solvate_rbmin**: Use rigid-body minimization following solvation
-   **min_water_jump**: Include waters in rigid-body minimization following solvation and packing
-   **compute_rmsd**: Compute the rmsd both with and without superimposing -- requires in:file:native to be supplied
-   **dump_pdbs**: Dump debugging PDB files. Dumps 6 pdbs per instance: BOUND_before_repack, BOUND_after_repack, BOUND_after_relax, UNBOUND_before_repack, UNBOUND_after_repack, and UNBOUND_after_relax.
-   **apbs_path**: XRW TO DO
-   **charged_chains**: Comma delimited list of charged chainnumbers ( greater than or equal to 1). e.g. charged_chains=1,2,3 for chains 1, 2 and 3. No extra whitespace is permitted
-   **revamp_near_chain**: Comma delimited list of chain numbers. Scale down PB interactions if near the given chain(s). Default to none
-   **potential_cap**: Upper limit for PB potential input. Default to 20.0
-   **sidechain_only**: Set "true" to limit calculation of interactions to sidechain. Default to "false"
-   **epsilon**: mutation tolerance in Angstrom. Potential is re-computed only when | Ca1 - Ca2 | greater than epsilon, for all Ca1 in Alpha-carbon in previous pose and all Ca2 in the current pose. The default is 2.0 A
-   **calcenergy**: Set "true" to calculate energy. Not yet implemented. Default to false
-   **apbs_debug**: APBS debug level [0-6]. Default to 2

---
