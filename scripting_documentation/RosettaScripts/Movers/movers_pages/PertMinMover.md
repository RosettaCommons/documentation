# PertMinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PertMinMover

[[include:mover_PertMinMover_type]]

This mover is based off the approach taken by Davey & Chica, Proteins 82:771-784 [doi:10.1002/prot.24457](https://dx.doi.org/mover_PertMinMover_type)

In short, it explores local conformational space by making a small, random Cartesian perturbation of atomic coordinates, followed by an energy minimization. In a rough energy landscape, even small variations in starting position can greatly change the trajectory of minimization and the final result, resulting in local conformation search (see Fig. 2 of Davey & Chica).

In contrast to the Davey & Chica approach, which used a fixed +/- 0.001 Ang perturbation in the PDB file, this mover allows you to vary the size and distribution of the perturbation, either applying a displacement selected uniformly within in a sphere of a given radius (the default), or from a spherically symmetric Gaussian distribution of a given standard deviation (which biases toward smaller displacements while allowing much larger ones).

Which atoms are perturbed can be controlled by the provided ResidueSelector (defaults to all residues in the system), and the sc_only flag. Which degrees of freedom can move during minimization can be controlled by the provided MoveMap specification.


##See Also

* [[MinMover]]: Do minimization without perturbation
* [[Minimization overview]]
* [Minimization Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/minimization/minimization)
* [[I want to do x]]: Guide to choosing a mover
