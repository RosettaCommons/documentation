# SymFoldandDockRbTrialMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SymFoldandDockRbTrialMover

[[include:mover_SymFoldandDockRbTrialMover_type]]

Apply rigid body orientation perturbation of the given magnitude to the symmetric docking jumps for the given number of cycles. If `use_mc` is enabled, do so in a Monte Carlo fashion, applying the Boltzmann criteria (using the `interchain_cen` scorefunction) after each move.