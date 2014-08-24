# StepWiseModeler
`StepWiseModeler` takes a pose and a single position moving residue, and figures everything out from there, including  whether to sample of one terminal nucleotide (default for RNA), or two amino acids (default for protein); what the two partitions are that will move relative to each other (there are essentially always two!); and whether to do rigid body docking (if the moving residue's parent is a jump).

# Basic steps
Here is the  `apply` function for `StepWiseModeler`:
```
		initialize( pose );

		do_prepacking( pose );
		do_sampling( pose );
		if ( sampling_successful() ) do_minimizing( pose );

		reinitialize( pose );
```
• `initialize` figures out a bunch of working parameters -- which residues to move, any `bridge_res` residues to CCD close, etc. -- into one object. All of this information can actually be derived from the pose & `moving_res`, but it was historical to have all of it readily available in one object. The function also re-roots the pose so that the biggest partition is fixed, and aligns it to an alignment pose; this accelerates computation. Last, native constraints can be applied here if the `rmsd_screen` option is specified from command line.

• `do_prepacking` packs protein side-chains and RNA 2' hydroxyls, as well as any 5' or 3' phosphates that are hanging off RNA strands. By default, the packing allows virtualization of side-chains and RNA hydroxyls -- if there aren't enough contacts with those groups to define them, they are kept virtual (through bonuses in the `free_side_chain` and `free_2HOprime` terms).

• `do_sampling` actually carries out the enumerative or stochastic sampling using the StepWiseConnectionSampler, which sets up a [SampleAndScreen|stepwise-sample-and-screen] (see below).  No minimizing occurs here, just a discrete grid search over backbone torsions or rigid-body DOFs.

• `do_minimizing` takes the lowest energy pose(s) found in sampling, and carries out torsional minimization. How many poses to minimize is encoded in option `num_pose_minimize` (see [options/] below).

• `reinitialize` zeros out several objects in `StepWiseModeler` in case it is reused (which it will be in `StepWiseMonteCarlo` applications). It also removes any native constraints added to the pose.

In addition to `StepWiseModeler.cc`, this `modeler/` directory also contains several subdirectories and files for defining options classes, packers, and minimizers, as well as some code specific for protein and RNA sampling (which perhaps should be moved to another directory).

# Notes

