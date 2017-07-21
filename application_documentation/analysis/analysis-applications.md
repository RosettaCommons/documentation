#Analysis applications

**NOTE: If you are looking for general information on analyzing your results in Rosetta, check the [[Analyzing Results]] page.

##List of analysis applications

* [[Score application|score-commands]]: Application to score one or more structures.
* [[Residue energy breakdown]]: Outputs residue-by-residue score information for a given input structure.
* [[Density map scoring]]: Scores how well a structure agrees with experimental electron density data.
* [[DDG monomer]]: Application to predict changes in stability for monomeric proteins caused by a point mutation.
* [[Cartesian DDG]]: DDG calculation using Cartesian space sampling.
* [[Interface analyzer]]: Calculates binding energies, buried surface areas, and other metrics for interfaces between two or more chains in a PDB.
* [[interface_energy]]: energy at the interface between two sets of residues.
* [[PeptiDerive]]: For a given interface, finds the linear stretch that contributes the most binding energy.
* [[Pocket measure]]: This application takes in a PDB file and specified target residue/residue pair and, generates a (localized) PocketGrid, and outputs the total "deep volume" of all target pockets and the largest pocket.
* [[Theta ligand]]: Given PDB files for a protein and ligand, outputs the fraction of the ligand that is exposed to solvent in the bound complex.
* [[RosettaHoles]]: Rapid assessment of protein core packing for structure prediction, design, and validation.
* [[FeaturesReporters|Features-reporter-overview]].
* [[RECCES]]: RNA free energy calculation with comprehensive sampling.
* [[shobuns]]: Buried unsatisfied polar atoms for the SHO solvation model.

##See Also

* [[Tools]]: Python-based tools for use with Rosetta
* [[Rosetta Servers]]: Servers that provide access to some Rosetta applications
* [[Application Documentation]]: List of Rosetta applications
* [[Scoring explained]]: Description of scoring in Rosetta
* [[RosettaScripts]]
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files