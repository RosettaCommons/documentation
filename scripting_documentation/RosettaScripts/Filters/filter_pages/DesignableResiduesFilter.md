# DesignableResidues
*Back to [[Filters|Filters-RosettaScripts]] page.*
## DesignableResidues

Filters based on minimum and maximum number of designable residues allowed, but defaults are set to 0 and 1000, respectively so that by default it functions primarily to report to tracers the total number of and which residues are repackable/designable according to use-defined task\_operations. Will also output text to tracers to aid in easy visualization of designable/repackable positions in Pymol. Useful for automatic interface detection (use the ProteinInterfaceDesign task operation for that). The residue number that are reported are pdb numbering. Works with symmetric poses and poses with symmetric "building blocks".

```xml
<DesignableResidues name="(&string)" task_operations="(comma-separated list)" designable="(1 &bool)" packable="(0 &bool)" lower_cutoff="(0 &size)" upper_cutoff="(1000 &size)"/>
```

-   task\_operations: define what residues are designable or repackable.
-   designable: whether or not to report the number of designable positions
-   packable: whether or not to report the number of repackable positions
-   lower\_cutoff: minimum number of designable positions
-   upper\_cutoff: maximun number of designable positions

## See also:

* [[TaskOperations-RosettaScripts]]
* [[MutationsFilter]]
* [[SaveResfileToDiskFilter]]
