# FilterScan
*Back to [[Filters|Filters-RosettaScripts]] page.*
## FilterScan

Described in Whitehead et al., Nat Biotechnol. 30:543

Scan all mutations allowed by `     task_operations    ` and test against a filter. Produces a report on the filter's values for each mutation as well as a resfile that says which mutations are allowed. The filter can work with symmetry poses; simply use [[SetupForSymmetryMover]] and run. It will figure out that it needs to do symmetric packing for itself.

```xml
<FilterScan name="(&string)" scorefxn="(score12 &string)" task_operations="(comma separated list)" triage_filter="(true_filter &string)" dump_pdb="(0 &bool)" filter="(&string)" report_all="(0 &bool)" relax_mover="(null &string)" resfile_name="([PDB].resfile &string)" resfile_general_property="('nataa' &string)" delta="(0 &bool)" unbound="(0 &bool)" jump="(1 &int)" rtmin="(0&bool)" delta_filters="(comma delimited list of filters)" score_log_file="('' &string)"/>
```

-   triage\_filter: If this filter evaluates to false, don't include the mutation in the resulting resfile
-   dump\_pdb: dump models for each of the single mutants that pass triage filter. The pdb is scored and dumped after running the relax mover. The naming is: \<input file name\>RESxxxRES where the suffix for the Ala278-\>Arg mutant will look like ALA278ARG.
-   filter: Used only for reporting the value for the pose in the tracer report
-   report\_all: By default, only attempted mutations which pass `      triage_filter     ` will be evaluated by `      filter     ` and reported in the tracer report. If `      report_all     ` is true, report the value of `      filter     ` for all evaluated mutations. (Note this will increase the number of calls to `      filter     ` /the computational cost.)
-   relax\_mover: After mutation, what mover to use for relax (minimization may be a good idea) This mover is in addition to repacking done as part of the mutation. (Repacking is done according to `      task_operations     ` , but is limited to an 8 Angstrom shell around each mutated residue.)
-   scorefxn: The scorefunction to use with the mutation repacking
-   resfile\_name: the output resfile name. Defaults to what's the -s on the commandline +".resfile"
-   resfile\_general\_property: What to do with all other residues in the resfile
-   delta: Test the filter against a baseline which is the filter's value at the start of the run?
-   unbound: Test the filter in the unbound state?
-   jump: If unbound, which jump?
-   rtmin: carry out an rtmin repack step before the relax steps? Improves the fit of the mutated residue but can lead to noisy energies.
-   delta\_filters: a list of filters of type DeltaFilter. See below for baseline evaluation.
-   score\_log\_file: filename to put the score values (per residue filter output).

To compute a baseline, the entire pose is first repacked (with include current, no design, initialized from the comandline, but ignoring the taskoperations), and relax\_mover is called. This can be useful to get the pose's energy down. If delta\_filters are specified then before introducing mutations to any given position, the mutation to self is made (say Arg25-\>Arg), repacked/rtmin,relaxed as usual and each filter's value is evaluated. Then, these values are set as the baselines for each DeltaFilter.

Filter and triage\_filter are potentially confusing. You can use the same filter for both. Triage\_filter can be more involved, including compound filter statements, whereas the filter option is reserved to filters that have meaningful report\_sm methods (ddG, energy...).

The reported values from filter will appear in a Tracer called ResidueScan, so -mute all -unmute ResidueScan will only output the necessary information

Use the unbound option only on a Prepacked structure with jump\_number=1, o/w the reference energy (baseline) won't make any sense.

## See also

* [[AlaScanFilter]]
* [[DdgScanFilter]]
