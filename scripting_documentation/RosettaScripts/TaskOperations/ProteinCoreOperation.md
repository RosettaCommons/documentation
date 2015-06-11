# ProteinCore
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## ProteinCore

Restricts design of residues that are in the core (e.g. to prevent charges). To determine which residues are core, it counts spatial neighbors (distance between Cb). To avoid confusion in turns on the protein surface, neighbors in sequence are omitted, similar to the way used in *Choi & Deane, Mol Biosyst(2011) 7(12):3327-3334 DOI: 10.1039/c1mb05223c*

     
     <ProteinCore name=(&string) distance_threshold=(8.0 &real) bound=(0 &bool) jump=(1 &Size) neighbor_cutoff=(10 &Size) neighbor_count_cutoff=(6 &Size) /> 

Option list

-   distance\_threshold: maximum distance for a residue to be considered a neighbor
-   bound: removes chain(s) after jump to avoid counting ligand residues as neighbors
-   jump: jump between chain of interest and ligand
-   neighbor\_cutoff: number of sequential neighbors to be excluded from calculation
-   neighbor\_count\_cutoff: number of neighbors required for a core residue

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta