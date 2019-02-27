# GraftSwitchMover
Page created by Bobby Langan (langar2@uw.edu).  Last updated 26 February 2019.
*Back to [[Mover|Movers-RosettaScripts]] page.*
## GraftSwitchMover

Grafts a sequence onto the latch of a LOCKR type protein [REF Langan, Ng, Boyken, et. al 2019]. Returns all threads where average degree of defined "important residues" is greater than the cutoff (defualt=6). "Important residues" are user defined as the residues that must be buried in the cage/latch interface. User defines the set of threadable residues either by start/end positions or by residue selector and the mover determines where in that set the defined sequence(s) can fit.  If set of residues not defined in those ways, the mover selects the C-terminal helix.  Mover will select the N-terminal helix and/or the loop adjacent to the terminal helix as defined by user parameters.

```xml
<GraftSwitchMover name="(&string)" start="(0 &int)" end="(0 &int)" 
n_term="(false &bool)" any_order="(true &bool)" pack_neighbors="(true &bool)" 
graft_on_latch_loop="(true &bool)" sequence="(&string)" 
important_residues="(&string)" burial_cutoff="(6 &real)" selector="(&string)" 
task_operations="(&string)" scorefxn="(&string)"/>
```

- <b>start</b>: Residue number defining the start of the threadable residue range.  Must be defined with 'end'. Overrides default behavior.

- <b>end</b>: Residue number to end the range of residues to allow threading.

- <b>n_term</b>: Default behaivor without setting start/end or selector is to find the c-terminal helix and set all positions designable.  Set to true if latch is on the n-terminus instead.

- <b>any_order</b>: With multiple sequences, set to false if you want to maintain the order of sequences you've defined.  Useful if you need one seq closer to one terminus than the other.

- <b>pack_neighbors</b>: Set to false if you do not want neighboring residues to repack during threading

- <b>graft_on_latch_loop</b>: Set to false if you do not want the loop between the cage/latch to be threaded

- <b>sequence</b>:  Comma separated list of sequences to thread. A '-' indicates a gap where NATAA will be default

- <b>important_residues</b>: A comma-separated list of residue numbers (1 corresponding to first residue in 'sequence') that must be buried/caged. Separate important residues for separate sequences with a '/' in order listed for the 'sequences' tag

- <b>burial_cutoff</b>: Number of neighboring residues that determines extent of burial

- <b>selector</b>: Residue Selector defining residues that can be threaded onto.  Overrides default behavior and start/end if defined.

- <b>task_operations</b>: A comma separated list of TaskOperations to use.

- <b>scorefxn</b>: Name of score function to use

- <b>name</b>: The name given to this instance.

##See Also

* [[Threading a single sequence at a single position|SimpleThreadingMover]]
* [[I want to do x]]: Guide to choosing a mover
