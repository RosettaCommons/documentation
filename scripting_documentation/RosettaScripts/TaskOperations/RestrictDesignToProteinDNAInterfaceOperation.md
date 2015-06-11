# RestrictDesignToProteinDNAInterface
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictDesignToProteinDNAInterface

Restrict Design and repacking to protein residues around the defined DNA bases

    <RestrictDesignToProteinDNAInterface name=(&string) dna_defs=(chain.pdb_num.base) base_only=(1, &bool) z_cutoff=(0.0, &real) />

-   dna\_defs: dna positions to design around, separated by comma (e.g. C.405.THY,C.406.GUA). The definitions should refer only to one DNA chain, the complementary bases are automatically retrieved. Bases are ADE, CYT, GUA, THY. The base (and its complementary) in the starting structure will be mutated according to the definition, if not prevented from another task operation.
-   base\_only: only residues within reach of the DNA bases are considered
-   z\_cutoff: limit the protein interface positions to the ones that have a projection of their distance vector on DNA axis lower than this threshold. It prevents designs that are too far away along the helical axis


