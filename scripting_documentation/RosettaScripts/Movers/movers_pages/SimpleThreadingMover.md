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

### Overview

In order to run this protocol, you just need to specify the place to start in rosetta or PDB numbering and the sequence.  
We will parse the PDB numbering on apply time in case there are any pose-length changes until then. 
Pass the option to repack neighbors for packing.  


     <SimpleThreadingMover name="threader" start_position="24L" thread_sequence="TGTGT--GTGT" pack_neighbors="1" neighbor_dis="6"  pack_rounds="5"/>

## Required Options

-  _start_position_ (&string): Position to start thread.  PDB numbering (like 30L) or Rosetta pose numbering.  PDB numbering parsed at apply time to allow for pose-length changes prior to apply of this mover.
-  _thread_sequence_ (&string): One letter amino acid sequence we will be grafting.  Currently only works for canonical amino acids. 


## Optional

-  _scorefxn_ (&ScoreFunction) (default = cmd-line default): Optional Scorefunction name passed - setup in score function block.


-  _pack_neighbors_ (&bool) (default = false): Option to pack neighbors while threading
-  _neighbor_dis_ (&real) (default = 6.0): Distance to repack neighbor side chains.  'repack shell distance' for each threaded residue.
-  _pack_rounds_ (&int) (default = 5): Number of packing rounds for threading. 
-  _skip_unknown_mutant_ (&bool) (default = false): Skip unknown amino acid in thread_sequence string instead of throwing an exception.


##See Also

* [[RosettaCM]]: Full Rosetta Comparative Modeling protocol
* [[HybridizeMover]]: More Complex mover for Comparative Modeling
* [[FastRelaxMover]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover