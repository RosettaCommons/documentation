#Ignoring Residues

* <code> -ignore_unrecognized_res </code>
 * Generally, this can be used if you want ignore residues that Rosetta can't or shouldn't load (for instance, you are interested in a different region than where the ligand is it, etc etc
<br>
<br>
* <code> -ignore_zero_occupancy false </code>
 * Rosetta will ignore any residues/atoms that have an occupancy of 0.  Typically this means that the atom or residue was not resolved well enough in the structure.  In order to load these residues/atoms into Rosetta anyway (for modeling, design, etc etc.), pass this option.  

##See Also

* [[Making your code robust against malformed PDBs|robust]]
* [[Guides for non-protein inputs|non-protein-residues]]: Notes on working with [[noncanonical amino acids|Noncanonical Amino Acids]], [[metals|Metals]], [[carbohydrates|Carbohydrates]], _etc_.
* [[Options in Rosetta|options-overview]]
* [[How to turn on residue types that are off by default]]
* [[Params files|Residue Params file]]: Notes for adding new residue types that are not already in the Rosetta database.