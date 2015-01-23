#Ignoring Residues

* <code> -ignore_unrecognized_res </code>
 * Generally, this can be used if you want ignore residues that Rosetta can't or shouldn't load (for instance, you are interested in a different region than where the ligand is it, etc etc
<br>
<br>
* <code> -ignore_zero_occupancy false </code>
 * Rosetta will ignore any residues/atoms that have an occupancy of 0.  Typically this means that the atom or residue was not resolved well enough in the structure.  In order to load these residues/atoms into Rosetta anyway (for modeling, design, etc etc.), pass this option.  