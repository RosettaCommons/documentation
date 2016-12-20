Analyzing Results
===========

The overview of a Rosetta protocol is extraordinarily generic: you take a set of input data that specifies large parts of the sequence and conformation space of a putative protein, you do some sampling of the degrees of freedom in question, and then you pick the "best" results drawn from that sampling procedure.
This document concerns itself with one aspect of the second step and, primarily, with the third step.
The glaring question the second step leaves open is the precise amount of sampling necessary to arrive at a reasonable set of structures to analyze.
Like in a molecular dynamics simulation, you can generally determine whether you have gotten as close to the "right answer" as possible given your sampling criteria.

The classic example is in _ab initio_ folding, where one will plot score versus rmsd to native and obtain a "folding funnel," where large rmsds correspond to poor scores (and a relatively low score derivative) and, as rmsd approaches the native, rapidly improving scores, leading to a cluster of near-native conformations.
Not every sequence yields a folding funnel at all (granted, not every sequence yields a folded protein in reality either!) but _for the most part_, a folding funnel is some evidence of convergence.
(Not to overwhelm with caveats, but _in theory_ you could imagine that conformational space might simply be fifty times larger than what you've actually sampled, and your observed funnel is merely a sub-funnel describing some portion of that space. So unsurprisingly, unless you have a true native structure, you can't tell how close you are.)
But, much as in an MD simulation, you can observe the likelihood that you have not converged declining, and that's good enough.
After all, you're just converging with respect to the scoring function you're using. By your millionth decoy of _ab initio_, the error in the scoring function is almost certainly much greater than imperfection in your sampling.
(Doing fixed backbone design, you have likely reached that point by decoy one hundred.)

The point is that the very first thing you should do is make sure that you are making enough structures.
As a work-around to help you accomplish more effective sampling with a certain number of structures, you can break your protocol into multiple phases.
For example, suppose you are running FastRelax with some amount of design.
This is a great protocol and gives people wonderful results!
But if you are redesigning twenty residues to ALLAAxc, that's quite a number of configurations to visit in addition to backbone and sidechain minimization and sidechain repacking.
If real-life constraints prevent you from generating 20,000-100,000 decoys, which would be ideal for this space, you could instead generate 5,000 decoys through FastRelax without design, process the results to obtain a smaller number of structures (perhaps the 10-20 best cluster centroids, or something similar) and then run a more conservative design protocol (like fixed-backbone design) on the results, for a hundred decoys or so.

So, processing results can take many forms.
Important highlights of this process include:
-	Clustering, which serves two purposes. 
	-	First, there is little point in performing a second stage of sampling using two near-identical structures generated from the first stage: it is a very inefficient way to traverse structure space.
	-	Second, there is valuable confirmation that a result is valid that can be obtained from clustering. A large cluster of a given energy is more likely to contain a global minimum than a much smaller cluster, even if the smaller cluster has a slightly better energy.
		This is because the global minimum is more likely to have more low-energy structures surrounding it, while false positives are likely flukes, structurally speaking.
		Moreover, most Rosetta scoring is still fairly coarse; for example, unless you're using the cart_bonded scoring term, bond lengths and angles are immutable.
		So it is very likely that the broad Rosetta scoring function minimum masks a deeper free energy minimum that you might find via another orthogonal sampling method.
-	Choosing the best cluster centroids (or, if you already have few, well distributed structures, the best models) by some metric.
This metric generally ought to correspond to the _physical reality_ of the model.
An overall scoring function is typically a good choice.
It may differ from the scoring function that you used to guide sampling.
For example, you may have added [[constraints|constraint-file]] to your scoring function so that you only sample conformations near a binding site.
But when it comes time to score, you are much more interested in whether your models have no clashes, few bad rotamers, and good packing than how well they satisfy your original constraints.
So you may use a scoring function with few or different constraints to score models here.
-	After you select some percentage of your models or centroids based on that "physical reality" score, you may have a secondary objective by which you should rank these models.
In cases like _ab initio_ folding, the two scoring functions are likely identical, as there is only one objective: to find the correct structure for a sequence.
In cases like interface design, in contrast, you want to first select good models, but you might sort your "successful" models by their interface energy, because that better reflects your functional objective.
Of course, better interface energies should correlate with better scores, but sometimes a good score is caused by better packing distant from the interface.
Similarly, good interface energies coming from low-scoring structures may be entirely meaningless.

##See Also

* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Comparing structures]]: Essay on comparing structures
* [[Units in Rosetta]]: Gives descriptions of Rosetta Energy Units and other units of measurement.
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Resources for learning biophysics and computational modeling]]

<!--
This hidden comment is a search hack for the terrible Gollum search tool.
analyzing results
analyzing results
analyzing results
analysis
analysis
analyze
analyze
analysing
analysing
-->
