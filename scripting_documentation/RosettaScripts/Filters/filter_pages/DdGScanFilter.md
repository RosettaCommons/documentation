# DdGScan
*Back to [[Filters|Filters-RosettaScripts]] page.*
## DdGScan

Takes a set of task operations from the user in order to more precisely specify a set of residues to analyze via ddG scanning. Individually mutates each of the residues to alanine (or whatever other resiude is defined in the task operations) and calculates the change in binding energy (ddG).

```
<DdGScan name=(& string) task_operations=(comma-delimited list of task operations) repeats=(1 &Size) scorefxn=(&scorefxn) report_diffs=(1 &bool) write2pdb=(0 &bool) />
```

-   task\_operations - The task operations to use to identify which residues to scan. Designable or packable residues are scanned.
-   repeats - How many times to repeat the ddg calculations; the average of all the repeats is returned.
-   scorefxn - The score function used for the calculations. If a ddG mover is defined, this score function will be used in that mover as well, overriding any different score function defined in that mover.
-   report\_diffs - Whether to report the changes in binding energy upon mutation (pass true), or the total binding energy for the mutated structure (pass false).
-   exempt\_identities - *DEPRECATED* The user used to be able to exempt certain amino acid identities (for instance, glycine) from being mutated to during scanning by specifying them here (e.g., "GLY,PRO"). Now, if you wish to exempt certain residue types, handle this directly in the task\_operations.
-   write2pdb - Whether to write the residue-specific ddG information to the output .pdb file.

