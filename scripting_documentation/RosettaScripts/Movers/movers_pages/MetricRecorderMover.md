# MetricRecorder
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MetricRecorder

Record numeric metrics to a tab-delimited text file. Only record metrics every n times using stride. Append ".gz" to filename to use compression.

Note that this is independent of the [[SimpleMetrics]] framework. 

Currently only torsion angles can be recorded, specified using the TorsionID. The residue can be indicated using absolute Rosetta number (integer) or with the PDB number and chain (integer followed by character).

```xml
<MetricRecorder stride="(100 &Size)" filename="(metrics.txt &string)" cumulate_jobs="(0 &bool)" cumulate_replicas="(0 &bool)" prepend_output_name="(0 &bool)" >
  <Torsion rsd="(&string)" type="(&string)" torsion="(&Size)" name="('' &string)"/>
  ...
</MetricRecorder>
```

If used within [MetropolisHastings](#MetropolisHastings) , the current job output name is prepended to filename. If run with MPI, the cumulate\_jobs and cumulate\_replicas parameters affect the filename where the metrics are ultimately written. For instance, with the default filename parameter of `     metrics.txt    ` , input structure name of `     structname    ` , trajectory number of `     XXXX    ` , and replica number of `     YYY    ` , the following names will be generated given the options.

-   cumulate\_jobs=0 cumulate\_replicas=0: structname\_XXXX\_YYY\_metrics.txt
-   cumulate\_jobs=0 cumulate\_replicas=1: structname\_XXXX\_metrics.txt
-   cumulate\_jobs=1 cumulate\_replicas=0: YYY\_metrics.txt
-   cumulate\_jobs=1 cumulate\_replicas=1: metrics.txt

If not used within MetropolisHastings, by default the current job output name will not be prepended to the filename, similar to `     metrics.txt    ` above. If `     prepend_output_name=1    ` , then it will be prepended following the format, `     structname_XXXX_metrics.txt    ` .

