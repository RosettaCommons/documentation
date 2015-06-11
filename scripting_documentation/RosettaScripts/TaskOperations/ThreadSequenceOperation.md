# ThreadSequence
## ThreadSequence

Threads a single letter sequence onto the source pdb.

    <ThreadSequence name=(&string) target_sequence=(&string) start_res=(1&int) allow_design_around=(1&bool)/>

To actually change the sequence of the pose, you have to call something like PackRotamersMover on the pose using this task operation. Notice that with default parameters, this packs the threaded sequence while leaving everything else open for design.

The target sequence can contain two types of 'wildcards'. Placing 'x' in the sequence results in design at this position: target\_sequence="TFYxxxHFS" will thread the two specified tripeptides and allow design in the intervening tripeptide. Placing ' ' (space) or '\_' (underscore), however, restricts this position to repacking: the string "TFY HFS" (three spaces between the two triplets) will thread the two tripeptides and will repack the pose's original intervening tripeptide. The string "TFY\_\_\_HFS" (three underscores between the two triplets) will also only repack the original intervening tripeptide.

allow\_design\_around: if set to false, only design the region that is threaded. The rest is set to repack.

