#MergePDBMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MergePDBMover


##Author
TJ Brunette; tjbrunette@gmail.com; 

##Overview 

Combines two poses along a common secondary structure element and redesigns the sequence as appropriate
```xml
<MergePDB name="(&string)" task_operations="(&string)" scorefxn="(&string)" attachment_termini="(&string)" overlap_length="(&int) />
```

Options:

* [[task_operations|TaskOperations-RosettaScripts]]: The residues to pack and/or design.  By default, any residue 
  within 10A of the loop will be repacked and no residues will be designed.  If 
  you specify your own task operations, nothing will be repacked by default, so 
  make sure to let residues within some reasonable shell of the loop repack.

* scorefxn: The score function used for packing.  Required if not being used as 
  a subtag within some other LoopMover.

* [[loop_file|loops-file]]: See [[LoopModelerMover]].

Subtags:

* Loop: See [[LoopModelerMover]].

Caveats:

* The input pose must have sidechains, i.e. it must be in fullatom mode.