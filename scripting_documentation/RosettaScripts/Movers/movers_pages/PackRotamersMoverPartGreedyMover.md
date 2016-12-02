# PackRotamersMoverPartGreedy
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PackRotamersMoverPartGreedy

Greedily optimizes around a set of target residues, then repacks sidechains with user-supplied options, including TaskOperations. Given a task and a set of target residues, this mover will first greedily choose the neighbors of these residues, and then perform the usual simulated annealing on the rest (while maintaining the identity of the greedily chosen sidechains). The greedy choices are made one by one, i.e. first convert every neighbor of a given target sidechain to Ala, choose the lowest energy neighbor rotamer and minimize, then look at the rest of the neighbors and choose the best for interacting with the two chosen so far, and so on, until you're out of neighbor positions. If more than one target residues are specified, a random permutation of this list is used in each run of the mover.

```
<PackRotamersMoverPartGreedy name="&string" scorefxn_repack="(score12 &string)" scorefxn_repack_greedy="(score12 &string)" scorefxn_minimize="(score12 &string)" distance_threshold="(8.0 &Real)" task_operations="(&string,&string,&string)" target_residues="(&string,&string)" target_cstids="(&string,&string)" choose_best_n="(0 &int)"/>
```

-   scorefxn\_repack: scorefunction to use for repacking (for sim annealing)
-   scorefxn\_repack\_greedy: scorefunction to use for greedy design
-   scorefxn\_minimize: scorefunction to use for minimizing in greedy optimizaiton
-   taskoperations: comma-separated list of task operations
-   target\_residues: comma-separated list of target residues
-   target\_cstids: comma-separated list of target cstids (e.g. 1B,2B,3B etc)
-   choose\_best\_n: number of lowest scoring residues on a protein-ligand interface to use as targets
-   distance\_threshold: distance between residues to be considered neighbors (of target residue)


##See Also

* [[PackRotamersMover]]
* [[TryRotamersMover]]
* [[Fixbb]]: Application to pack rotamers
* [[SymPackRotamersMover]]: Symmetric version of PackRotamersMover
* [[RotamerTrialsMover]]
* [[RotamerTrialsMinMover]]
* [[RotamerTrialsRefinerMover]]
* [[MinPackMover]]
* [[I want to do x]]: Guide to choosing a mover