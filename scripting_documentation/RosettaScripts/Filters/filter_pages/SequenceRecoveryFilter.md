# SequenceRecovery
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SequenceRecovery

Calculates the fraction sequence recovery of a pose compared to a reference pose. This is similar to the [[InterfaceRecapitulationMover]] mover, but does not require a design mover. Instead, the user can provide a list of task operations that describe which residues are designable in the pose. Works with symmetric poses and poses with symmetric "building blocks". Can also filter based on/report to the scorefile the number of mutations rather than the recovery rate if desired by using the report\_mutations and mutation\_threshold options. Will output the specific mutations to the tracer if the option verbose=1. The reference pose against which the recovery rate will be computed can be defined using the -in:file:native command-line flag. If that flag is not defined, the starting pose will be used as a reference.

```xml
<SequenceRecovery name="(&string)" rate_threshold="(0.0 &Real)" task_operations="(comma-delimited list of operations &string)" mutation_threshold="(100 &Size)" report_mutations="(0 &bool)" scorefxn="('talaris2013' &string)" verbose="(0 &bool)" />
```

-   rate\_threshold: Lower cutoff for the acceptable recovery rate for a passing design. Will fail if actual rate is below this threshold.
-   task\_operations: Define the designable residues.
-   scorefxn: Define the score function used to score the mutations listed in the reports.
-   mutation\_threshold: Upper cutoff for the number of mutations for an acceptable design. Only matters if report\_mutations is set to true.
-   report\_mutations: Defaults to false. If set to true, then will act as a filter for the number of mutations rather than the rate.
-   verbose: Defaults to false. If set to true, then will output the mutated positions and identities to the tracer.

## See also

* [[Design in Rosetta|application_documentation/design/design-applications]]
* [[Task Operations|TaskOperations-RosettaScripts]]
* [[InterfaceRecapitulationMover]]
* [[PackRotamersMover]]

