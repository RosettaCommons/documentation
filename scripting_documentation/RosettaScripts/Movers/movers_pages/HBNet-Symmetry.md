#HBNet Symmetry

*Back to [[HBNet|HBNetMover]] page.  Back to [[Mover|Movers-RosettaScripts]] page.  Back to [[RosettaScripts|RosettaScripts]] page.*<br>

HBNet is fully functional with the [[Symmetry]] machinery of Rosetta, and symmetry is auto detected, but there are several things to be aware of and special cases with network detection and processing for symmetric poses:

* Like most of Rosetta, symmetric functions keep track of the independent residues (asymmetric unit; ASU), and operations on the ASU are then propagated to the symmetric copies/clones
* Rotamer-rotamer energies are stored at edges of the InteractionGraph (IG) that correspond to the independent residues, and if multiple symmetric interactions exist, it's the sum of all those interactions that is stored; what this means is that there may not be any h-bonds between residue 10 and 23, but if there are between rotamers of position 10 and 123 (where 123 is symm clone of 23), there will be an edge between 10 and 23; most of this gets handled automatically, but when modifying code, it's especially important to keep track of this info when evaluating satisfaction and other network metrics.
* For rotamers that h-bond to symmetric copies of itself, these energies are stored in the one-body energies of the IG; HBNet uses a custom way of populating the one-body energies of its IG to be able to detect these cases during IG traversal.
* Certain metrics want to be applied to the full pose and not only ASU, and there are special catches for this in the code.