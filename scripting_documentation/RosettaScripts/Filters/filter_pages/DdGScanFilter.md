# DdGScan
*Back to [[Filters|Filters-RosettaScripts]] page.*
## DdGScan (used to be named "TaskAwareAlaScan")

Takes a set of task operations from the user in order to more precisely specify a set of residues to analyze via ddG scanning. Individually mutates each of the residues to alanine (or whatever other residue is defined in the task operations) and calculates the change in binding energy (ddG).

```xml
<DdGScan name="(& string)" task_operations="(comma-delimited list of task operations)" repeats="(1 &Size)" scorefxn="(&scorefxn)" report_diffs="(1 &bool)" write2pdb="(0 &bool)" />
```

-   task\_operations - The task operations to use to identify which residues to scan. Designable or packable residues are scanned.
-   repeats - How many times to repeat the ddg calculations; the average of all the repeats is returned.
-   scorefxn - The score function used for the calculations. If a ddG mover is defined, this score function will be used in that mover as well, overriding any different score function defined in that mover.
-   report\_diffs - Whether to report the changes in binding energy upon mutation (pass true), or the total binding energy for the mutated structure (pass false).
-   exempt\_identities - *DEPRECATED* The user used to be able to exempt certain amino acid identities (for instance, glycine) from being mutated to during scanning by specifying them here (e.g., "GLY,PRO"). Now, if you wish to exempt certain residue types, handle this directly in the task\_operations.
-   write2pdb - Whether to write the residue-specific ddG information to the output .pdb file.

Sample query to obtain results from database:
```sql
SELECT 
    structures.tag AS tag, 
    residues.name3 AS wt, 
    residue_pdb_identification.residue_number as rosetta_resNum, 
    residue_pdb_identification.pdb_residue_number AS pdb_resNum, 
    residue_pdb_identification.chain_id AS chain, 
    ddg.mutated_to_name3 AS mut, 
    ddg.ddG_value, 
    batches.description 
FROM ddg 
INNER JOIN structures ON structures.struct_id=ddg.struct_id 
INNER JOIN residue_pdb_identification ON 
    residue_pdb_identification.struct_id=structures.struct_id 
    AND residue_pdb_identification.residue_number=ddg.resNum 
INNER JOIN residues ON residues.struct_id=structures.struct_id 
    AND residues.resNum=ddg.resNum 
INNER JOIN batches ON batches.batch_id=structures.batch_id;
```


## See also

* [[Docking applications|docking-applications]]
* [[AlaScanFilter]]
* [[ddGMover]]
* [[DdgFilter]]
* [[FilterScanFilter]]

