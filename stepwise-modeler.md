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

• `do_sampling` actually carries out the enumerative or stochastic sampling using the StepWiseConnectionSampler, which sets up a [[SampleAndScreen|stepwise-sample-and-screen]].  No minimizing occurs here, just a discrete grid search over backbone torsions or rigid-body DOFs.

• `do_minimizing` takes the lowest energy pose(s) found in sampling, and carries out torsional minimization. How many poses to minimize is encoded in option `num_pose_minimize` (see [options/] below).

• `reinitialize` zeros out several objects in `StepWiseModeler` in case it is reused (which it will be in `StepWiseMonteCarlo` applications). It also removes any native constraints added to the pose.

In addition to `StepWiseModeler.cc`, this `modeler/` directory also contains several subdirectories and files for defining options classes, packers, and minimizers, as well as some code specific for protein and RNA sampling (which perhaps should be moved to another directory).

# Notes
• The input `moving_res` needs to actually be in the working numbering. I.e., if the pose has residues 1-4 and 7-12 of the full modeling problem posed, and we need to resample the connection from residue 7 to 8, supply '5' (the actual fifth residue in the pose). If thats too confusing, would be easy to refactor to accept the moving residue as full-numbering.

• For RNA, the specified residue and its connection to its parent in the fold tree are sampled.

• For protein, the parent of the specified residue is also sampled (as long as it is not a fixed part of an input PDB). This choice still permit full enumeration and was worked out in the paper on [stepwise assembly for proteins](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0074830).

• StepWiseModeler can be used purely as a packer (no actual discrete sampling of any degrees of freedom), if `working_prepack_res` is set. This is useful in `-preminimize` modes for `stepwise`.
