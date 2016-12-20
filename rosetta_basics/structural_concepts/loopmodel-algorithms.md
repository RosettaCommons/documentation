#Loop modeling algorithms used in Rosetta

-  [[CCD|loopmodel-ccd]]: fragment insertion with cyclic coordinate descent to close chain breaks

-  [[KIC|loopmodel-kinematic]]: robotics-inspired kinematic closure combined with random sampling of non-pivot loop torsions from Ramachandran space

-  [[next generation KIC|next-generation-KIC]]: refined version of KIC; using omega sampling, neighbor-dependent Ramachandran distributions and ramping of rama and fa_rep score terms to achieve higher loop reconstruction performance and increase sampling of sub-Angstrom conformations (recommended algorithm if no fragment data is available)

-  [[KIC with fragments|KIC_with_fragments]]: fragment-based loop modeling using kinematic closure; combining the sampling powers of KIC and coupled phi/psi/omega degrees of freedom from protein fragment data to achieve higher loop reconstruction performance and the best sampling yet of sub-Angstrom conformations (recommended algorithm if fragment data is available) 

