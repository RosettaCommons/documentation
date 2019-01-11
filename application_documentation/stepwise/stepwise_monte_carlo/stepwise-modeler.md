After the move is applied, the affected degrees of freedom are then (re-)sampled and the resulting structures are subject to screening and filtering (i.e. passed through a gauntlet of filters, chainbreak-closers, packers, and clusterers).  The _modeling_ and _minimization_ steps are the same as in the previously published stepwise assembly procedure {sripakdeevong, 2011}, except that, here, the resampling step involves the discovery of 20 random torsion combinations that pass filters, rather than a complete enumeration of all such torsion combinations.

The modeling functionality has been implemented in the Rosetta stepwise framework, as follows:

 - `StepWiseModeler` takes a pose and a single position of a moving residue, and uses this to figure out information including: which nucleotide(s) to sample; what the two partitions are that will move relative to each other; and whether to do rigid body docking (if the moving residue’s parent is a jump). After initialization, RNA 2’ hydroxyls are packed, as well as any 5’ or 3’ phosphates that are hanging off RNA strands. By default, if there are not enough contacts with the groups to be packed, the groups are allowed to remain virtual. Then, the `StepWiseModeler` actually carries out the enumerative or stochastic sampling via a discrete grid search over backbone torsions or rigid-body degrees of freedom, using the `StepWiseConnectionSampler`. Finally, the lowest energy pose(s) found in sampling are subject to torsional minimization. The number of poses to be minimized is encoded in the option `num_pose_minimize`, which can be set by the user at run-time.

 - The `StepWiseConnectionSampler` initializes and runs the core stepwise functionality, encapsulated in a StepWiseSampleAndScreen object. The `StepWiseSampleAndScreen` object is the core “main loop” in stepwise modeling. It involves plug-and-play of several possible `StepWiseSamplers`--defining the nested loops of DOF sampling--and `StepWiseScreeners` (the gauntlet of filters, closers, packers, and clusterers). One nice feature of the `StepWiseSampleAndScreen` framework is that poses are only saved into memory once they have passed all the screens. This allows it to handle sampling calculations that enumerate through millions of samples.

# Sampling

 - After some initial aligning and packing of the pose, sampling of the affected degrees of freedom is carried out. The `StepWiseSampleAndScreen` object is initialized with a `StepWiseSampler` object which delineates the degrees of freedom to be sampled, their discrete values, and what order these go in. This `StepWiseSampler` object is typically itself the composition of several `StepWiseSampler` objects. This concatenated list of `StepWiseSampler` objects define the sampling loop, to which millions of may be subject to. A single `StepWiseSampler` in this loop typically consists of applying new rotamer conformations to a pose, until all rotamers have been sampled/screened.

 - Generally, sampling of the nucleotide’s conformational space includes stochastically sampling via a discrete grid search over backbone torsions connecting the nucleotide to its 5’ or 3’ neighbor [the backbone “suite”, <greek symbols>], the nucleobase’s glycosidic torsion (<chi>) in 20 degree intervals, and the nucleotide ribose sugar (torsions v0, v1, v2, v3/sigma, and v4) and its north (3’-endo) and south (2’-endo) puckered conformations. 2’-OH sampling is carried out separately. Stochastic sampling via discrete grid search over the <alpha>, <gamma>, and <zeta> torsions, sampled over the entire 360 degree range. Other torsions are restricted to sterically allowed regions: <Beta> in the trans region (80 degrees - 280 degrees) and <sigma> to the trans and gauche regions (170 degrees - 290 degrees if the sugar pucker was north; 182 degrees to 302 degrees if south). For both pyrimidines and purines, the the <chi> torsion is sampled in the anti region (179 degrees - 219 degrees if north; 217 degrees - 257 degrees if south). Additionally for purines, the <chi> torsion is sampled in the syn region (49 degrees - 89 degrees if north; 50 degrees to 90 degrees if south). While the functionality to enumerate over the 5,388,768 unique conformations for purines and 2,694,384 unique conformations for pyrimidines (spaced from each other, on average, by 0.6 Angstroms all-heavy-atom RMSD) has been retained in the stepwise framework, the default stochastic sampling yields 20 torsional combinations, selected at random.

# Screening

Next, the collection of poses resulting from the previous sampling step are subject to screening. The `StepWiseSampleAndScreen` object is initialized with a vector of `StepWiseScreener` objects which delineate the gauntlet of filters, packers, and loop closers that are run after each sample is applied to the pose. Having these screeners in a particular order can accelerate sampling, and in a few cases there are some dependencies. Currently available `StepWiseScreener` classes include functionality for: common filters; chain closure; packing; geometric filters; rigid body screening; pose selection and ‘on-the-fly’ clustering; etc. Some commonly used filters are described briefly here:

-	`PartitionContactScreener` looks at the two partitions whose intermediate connection (a jump or several backbone degrees of freedom) is being sampled. Only poses with no clashes, but some contact, will successfully pass through this filter. Essentially, fa_atr and fa_rep scores are computed for pairs of cross-partition residues to identify clashes between the two partitions. 

-	`VDWBinScreener` enables fast Van der waals clash checks, by checking a grid of binned atom positions, rather than comparing exact atom coordinates. 

-	`NativeRMSDScreener` is used to ensure similarity between the pose and a user-defined reference pose. This functionality can be activated by specifying the desired RMSD cutoff via the `-rmsd_screen` command-line argument.

-	`BaseCentroidScreener` (RNA specific) and looks for base pairs and base stacks. Poses without at least one base pair or base stack between its partitions are filtered out here.

-	`O2PrimeScreener` (RNA specific) is screener for specialized 2’-OH packing. This specialized packing treats 2’-OH moieties as side-chains and allows for them to be virtualized. 

-	`PhosphateScreener` (RNA specific) is a screener for specialized sampling of phosphates at 5’ or 3’ ends of RNA strands. This specialized screner treats phosphate moieties as side-chains and allows for them to be virtualized. 

-	Geometric filters were largely developed for sampling ‘floating bases’ for RNA--docking of nucleotides that are not covalently connected to the rest of the pose, but instead are separated by a single nucleotide.

-	Rigid body screeners include a `StubApplier` and `StubDistanceScreener`, which allow screening of rigid-body arrangements during docking based purely on geometry, without requiring pose updates.

-	`PoseSelectionScreener` handles the final clustering and selection of poses that have passed all other screens. Generally, it should be the last screener applied. 

After all samplers and screeners have been applied, the resulting collection of poses is subject to clustering. The poses are clustered with an all-atom RMSD cutoff of 0.5 Angstrom over all the sampled atoms and by similarity of the newly built nucleotide’s sugar pucker. Clustering functionality, including pose collection and ‘on-the-fly’ clustering, is encapsulated by a `StepWiseClusterer` object.

The lowest energy member of each cluster is retained. Finally, the resulting poses are assessed for their energy, and the lowest energy model is passed on to the next step.

# Minimization

The resulting model is minimized in a _minimization_ step.

The stepwise application also allows a choice of passing through several models, which are clustered, minimized, and re-clustered; this mode is used in the previous stepwise assembly enumeration procedure.

# Monte Carlo acceptance

The lowest energy model is selected, and its energy is compared to the energy of the model generated by the previous step, and the new model is either accepted or rejected based on the Metropolis criterion; if the new model has a lower energy it is accepted.


# Code review
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


Go back to [[StepWise Overview|stepwise-classes-overview]].

##See Also

* [[Stepwise options]]: Options classes for Stepwise code
* [[Writing an application]]
* [[Development Documentation]]: The home page for development documentation
* [[I want to do x]]: Guide to selecting movers for structural perturbations
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
