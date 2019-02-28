# PackRotamersMoverPartGreedy
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PackRotamersMoverPartGreedy

Greedily optimizes around a set of target residues, then repacks sidechains with user-supplied options, including TaskOperations. Given a task and a set of target residues, this mover will first greedily choose the neighbors of these residues, and then perform the usual simulated annealing on the rest (while maintaining the identity of the greedily chosen sidechains). The greedy choices are made one by one, i.e. first convert every neighbor of a given target sidechain to Ala, choose the lowest energy neighbor rotamer and minimize, then look at the rest of the neighbors and choose the best for interacting with the two chosen so far, and so on, until you're out of neighbor positions. If more than one target residues are specified, a random permutation of this list is used in each run of the mover.


[[include:mover_PackRotamersMoverPartGreedy_type]]


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
