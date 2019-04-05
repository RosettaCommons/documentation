##MetaData

`Mover` created by Labonte <JWLabonte@jhu.edu>.

##Description
A `Mover` for tautomerizing the anomeric carbon of reducing-end saccharide residues.

Based on a given [[ResidueSelector]] and limited by a [[MoveMap]], this carbohydrate-specific `Mover` selects applicable ("free") reducing-end saccharide residues (that is, not glycosides) at random and replaces them with their anomer. For example, &alpha;-sugars will be converted to &beta;-sugars and _vice versa_. Reducing-end sugars tautomerize readily in aqueous solutions between the two isomeric forms, and it is generally not certain which form is preferred (if any) in sugar-binding proteins.

This could be considered an extremely limited design case; however, reducing ends readily tautomerize in solution, in contrast to other cases, in which residues do not readily mutate into others! It is generally not certain which form is preferred (if any) in sugar-binding proteins, and crystal structures sometimes arbitrarily assign one anomer over another when fitting density, so this `Mover` can assure that each anomer is sampled.

##RosettaScripts Details
[[include:mover_TautomerizeAnomerMover_type]]
