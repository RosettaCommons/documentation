#SimpleThreadingMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SimpleThreadingMover

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)


This mover functions to thread the sequence of a region onto the given pose.  Nothing fancy here.  Useful when combined with -parser:string_vars option to replace strings within the RosettaScript.

For more a more fancy comparative modeling protocol, please see the lovely [[RosettaCM]].


### Details
It does the threading by allowing the task to only enable these residues and then does a repacking. Optionally repack neighbors so we save one more step.

A sequence is just a string, additional '-' charactors denote to skip this position in the thread.
Default is 5 rounds of packing.