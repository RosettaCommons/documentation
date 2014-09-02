# GeneralizedKIC Perturbers

## Overview
GeneralizedKIC perturbers alter the chain to be closed in some way prior to kinematic closure.  They can _only_ act on the chain to be closed, and have no effect on tail residues or on any other part of the input structure.  Perturbers are applied in the order that they are defined.  Different perturbers may alter the same degrees of freedom, sequentially.

## Use within RosettaScripts

**TODO -- mention shorthands**

## Types of perturbers
1. Set dihedral/bondangle/bondlength (**perturber="set_dihedral"**, **perturber="set_bondangle"**, **perturber="set_bondlength"**)<br>These perturbers allow the user to set a desired dihedral angle, bond angle, or bond length.  The set_dihedral perturber takes four or two atoms within each **<AddAtoms>** block; if two atoms are specified, they will be assumed to be the middle two atoms in the set of four defining the dihedral angle and the other two will be inferred.  Similarly, the set_bondangle perturber takes three or one atoms within each **<AddAtoms>** block.  The set_bondlength perturber always takes two atoms within each **<AddAtoms>** block.  For each degree of freedom specified with an **<AddAtoms>** block, the user can specify a value with **<AddValue>**.  Alternatively, a single value can be specified for multiple degrees of freedom, in which case all are set to the specified value.
2.  Randomize dihedral (**perturber="randomize_dihedral"**)<br>This perturber assigns each specified dihedral angle a uniformly-distributed random value between -180 degrees and 180 degrees.  The value from the input structure is discarded.  Dihedrals are specified with **<AddAtoms>** blocks, and are defined by either two or four atoms.  This perturber takes no values.
3.  

**THIS PAGE IS UNDER CONSTRUCTION**