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
A concise description of a move is given as a `SWA_Move`. The types of moves are the following (see `src/protocols/stepwise/monte_carlo/swa_move.hh`:

• `ADD`  -- supply residue(s) to add to pose (in full model numbering). if a single covalent connection can be drawn from existing pose to residue, will be covalent; otherwise added by jump.
 
• `DELETE` -- supply residue(s) to remove. If more than one contiguous residue, pose is split, and those removed residues are kept in the `other_pose_list` held in the pose's `full_model_info` objext.

• `FROM_SCRATCH` -- create a dinucleotide or dipeptide from scratch.

• `RESAMPLE` -- sample a specific connection. Specify residue to move; connection will be inferred based on parent residue in pose. 

• `RESAMPLE_INTERNAL_LOCAL` -- (tested for RNA only so far) sample a specific internal residue, making a transient cutpoint after it, enforcing KIC-based chain closure, and removing the cutpoint variant. (ERRASER style -- kind of like a **backrub** but for RNA.)

For each SWA_Move, the residue is specified, the type of connection ('AttachmentType') to a parent residue (BOND_TO_PREVIOUS, BOND_TO_NEXT,JUMP_TO_PREV_IN_CHAIN, JUMP_TO_NEXT_IN_CHAIN,JUMP_INTERCHAIN), and the parent residue. The last two pieces of information are basically redundant, but allow for consistency checks in Movers.

`SWA_MoveSelector` (also in `src/protocols/stepwise/monte_carlo/`) finds all `SWA_Move` moves possible for a given pose, and has nice examples for how to define each type of move.

# How to do a specific move
---------------------------

```
AddMover add_mover( scorefxn );
add_mover.set_presample_by_swa( true ); // will do the stepwise sampling.
add_mover.set_stepwise_modeler( new StepWiseModeler( scorefxn ) );
add_mover.apply( pose, 3 /*add res*/, 2 /*takeoff res*/ );   // imagine the pose has residues 1, 2, 7, 8
```

**What other documentation would be useful here?**

---
Go back to [[StepWise Overview|stepwise-classes-overview]].

