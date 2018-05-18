# GenMeanFieldMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## GenMeanFieldMover

## Description

This [[Mover]] reports a probability distribution of amino acids for a given set of positions, depending on your TaskOperations and input files.  The values are reported to the log file and dumped as a set of transfacs.

```xml
<GenMeanFieldMover name="&string" threshold="(10.0 &float)" lambda_memory="(0.5 &float)" tolerance="(0.0001 &float)" temperature="(0.8 &float)" task_operations="(&string,&string,&string)" />
```

- threshold: The threshold to use for truncation of energies in the Boltzmann weighting scheme.  Truncation is required so as not to end up with nan values.  A value of 5 is the current best-tested value.

- lambda_memory: Prevents oscillation of the mean-field iteration and increases speed of convergence. A value of 0.5 is the current best-tested value.

- tolerance: At what point convergence is considered reached.

- temperature: kT for the Boltzmann weighting.  A value of 0.8 is the current best-tested value.

- task_operations: Comma separated list of task operations.  Amino acid probability distributions are generated for all designed positions.

##Command-line accessible options

- bb_list: file that contains list of pdbs to run MF on, in the flexible backbone use case.
- dump_transfac: path to location at which to dump transfac probability distribution files.


##See Also

* [[I want to do x]]: Guide to choosing a mover
