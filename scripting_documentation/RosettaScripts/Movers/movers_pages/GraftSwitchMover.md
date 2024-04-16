# GraftSwitchMover
Page created by Bobby Langan (robert.langan@gmail.com).  Last updated 26 February 2019.
*Back to [[Mover|Movers-RosettaScripts]] page.*
## GraftSwitchMover

Grafts a sequence onto the latch of a LOCKR type protein ([Langan RA, Ng AH, Boyken SE, et. al Nature 2019](https://www.nature.com/articles/s41586-019-1432-8)). Returns all threads where average degree of defined "important residues" is greater than the cutoff (defualt=6). "Important residues" are user defined as the residues that must be buried in the cage/latch interface. User defines the set of threadable residues either by start/end positions or by residue selector and the mover determines where in that set the defined sequence(s) can fit.  If set of residues not defined in those ways, the mover selects the C-terminal helix.  Mover will select the N-terminal helix and/or the loop adjacent to the terminal helix as defined by user parameters.

Mover returns several poses - MultiplePoseMover must be used for downstream design and filtering.

Use this when you want to thread one or more sequences in several potential positions - use [[SimpleThreadingMover|SimpleThreadingMover]] if you have one position to put one sequence.  This mover calls SimpleThreadingMover after parsing threadable positions and performs downstream filtering for burial.

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

- <b>task_operations</b>: A comma separated list of TaskOperations to use.  Use if you have residues you do not want to be repacked (or set pack_neighbors to false if you don't want any residues repacked).  Good if you're doing HBNet upstream in your protocol - use the HBNet TaskOp to maintain those rotamers.

- <b>scorefxn</b>: Name of score function to use.

- <b>name</b>: The name given to this instance.

There are three ways to define the threadable residues.  If you do nothing, the C-terminal will be selected along with the loop preceding it.  Setting <b>n_term</b> to true will use the N-terminal helix and loop instead.  Setting <b>graft_on_latch_loop</b> to false will just use the corresponding helix.

```xml
<GraftSwitchMover name="lockr_des" graft_on_latch_loop="false" 
sequence="L-MSCAQES" important_residues="5,6" />
```

If you define start and end it will thread on all residues between the defined positions.  Both must be defined if one is, otherwise mover will throw an error.

```xml
<GraftSwitchMover name="lockr_des" start="240" end="260"
sequence="L-MSCAQES" important_residues="5,6" />
```

A residue selector can be used to define a discontinuous set of residues.  The mover will programmatically determine where in that discontinuous set your sequence(s) fit.

```xml
<RESIDUE_SELECTORS>
    #Select both terminal helices but not HBNet residues
    <ResiduePDBInfoHasLabel name="hbnet_residues" property="HBNet" />
    <Not name="not_HBnet" selector="hbnet_residues"/>
    <SSElement name="n_helix" selection="1,H" />
    <SSElement name="c_helix" selection="-1,H" />
    <Or name="terminal_helices" selectors="n_helix,c_helix"/>

    <And name="threadable_residues" selectors="not_HBnet,terminal_helices"/>
</RESIDUE_SELECTORS>
<MOVERS>
    <GraftSwitchMover name="lockr_des" selector="threadable_residues"
    sequence="L-MSCAQES" important_residues="5,6" />
</MOVERS>
```

Using MultiplePoseMover for downstream design and filtering is necessary to capture all the output from this mover.

##See Also

* [[SimpleThreadingMover|SimpleThreadingMover]]
* [[I want to do x]]: Guide to choosing a mover
