# SetupHotspotConstraints
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetupHotspotConstraints (formerly hashing_constraints)

[[include:mover_SetupHotspotConstraints_type]]

* stubfile: a pdb file containing the hot-spot residues
* redesign_chain: which is the host_chain for design. Anything other than chain 2 has not been tested.
* cb_force: the Hooke's law spring constant to use in setting up the harmonic restraints on the Cb atoms.
* worst_allowed_stub_bonus: triage stubs that have energies higher than this cutoff.
* apply_stub_self_energies: evaluate the stub's energy in the context of the pose.
* pick_best_energy_constraint: when more than one restraint is applied to a particular residue, only sum the one that makes the highest contribution.
* backbone_stub_constraint_weight: the weight on the score-term in evaluating the constraint. Notice that this weight can be overridden in the individual scorefxns.

##See Also

* [[I want to do x]]: Guide to choosing a mover
