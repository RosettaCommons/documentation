# GreedyOptMutationMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## GreedyOptMutationMover
### Publication

King C, Garza EN, Mazor R, Linehan JL, Pastan I, Pepper M, Baker D. Removing T-cell epitopes with computational protein design. Proceedings of the National Academy of Sciences. 2014 Jun 10;111(23):8577-82.
[[http://www.pnas.org/content/111/23/8577.long]]

Nivón, L. G., Bjelic, S., King, C. and Baker, D. (2014), Automating human intuition for protein design. Proteins, 82: 858–866. doi:10.1002/prot.24463
[[http://onlinelibrary.wiley.com/doi/10.1002/prot.24463/full]]

This mover will first attempt isolated/independent mutations defined in the input task operation, score/filter them all, rank them by score, then attempt to combine them, starting with the best scoring single mutation, accepting the mutation only if the filter score decreases (see skip\_best\_check for optional exception), and working down the list to the end. Optionally test one of the top N mutations at each positions instead of just the best.

This mover is parallelizable with MPI. To use it, you must set the option parallel=1, and you must set the command line flag nstruct = nprocs - 1

Note: Each attempted mutation is always followed by repacking all residues in an 8 Å shell around the mutation site. The user-defined relax\_mover is called after that.

Note: Producing the very first output structure requires calculating all point mutant filter scores, which may take a bit, but output of subsequent structures (with nstruct \> 1 ) will re-use this table if it's still valid, making subsequent design calculations significantly faster. However, the table must be recalculated each time if it is receiving different structures at each iteration (e.g. if movers that stochastically change the structure are being used before this mover is called).

Necessary:

-   task\_operations: defines designable positions and identities
-   filter: defines the score you're trying to optimize (and a cutoff), defaults to lower = better
-   relax\_mover: a mover for post-repacking relaxation (e.g. minimization)

Optional:

-   filter\_delta: add sequence diversity; useful with nstruct \> 1; randomly try any mutation that scores within N filter points of the best-scoring mutation at each position instead of just the first, e.g. filter\_delta=0.5 for attempting any mutation within 0.5 filter points of the best one
-   incl\_nonopt: Default = false. Use with filter\_delta. This option modifies filter\_delta behavior such that all mutations that score within N filter points of the best are attempted in the combinatorial design stage.
-   sample\_type: if your filter values are such that higher = better, use "sample\_type=high"
-   dump\_pdb: if you want to see a pdb of every trial mutation, add "dump\_pdb=1"
-   dump\_table: if true, will save to a file the table of amino acids/filter values over which it is operating. (Filename and format of table may be subject to change: Current version lists the score for each allowed mutation, with an \* next to the original identity. The order of amino acids in the table is set by a sort over the filter, so the first aa listed is the best as judged by the filter, etc.)
-   design\_shell: default is set to -1, so there is no design. Set a positive value to determine the radius of design shell. This might be useful in case of reversion to native where more than one mutation is needed to revert.
-   repack\_shell: what radius should we repack around each tested/designed mutation
-   stopping\_condition: stops before trials are done if a filter evaluates to true (accepting the last mutation that caused the filter to evaluate to true by default. See stop\_before\_condition to change this behavior).
-   stop\_before\_condition: Default = false. Stop mover once the stopping\_condition is reached and do not accept the last mutation (ie, reject the mutation that set the stopping\_condition to true)
-   skip\_best\_check: Default = false. Accept mutations during the combining stage as long as they pass the filter(s), regardless of whether or not the value is the best so far.
-   reset\_delta\_filters: comma-separated list of delta\_filters. Will reset the baseline value of each delta filter to match the "best pose" after each accepted mutation during the combining stage. Useful so that the mutations are still evaluated on an individual basis, in the context of the current best pose.
-   rtmin: do rtmin following repack?
-   parallel: run the point mutation calculator in parallel, use in conjunction with openMPI
-   pareto mode is performed whenever multiple filters are defined with branch tags (see below). pareto mode will first attempt isolated/independent mutations defined in the input task operation and score/filter them all using all defined filters. Then, the Pareto-optimal mutations are identified at each position (see: [Wikipedia page on the Pareto frontier](http://en.wikipedia.org/wiki/Pareto_efficiency#Pareto_frontier)), discarding the non-optimal mutations. Next, the mover attempts to combine the Pareto-optimal mutations at each position. **this is a multiple pose mover, so use nstruct >1. -nstruct 100 is safe. The number of poses cached in memory is limited by nstruct to prevent memory overload**.

```xml
<GreedyOptMutationMover name="(&string)" task_operations="(&string comma-separated taskoperations)" filter="(&string)" scorefxn="(score12 &string)" relax_mover="(&string)" sample_type="(low &string)" diversify_lvl="(1 &int)" dump_pdb="(0 &bool)" dump_table="(0 &bool)" rtmin="(0 &bool)" stopping_condition="('' &string)" stop_before_condition="(0 &bool)" skip_best_check="(0 &bool)" reset_delta_filters="(&string comma-separated deltafilters)" design_shell="(-1, real)" repack_shell="(8.0, &real)"/>

#Pareto mode example, minimize filter 1 and maximize filter2 
<GreedyOptMutationMover name="gopt" task_operations="task" relax_mover="min" scorefxn="score12">
    <Filters>
       <AND filter_name="filter1" sample_type="low"/>
       <AND filter_name="filter2" sample_type="high"/>
    </Filters>
</GreedyOptMutationMover>
```


##See Also

* [[RandomMutationMover]]
* [[DeltaFilter]]
* [[GenericMonteCarloMover]]
* [[RotamerTrialsMover]]
* [[PackRotamersMover]]
* [[Point mutant scan application|pmut-scan-parallel]]
* [[I want to do x]]: Guide to choosing a mover
