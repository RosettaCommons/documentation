#SimpleThreadingMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SimpleThreadingMover

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)

[[include:mover_SimpleThreadingMover_type]]

### Details
It does the threading by allowing the task to only enable these residues and then does a repacking. Optionally repack neighbors so we save one more step.

A sequence is just a string, additional '-' charactors denote to skip this position in the thread.
Default is 5 rounds of packing.  If the sequence would be threaded past the C-terminus, the returned pose will have the sequence threaded up to the end of the pose - additional residues will not be added or modeled.

SimpleThreadingMover supports symmetric poses.

### Overview

In order to run this protocol, you just need to specify the place to start - in rosetta or PDB numbering - and the sequence.  
We will parse the PDB numbering on apply time in case there are any pose-length changes until then. 
Pass the option to repack neighbors for packing.  


     <SimpleThreadingMover name="threader" start_position="24L" thread_sequence="TGTGT--GTGT" pack_neighbors="1" neighbor_dis="6"  pack_rounds="5"/>

##See Also

* [[RosettaCM]]: Full Rosetta Comparative Modeling protocol
* [[HybridizeMover]]: More Complex mover for Comparative Modeling
* [[FastRelaxMover]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover