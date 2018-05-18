# PDBTrajectoryRecorder
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PDBTrajectoryRecorder

Record a trajectory to a multimodel PDB file. Only record models every n times using stride. Append ".gz" to filename to use compression.

```xml
<PDBTrajectoryRecorder stride="(100 &Size)" filename="(traj.pdb &string)" cumulate_jobs="(0 &bool)" cumulate_replicas="(0 &bool)"/>
```

If run with MPI, the cumulate\_jobs and cumulate\_replicas parameters affect the filename where the trajectory is ultimately written. For instance, with the default filename parameter of `     traj.pdb    ` , input structure name of `     structname    ` , trajectory number of `     XXXX    ` , and replica number of `     YYY    ` , the following names will be generated given the options.

-   cumulate\_jobs=0 cumulate\_replicas=0: structname\_XXXX\_YYY\_traj.pdb
-   cumulate\_jobs=0 cumulate\_replicas=1: structname\_XXXX\_traj.pdb
-   cumulate\_jobs=1 cumulate\_replicas=0: YYY\_traj.pdb
-   cumulate\_jobs=1 cumulate\_replicas=1: traj.pdb


