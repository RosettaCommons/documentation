# RelativePose
*Back to [[Filters|Filters-RosettaScripts]] page.*
## RelativePose

Compute a filter's value relative to a different pose's structure. This is useful for cases in which you want to know the effects of a mutation on different poses. An alignment of the pose being read from disk is made to the currently active pose (through the user defined alignment), and applies any sequence changes to the pose read from disk, while repacking a shell around each mutation. It can then apply a relax mover, report a filter's evaluation and dump a scored pose to disk. Works with symmetric poses as well.

```xml
<RelativePose name="(&string)" pdb_name="(&string)" filter="(&string)" relax_mover="(null &string)" dump_pose="('' &string)" alignment="(&string; see below)" scorefxn="(score12 &string)" packing_shell="(8.0 &Real)" thread="(1 &bool)" baseline="(1 &bool)" unbound="(0 &bool)" copy_stretch="(1&bool)" rtmin="(0 &bool)" symmetry_definition="('' &string)" copy_comments="('' &comma-delimited list)">
```

-   pdb\_name: which is the reference pose to read from disk.
-   filter: which filter to apply.
-   relax\_mover: which relax mover to apply after threading.
-   dump\_pose: optional- should we dump the pose after threading?
-   alignment: what segments to align between the disk-pose and the current pose. defaults to aligning from 1-\>nres. To specify something different use the following format: 3A:1B,4A:2B,5A:6B, meaning align disk pose's 3A-5A to 1B,2B, and 6B on the current pose. Only the aligned segments are searched for mutations between the disk and current pose for threading. All else is ignored. If no residue number is specified, the method aligns chains. For instance: A:D,B:B, means align A with D and B with B. No checks are made to guarantee length compatibility etc.
-   scorefxn: used for packing during threading and for scoring the dumped pose.
-   packing\_shell: radius of shell around each residue to repack after threading. The more use use the longer the simulation.
-   thread: Normally you'd want this to be true. This is not the case only if you're estimating baselines for the disk pose before doing an actual run.
-   baseline: shall we use the pose which is read from disk as a reference? (means that the filter's return value will equal the filter's value at run time minus the reference value.
-   unbound: before threading, should we dissociate the complex?
-   copy\_stretch: rather than threading the residue identities on the pose read from disk, copy the aligned segment from the current pose onto the pose read from disk (residue identities + conformations). No repacking is done, and then goes straight to relax. Obviously the segment should be prealigned for this to make any sense, and should probably only be used on entire chains rather than stretches within chains. Any way, take care in using. No guarantees.
-   rtmin: do rtmin following repack?
-   symmetry\_definition: if symmetric, enter the symmetry definition file here.
-   copy_comments: a comma-delimited list of pose-comment key values to copy from the reference pose (the current pose computed in the trajectory) to the relative pose (from disk). Useful if conformational change needs to be communicated from the reference pose to the relative pose.

## See also

* [[CombinedValueFilter]]
* [[MoveBeforeFilter]]
