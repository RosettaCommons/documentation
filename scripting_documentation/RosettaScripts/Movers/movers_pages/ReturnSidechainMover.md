# ReturnSidechainsMover
*Back to [[Mover|Movers-RosettaScripts]] page.*

This Mover is used to return known sidechain conformations to a [[centroid|Glossary#centroid]] pose.  Many protocols take [[fullatom|Glossary#fullatom]] input, do a centroid "broad sampling" / perturbation step, then do a fullatom refinement step (for example, loop modeling).  This Mover is used to route the input sidechains for the original fullatom input Pose around a centroid phase so that the data are not lost.  (Obviously, some of those sidechains will be inappropriate for the new conformation - but maybe large parts are internally rigid and the crystal sidechains are good).

It's not actually RosettaScripts compatible, because [[SaveAndRetrieveSidechainsMover]] already is.  The two were accidentally developed in parallel years ago.  However, ReturnSidechainMover has the advantage of being at a lower library level of protocols (it's in .3 as part of simple_moves) so it's a more available choice for C++ protocol writing.  

It takes its reference pose - the one to return sidechains from - in its constructor.

[[SwitchResidueTypeSetMover]] is its reverse-companion (for putting centroid where fullatom is).  

##See Also

* [[BuildAlaPoseMover]]
* [[SaveAndRetrieveSidechainsMover]]
* [[SwitchResidueTypeSetMover]]
* [[SavePoseMover]]
* [[I want to do x]]: Guide to choosing a mover