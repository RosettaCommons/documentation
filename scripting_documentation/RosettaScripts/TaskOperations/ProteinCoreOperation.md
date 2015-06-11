# ProteinCore
## ProteinCore

(This is a devel TaskOperation and not available in released versions.)

Restricts design of residues that are in the core (e.g. to prevent charges). To determine which residues are core, it counts spatial neighbors (distance between Cb). To avoid confusion in turns on the protein surface, neighbors in sequence are omitted, similar to the way used in *Choi & Deane, Mol Biosyst(2011) 7(12):3327-3334 DOI: 10.1039/c1mb05223c*

     
     <ProteinCore name=(&string) distance_threshold=(8.0 &real) bound=(0 &bool) jump=(1 &Size) neighbor_cutoff=(10 &Size) neighbor_count_cutoff=(6 &Size) /> 

Option list

-   distance\_threshold: maximum distance for a residue to be considered a neighbor
-   bound: removes chain(s) after jump to avoid counting ligand residues as neighbors
-   jump: jump between chain of interest and ligand
-   neighbor\_cutoff: number of sequential neighbors to be excluded from calculation
-   neighbor\_count\_cutoff: number of neighbors required for a core residue

