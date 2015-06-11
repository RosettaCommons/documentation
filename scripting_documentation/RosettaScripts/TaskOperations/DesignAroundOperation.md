# DesignAround
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DesignAround

Designs in shells around a user-defined list of residues. Restricts all other residues to repacking.

    <DesignAround name=(&string) design_shell=(8.0 &real) resnums=(comma-delimited list) repack_shell=(8.0&Real) allow_design=(1 &bool) resnums_allow_design=(1 &bool)/> 

-   resnums can be a list of pdb numbers, such as 291B,101A.
-   repack\_shell: what sphere to pack around the target residues. Must be at least as large as design\_shell.
-   allow\_design: allow design in the sphere, else restrict to repacking.
-   resnums\_allow\_design: allow design in the resnums list, else restrict to repacking.

