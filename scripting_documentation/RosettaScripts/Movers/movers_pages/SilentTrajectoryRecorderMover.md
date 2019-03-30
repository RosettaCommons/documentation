# SilentTrajectoryRecorder
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SilentTrajectoryRecorder

Record a trajectory of snapshots as silent-file.

```xml
<SilentTrajectoryRecorder stride="(100 &Size)" score_stride="(100 &Size)" filename="(traj &string)" cumulate_jobs="(0 &bool)" cumulate_replicas="(0 &bool)"/>
```

By default, this will actually generate PDB file output. To get silent file output, several additional command line flags are required:

     -out:file:silent <silent filename> -run:intermediate_structures

If used within [MetropolisHastings](#MetropolisHastings) , the current job output name becomes part of the filename. If run with MPI, the cumulate\_jobs and cumulate\_replicas parameters affect the filename where the trajectory is ultimately written. For instance, with the default filename parameter of `     traj    ` , input structure name of `     structname    ` , trajectory number of `     XXXX    ` , replica number of `     YYY    ` , and `     -out:file:silent default.out    ` , the following names will be generated given the options.

-   cumulate\_jobs=0 cumulate\_replicas=0: default\_structname\_XXXX\_YYY\_traj.out
-   cumulate\_jobs=0 cumulate\_replicas=1: default\_structname\_XXXX\_traj.out
-   cumulate\_jobs=1 cumulate\_replicas=0: default\_YYY\_traj.out
-   cumulate\_jobs=1 cumulate\_replicas=1: default\_traj.out


##See Also

* [[Silent file]]: Working with silent files in Rosetta
* [[I want to do x]]: Guide to choosing a mover
