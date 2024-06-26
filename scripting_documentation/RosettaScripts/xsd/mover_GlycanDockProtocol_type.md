<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
GlycanDock performs protein-glycoligand local docking given a putative complex as input. All GlycanDockProtocol attributes are set to their default, and suggested values based on the results from the GlycanDock benchmark assessment.

```xml
<GlycanDockProtocol name="(&string;)" refine_only="(false &bool;)"
        prepack_only="(false &bool;)" partners="(_ &string;)"
        stage1_rotate_glycan_about_com="(false &bool;)"
        stage1_perturb_glycan_com_trans_mag="(0.5 &real;)"
        stage1_perturb_glycan_com_rot_mag="(7.5 &real;)"
        stage1_torsion_uniform_pert_mag="(12.5 &real;)"
        n_repeats="(1 &non_negative_integer;)" mc_kt="(0.6 &real;)"
        n_rigid_body_rounds="(8 &non_negative_integer;)"
        n_torsion_rounds="(8 &non_negative_integer;)"
        stage2_trans_mag="(0.5 &real;)" stage2_rot_mag="(7.5 &real;)"
        full_packing_frequency="(8 &non_negative_integer;)"
        interface_packing_distance="(16.0 &real;)" ramp_scorefxn="(true &bool;)"
        watch_in_pymol="(false &bool;)" />
```

-   **refine_only**: Perform refinement of the input putative complex only. Skips Stage 1 (conformational initialization via a random perturbation) and, during Stage 2, do not perform large perturbations in glycosidic torsion angle space. Default = false
-   **prepack_only**: Perform Stage 0 pre-packing of the input putative complex only. Separates the glycoligand from its protein receptor and optimizes all sidechain rotamer conformations. Default = false
-   **partners**: Chain IDs of protein-glycoligand docking partneers. Synonymous with the -docking:partners flag. Required when performing docking or the pre-pack protocol. E.g. A_X or HL_X. Default = '_'
-   **stage1_rotate_glycan_about_com**: During Stage 1 conformation initialization, rotate the glycoligand about its center-of-mass in uniform 3D space. Default = false. Recommended to set to true if confidence of the glycoligand's rigid-body orientation in the putative binding site is low.
-   **stage1_perturb_glycan_com_trans_mag**: During Stage 1 conformation initialization, this is the magnitude for performing a random translational Gaussian perturbation on the glycoligand's center-of-mass. Default = 0.5 (Angstroms)
-   **stage1_perturb_glycan_com_rot_mag**: During Stage 1 conformation initialization, this is the magnitude for performing a random rotational Gaussian perturbation on the glycoligand's center-of-mass. Default = 7.5 (degrees)
-   **stage1_torsion_uniform_pert_mag**: During Stage 1 conformation initialization, the magnitude used to perform a uniform perturbation on each phi, psi, and omega glycosidic torsion angle. Default = 12.5 (degrees).
-   **n_repeats**: Number of times to run the GlycanDock protocol on a protein-glycoligand system if the final docked structure does not pass the quality filter (negative Rosetta interaction energy). Default = 1
-   **mc_kt**: During Stage 2 docking and refinement, the value of kT used to accept or reject moves based on the Metropolis criterion. Default = 0.6
-   **n_rigid_body_rounds**: During Stage 2 docking and refinement, the number of rigid-body sampling rounds to perform each cycle. Default = 8
-   **n_torsion_rounds**: During Stage 2 docking and refinement, the number of glycosidic torsion angle sampling rounds to perform each cycle. Default = 8
-   **stage2_trans_mag**: During Stage 2 docking and refinement, this is the magnitude for performing a translational Gaussian perturbation on the glycoligand's center-of-mass. The perturbation is accepted or rejected based on the Metropolis criterion. Default = 0.5 (Angstroms)
-   **stage2_rot_mag**: During Stage 2 docking and refinement, this is the magnitude for performing a rotational Gaussian perturbation on the glycoligand's center-of-mass. The perturbation is accepted or rejected based on the Metropolis criterion. Default = 7.5 (degrees)
-   **full_packing_frequency**: During Stage 2 docking and refinement, the frequency at which a full packing operation via the PackRotamersMover should be applied. Default = 8. Should be a factor of n_rigid_body_rounds and n_torsion_rounds. When not performing a full packing operation, the faster EnergyCutRotamerTrialsMover is applied.
-   **interface_packing_distance**: During Stage 2 docking and refinement, the distance used to define protein-glycoligand interface residues for packing. Default = 16 (Angstroms). Used for the RestrictToInterface task operation.
-   **ramp_scorefxn**: During Stage 2 docking and refinement, ramp the fa_atr and fa_rep score terms. fa_atr is set high and fa_rep is set low, and then ramped to their starting weights incrementally over the course of n_cycles. Default = true. Used to promote sampling by not strictly enforcing rigid sterics in the early stages of the protocol.
-   **watch_in_pymol**: Watch the GlycanDock protocol in PyMOL? Sends the Pose at specific, hard-coded steps to PyMOL. Default = false. Used as an alternative to -show_simulation_in_pymol.

---
