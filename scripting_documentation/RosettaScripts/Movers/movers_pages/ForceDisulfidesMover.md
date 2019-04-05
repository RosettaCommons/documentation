# ForceDisulfides
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ForceDisulfides

[[include:mover_ForceDisulfides_type]]

The disulfide forcing uses Rosetta's standard, Conformation.fix\_disulfides( .. ), which only sets the residue type to disulfide and makes the connection. The (optional) repacking step is necessary to realize the disulfide bond geometry. Repacking takes place in 6A shells around each affected cysteine, using the specified scorefunction.

By default, the specified disulfides are added to the set of currently existing disulfides. One can use the  `remove_existing` option to remove all the existing disulfides. (The new free cysteines will be added to the list of residues to repack around.) The `remove_existing` option can also be used with an omitted `disulfides` option to remove all disulfides from the pose.

##See Also

* [[DisulfideMover]]
* [[DisulfidizeMover]]
* [[RemodelMover]]
* [[I want to do x]]: Guide to choosing a mover
