# MutationsFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## MutationsFilter

Determines mutated residues in current pose as compared to a reference pose. Can be used to stop trajectories if desired by setting a mutation\_threshold or rate\_threshold. The residues considered are restricted by task operations. By default, only designable residues are considered, but packable residues can also be considered if the option packable=true (useful for instance if a resfile is used to mutate some positions during the protocol, but only one AA was allowed to be considered during repack. Such a position is only considered packable). Outputs the number of mutations or the mutation rate (number of mutations divided by the number of designable (or packable) positions. Works with symmetric poses and symmetric "building blocks". The reference pose against which the recovery rate will be computed can be defined using the -in:file:native command-line flag.

```xml
<MutationsFilter name="(&string)" rate_threshold="(0.0 &Real)" task_operations="(comma-delimited list of operations &string)" mutation_threshold="(100 &Size)" report_mutations="(0 &bool)" packable="(0 &bool)" verbose="(0 &bool)" write2pdb="(0 &bool)" />
```

-   rate\_threshold: Lower cutoff for the acceptable recovery rate for a passing design. Will fail if actual rate is below this threshold.
-   task\_operations: Define the designable residues or packable residues.
-   mutation\_threshold: Upper cutoff for the number of mutations for an acceptable design. Only matters if report\_mutations is set to true.
-   report\_mutations: Defaults to false. If set to true, then will act as a filter for the number of mutations rather than the rate.
-   verbose: Defaults to false. If set to true, then will output the mutated positions and identities to the tracer.
-   write2pdb: Defaults to false. If set to true, then will output the mutated positions and identities to the output pdb.
-   packable: Defaults to false. If set to true, then will also consider mutations at packable positions in addition to designable positions.

## See also

* [[TaskOperations-RosettaScripts]]
* [[ClashCheckFilter]]
* [[DesignableResiduesFilter]]
* [[GetRBDOFValuesFilter]]
* [[InterfacePackingFilter]]
* [[OligomericAverageDegreeFilter]]
* [[SymUnsatHbondsFilter]]

