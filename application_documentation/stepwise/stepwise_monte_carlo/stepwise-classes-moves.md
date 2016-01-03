#StepWise Moves & Monte Carlo
# Code
Basic code running stepwise monte carlo is in `src/protocols/stepwise/monte_carlo/StepWiseMonteCarlo.hh`.

# How to run it
----------------
(see, e.g., `src/apps/public/stepwise/stepwise.cc`)
```
	StepWiseMonteCarlo stepwise_monte_carlo( scorefxn );

	StepWiseMonteCarloOptionsOP options = new StepWiseMonteCarloOptions;
	stepwise_monte_carlo.set_options( options );

	stepwise_monte_carlo.apply( pose );
```

# What StepWiseMonteCarlo can do.
---------------------------------
A concise description of a move is given as a `StepWiseMove`. The types of moves are the following (see `src/protocols/stepwise/monte_carlo/mover/stepwise_move.hh`:

• `ADD`  -- supply residue(s) to add to pose (in full model numbering). if a single covalent connection can be drawn from existing pose to residue, will be covalent; otherwise added by jump.
 
• `DELETE` -- supply residue(s) to remove. If more than one contiguous residue, pose is split, and those removed residues are kept in the `other_pose_list` held in the pose's `full_model_info` objext.

• `FROM_SCRATCH` -- create a dinucleotide or dipeptide from scratch.

• `RESAMPLE` -- sample a specific connection. Specify residue to move; connection will be inferred based on parent residue in pose. 

• `RESAMPLE_INTERNAL_LOCAL` -- (tested for RNA only so far) sample a specific internal residue, making a transient cutpoint after it, enforcing KIC-based chain closure, and removing the cutpoint variant. (ERRASER style -- kind of like a **backrub** but for RNA.)

• `ADD_SUBMOTIF` -- finds a submotif in Rosetta database (currently holds C-G Watson-Crick pair, U-A noncanonical W/H pair, G-G noncanonical W/H pairs, U-turns) that matches some uninstantiated part of the pose and adds it. Must be a single covalent connection to existing pose. 

For each SWA_Move, the residue is specified, the type of connection ('AttachmentType') to a parent residue (`BOND_TO_PREVIOUS`, `BOND_TO_NEXT`,`JUMP_TO_PREV_IN_CHAIN`, `JUMP_TO_NEXT_IN_CHAIN`, `JUMP_DOCK`), and the parent residue. The last two pieces of information are basically redundant, but allow for consistency checks in Movers.

For submotif moves, the move also supplies a `submotif_tag` of the database submotif.

`StepWiseMoveSelector` (also in `src/protocols/stepwise/monte_carlo/mover/`) finds all `StepWiseMove` moves possible for a given pose, and has nice examples for how to define each type of move.

[*Experimental* For design, also testing `ADD_LOOP_RES` and `DELETE_LOOP_RES` moves that don't change pose but instead the assumed loop lengths.]

# How to do a specific move
---------------------------

```
AddMover add_mover( scorefxn );
add_mover.set_presample_by_swa( true ); // will do the stepwise sampling.
add_mover.set_stepwise_modeler( new StepWiseModeler( scorefxn ) );
add_mover.apply( pose, 3 /*add res*/, 2 /*takeoff res*/ );   // imagine the pose has residues 1, 2, 7, 8
```

More examples of how to use these classes are in unit tests (`test/protocols/stepwise`)

---
Go back to [[StepWise Overview|stepwise-classes-overview]].

##See Also

* [[Stepwise options]]: Options classes for Stepwise code
* [[Writing an application|writing-an-app]]
* [[Development Documentation]]: The home page for development documentation
* [[Stepwise]]: The StepWise MonteCarlo application
* Applications for deterministic stepwise assembly:
  * [[Stepwise assembly for protein loops|swa-protein-main]]
    * [[Additional documentation|swa-protein-long-loop]]
  * [[RNA loop modeling with Stepwise Assembly|swa-rna-loop]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
