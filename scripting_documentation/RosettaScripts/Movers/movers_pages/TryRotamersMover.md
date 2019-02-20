# TryRotamers
*Back to [[Mover|Movers-RosettaScripts]] page.*
## TryRotamers

Produces a set of rotamers from a given residue. Use after [AtomTree](#AtomTree) to generate inverse rotamers of a given residue.

[[include:mover_TryRotamers_type]]


-   explosion: range from 0-4 for how much extra rotamer explosion to include. Extra explosion in this context means EX\_FOUR\_HALF\_STEP\_STDDEVS (+/- 0.5, 1.0, 1.5, 2.0 sd). (By default EX\_ONE\_STDDEV (+/- 1.0 sd) is included for all chi1,2,3,4.)
    -   1 = explode chi1
    -   2 = explode chi1,2
    -   3 = explode chi1,2,3
    -   4 = explode chi1,2,3,4
-   pdb\_num/res\_num: see the main [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more.
-   shove: use the shove atom-type (reducing the repulsive potential on backbone atoms) for a comma-separated list of residue identities. e.g., shove=3A,40B.
-   automatic\_connection: should TryRotamers set up the inverse-rotamer fold tree independently?

Each pass through TryRotamers will place the next rotamer at the given position. Increase -nstruct settings appropriately to obtain them all. Once all rotamers have been placed, TryRotamers will cause subsequent runs through the protocol with the same settings to fail.


##See Also

* [[PackRotamersMover]]
* [[PackRotamersMoverPartGreedyMover]]
* [[Fixbb]]: Application to pack rotamers
* [[MinPackMover]]
* [[PrepackMover]]
* [[RepackMinimizeMover]]
* [[RotamerTrialsMover]]
* [[RotamerTrialsMinMover]]
* [[RotamerTrialsRefinerMover]]
* [[I want to do x]]: Guide to choosing a mover
