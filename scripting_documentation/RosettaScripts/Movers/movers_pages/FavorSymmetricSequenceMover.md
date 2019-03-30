# FavorSymmetricSequence
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FavorSymmetricSequence

Add ResidueTypeLinkingConstraints to the pose such that a symmetric sequence (CATCATCAT) will be favored during design. You should add this mover before sequence design is performed.

    <FavorSymmetricSequence penalty="(&real)" name="symmetry_constraints" symmetric_units="(&size)"/> 

-   penalty should be a positive Real number and represents the penalty applied to a pair of asymmetric residues.
-   symmetric\_units should be a positive Integer representing the number of symmetric units in the sequence. It should be a value of 2 or greater

The total constraint score is listed as 'res\_type\_linking\_constraint'


##See Also

* [[ResidueTypeConstraintMover]]
* [[I want to do x]]: Guide to choosing a mover