# MPResidueLipophilicityEnergy
documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

[[_TOC_]]

## Energy term basis
the main energy term in the ref2015_memb membrane protein energy function.
this energy term calibrates the energy function to behave similar to the membrane insertion profiles described by Elazar, A. et al. (2016) ‘Mutational scanning reveals the determinants of protein insertion and association energetics in the plasma membrane’, eLife, 5. doi: 10.7554/eLife.12125.

## Energy term calibration
this energy term relies on splines calibrated externally using, every time a new energy function is created.
because of it's nature, the energy term calibrated for one energy function is NOT suitable for use in the context of another energy function.
the current energy function suitable for this energy term is ref2015, and the energy function weights file is at ref2015_memb.
the calibration process uses an idealised poly-A alpha-helix inserted into the membrane. on this helix, every position is mutated to every identity, and the total score profile for every amino-acid as a function of the membrane depth is calculated. the energy terms adds the delta between these profiles and the insertion profiles in the paper mentioned above (after some minor corrections).

## Residue burial
every residue's score from this term is multiplied by a sigmoid that estimates the residue's burial. this prefers the exposing hydrophobic residues to the membrane, and burying polar residues.

## Symmetry
this energy term works with symmetric poses, just use symmetric="1" in the energy function declaration

## Centroid level
the energy term works for both full atom and centroid level poses. it was calibrated for the score0-5 centorid level energy functions, and these are now found at score*_memb.wts
the term detects if the pose is centroid or not by itself.

## See also
* [[MPHelicalityEnergy]]
* [[MPSpanAngleEnergy]]
* [[ResidueLipophilicityFilter]]