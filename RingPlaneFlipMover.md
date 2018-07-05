##MetaData

`Mover` created by Labonte <JWLabonte@jhu.edu>.

##Description
A `Mover` for flipping the plane of a carbohydrate pyranose ring 180 degrees about its anomeric bond.

Based on a given [[ResidueSelector]] and limited by a [[MoveMap]], this `Mover` selects applicable cyclic residues and performs a 180-degree shearing move in which the anomeric bond and the main-chain bond on the opposite side of the ring are moved in opposite directions. An "applicable" residue is limited to 1,4-linked aldopyranoses or 2,5-linked ketopyranoses for which both the anomeric bond and the glycosidic linkage bond are equatorial.

This `Mover` is useful in cases &mdash; for example, when working with highly charged and sulfated heparins &mdash; where Rosetta models an oligo- or polysaccharide in such a way that the residue is sitting in the relatively correct position but is missing favorable interactions that it could make on the other side of the glycan ring. Sometimes, a simple "ring flip" could correct this, but the energy barrier to rotate is too high; the small moves of a [[ShearMover]] would never flip the ring around.

##RosettaScripts Details
[[include:mover_RingPlaneFlipMover_type]]

##See Also
 - [[ShearMover]]