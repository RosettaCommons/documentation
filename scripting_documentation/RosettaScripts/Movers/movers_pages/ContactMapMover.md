# ContactMap
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ContactMap

Calculate and output contact maps for each calculated structure

```xml
<ContactMap name="&string" region1="( &string)" region2="( &string)" ligand="( &string)"  distance_cutoff="( 10.0 &Real)"  prefix="('contact_map_' &string)" reset_count="('true' &string)" models_per_file="(1 &int)" row_format="('false' &string)" />
```

-   region1: region definition for region1 of ContactMap in format '\<start\>-\<end\>' or '\<chainID\>' defaults to 1-\<n\_residue()\>
-   region2: region definition for region2 of ContactMap
-   ligand: sequence position or chainID of ligand - all non-hydrogen atoms of the corresponding residue will be mapped against the CB atoms of region1(ignored if region2-tag is specified)
-   distance\_cutoff: Maximum distance of two atoms so contacts count will be increased
-   prefix: Prefix for output\_filenames
-   reset\_count: flag whether the count will be reset to 0 after the ContactMap was output to a file. if set to false, the same file will be updated every 'models\_per\_file' structures (only applies for n\_struct\>1 when called with the Scripter)
-   models\_per\_file: defines after how many structures an output file should be generated (no file will be created if equal to 0 or greater than n\_struct !)
-   row\_format: flag if output should be in row format rather than the default matrix format

##See Also

* [[AtomicContactFilter]]
* [[ResidueDistanceFilter]]
* [[ExtractSubposeMover]]
* [[I want to do x]]: Guide to choosing a mover
