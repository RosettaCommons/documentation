# BuildingBlockInterface
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## BuildingBlockInterface

(This is a devel TaskOperation and not available in released versions.)

<!--- BEGIN_INTERNAL -->
For use when designing with symmetric building blocks. Prevents repacking at residues that are: 1) distant from the inter-building block interface, or 2) near the inter-building block interface, but also make intra-building block interface contacts that are not clashing.

      <BuildingBlockInterface name=(&string) nsub_bblock=(1 &Size) sym_dof_names="" &string) contact_dist=(10.0 &Real) bblock_dist=(5.0 &Real) fa_rep_cut=(3.0 &Real) />

-   nsub\_bblock - The number of subunits in the symmetric building block (e.g., 3 for a trimer). This option is not needed for multicomponent systems.
-   sym\_dof\_names - Names of the sym\_dofs corresponding to the symmetric building blocks. (Eventually replace the need for this option by having is\_singlecomponent or is\_multicomponent utility functions). If no sym\_dof\_names are specified, then they will be extracted from the pose.
-   contact\_dist - Residues with beta carbons not within this distance of any beta carbon from another building block are prevented from repacking.
-   bblock\_dist - The all-heavy atom cutoff distance used to specify residues that are making inter-subunit contacts within the building block. Because these residues are making presumably important intra-building block interactions, they are prevented from repacking unless they are clashing.
-   fa\_rep\_cut - The cutoff used to determine whether residues making inter-subunit contacts within the building block are clashing.

<!--- END_INTERNAL --> 
